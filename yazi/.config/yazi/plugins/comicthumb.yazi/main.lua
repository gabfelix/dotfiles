---@diagnostic disable: undefined-field, undefined-global --temp while fields are incomplete within types.yazi
---@diagnostic disable: redefined-local --reusing err
local M = {}

function M:peek(job)
	local ok, err = self:preload(job)
	if not ok or err then
		--ya.dbg("Peek failed during preload", tostring(err))
		return
	end

	local cache = ya.file_cache(job)
	if not cache then
		return
	end

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek(job)
	local h = cx.active.current.hovered
	if not h or h.url ~= job.file.url then
		return
	end
	local step = math.max(0, cx.active.preview.skip + ya.clamp(-1, job.units, 1))

	local metadata_url = ya.file_cache({ file = job.file, skip = 999999 })
	if not metadata_url then
		return
	end
	local filenames = {}

	local metadata = io.open(tostring(metadata_url))
	if metadata then
		for filename in metadata:lines() do
			table.insert(filenames, filename)
		end
		metadata:close()

		step = math.min(step, #filenames - 1)
	end

	-- Nothing to navigate to (empty/unreadable archive); bail before emitting
	-- a negative page index.
	if step < 0 then
		return
	end

	--ya.dbg("Seek:", tostring(step), "Max:", #filenames - 1, tostring(job.file.url))
	ya.emit("peek", { step, only_if = job.file.url })
end

function M:preload(job)
	local metadata_url = ya.file_cache({ file = job.file, skip = 999999 })
	if not metadata_url then
		return false, Err("Failed to get metadata URL")
	end
	local filenames = {}

	local meta_cha, _ = fs.cha(metadata_url)
	if not meta_cha or meta_cha.len == 0 then
		local list, output = self.generate_list(job.file.url)
		if not list then
			return false, Err("Failed to generate archive list", output)
		end
		filenames = list -- assign to outer var (original shadowed it, leaving it empty)

		local write_output, err = fs.write(metadata_url, table.concat(filenames, "\n"))
		if not write_output then
			return false, Err("Failed to write metadata cache", err)
		end
	else
		local metadata = io.open(tostring(metadata_url))
		if metadata then
			for filename in metadata:lines() do
				table.insert(filenames, filename)
			end
			metadata:close()
		end
	end

	-- Guard: no images means page index would be -1, which crashes the renderer.
	if #filenames == 0 then
		return false, Err("No images found in archive")
	end

	job.skip = job.skip >= #filenames and (#filenames - 1) or job.skip
	--ya.dbg("Load:", job.skip + 1, "Max:", #filenames, "Filenames:", filenames)

	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local name = filenames[job.skip + 1]

	-- "--" stops 7z switch parsing, so an archive entry whose name starts
	-- with "-" is treated as a file operand, never as a flag.
	local extract_output, err = Command("7z")
		:arg({ "e", "-so", "--", tostring(job.file.url), name })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()
	if not extract_output then
		return false, Err("Failed to start 7z to extract image: %s", err)
	end
	if #extract_output.stdout == 0 then
		return false, Err("7z extracted no data for %s", name)
	end

	-- image_precache determines the image format from the *source path* (the
	-- built-in previewer passes the original file URL for this reason). An
	-- extensionless cache file fails for webp, whose format can't be recovered
	-- from content alone here -- so stage the bytes in a temp file that keeps
	-- the page's real extension, precache from that, then remove it.
	local ext = name:match("%.([%a%d]+)$") or "bin"
	local src = Url(tostring(cache) .. "." .. ext:lower())

	local write_output, err = fs.write(src, extract_output.stdout)
	if not write_output then
		return false, Err("Failed to write temp image", err)
	end

	local ok, err = ya.image_precache(src, cache)
	fs.remove("file", src)
	if not ok then
		return false, Err("Failed to precache image: %s", err)
	end
	return true
end

local IMAGE_EXTS = {
	jpg = true,
	jpeg = true,
	png = true,
	gif = true,
	webp = true,
	bmp = true,
}

function M.generate_list(url)
	-- "-slt" prints one "Path = <name>" line per entry, so detection no longer
	-- depends on 7z's fixed-width column layout (which shifts between formats).
	local list_output, err = Command("7z")
		:arg({ "l", "-slt", "--", tostring(url) })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()
	if not list_output then
		return false, Err("Failed to run 7z", err)
	end

	local filenames = {}
	for line in list_output.stdout:gmatch("[^\r\n]+") do
		local name = line:match("^Path = (.+)$")
		if name then
			local ext = name:match("%.([%a]+)$")
			if ext and IMAGE_EXTS[ext:lower()] then
				table.insert(filenames, name)
			end
		end
	end
	table.sort(filenames)
	return filenames
end

return M

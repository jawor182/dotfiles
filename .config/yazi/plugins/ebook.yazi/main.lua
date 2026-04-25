local M = {}

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err, bound = self:preload(job)
	if bound and bound > 0 then
		return ya.emit("peek", { bound - 1, only_if = job.file.url, upper_bound = true })
	elseif not ok or err then
		return ya.preview_widget(job, err)
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local step = ya.clamp(-1, job.units, 1)
		ya.emit("peek", { math.max(0, cx.active.preview.skip + step), only_if = job.file.url })
	end
end

function M:preload(job)
    local cache = ya.file_cache(job)
    if not cache or fs.cha(cache) then
        return true
    end

    -- Use :arg() repeatedly for maximum compatibility
    -- We pass the input file, then the specific flag with the value attached
    local output, err = Command("ebook-meta")
        :arg(tostring(job.file.url))
        :arg("--get-cover=" .. tostring(cache))
        :stderr(Command.PIPED)
        :output()

    if not output then
        return false, "Failed to start `ebook-meta`: " .. tostring(err)
    elseif not output.status.success then
        return false, "ebook-meta failed: " .. output.stderr
    end

    return true
end

return M



-- This file will be executed in the "make" process Any functions defined here
-- are available in $(lua ...) in the Makefile

function get_markdown()
	require ("socket.http")
	_, code, reason = socket.http.request {
		url = "http://www.frykholm.se/files/markdown.lua",
		sink = ltn12.sink.file(io.open("markdown.lua", "w"))
	}
	if code ~= 200 then error ("Error downloading file: "..reason) end
end

function gen_readme(infile, outfile)
	require ("markdown")
	s = markdown(io.open(infile, "r"):read("*a"))
	file = io.open(outfile, "w") or error("could not open output " .. out)
	file:write(s)
	file:close()
end

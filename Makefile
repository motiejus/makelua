define LUAIO

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

endef

CFLAGS += $(shell \
		pkg-config --libs --cflags lua 2>/dev/null || \
		pkg-config --libs --cflags lua5.1 2>/dev/null || \
		pkg-config --libs --cflags lua5.2 || \
		echo -lua_not_found)

-load mk_lua.so
$(lua $(LUAIO))

.PHONY: all clean
all: README.html

README.html: README.md markdown.lua
	@echo Making README.html out of README.md
	$(lua gen_readme("README.md", "README.html"))

markdown.lua: mk_lua.so
	@echo Fetching markdown.md
	$(lua get_markdown())

CFLAGS += -Imake-4.0
mk_lua.so: mk_lua.c
	$(CC) $(CFLAGS) -Wall -Wextra -shared -fPIC -o $@ $<

clean:
	rm -f mk_lua.so README.html markdown.lua

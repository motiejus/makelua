-load mk_lua.so
ifneq ($(findstring mk_lua.so,$(.LOADED)),)
$(lua require("make"))
endif

.PHONY: all clean
all: README.html

README.html: README.md markdown.lua
	@echo Making README.html out of README.md
	$(lua gen_readme("README.md", "README.html"))

markdown.lua: mk_lua.so
	@echo Fetching markdown.md
	$(lua get_markdown())

CFLAGS += $(shell pkg-config --libs --cflags lua5.1 2>/dev/null || \
		  pkg-config --libs --cflags lua5.2 || echo -lua_not_found)
mk_lua.so: mk_lua.c
	$(CC) $(CFLAGS) -Wall -Wextra -shared -fPIC -o $@ $<

clean:
	rm -f mk_lua.so README.html markdown.lua

-load mk_lua.so
ifneq ($(findstring mk_lua.so,$(.LOADED)),)
$(lua require("make"))
endif

.PHONY: all clean
all: README.html

README.html: README.md markdown.lua
	@echo Making $@ out of $<
	$(lua gen_readme("$<", "$@"))

markdown.lua: mk_lua.so
	@echo Fetching markdown.md
	$(lua get_markdown())

CFLAGS += $(shell \
		  pkg-config --libs --cflags lua5.1 2>/dev/null || \
		  pkg-config --libs --cflags lua5.2 2>/dev/null || \
		  pkg-config --libs --cflags lua5.3 2>/dev/null || echo -lua_not_found)
mk_lua.so: mk_lua.c
	$(CC) -o $@ $< -Wall -shared -fPIC $(CFLAGS)

clean:
	rm -f mk_lua.so README.html markdown.lua

define LUAIO
function hello()
    noop = 1
end

function clock()
	return "bac", os.clock()
end
endef

-load mk_lua.so
$(lua $(LUAIO))

.PHONY: all
all:
	@echo h-$(lua hello())
	@echo c-$(lua return clock())

CFLAGS += -Imake-4.0 $(shell pkg-config --libs --cflags lua5.1)
mk_lua.so: mk_lua.c
	$(CC) $(CFLAGS) -Wall -Wextra -shared -fPIC -o $@ $<

clean:
	rm -f mk_lua.so

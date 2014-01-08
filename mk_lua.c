#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#include <lauxlib.h>
#include <lualib.h>
#include <gnumake.h>

int plugin_is_GPL_compatible;
static lua_State *L = NULL;

static char* run_lua(const char *nm, unsigned int argc, char **argv)
{
    char *gmk_ret;
    size_t ret_len;

    if (luaL_loadstring(L, argv[0]) || lua_pcall(L, 0, 1, 0)) {
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        lua_pop(L, 1); /* Pop error message from the stack */
        return NULL;
    }

    if (lua_isstring(L, -1)) {
        const char* ret = lua_tolstring(L, -1, &ret_len);

        if ((gmk_ret = gmk_alloc(ret_len+1)) == NULL) {
            perror("gmk_alloc");
            return NULL;
        }
        memcpy(gmk_ret, ret, ret_len+1);
        lua_pop(L, 1);
        return gmk_ret;
    }
    return NULL;
}

int mk_lua_gmk_setup() {
    if ((L = luaL_newstate()) == NULL) {
        fprintf(stderr, "Lua state allocation failure\n");
        return 0;
    }
    luaL_openlibs(L);

    gmk_add_function ("lua", run_lua, 1, 1, 0);
    return 1;
}

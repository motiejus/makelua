#![crate_type = "dylib"]

#[allow(non_upper_case_globals)]
#[no_mangle]
pub static plugin_is_GPL_compatible : i32 = 0;


enum LuaState {}
struct ThreadSafeLie<T>(T);
unsafe impl<T> Sync for ThreadSafeLie<T> {}
static mut L: Option<ThreadSafeLie<*mut LuaState>> = None;

#[link(name = "lua5.1")]
extern {
    fn luaL_newstate() -> *mut LuaState;
}

#[no_mangle]
pub extern fn mk_hello_gmk_setup() -> i32 {
    unsafe {
        let l1: *mut LuaState = luaL_newstate();
        if l1.is_null() {
            panic!("State allocation failure, quitting");
        }
        L = Some(ThreadSafeLie(l1));
    }
    1
}

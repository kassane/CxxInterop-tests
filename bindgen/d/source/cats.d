extern (C++,class)
{
    struct cat
    {
    public:
        version (Windows)
        {
            pragma(mangle, "??0cat@@QEAA@PEBD@Z")
            extern (C++) this(const(char)* name) @safe;

        pure nothrow @nogc:

            pragma(mangle, "?name@cat@@QEBAPEBDXZ")
            extern (C++) final const(char)* name() @safe;
            pragma(mangle, "?feed@cat@@QEAAXXZ")
            extern (C++) final void feed() @safe;
            pragma(mangle, "?meow@cat@@QEBAXXZ")
            extern (C++) final void meow() @safe;
        }
        else
        {
            pragma(mangle, "_ZN3catC1EPKc")
            extern (C++) this(const(char)* name) @safe;

        pure nothrow @nogc:

            pragma(mangle, "_ZNK3cat4nameEv")
            extern (C++) final const(char)* name() @safe;
            pragma(mangle, "_ZN3cat4feedEv")
            extern (C++) final void feed() @safe;
            pragma(mangle, "_ZNK3cat4meowEv")
            extern (C++) final void meow() @safe;
        }

    private:
        const(char)* name_;
        bool is_hungry;
    }
}

extern (C) void main()
{
    import core.stdc.stdio;

    const(char)* chashu_name = cast(const(char)*) "chashu";
    auto chashu = cat(chashu_name);
    printf("[D] Our cat is: %s\n", chashu_name);
    chashu.meow();
    chashu.feed();
    chashu.meow();
}

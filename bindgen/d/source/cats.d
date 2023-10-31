@nogc nothrow:
extern (C++):
__gshared:

class cat
{
public:
    this(const(char)* name);
    const(char)* name() const;
    void feed();
    void meow() const;

private:
    const(char)* name_;
    bool is_hungry;
}

cat make_cat(const(char)* name);
const(char)* cat_name(const(cat)* c);
void cat_feed(cat* c);
void cat_meow(const(cat)* c);

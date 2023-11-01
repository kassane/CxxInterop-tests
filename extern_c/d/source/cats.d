@nogc nothrow:
extern (C):
__gshared:

struct cat
{
    const(char)* name_;
    bool is_hungry;
}

cat make_cat(const(char)* name);
const(char)* cat_name(const(cat)* c);
void cat_feed(cat* c);
void cat_meow(const(cat)* c);

import core.stdc.stdio : printf;
void main()
{
    printf("D language - extern C\n");
    const(char)* marshmallow_name = cast(const(char)*) "Marshmallow";
    auto marshmallow = make_cat(marshmallow_name);
    printf("Our cat is: %s\n",cat_name(&marshmallow));
    cat_meow(&marshmallow);
    cat_feed(&marshmallow);
    cat_meow(&marshmallow);
}

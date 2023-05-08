#include <string>
#include <iostream>

struct cat
{
    const char *name_;
};

extern "C"
{
    cat make_cat(const char *name);
    const char *cat_name(const cat *c);
    void cat_meow(cat *c);
}

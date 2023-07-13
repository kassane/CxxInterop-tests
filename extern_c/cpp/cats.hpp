#include <string>
#include <iostream>

struct cat
{
    const char *name_;
    bool is_hungry;
};

extern "C"
{
    cat make_cat(const char *name);
    const char *cat_name(const cat *c);
    void cat_feed(cat *c);
    void cat_meow(const cat *c);
}

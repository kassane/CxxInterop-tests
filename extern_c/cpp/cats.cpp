#include "cats.hpp"

cat make_cat(const char *name)
{
    return {name};
}

const char *cat_name(const cat *c)
{
    return c->name_;
}

void cat_meow(cat *c)
{
    std::cout << "meow\n";
}

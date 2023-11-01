#include "cats.hpp"

cat make_cat(const char *name)
{
    cat c{name, true};
    std::cout << "[C++] library says\n";
    return c;
}

const char *cat_name(const cat *c)
{
    return c->name_;
}

void cat_feed(cat *c)
{
    c->is_hungry = false;
}

void cat_meow(const cat *c)
{
    if (c->is_hungry)
    {
        std::cout << c->name_ << " is hungry\n";
    }
    else
    {
        std::cout << c->name_ << " is sleepy\n";
    }
}

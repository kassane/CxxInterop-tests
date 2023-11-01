#include "cats.hpp"

cat::cat(const char *name) : name_(name), is_hungry(true) { std::cout << "[C++] library says\n"; }

const char *cat::name() const { return name_; }

void cat::feed()
{
    is_hungry = false;
}

void cat::meow() const
{
    if (is_hungry)
    {
        std::cout << name_ << " is hungry\n";
    }
    else
    {
        std::cout << name_ << " is sleepy\n";
    }
}

#include <string>
#include <iostream>

class cat
{
public:
    cat(const char *name);
    const char *name() const;
    void feed();
    void meow() const;

private:
    const char *name_;
    bool is_hungry;
};

#include "../rust/target/cxxbridge/cats_cxx/src/main.rs.h"
#include <iostream>
void test()
{
    Cat marshmallow = make("Marshmallow");
    marshmallow.meow();
    std::cout << std::string(marshmallow.name());
}

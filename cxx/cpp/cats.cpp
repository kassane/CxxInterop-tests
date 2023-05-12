#include "../../target/cxxbridge/cats_cxx/src/main.rs.h"
#include <iostream>
void test()
{
    Cat nori = make("Nori");
    std::printf("Our cat's name is %s", std::string(nori.name()).c_str());
    nori.meow();
    nori.feed();
    nori.meow();
}

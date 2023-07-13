#include "../../target/cxxbridge/cats_cxx/src/main.rs.h"
#include <iostream>
void test()
{
    Cat nori = make("Nori");
    std::cout << "Our cat's name is " << std::string(nori.name()) << "\n";
    nori.meow();
    nori.feed();
    nori.meow();
}

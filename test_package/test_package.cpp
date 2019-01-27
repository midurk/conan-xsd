#include "hello.hxx"

#include <iostream>
#include <sstream>

const std::string hello_xml = R"&&&(<?xml version="1.0"?>
<hello>

  <greeting>Hello</greeting>

  <name>sun</name>
  <name>moon</name>
  <name>world</name>

</hello>  
)&&&";

int
main ()
{
  try
  {
    std::istringstream iss(hello_xml);

    std::unique_ptr<hello_t> h (hello(iss, xml_schema::flags::dont_validate));

    for (const auto & name : h->name()) {
      std::cout << h->greeting () << ", " << name << "!" << std::endl;
    }
  }
  catch (const xml_schema::exception& e)
  {
    std::cerr << e << std::endl;
    return 1;
  }
}
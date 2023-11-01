import Cats;

print("Swift language - extern C")

let marshmallowName = "Marshmallow"
var marshmallow = make_cat(marshmallowName)
print("Our cat is: \"\(String(cString: cat_name(&marshmallow)))\"\n")
cat_meow(&marshmallow)
cat_feed(&marshmallow) 
cat_meow(&marshmallow)
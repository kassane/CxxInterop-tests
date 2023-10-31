module d.source;
import cats;

void main()
{
	const(char)* marshmallow_name = cast(const(char)*)"Marshmallow";
    auto marshmallow = make_cat(marshmallow_name);
    cat_meow(&marshmallow);
    cat_feed(&marshmallow);
    cat_meow(&marshmallow);
}

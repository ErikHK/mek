include <inc/constants.scad>
use <shaft.scad>


module spacer(squares=[true])
{
  bar(length=0, square=squares);

}

spacer();

//bar(length=1, square=[true]);
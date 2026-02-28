/* Test MXU3 Peephole optimization to choice instruction 'bselv' */
/* { dg-options "-mmxu3 -ftree-vectorize" } */
/* { dg-skip-if "" { *-*-* } { "*" } { "-O2" } }*/
#include "mxu3-check.h"

int main(int argc,char *argv[])
{
	int x;
	if (argc > 1) x = 0; 
	else x = -1;
	v16i32 vrd = {x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x};
	v16i32 vrs = {1*argc,2*argc,3*argc,4*argc,5*argc,6*argc,7*argc,8*argc,9*argc,10*argc,11*argc,12*argc,13*argc,14*argc,15*argc,16*argc};
	v16i32 vrp = {-1*argc,-2*argc,-3*argc,-4*argc,-5*argc,-6*argc,-7*argc,-8*argc,-9*argc,-10*argc,-11*argc,-12*argc,-13*argc,-14*argc,-15*argc,-16*argc};
// vrd = ((vrp^vrs)&(vrd))^vrs ==>> bselv vrd,vrs,vrp 
	vrd = ((vrp^vrs)&(vrd))^vrs;
	
    int i;
	for (i = 0;i < 16; i ++)
	{
		if((x == 0 && vrd[i] != vrs[i]) || (x == -1 && vrd[i] != vrp[i]) )
			abort ();
	}
	
	return 0;
}
/* { dg-final { scan-assembler "\tbselv\t" } } */

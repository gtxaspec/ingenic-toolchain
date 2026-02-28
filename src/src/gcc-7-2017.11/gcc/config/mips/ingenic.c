/* Subroutines used for MIPS Ingenic special code generation.
   Copyright (C) 1989, 1990, 1991, 1993, 1994, 1995, 1996, 1997, 1998,
   1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
   2011, 2012

   Contributed by Qian Liu, qian.liu@ingenic.com.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

GCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING3.  If not see
<http://www.gnu.org/licenses/>.  */


/* For MXU2 instruction cost. The cost is insn's latency + 1 */
#define MXU2_LAT3_COST 4
#define MXU2_LAT4_COST 5
#define MXU2_LAT5_COST 6
#define MXU2_LAT6_COST 7
#define MXU2_LAT9_COST 10
#define MXU2_LAT33_COST 34
#define MXU2_LAT_MULT1_COST_M1 6
#define MXU2_LAT_MULT1_COST_M2 8
#define MXU2_LAT_MULT1_COST_M3 11
#define MXU2_LAT_MULT2_COST_M1 13
#define MXU2_LAT_MULT2_COST_M2 21
#define MXU2_LAT_MULT2_COST_M3 37
#define MXU2_LAT_MULT2_COST_M4 69
#define MXU2_LAT_MULT3_COST_M1 8
#define MXU2_LAT_MULT3_COST_M2 11
#define MXU2_LAT_MULT4_COST_M1 11
#define MXU2_LAT_MULT4_COST_M2 16
#define MXU2_LAT_MULT5_COST_M1 16
#define MXU2_LAT_MULT5_COST_M2 19

static int
mips_adjust_cost_ingenic (rtx_insn *insn ATTRIBUTE_UNUSED, rtx link,
			  rtx_insn *dep ATTRIBUTE_UNUSED, int cost)
{
  enum attr_lat_type dep_insn_type;
  enum machine_mode mode;
  dep_insn_type = get_attr_lat_type(dep);
  /* This return value all are latency + 1 */
  switch(dep_insn_type)
    {
    case LAT_TYPE_LAT_MULT1:
      mode = GET_MODE (XEXP (PATTERN (dep), 0));
      switch (mode)
      {
      case V16QImode:
      case V8HImode:
	return MXU2_LAT_MULT1_COST_M1;
      case V4SImode:
	return MXU2_LAT_MULT1_COST_M2;
      case V2DImode:
	return MXU2_LAT_MULT1_COST_M3;
      default:  break;
      }
      break;
    case LAT_TYPE_LAT_MULT2:
      mode = GET_MODE (XEXP (PATTERN (dep), 0));
      switch (mode)
      {
      case V16QImode:
        return MXU2_LAT_MULT2_COST_M1;
      case V8HImode:
        return MXU2_LAT_MULT2_COST_M2;
      case V4SImode:
        return MXU2_LAT_MULT2_COST_M3;
      case V2DImode:
        return MXU2_LAT_MULT2_COST_M4;
      default:  break;
      }
      break;
    case LAT_TYPE_LAT_MULT3:
       mode = GET_MODE (XEXP (PATTERN (dep), 0));
       if (mode == V4SFmode)
	 return MXU2_LAT_MULT3_COST_M1;
       else if (mode == V2DFmode)
	 return MXU2_LAT_MULT3_COST_M2;
       break;
    case LAT_TYPE_LAT_MULT4:
      mode = GET_MODE (XEXP (PATTERN (dep), 0));
      if (mode == V4SFmode)
	return MXU2_LAT_MULT4_COST_M1;
      else if (mode == V2DFmode)
	return MXU2_LAT_MULT4_COST_M2;
      break;
    case LAT_TYPE_LAT_MULT5:
      mode = GET_MODE (XEXP (PATTERN (dep), 0));
      if (mode == V4SFmode)
	return MXU2_LAT_MULT5_COST_M1;
      else if (mode == V2DFmode)
	return MXU2_LAT_MULT5_COST_M2;
      break;
    case LAT_TYPE_LAT3:  return MXU2_LAT3_COST;
    case LAT_TYPE_LAT4:  return MXU2_LAT4_COST;
    case LAT_TYPE_LAT5:  return MXU2_LAT5_COST;
    case LAT_TYPE_LAT6:  return MXU2_LAT6_COST;
    case LAT_TYPE_LAT9:  return MXU2_LAT9_COST;
    case LAT_TYPE_LAT33: return MXU2_LAT33_COST;
    default:
       break;
    }
  return cost;
}

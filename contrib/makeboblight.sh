#!/bin/bash

# boblight
# Copyright (C) Bob  2009 
#
# makeboblight.sh created by Adam Boeglin <adamrb@gmail.com>
# 
# boblight is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# boblight is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.


# Usage
#
# This script makes quite a few assumptions of your light system
#
# 1. You have your lights evenly spaced on each side they are on
# 2. You only have one device configured
# 3. Each color light is on the same device
# 4. Lights are arranged clockwise around monitor starting at the bottom center
# 5. Probably some other things I'm missing
#
# How to run:
# This should work on any *nix system with bash and 'bc' installed.
#
# Make the script executable (chmod +x makeboblight.sh), and run it with ./makeboblight.sh

clear

echo "***** Boblight Light Section Configuration Generator ******"
echo "Please answer the following questions.  Press [enter] for defaults."
echo

echo -n "What is the depth that the hscan and vscan should look into the screen? [13] "
read depth

echo -n "What is the dame of your light device from your [device] secion? [ambilight1] "
read devicename

echo -n "How many lights on the Left side? [0] "
read left

echo -n "How many lights on the Top? [0] "
read top

echo -n "How many lights on the Right side? [0] "
read right

echo -n "How many lights on the Bottom? [0] "
read bottom


# Set the defaults
left=${left:-0}
top=${top:-0}
right=${right:-0}
bottom=${bottom:-0}
devicename=${devicename:-ambilight1}
depth=${depth:-13}

total=$(expr $left + $top + $right + $bottom)

echo
echo "Total lights: $total"

echo
echo "Paste the content of the light sections inside your boblight.conf"
echo "Make sure there are no other sections containing [light] (unless you know you want them)"
echo
echo "------- Light section starts here ------"

current=1
colorcount=1


if [ $bottom -ne 0 ]; then
	bcount=1
	brange=$(echo "scale=2; 100 / $bottom" | bc)
	bcurrent=50

	while [ $bcount -le $(expr $bottom / 2 2>/dev/null) ]; do
		btop=$(echo "scale=2; $bcurrent - $brange" | bc)

		echo
		echo "[light]"
		echo "name            bottom$bcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $btop $bcurrent"
		echo "vscan           $(echo "scale=2; 100 - $depth" | bc) 100"


		bcurrent=$btop

		((bcount++))
		((current++))
	done
fi

if [ $left -ne 0 ]; then
	lcount=1
	lrange=$(echo "scale=2; 100 / $left" | bc)
	lcurrent=100

	while [ $lcount -le $left ]; do
		ltop=$(echo "scale=2; $lcurrent - $lrange" | bc)
		
		echo
		echo "[light]"
		echo "name            left$lcount"
		
		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount" 
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           0 $depth"
		echo "vscan           $ltop $lcurrent"

		lcurrent=$ltop

		((lcount++))
		((current++))
	done
fi


if [ $top -ne 0 ]; then
	tcount=1
	trange=$(echo "scale=2; 100 / $top" | bc)
	tcurrent=0

	while [ $tcount -le $top ]; do
		ttop=$(echo "scale=2; $tcurrent + $trange" | bc)

		echo
		echo "[light]"
		echo "name            top$tcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $tcurrent $ttop"
		echo "vscan           0 $depth"


		tcurrent=$ttop

		((tcount++))
		((current++))
	done
fi

if [ $right -ne 0 ]; then
	rcount=1
	rrange=$(echo "scale=2; 100 / $right" | bc)
	rcurrent=0

	while [ $rcount -le $right ]; do
		rtop=$(echo "scale=2; $rcurrent + $rrange" | bc)

		echo
		echo "[light]"
		echo "name            right$rcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $(echo "scale=2; 100 - $depth" | bc) 100"
		echo "vscan           $rcurrent $rtop"

		rcurrent=$rtop

		((rcount++))
		((current++))
	done
fi


if [ $bottom -ne 0 ]; then
	bcurrent=100

	while [ $bcount -le $bottom ]; do
		btop=$(echo "scale=2; $bcurrent - $brange" | bc)

		echo
		echo "[light]"
		echo "name            bottom$bcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $btop $bcurrent"
		echo "vscan           $(echo "scale=2; 100 - $depth" | bc) 100"


		bcurrent=$btop

		((bcount++))
		((current++))
	done
fi

echo
echo "------- Light section ends here ------"

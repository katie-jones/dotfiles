#!/bin/bash

echo "Section \"InputClass\"
        Identifier \"touchpad catchall\"
        Driver \"synaptics\"
        MatchIsTouchpad \"on\""

synclient | gawk 'NF>2 { if (/Delta/) { num=-$3 printf "\t%s=%g\n", $1, num } }'


echo "MatchDevicePath \"/dev/input/event*\"
EndSection"

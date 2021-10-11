#!/bin/bash

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#e6cd69cc'  # default
T='#55b5dbee'  # text
W='#cd3f45ff'  # wrong
V='#43a5d5bb'  # verifying
VT='Hmmm...'
WT='Nah'
IT='Empty'

i3lock								\
--verif-text=$VT				\
--wrong-text=$WT				\
--noinput-text=$IT			\
--insidever-color=$C		\
--ringver-color=$V     \
\
--insidewrong-color=$C \
--ringwrong-color=$W   \
\
--inside-color=$B      \
--ring-color=$D        \
--line-color=$B        \
--separator-color=$D   \
\
--verif-color=$T       \
--wrong-color=$T       \
--time-color=$T        \
--date-color=$T        \
--layout-color=$T      \
--keyhl-color=$V       \
--bshl-color=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--time-str="%H:%M:%S"  \
--date-str="%A, %m %Y" \
--keylayout 2         \

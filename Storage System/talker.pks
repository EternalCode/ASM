#dyn 0x740000
#org @start
lock
faceplayer
copybyte 0x20370D0 0x203C000 ' storage count into last result
compare LASTRESULT 0x0
if == jump @putOnly
msgbox @add
callstd MSG_YESNO 'want to take?
compare LASTRESULT 0x1
if == jump @addParty
jump @putOnly

#org @putOnly
countpokemon
copyvar 0x8000 0x800D
compare 0x8000 0x1
if <= jump @greetings
msgbox @put
callstd MSG_YESNO 'want to put?
compare LASTRESULT 0x1
if == jump @addStorage
msgbox @exit
callstd MSG_NORMAL
release
end

#org @addStorage
setvar 0x8000 0x1
special 0x9F
waitspecial
countpokemon
compare LASTRESULT 0x8004
if < jump @noSelection
callasm 0x8800051
msgbox @gave
callstd MSG_NORMAL
release
end


#org @addParty
setvar 0x8000 0x0
countpokemon
compare LASTRESULT 0x6
if == jump @fullP
msgbox @store
callstd MSG_NORMAL
setvar 0x8004 0x0 'gotta rework this to work a better way
callasm 0x8800051'Takes Pokemon from slot specified
fanfare 0x101
msgbox @complete
callstd MSG_NORMAL
release
end

#org @greetings
msgbox @hello
callstd MSG_NORMAL
release
end

#org @fullP
msgbox @full
callstd MSG_NORMAL
release
end

#org @noSelection
msgbox @exit
callstd MSG_NORMAL
release
end

#org @full
= You're full!

#org @hello
= Hi, I can't do anything\nyour slots are full[.]

#org @complete
= I gave it back

#org @store
= Alright I'll give one.

#org @gave
= Thanks for giving me this.

#org @exit
= Alright, next time then.

#org @add
= want a Pokemon?

#org @put
= want to give me a pokemon?
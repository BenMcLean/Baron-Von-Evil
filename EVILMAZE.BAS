' This game was created by Benjamin McLean
' Email me at mclean.ben@gmail.com
'
' Modding, making new levels, adding new elements is all encouraged!
' Not a good example of programming!
' I made this back in middle school and I'm in college now. LOL!

DECLARE SUB PrintMapChar (W$)
DECLARE SUB Intro ()
DECLARE SUB DrawBorder ()
DECLARE SUB DrawScreen ()
DECLARE SUB DoInve ()
DECLARE SUB Center (Row%, Text$)
DECLARE SUB LookAheadNorth ()
DECLARE SUB LookAheadSouth ()
DECLARE SUB LookAheadEast ()
DECLARE SUB LookAheadWest ()
DECLARE SUB SneakSound1 ()
DECLARE SUB SneakSound2 ()
DECLARE SUB Dissolve ()
DECLARE SUB Sit ()
DECLARE SUB RefreshScreen ()
DECLARE SUB MiniMap ()
DECLARE SUB FightStoneMonster ()
DECLARE SUB DeadMonster (D%)
DECLARE SUB DefeatMonsterFX ()
DECLARE SUB WallAhead (Distance%, Turn%)
DECLARE SUB SeeTurn (Distance%, Turn%)
DECLARE SUB StoneMonster (D%)
DECLARE SUB Gem (D%, Clr%)
DECLARE SUB GemFX ()
DECLARE SUB Gun (D%)
DECLARE SUB Door (Distance%)
DECLARE SUB SadSound ()
DECLARE SUB Entertain ()
DECLARE SUB Coin (D%)
DECLARE SUB CoinFX ()
DECLARE SUB LoadLev ()
DECLARE SUB SeeTeleport (D%)
DECLARE SUB Teleport ()
DECLARE SUB TheEnd ()
DECLARE SUB Bye ()

DIM SHARED R%
DIM SHARED C%
DIM SHARED WAY%
DIM SHARED WideCol%
DIM SHARED WideRow%
DIM SHARED StartRow%
DIM SHARED StartCol%
DIM SHARED Weapons%
DIM SHARED Diamond%
DIM SHARED Emrald%
DIM SHARED Ruby%
DIM SHARED Coins%
LET Weapons% = 0
LET WideRow% = 23
LET WideCol% = 67
LET StartRow% = 2
LET StartCol% = 34
LET WAY% = 3
LET R% = StartRow%
LET C% = StartCol%
LET Diamond% = 0
LET Emrald% = 0
LET Ruby% = 0
LET Coins% = 0
DIM SHARED M%(100, 100)

CONST DefaultC = 15
CONST BorderC = 15
CONST MonsterC = 7
CONST GemC = 9
CONST RubyC = 12
CONST EmraldC = 10
CONST DiamondC = 11
CONST PurpleC = 13
CONST CoinC = 14

LET D% = 6

SCREEN 0: WIDTH 80, 25: VIEW PRINT 1 TO 25: COLOR DefaultC, 0: CLS

Intro

LoadLev

COLOR DefaultC, 0: CLS

DrawBorder

WhatNow:
RefreshScreen

IF M%(R%, C%) = ASC("M") THEN FightStoneMonster
IF M%(R%, C%) = ASC("T") THEN Sit: Teleport
IF M%(R%, C%) = ASC("D") THEN GemFX: LET Diamond% = Diamond% + 1: LET M%(R%, C%) = ASC(" "): DoInve
IF M%(R%, C%) = ASC("E") THEN GemFX: LET Emrald% = Emrald% + 1: LET M%(R%, C%) = ASC(" "): DoInve
IF M%(R%, C%) = ASC("R") THEN GemFX: LET Ruby% = Ruby% + 1: LET M%(R%, C%) = ASC(" "): DoInve
IF M%(R%, C%) = ASC("C") THEN CoinFX: LET Coins% = Coins% + 1: LET M%(R%, C%) = ASC(" "): DoInve
IF M%(R%, C%) = ASC("W") THEN SadSound: LET Weapons% = Weapons% + 1: LET M%(R%, C%) = ASC(" "): DoInve

DO
SELECT CASE UCASE$(INKEY$)
CASE CHR$(27)
Bye
CASE CHR$(0) + "P"
GOSUB Backwards
EXIT DO
CASE CHR$(0) + "K"
' Left
IF WAY% = 1 THEN LET WAY% = 4: EXIT DO
IF WAY% = 2 THEN LET WAY% = 1: EXIT DO
IF WAY% = 3 THEN LET WAY% = 2: EXIT DO
IF WAY% = 4 THEN LET WAY% = 3: EXIT DO
CASE CHR$(0) + "M"
' Right
IF WAY% = 1 THEN LET WAY% = 2: EXIT DO
IF WAY% = 2 THEN LET WAY% = 3: EXIT DO
IF WAY% = 3 THEN LET WAY% = 4: EXIT DO
IF WAY% = 4 THEN LET WAY% = 1: EXIT DO
CASE CHR$(0) + "H"
' Forewards
 GOSUB Forewards
 EXIT DO
CASE "8"
 LET WAY% = 1
 GOSUB Forewards
 EXIT DO
CASE "W"
 LET WAY% = 1
 GOSUB Forewards
 EXIT DO
CASE "6"
 LET WAY% = 2
 GOSUB Forewards
 EXIT DO
CASE "D"
 LET WAY% = 2
 GOSUB Forewards
 EXIT DO
CASE "2"
 LET WAY% = 3
 GOSUB Forewards
 EXIT DO
CASE "S"
 LET WAY% = 3
 GOSUB Forewards
 EXIT DO
CASE "A"
 LET WAY% = 4
 GOSUB Forewards
 EXIT DO
CASE "4"
 LET WAY% = 4
 GOSUB Forewards
 EXIT DO
CASE ELSE
REM
END SELECT
LOOP
GOTO WhatNow

Forewards:
SELECT CASE WAY%
CASE 1
IF NOT M%(R% - 1, C%) = ASC("X") THEN LET R% = R% - 1
CASE 2
IF NOT M%(R%, C% + 1) = ASC("X") THEN LET C% = C% + 1
CASE 3
IF NOT M%(R% + 1, C%) = ASC("X") THEN LET R% = R% + 1
CASE 4
IF NOT M%(R%, C% - 1) = ASC("X") THEN LET C% = C% - 1
CASE ELSE
REM
END SELECT
RETURN

Backwards:
SELECT CASE WAY%
CASE 1
IF NOT M%(R% + 1, C%) = ASC("X") THEN LET R% = R% + 1
CASE 2
IF NOT M%(R%, C% - 1) = ASC("X") THEN LET C% = C% - 1
CASE 3
IF NOT M%(R% - 1, C%) = ASC("X") THEN LET R% = R% - 1
CASE 4
IF NOT M%(R%, C% + 1) = ASC("X") THEN LET C% = C% + 1
CASE ELSE
REM
END SELECT
RETURN

SUB Bye
COLOR DefaultC, 0
CLS
DrawBorder
Door 1
COLOR 12, 0: Center 6, "Press any key to Exit"
COLOR 9, 0
Sit
SCREEN 0: WIDTH 80, 25: COLOR 7, 0
CLS
CLS
END

END SUB

SUB Center (Row%, Text$)
    LOCATE Row%, 41 - LEN(Text$) / 2
    PRINT Text$
END SUB

SUB Coin (D%)
COLOR CoinC, 0
SELECT CASE D%
CASE 5
LOCATE 11, 39: PRINT "."
CASE 4
LOCATE 12, 38: PRINT "o"
CASE 3
LOCATE 13, 36: PRINT "()"
CASE 2
LOCATE 13, 34: PRINT "‹ﬂ‹"
LOCATE 14, 33: PRINT "€ õ €"
LOCATE 15, 34: PRINT "ﬂ‹ﬂ"
CASE 1
LOCATE 13, 32: PRINT "‹‹‹"
LOCATE 14, 30: PRINT "‹€ONE€‹"
LOCATE 15, 30: PRINT "€COIN!€"
LOCATE 16, 30: PRINT "ﬂ€ õ €ﬂ"
LOCATE 17, 32: PRINT "ﬂﬂﬂ"
END SELECT
COLOR DefaultC, 0

END SUB

SUB CoinFX
FOR this% = 1 TO 10
GemFX
NEXT this%
END SUB

SUB DeadMonster (D%)
COLOR 8
SELECT CASE D%
CASE 5
LOCATE 11, 40: PRINT "x";
CASE 4
LOCATE 12, 39: PRINT "xxx";
CASE 3
LOCATE 14, 37: PRINT "xxxxxxx";
CASE 2
LOCATE 15, 35: PRINT "xxxxxxxxxxx";
CASE 1
LOCATE 17, 33: PRINT "xxxxxxxxxxxxxxx";
END SELECT
COLOR DefaultC
END SUB

SUB DefeatMonsterFX
' This sound came from the game "SPACE TREK."

TP1 = .1
        TP2 = 200
        FOR TP3 = 1 TO 1
        T# = TIMER: WHILE TIMER - T# < .4: WEND
        FOR TP4 = 1 TO 10
        TP5 = TP4 * TP2
        SOUND TP5, TP1
        NEXT TP4
        FOR TP4 = 10 TO 1 STEP -1
        TP5 = TP4 * TP2
        SOUND TP5, TP1
        NEXT TP4
        NEXT TP3
FOR A = 1 TO 100
        J = RND(1) * 100 + 40
        SOUND J, .1
        NEXT
END SUB

SUB Dissolve
'*******************************************************************************
'*  use instead of cls for an interesting way to clear the screen              *
'*******************************************************************************

    DIM ScreenPos%(2000)
    FOR CLSX% = 1 TO 2000
        ScreenPos%(CLSX%) = CLSX%
    NEXT CLSX%

    FOR CLSX% = 1 TO 2000
        SWAP ScreenPos%(CLSX%), ScreenPos%(INT(RND(1) * 2000) + 1)
    NEXT CLSX%

    FOR CLSX% = 1 TO 2000
        CLSR% = ScreenPos%(CLSX%) \ 80 + 1
        IF CLSR% = 0 THEN CLSR% = 1
        IF CLSR% > 25 THEN CLSR% = 25
        CLSC% = ABS(ScreenPos%(CLSX%) - (80 * CLSR%))
        IF CLSC% = 0 THEN CLSC% = 1
        LOCATE CLSR%, CLSC%
        PRINT " ";
    NEXT CLSX%

    LOCATE 1, 80: PRINT " ";   ' cheap temporary fix
    CLS : ' even cheaper temporary fix
END SUB

SUB DoInve
LOCATE 3, 4: COLOR DefaultC
PRINT CHR$(18); " ";
SELECT CASE WAY%
CASE 1
PRINT "North"
CASE 2
PRINT "East "
CASE 3
PRINT "South"
CASE 4
PRINT "West "
END SELECT

LOCATE 5, 5: COLOR MonsterC
PRINT USING CHR$(214) + "##"; Weapons%
LOCATE 6, 4: COLOR CoinC
PRINT USING "## " + CHR$(155); Coins%
LOCATE 7, 5: COLOR GemC
PRINT USING CHR$(4) + "##"; Gems%
LOCATE 8, 5: COLOR PurpleC
PRINT USING CHR$(4) + "##"; Purple%
LOCATE 9, 5: COLOR RubyC
PRINT USING CHR$(4) + "##"; Ruby%
LOCATE 10, 5: COLOR EmraldC
PRINT USING CHR$(4) + "##"; Emrald%
LOCATE 11, 5: COLOR DiamondC
PRINT USING CHR$(4) + "##"; Diamond%

COLOR DefaultC
' LOCATE 5, 65
' PRINT "T";
' LOCATE 6, 63
' PRINT "F "; CHR$(4); " H";
' LOCATE 7, 65
' PRINT "G";
END SUB

SUB Door (Distance%)
SELECT CASE Distance%
CASE 5
 LOCATE 10, 40: COLOR 12, 0: PRINT CHR$(240);
 LOCATE 11, 40: COLOR 2, 1: PRINT CHR$(220);
CASE 4
 ' LOCATE 10, 38: COLOR 6, 0: PRINT "/";
 ' LOCATE 11, 38: COLOR 6, 0: PRINT " ";
 ' LOCATE 12, 38: COLOR 6, 0: PRINT " ";
 ' LOCATE 13, 38: COLOR 6, 0: PRINT "/";
 LOCATE 9, 39: COLOR 12, 0:  PRINT STRING$(3, 240)
 LOCATE 10, 39: COLOR 2, 1: PRINT "   ";
 LOCATE 11, 39: COLOR 2, 1: PRINT STRING$(3, 220);
 LOCATE 12, 39: COLOR 2, 7: PRINT STRING$(3, 220);
CASE 3
 LOCATE 8, 37: COLOR 12, 0:  PRINT STRING$(7, 240);
 LOCATE 9, 37: COLOR 15, 1:  PRINT "       ";
 LOCATE 10, 37: COLOR 15, 1: PRINT "       ";
 LOCATE 11, 37: COLOR 15, 2: PRINT "       ";
 LOCATE 12, 37: COLOR 14, 7: PRINT "- - - -";
 LOCATE 13, 37: COLOR 15, 2: PRINT "       ";
 ' COLOR 6, 0
 ' LOCATE 9, 36:    PRINT "/";
 ' LOCATE 10, 34: PRINT "/  ";
 ' LOCATE 11, 34: PRINT "   ";
 ' LOCATE 12, 34: PRINT "   ";
 ' LOCATE 13, 34: PRINT "  /";
 ' LOCATE 14, 34: PRINT "/";
CASE 2
 LOCATE 8, 36: COLOR 12, 0:  PRINT "ESC" + STRING$(2, 240) + "Exit";
 LOCATE 9, 36: COLOR 15, 1:  PRINT "         ";
 LOCATE 10, 36: COLOR 15, 1: PRINT "         ";
 LOCATE 11, 36: COLOR 2, 1: PRINT STRING$(9, 220);
 LOCATE 12, 36: COLOR 15, 2: PRINT "         ";
 LOCATE 13, 36: COLOR 14, 7: PRINT " - - - - ";
 LOCATE 14, 36: COLOR 15, 2:  PRINT "         ";
CASE 1
 LOCATE 6, 32: COLOR 12, 0:   PRINT "Press ESC to Exit";
 LOCATE 7, 33: COLOR 1, 0:    PRINT STRING$(15, 220);
 LOCATE 8, 33: COLOR 15, 1:   PRINT "               ";
 LOCATE 9, 33: COLOR 15, 1:   PRINT "               ";
 LOCATE 10, 33: COLOR 15, 1:  PRINT "               ";
 LOCATE 11, 33: COLOR 15, 1:  PRINT "               ";
 LOCATE 12, 33: COLOR 1, 2:   PRINT "               ";
 ' LOCATE 12, 33: COLOR 2, 1: PRINT STRING$(15, 220);
 LOCATE 13, 33: COLOR 0, 2:   PRINT "               "
 LOCATE 14, 33: COLOR 14, 7:  PRINT " _ _ _ _ _ _ _ ";
 LOCATE 15, 33: COLOR 2, 7:   PRINT "               ";
 ' LOCATE 15, 33: COLOR 2, 7: PRINT STRING$(15, 220);
 LOCATE 16, 33: COLOR 0, 2:   PRINT "               ";
END SELECT

COLOR DefaultC, 0
END SUB

SUB DrawBorder
COLOR DefaultC, 0
Center 1, "Baron Von Evil's Mansion"
LOCATE 1, 1
PRINT "…Õª"
PRINT "»ÕŒ"; STRING$(73, "Õ"); "ŒÕº";
LOCATE 1, 77: PRINT "…Õª";
FOR this% = 3 TO 23
LOCATE this%, 3: PRINT "∫";
LOCATE this%, 77: PRINT "∫";
NEXT this%
LOCATE 24, 1: PRINT "…ÕŒ"; STRING$(73, "Õ"); "ŒÕª";
LOCATE 25, 1: PRINT "»Õº";
LOCATE 25, 1: PRINT "»Õº";
LOCATE 25, 77: PRINT "»Õº";
END SUB

SUB DrawScreen
COLOR DefaultC
LOCATE 3, 24: PRINT "…ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒª";
LOCATE 4, 24: PRINT "≥  \                         /  ≥"
LOCATE 5, 24: PRINT "≥    \                     /    ≥"
LOCATE 6, 24: PRINT "≥      \                 /      ≥"
LOCATE 7, 24: PRINT "≥        \             /        ≥"
LOCATE 8, 24: PRINT "≥          \         /          ≥"
LOCATE 9, 24: PRINT "≥            \     /            ≥"
LOCATE 10, 24: PRINT "≥              \ /              ≥"
LOCATE 11, 24: PRINT "≥              / \              ≥"
LOCATE 12, 24: PRINT "≥            /     \            ≥"
LOCATE 13, 24: PRINT "≥          /         \          ≥"
LOCATE 14, 24: PRINT "≥        /             \        ≥"
LOCATE 15, 24: PRINT "≥      /                 \      ≥"
LOCATE 16, 24: PRINT "≥    /                     \    ≥"
LOCATE 17, 24: PRINT "≥  /                         \  ≥"
LOCATE 18, 24: PRINT "»ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒº"

END SUB

SUB Entertain
' The Entertainer
PLAY "T175 MFo3L16dd+el8>c<l16e>l8c<l16e>l4cl16dd+ecdecl8dl8cg>cp8 T500 MB"

END SUB

SUB FightStoneMonster
Center 19, "The Stone Monster:"
LOCATE 20, 4: PRINT "HA! If you are clever enough to defeat me, you'll still never get past...";
LOCATE 21, 4: PRINT "MY WALL! ";
SneakSound1
INPUT "Do you want to fight me??? ", Fight$
IF INSTR(UCASE$(Fight$), "Y") THEN GOTO FightStoneMonsterNow
LOCATE 22, 4: PRINT "Too scared, huh? We can fight later!";
Sit
SELECT CASE WAY%
CASE 1
IF NOT M%(R% + 1, C%) = ASC("X") THEN LET R% = R% + 1
CASE 2
IF NOT M%(R%, C% - 1) = ASC("X") THEN LET C% = C% - 1
CASE 3
IF NOT M%(R% - 1, C%) = ASC("X") THEN LET R% = R% - 1
CASE 4
IF NOT M%(R%, C% + 1) = ASC("X") THEN LET C% = C% + 1
END SELECT
CLS
RefreshScreen
EXIT SUB

FightStoneMonsterNow:

IF Weapons% = 0 THEN
 CLS
 DrawBorder
 LOCATE 3, 4
 PRINT "He kills you. You're DEAD! DEAD, DEAD, DEAD!!!";
 StoneMonster 1
 ' Game Over Sound
 PLAY "T160 MF MS O1 L4dL6dL16dL4d L6fL16eL6eL16dL6dL16c+L2d MB"
 Sit
 Bye
END IF

CLS
RefreshScreen
SneakSound2
LOCATE 20, 4: PRINT "Very well. Let the fighting begin!!!";
LOCATE 21, 4: PRINT "You fight him as hard as you can.";
LOCATE 22, 4: PRINT "But you eventually defeat him.";
LET M%(R%, C%) = ASC("m")
Sit
DefeatMonsterFX
CLS
RefreshScreen
LOCATE 19, 4: PRINT "He's dead.";
LOCATE 20, 4: PRINT "You might be able to make out a dead monster on your screen.";
LOCATE 21, 4: PRINT "It looks like all his wall needed was a good swift kick.";
LOCATE 23, 4: PRINT "Press any key to continue your adventure...";
Entertain
Sit
CLS
RefreshScreen

END SUB

SUB Gem (D%, Clr%)
COLOR Clr%, 0
SELECT CASE D%
CASE 5
LOCATE 11, 41: PRINT ""
CASE 4
LOCATE 11, 42: PRINT "/\"
LOCATE 12, 42: PRINT "\/"
CASE 3
LOCATE 12, 43: PRINT "/*\"
LOCATE 13, 43: PRINT "\*/"
CASE 2
LOCATE 13, 44: PRINT "/*\"
LOCATE 14, 43: PRINT "<***>"
LOCATE 15, 44: PRINT "\*/"
CASE 1
LOCATE 13, 46: PRINT "/*\"
LOCATE 14, 45: PRINT "/***\"
LOCATE 15, 44: PRINT "<*****>"
LOCATE 16, 45: PRINT "\***/"
LOCATE 17, 46: PRINT "\*/"
END SELECT
COLOR DefaultC, 0
END SUB

SUB GemFX
PLAY "T500 MB L25 O5 G O6 C"
END SUB

SUB Gun (D%)
COLOR CoinC, 0
SELECT CASE D%
CASE 5
LOCATE 11, 40: PRINT "©"
CASE 4
LOCATE 12, 39: PRINT "’Õ"
CASE 3
LOCATE 12, 38: PRINT "/>>Ø"
LOCATE 13, 38: PRINT "í"
CASE 2
LOCATE 13, 38: PRINT "/>>>‰"
LOCATE 14, 38: PRINT "í"
CASE 1
LOCATE 13, 36: PRINT "REALLY BIG"
LOCATE 14, 37: PRINT "€ﬂﬂﬂﬂﬂﬂﬂ"
LOCATE 15, 37: PRINT "ﬂ"
LOCATE 15, 39: PRINT "GUN!"
END SELECT
COLOR DefaultC, 0
END SUB

SUB Intro
' CLS
' DrawBorderCenter 3, ""

PLAY "MF ML O4 L8C L64<BB-AA- L16G L64A-AB-B> L8C MB MN"

' LOCATE 13, 4: PRINT ""
' Center 20, "Tune in next time for..."
' Center 22, "Baron Von Evil's Other Mansion"
' Sit

END SUB

SUB LoadLev
DIM MR$(WideRow%)
 LET MR$(1) = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
 LET MR$(2) = "XEX   D        D      D         X#X         D      D       D    XEX"
 LET MR$(3) = "X X XXXXXXXXXXXXXXXXXXXXXXXXXXX X X XXXXXXXXXXXXXXXXXXXXXXXXXXX X X"
 LET MR$(4) = "X     D        X      D                     D      X       D      X"
 LET MR$(5) = "XXXXXXXXXXXXXX X XXXXXXXXXXXXXX X X XXXXXXXXXXXXXX X XXXXXXXXXXXXXX"
 LET MR$(6) = "X     D        X      D    X    X X    X    D      X       D      X"
 LET MR$(7) = "X XXXXXXXXXXXXXXXXXXXXXXXX X XXXX XXXX X XXXXXXXXXXXXXXXXXXXXXXXX X"
 LET MR$(8) = "X     D        D      D    X XXDEDEDXX X    D      D       D      X"
 LET MR$(9) = "X XXXXXXXXXXXXXXXXXXXXXXXX X XXEXEXEXX X XXXXXXXXXXXXXXXXXXXXXXXX X"
LET MR$(10) = "X XR X   X   X   X   X   X X XXDEREDXX X X   X   X   X   X   X RX X"
LET MR$(11) = "X XX X X X X X X X X X X X X XXEXEXEXX X X X X X X X X X X X X XX X"
LET MR$(12) = "X XX   X   X   X   X   X   X XXDEDEDXX X   X   X   X   X   X   XX X"
LET MR$(13) = "X XXXXXXXXXXXXXXXXXXXXXXXX X XXXX XXXX X XXXXXXXXXXXXXXXXXXXXXXXX X"
LET MR$(14) = "X     D        D      D    XE   R R   EX    D      D       D      X"
LET MR$(15) = "XXXXXXXXXXXXXXXXXXXXXXXXXX X XXXX XXXX X XXXXXXXXXXXXXXXXXXXXXXXXXX"
LET MR$(16) = "X                    CX    X    X X    X    XC                    X"
LET MR$(17) = "X                   X X XXXXXXX X X XXXXXXX X X                   X"
LET MR$(18) = "X                   X   X    CX XMX XC    X   X                   X"
LET MR$(19) = "X                   X XXX XXX X X X X XXX XXX X                   X"
LET MR$(20) = "X                   X       X X X X X X       X                   X"
LET MR$(21) = "X XEXXXXXXXXXXXXXXXXXXXXXXX X X X X X X XXXXXXXXXXXXXXXXXXXXXXXEX X"
LET MR$(22) = "XEX                      CX     XTX     XW                      XEX"
LET MR$(23) = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

FOR this% = 1 TO WideRow%
FOR THAT% = 1 TO WideCol%
LET M%(this%, THAT%) = ASC(MID$(MR$(this%), THAT%, 1))
NEXT THAT%
NEXT this%

END SUB

SUB LookAheadEast
LET ForeSight% = 6
IF M%(R%, C% + 1) = ASC("X") THEN LET ForeSight% = 1: GOTO ReadyEast
IF M%(R%, C% + 2) = ASC("X") THEN LET ForeSight% = 2: GOTO ReadyEast
IF M%(R%, C% + 3) = ASC("X") THEN LET ForeSight% = 3: GOTO ReadyEast
IF M%(R%, C% + 4) = ASC("X") THEN LET ForeSight% = 4: GOTO ReadyEast
IF M%(R%, C% + 5) = ASC("X") THEN LET ForeSight% = 5: GOTO ReadyEast

ReadyEast:

IF ForeSight% > 1 AND ForeSight% < 6 THEN
 LET TurnWall% = 0
 IF NOT M%(R% - 1, C% + ForeSight% - 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% + 1, C% + ForeSight% - 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF ForeSight% = 1 THEN
 LET TurnWall% = 0
 IF NOT M%(R% - 1, C%) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% + 1, C%) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF R% > 3 THEN
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% - 1, C% + 4) = ASC("X") THEN SeeTurn 5, 1
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% + 1, C% + 4) = ASC("X") THEN SeeTurn 5, 2
END IF

IF R% > 2 THEN
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% - 1, C% + 3) = ASC("X") THEN SeeTurn 4, 1
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% + 1, C% + 3) = ASC("X") THEN SeeTurn 4, 2
END IF

IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% - 1, C% + 2) = ASC("X") THEN SeeTurn 3, 1
IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% + 1, C% + 2) = ASC("X") THEN SeeTurn 3, 2

IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% - 1, C% + 1) = ASC("X") THEN SeeTurn 2, 1
IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% + 1, C% + 1) = ASC("X") THEN SeeTurn 2, 2

IF NOT ForeSight% = 1 AND NOT M%(R% - 1, C%) = ASC("X") THEN SeeTurn 1, 1
IF NOT ForeSight% = 1 AND NOT M%(R% + 1, C%) = ASC("X") THEN SeeTurn 1, 2

FOR this% = ForeSight% TO 0 STEP -1
IF M%(R%, C% + this%) = ASC("D") THEN Gem this% + 1, DiamondC
IF M%(R%, C% + this%) = ASC("E") THEN Gem this% + 1, EmraldC
IF M%(R%, C% + this%) = ASC("R") THEN Gem this% + 1, RubyC
IF M%(R%, C% + this%) = ASC("T") THEN SeeTeleport this% + 1
IF M%(R%, C% + this%) = ASC("C") THEN Coin this% + 1
IF M%(R%, C% + this%) = ASC("W") THEN Gun this% + 1
IF M%(R%, C% + this%) = ASC("M") THEN StoneMonster this% + 1
IF M%(R%, C% + this%) = ASC("m") THEN DeadMonster this% + 1
NEXT this%

END SUB

SUB LookAheadNorth
1 LET ForeSight% = 6
IF M%(R% - 1, C%) = ASC("X") THEN LET ForeSight% = 1: GOTO ReadyNorth
IF M%(R% - 2, C%) = ASC("X") THEN LET ForeSight% = 2: GOTO ReadyNorth
IF M%(R% - 3, C%) = ASC("X") THEN LET ForeSight% = 3: GOTO ReadyNorth
IF M%(R% - 4, C%) = ASC("X") THEN LET ForeSight% = 4: GOTO ReadyNorth
IF M%(R% - 5, C%) = ASC("X") THEN LET ForeSight% = 5: GOTO ReadyNorth

ReadyNorth:

IF ForeSight% > 1 AND ForeSight% < 6 THEN
 LET TurnWall% = 0
 IF NOT M%(R% - ForeSight% + 1, C% - 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% - ForeSight% + 1, C% + 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF ForeSight% = 1 THEN
 LET TurnWall% = 0
 IF NOT M%(R%, C% - 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R%, C% + 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF R% > 3 THEN
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% - 4, C% - 1) = ASC("X") THEN SeeTurn 5, 1
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% - 4, C% + 1) = ASC("X") THEN SeeTurn 5, 2
END IF

IF R% > 2 THEN
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% - 3, C% - 1) = ASC("X") THEN SeeTurn 4, 1
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% - 3, C% + 1) = ASC("X") THEN SeeTurn 4, 2
END IF

IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% - 2, C% - 1) = ASC("X") THEN SeeTurn 3, 1
IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% - 2, C% + 1) = ASC("X") THEN SeeTurn 3, 2

IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% - 1, C% - 1) = ASC("X") THEN SeeTurn 2, 1
IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% - 1, C% + 1) = ASC("X") THEN SeeTurn 2, 2
IF NOT ForeSight% = 1 AND NOT M%(R%, C% - 1) = ASC("X") THEN SeeTurn 1, 1
IF NOT ForeSight% = 1 AND NOT M%(R%, C% + 1) = ASC("X") THEN SeeTurn 1, 2

FOR this% = ForeSight% TO 0 STEP -1
IF M%(R% - this%, C%) = ASC("D") THEN Gem this% + 1, DiamondC
IF M%(R% - this%, C%) = ASC("E") THEN Gem this% + 1, EmraldC
IF M%(R% - this%, C%) = ASC("R") THEN Gem this% + 1, RubyC
IF M%(R% - this%, C%) = ASC("C") THEN Coin this% + 1
IF M%(R% - this%, C%) = ASC("T") THEN SeeTeleport this% + 1
IF M%(R% - this%, C%) = ASC("W") THEN Gun this% + 1
IF M%(R% - this%, C%) = ASC("M") THEN StoneMonster this% + 1
IF M%(R% - this%, C%) = ASC("m") THEN DeadMonster this% + 1
IF M%(R% - this%, C%) = ASC("#") THEN Door this% + 1
NEXT this%

END SUB

SUB LookAheadSouth
LET ForeSight% = 6
IF M%(R% + 1, C%) = ASC("X") THEN LET ForeSight% = 1: GOTO ReadySouth
IF M%(R% + 2, C%) = ASC("X") THEN LET ForeSight% = 2: GOTO ReadySouth
IF M%(R% + 3, C%) = ASC("X") THEN LET ForeSight% = 3: GOTO ReadySouth
IF M%(R% + 4, C%) = ASC("X") THEN LET ForeSight% = 4: GOTO ReadySouth
IF M%(R% + 5, C%) = ASC("X") THEN LET ForeSight% = 5: GOTO ReadySouth

ReadySouth:

IF ForeSight% > 1 AND ForeSight% < 6 THEN
 LET TurnWall% = 0
 IF NOT M%(R% + ForeSight% - 1, C% + 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% + ForeSight% - 1, C% - 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF ForeSight% = 1 THEN
 LET TurnWall% = 0
 IF NOT M%(R%, C% + 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R%, C% - 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF NOT R% < 3 THEN
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% + 4, C% + 1) = ASC("X") THEN SeeTurn 5, 1
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% + 4, C% - 1) = ASC("X") THEN SeeTurn 5, 2
END IF

IF NOT R% < 2 THEN
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% + 3, C% + 1) = ASC("X") THEN SeeTurn 4, 1
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% + 3, C% - 1) = ASC("X") THEN SeeTurn 4, 2
END IF

IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% + 2, C% + 1) = ASC("X") THEN SeeTurn 3, 1
IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% + 2, C% - 1) = ASC("X") THEN SeeTurn 3, 2

IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% + 1, C% + 1) = ASC("X") THEN SeeTurn 2, 1
IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% + 1, C% - 1) = ASC("X") THEN SeeTurn 2, 2
IF NOT ForeSight% < 3 AND NOT M%(R%, C% + 1) = ASC("X") THEN SeeTurn 1, 1
IF NOT ForeSight% < 3 AND NOT M%(R%, C% - 1) = ASC("X") THEN SeeTurn 1, 2

FOR this% = ForeSight% TO 0 STEP -1
IF M%(R% + this%, C%) = ASC("D") THEN Gem this% + 1, DiamondC
IF M%(R% + this%, C%) = ASC("E") THEN Gem this% + 1, EmraldC
IF M%(R% + this%, C%) = ASC("R") THEN Gem this% + 1, RubyC
IF M%(R% + this%, C%) = ASC("C") THEN Coin this% + 1
IF M%(R% + this%, C%) = ASC("T") THEN SeeTeleport this% + 1
IF M%(R% + this%, C%) = ASC("W") THEN Gun this% + 1
IF M%(R% + this%, C%) = ASC("M") THEN StoneMonster this% + 1
IF M%(R% + this%, C%) = ASC("m") THEN DeadMonster this% + 1
NEXT this%
END SUB

SUB LookAheadWest
LET ForeSight% = 6
IF M%(R%, C% - 1) = ASC("X") THEN LET ForeSight% = 1: GOTO ReadyWest
IF M%(R%, C% - 2) = ASC("X") THEN LET ForeSight% = 2: GOTO ReadyWest
IF M%(R%, C% - 3) = ASC("X") THEN LET ForeSight% = 3: GOTO ReadyWest
IF M%(R%, C% - 4) = ASC("X") THEN LET ForeSight% = 4: GOTO ReadyWest
IF M%(R%, C% - 5) = ASC("X") THEN LET ForeSight% = 5: GOTO ReadyWest

ReadyWest:

IF ForeSight% > 1 AND ForeSight% < 6 THEN
 LET TurnWall% = 0
 IF NOT M%(R% + 1, C% - ForeSight% + 1) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% - 1, C% - ForeSight% + 1) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead ForeSight%, TurnWall%
END IF

IF ForeSight% = 1 THEN
 LET TurnWall% = 0
 IF NOT M%(R% + 1, C%) = ASC("X") THEN LET TurnWall% = 1
 IF NOT M%(R% - 1, C%) = ASC("X") THEN LET TurnWall% = TurnWall% + 2
 WallAhead 1, TurnWall%
END IF

IF C% > 3 THEN
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% + 1, C% - 4) = ASC("X") THEN SeeTurn 5, 1
 IF ForeSight% > 4 AND NOT ForeSight% - 1 = 4 AND NOT M%(R% - 1, C% - 4) = ASC("X") THEN SeeTurn 5, 2
END IF

IF C% > 2 THEN
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% + 1, C% - 3) = ASC("X") THEN SeeTurn 4, 1
 IF ForeSight% > 3 AND NOT ForeSight% - 1 = 3 AND NOT M%(R% - 1, C% - 3) = ASC("X") THEN SeeTurn 4, 2
END IF

IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% + 1, C% - 2) = ASC("X") THEN SeeTurn 3, 1
IF ForeSight% > 2 AND NOT ForeSight% - 1 = 2 AND NOT M%(R% - 1, C% - 2) = ASC("X") THEN SeeTurn 3, 2

IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% + 1, C% - 1) = ASC("X") THEN SeeTurn 2, 1
IF ForeSight% > 1 AND NOT ForeSight% - 1 = 1 AND NOT M%(R% - 1, C% - 1) = ASC("X") THEN SeeTurn 2, 2

IF NOT ForeSight% = 1 AND NOT M%(R% + 1, C%) = ASC("X") THEN SeeTurn 1, 1
IF NOT ForeSight% = 1 AND NOT M%(R% - 1, C%) = ASC("X") THEN SeeTurn 1, 2

FOR this% = ForeSight% TO 0 STEP -1
IF M%(R%, C% - this%) = ASC("D") THEN Gem this% + 1, DiamondC
IF M%(R%, C% - this%) = ASC("E") THEN Gem this% + 1, EmraldC
IF M%(R%, C% - this%) = ASC("R") THEN Gem this% + 1, RubyC
IF M%(R%, C% - this%) = ASC("C") THEN Coin this% + 1
IF M%(R%, C% - this%) = ASC("T") THEN SeeTeleport this% + 1
IF M%(R%, C% - this%) = ASC("W") THEN Gun this% + 1
IF M%(R%, C% - this%) = ASC("M") THEN StoneMonster this% + 1
IF M%(R%, C% - this%) = ASC("m") THEN DeadMonster this% + 1
NEXT this%

END SUB

SUB MiniMap
LET GuiRow% = 3
LET GUICol% = 67


LET MapStartR% = R% - 4
LET MapStartC% = C% - 4

COLOR 7, 0

LET ThisRow% = -1

FOR this% = MapStartR% TO MapStartR% + 8
LET ThisRow% = ThisRow% + 1

IF this% > 0 AND this% < WideRow% + 1 THEN

LOCATE GuiRow% + ThisRow%, GUICol%

FOR THAT% = MapStartC% TO MapStartC% + 8
IF THAT% > 0 AND THAT% < WideCol% + 1 THEN
PrintMapChar (CHR$(M%(this%, THAT%)))
ELSE
COLOR 7, 0
PRINT ".";
END IF

NEXT THAT%

ELSE
LOCATE GuiRow% + ThisRow%, GUICol%
COLOR 7, 0
PRINT ".........";
END IF

NEXT this%

COLOR 0, 7
LOCATE GuiRow% + 4, GUICol% + 4

SELECT CASE WAY%
CASE 1
'LookAheadNorth
PRINT CHR$(24);
CASE 2
'LookAheadEast
PRINT CHR$(26);
CASE 3
'LookAheadSouth
PRINT CHR$(25);
CASE 4
'LookAheadWest
PRINT CHR$(27);
END SELECT

COLOR DefaultC, 0
END SUB

SUB PrintMapChar (W$)

SELECT CASE W$
CASE "X":
 COLOR DefaultC, 0
 PRINT CHR$(176);
CASE " ":
 COLOR 7, 0
 PRINT " ";
CASE "W":
 COLOR DefaultC, 0
 PRINT CHR$(214);
CASE "C":
 COLOR CoinC, 0
 PRINT CHR$(155);
CASE "G":
 COLOR GemC, 0
 PRINT CHR$(4);
CASE "P":
 COLOR PurpleC, 0
 PRINT CHR$(4);
CASE "R":
 COLOR RubyC, 0
 PRINT CHR$(4);
CASE "E":
 COLOR EmraldC, 0
 PRINT CHR$(4);
CASE "D":
 COLOR DiamondC, 0
 PRINT CHR$(4);
CASE "#":
 COLOR 2, 1
 PRINT CHR$(220);
CASE "M":
 COLOR 7, 0
 PRINT CHR$(1);
CASE "m":
 COLOR 7, 0
 PRINT "_";
CASE "T":
 COLOR GemC, 0
 PRINT "@";
CASE ELSE:
 COLOR DefaultC, 0
 PRINT W$;
END SELECT

COLOR DefaultC, 0
END SUB

SUB RefreshScreen
' This is useful when I want to redo the screen from certain SUBs without
' typing all this in.
DrawBorder
DrawScreen
DoInve
MiniMap
SELECT CASE WAY%
CASE 1
LookAheadNorth
CASE 2
LookAheadEast
CASE 3
LookAheadSouth
CASE 4
LookAheadWest
END SELECT

END SUB

SUB SadSound
PLAY "MBMNT500o2P2P8L8GGGL2E- P4 4P8L8FFFL2D"
END SUB

SUB SeeTeleport (D%)
COLOR GemC, 0
SELECT CASE D%
CASE 5
LOCATE 11, 39: PRINT "."
CASE 4
LOCATE 12, 38: PRINT "@"
CASE 3
LOCATE 13, 36: PRINT "()"
CASE 2
LOCATE 13, 34: PRINT "‹ﬂ‹"
LOCATE 14, 33: PRINT "€ @ €"
LOCATE 15, 34: PRINT "ﬂ‹ﬂ"
CASE 1
LOCATE 13, 32: PRINT "‹‹‹‹"
LOCATE 14, 30: PRINT "‹€TIME€‹"
LOCATE 15, 30: PRINT "€&SPACE€"
LOCATE 16, 30: PRINT "ﬂ€WARP€ﬂ"
LOCATE 17, 32: PRINT "ﬂﬂﬂﬂ"
END SELECT
COLOR DefaultC, 0
END SUB

SUB SeeTurn (Distance%, Turn%)
IF Turn% = 1 OR Turn% = 3 THEN
 SELECT CASE Distance%
 CASE 1
  LOCATE 4, 25
  PRINT "==";
  FOR this% = 5 TO 16
  LOCATE this%, 25
  PRINT "..≥";
  NEXT this%
  LOCATE 17, 25
  PRINT "==";
 CASE 2
  LOCATE 5, 27
  PRINT "≥=";
  FOR this% = 6 TO 15
  LOCATE this%, 27
  PRINT "≥..≥";
  NEXT this%
  LOCATE 16, 27
  PRINT "≥=";
 CASE 3
  LOCATE 7, 31
  PRINT "≥=";
  FOR this% = 8 TO 13
  LOCATE this%, 31
  PRINT "≥.≥";
  NEXT this%
  LOCATE 14, 31
  PRINT "≥=";
 CASE 4
  LOCATE 8, 33
  PRINT "≥=";
  LOCATE 9, 33
  PRINT "≥.≥";
  LOCATE 10, 33
  PRINT "≥.≥";
  LOCATE 11, 33
  PRINT "≥.≥";
  LOCATE 12, 33
  PRINT "≥.≥";
  LOCATE 13, 33
  PRINT "≥=";
 CASE 5
  LOCATE 10, 37
  PRINT "∆µ";
  LOCATE 11, 37
  PRINT "∆µ";
 END SELECT
END IF

IF Turn% = 2 OR Turn% = 3 THEN
 SELECT CASE Distance%
 CASE 1
  LOCATE 4, 54
  PRINT "==";
  FOR this% = 5 TO 16
  LOCATE this%, 53
  PRINT "≥..";
  NEXT this%
  LOCATE 17, 54
  PRINT "==";
 CASE 2
  LOCATE 5, 52
  PRINT "=≥";
  FOR this% = 6 TO 15
  LOCATE this%, 50
  PRINT "≥..≥";
  NEXT this%
  LOCATE 16, 52
  PRINT "=≥";
 CASE 3
  LOCATE 7, 48
  PRINT "=≥";
  FOR this% = 8 TO 13
  LOCATE this%, 47
  PRINT "≥.≥";
  NEXT this%
  LOCATE 14, 48
  PRINT "=≥";
 CASE 4
  LOCATE 8, 46
  PRINT "=≥";
  LOCATE 9, 45
  PRINT "≥.≥";
  LOCATE 10, 45
  PRINT "≥.≥";
  LOCATE 11, 45
  PRINT "≥.≥";
  LOCATE 12, 45
  PRINT "≥.≥";
  LOCATE 13, 46
  PRINT "=≥";
 CASE 5
  LOCATE 10, 42
  PRINT "∆µ";
  LOCATE 11, 42
  PRINT "∆µ";
 END SELECT
END IF

'  \                         /
'  ==\                     /==
'  ..≥ \                 / ≥..
'  ..≥ ≥=\             /=≥ ≥..
'  ..≥ ≥.≥ \         / ≥.≥ ≥..
'  ..≥ ≥.≥ ≥=\     /=≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥.∆µ\ /∆µ.≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥.∆µ/ \∆µ.≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥=/     \=≥ ≥.≥ ≥..
'  ..≥ ≥.≥ /         \ ≥.≥ ≥..
'  ..≥ ≥=/             \=≥ ≥..
'  ..≥ /                 \ ≥..
'  ==/                     \==
'  /                         \
END SUB

SUB Sit
DO: LOOP UNTIL INKEY$ = ""
DO: LOOP UNTIL NOT INKEY$ = ""
DO: LOOP UNTIL INKEY$ = ""
END SUB

SUB SneakSound1
PLAY "T150 o0l3dl14ef.p13l13d. T500"
END SUB

SUB SneakSound2
PLAY "T150 o0l15ffgfg+fg+a T500"
END SUB

SUB StoneMonster (D%)
COLOR MonsterC, 0
SELECT CASE D%
CASE 5
LOCATE 10, 40: PRINT "x"
LOCATE 11, 40: PRINT "X"
CASE 4
LOCATE 10, 39: PRINT "xx"
LOCATE 11, 39: PRINT "<>"
LOCATE 12, 39: PRINT "/\"
CASE 3
LOCATE 10, 40: PRINT "_"
LOCATE 11, 39: PRINT "XôX"
LOCATE 12, 39: PRINT "<>"
LOCATE 13, 39: PRINT "/^\"
CASE 2
LOCATE 10, 40: PRINT "_"
LOCATE 11, 38: PRINT "\/î\/"
LOCATE 12, 38: PRINT "/<>\"
LOCATE 13, 39: PRINT "/^\"
LOCATE 13, 37: PRINT "|"
LOCATE 13, 43: PRINT "|"
LOCATE 14, 38: PRINT "|"
LOCATE 14, 42: PRINT "|"
LOCATE 15, 38: PRINT "|"
LOCATE 15, 42: PRINT "|"
CASE 1
LOCATE 5, 28:  PRINT "========================="
LOCATE 6, 28:  PRINT "........................."
LOCATE 7, 28:  PRINT "........................."
LOCATE 8, 28:  PRINT ".....X....._v_.....,....."
LOCATE 9, 28:  PRINT "......\...\oxo/.../......"
LOCATE 10, 28: PRINT "........\_/\^/\_/........"
LOCATE 11, 28: PRINT "..........|ÆXØ|.........."
LOCATE 12, 28: PRINT "...........\/..........."
LOCATE 13, 28: PRINT "........../...\.........."
LOCATE 14, 28: PRINT ".........|.....|........."
LOCATE 15, 28: PRINT ".........|.....|........."
LOCATE 16, 28: PRINT "=========Û=====Ú========="
END SELECT
COLOR DefaultC, 0
END SUB

SUB Teleport
CLS
DrawBorder
Center 3, "You Win!"
Center 10, "Modify this game and make more levels!"
Center 21, "Send them to me at mclean.ben@gmail.com"

REM Jump sound
PLAY "T255 MB ML O3 L64 CDEFGAB T100"

REM Laser sound
PLAY "T255 MB ML O4 L64bagfedc<bagfedec<bagfedc<bagfedc<bagfedc MN T100"

Sit
PLAY "T160O1>L20CDEDCDL10ECC"
Bye
END SUB

SUB TheEnd
SCREEN 0: WIDTH 80, 25: COLOR 7, 0: CLS : SYSTEM
END SUB

SUB Useless
'  \                         /
'    \                     /
'      \                 /
'        \             /
'          \         /
'            \     /
'              \ /
'              / \
'            /     \
'          /         \
'        /             \
'      /                 \
'    /                     \
'  /                         \
'
'
'  ==\                     /==
'  ..≥ \                 / ≥..
'  ..≥ ≥=\             /=≥ ≥..
'  ..≥ ≥.≥ \         / ≥.≥ ≥..
'  ..≥ ≥.≥ ≥=\     /=≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥.≥=\ /=≥.≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥.≥_/ \_≥.≥ ≥.≥ ≥..
'  ..≥ ≥.≥ ≥=/     \=≥ ≥.≥ ≥..
'  ..≥ ≥=≥ /         \ ≥=≥ ≥..
'  ..≥ ≥ /             \ ≥ ≥..
'  ..≥ /                 \ ≥..
'  ==/                     \==
'  /                         \
'
'  \                         /
'    \                     /
'      \                 /
'        \             /
'          \         /
'           ≥=======
'           ≥.......
'           ≥.......
'           ≥=======
'          /         \
'        /             \
'      /                 \
'    /                     \
'  /                         \
'
'  \                         /
'    \                     /
'      \                 /
'        \             /
'         ≥===========
'         ≥...........
'         ≥...........
'         ≥...........
'         ≥...........
'         ≥===========
'        /             \
'      /                 \
'    /                     \
'  /                         \
'
'  \                          /
'    \                      /
'     ≥                   /
'     ≥=================
'     ≥.................
'     ≥.................
'     ≥.................
'     ≥.................
'     ≥.................
'     ≥.................
'     ≥=================
'     ≥                   \
'    /                      \
'  /                          \
'
'\                           /
'  =========================
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  .........................
'  =========================
'/                           \
'
END SUB

SUB WallAhead (Distance%, Turn%)
SELECT CASE Distance%
CASE 6
' LOCATE 10, 41
' PRINT "_"
CASE 5
LOCATE 10, 39: PRINT "==="
LOCATE 11, 39: PRINT "==="
 IF Turn% = 1 THEN LOCATE 10, 38: PRINT "≥"; : LOCATE 11, 38: PRINT "≥";
 IF Turn% = 2 THEN LOCATE 10, 42: PRINT "≥"; : LOCATE 11, 42: PRINT "≥";
 IF Turn% = 3 THEN LOCATE 10, 38: PRINT "≥"; : LOCATE 11, 38: PRINT "≥"; : LOCATE 10, 42: PRINT "≥"; : LOCATE 11, 42: PRINT "≥";
CASE 4
 LOCATE 9, 37: PRINT "=======";
 LOCATE 10, 37: PRINT ".......";
 LOCATE 11, 37: PRINT ".......";
 LOCATE 12, 37: PRINT "=======";
 IF Turn% = 1 THEN FOR this% = 9 TO 12: LOCATE this%, 36: PRINT "≥"; : NEXT this%
 IF Turn% = 2 THEN FOR this% = 9 TO 12: LOCATE this%, 44: PRINT "≥"; : NEXT this%
 IF Turn% = 3 THEN : FOR this% = 9 TO 12: LOCATE this%, 36: PRINT "≥"; : NEXT this%: FOR this% = 9 TO 12: LOCATE this%, 44: PRINT "≥"; : NEXT this%
CASE 3
 LOCATE 8, 35
 PRINT "==========="
 LOCATE 9, 35
 PRINT "..........."
 LOCATE 10, 35
 PRINT "..........."
 LOCATE 11, 35
 PRINT "..........."
 LOCATE 12, 35
 PRINT "..........."
 LOCATE 13, 35
 PRINT "==========="
 IF Turn% = 1 THEN FOR this% = 8 TO 13: LOCATE this%, 34: PRINT "≥"; : NEXT this%
 IF Turn% = 2 THEN FOR this% = 8 TO 13: LOCATE this%, 46: PRINT "≥"; : NEXT this%
 IF Turn% = 3 THEN : FOR this% = 8 TO 13: LOCATE this%, 34: PRINT "≥"; : NEXT this%: FOR this% = 8 TO 13: LOCATE this%, 46: PRINT "≥"; : NEXT this%
CASE 2
 LOCATE 7, 32
 PRINT "================="
 LOCATE 8, 32
 PRINT "................."
 LOCATE 9, 32
 PRINT "................."
 LOCATE 10, 32
 PRINT "................."
 LOCATE 11, 32
 PRINT "................."
 LOCATE 12, 32
 PRINT "................."
 LOCATE 13, 32
 PRINT "................."
 LOCATE 14, 32
 PRINT "================="
 IF Turn% = 1 THEN FOR this% = 6 TO 15: LOCATE this%, 31: PRINT "≥": NEXT this%
 IF Turn% = 2 THEN FOR this% = 6 TO 15: LOCATE this%, 49: PRINT "≥": NEXT this%
 IF Turn% = 3 THEN FOR this% = 6 TO 15: LOCATE this%, 31: PRINT "≥": NEXT this%: FOR this% = 6 TO 15: LOCATE this%, 49: PRINT "≥": NEXT this%
CASE 1
 LOCATE 5, 29
 PRINT "======================="
 LOCATE 6, 29
 PRINT "......................."
 LOCATE 7, 29
 PRINT "......................."
 LOCATE 8, 29
 PRINT "......................."
 LOCATE 9, 29
 PRINT "......................."
 LOCATE 10, 29
 PRINT "......................."
 LOCATE 11, 29
 PRINT "......................."
 LOCATE 12, 29
 PRINT "......................."
 LOCATE 13, 29
 PRINT "......................."
 LOCATE 14, 29
 PRINT "......................."
 LOCATE 15, 29
 PRINT "......................."
 LOCATE 16, 29
 PRINT "======================="
 IF Turn% = 1 THEN FOR this% = 4 TO 17: LOCATE this%, 27: PRINT " ": NEXT this%
 IF Turn% = 2 THEN FOR this% = 4 TO 17: LOCATE this%, 53: PRINT " ": NEXT this%
 IF Turn% = 3 THEN FOR this% = 4 TO 17: LOCATE this%, 53: PRINT " ": NEXT this%: FOR this% = 4 TO 17: LOCATE this%, 27: PRINT " ": NEXT this%
END SELECT
END SUB


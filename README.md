# Bimbo Holdem Poker
This is a repository for Bimbo Holdem Poker, a NSFW erotic transformation poker game which was first [published at DeviantArt](https://www.deviantart.com/gardamuse/art/Bimbo-Holdem-Poker-584820811) 2016-01-17 and now resides primarily on [BlushingDefeat](https://www.blushingdefeat.com/bimbo-holdem-poker/). As such, this source was made public approximately 3 years after the games release and 1 year after the last update.

The codebase has not been explicitly prepared for an open source release and may therefore be poorly documented in places.

The game was developed using [FlashDevelop](http://www.flashdevelop.org).

## UI library
Of particular interest to anyone looking to write a flash game in a similar vein is the UI library I created during the making of this game. It has many components: text field, button and sliders (with a visible grip or more like a loading bar) to name a few. All components can be styled to pretty much anything, although it requires some digging around in code. All components can be created with a single line of code and there are some nice features like being able to add tooltips, automatically fade out and remove buttons etc.

I say library, but there are some peculiarities. The main UI library is located in `/src/ui2` so anyone who wants to use this library can just copy that folder. Some components however, like checkboxes, were never implemented in UI-2, but only exists in UI-1. If you want to use those, you need `/src/ui` as well. UI-1 has many of the same components as UI-2 as well, but you want to use UI-2 wherever possible.

A requirement for using the libraries is the [FlashPunk](http://useflashpunk.net) library. You can download it from their site, but if I remember correctly, I've done some additions to that library. That version is available in `/src/net/flashpunk/` and you could just copy that too.

Every screen in the game is a FlashPunk "world". To find out how to use the UI components, checkout any of the BHP worlds in `/src/worlds/`. You may have to dig around a bit, but I'm sure most things can be figured out. One thing to note is that the text rendering is terribly slow for long texts, like those found in the TutorialWorld. As such, worlds with long text has to be pre-loaded or there will be a slight delay when entering them. For BHP, pre-loading is done in LoadingWorld.

If there are any questions, feel free to contact me (Gardamuse).

## Licensing
Most code in this application is licensed under the MIT license. However, some parts are licensed differently or at the very least have their own permission notices. Graphical assets are also licensed separately.

This repository is currently distributed with 3 external libraries. These are only included for convenience and have their own licenses.

1. [FlashPunk](http://useflashpunk.net) is included by source and located in `src/net/flashpunk`. It is licensed by [Chevy Ray Johnston](https://github.com/useflashpunk/FlashPunk/blob/master/license.txt) under the MIT license. I have made some additions to the code and those are also licensed under the MIT license. These additions are minor but may be required for full functionality of the game and its UI.

2. [Greensock](https://greensock.com/) is licensed under the [Standard "No Charge" GeenSock License](https://greensock.com/standard-license). It is included as a .swc file under `/lib/`. If I remember correctly this library is used to implement tweening for UI components.

3. [AS3PokerFace](https://github.com/houen/PokerFace) is licensed under the MIT license by Søren Houen. It is included as a .swc file under `/lib/`. It is used to quickly evaluate poker hands.

All graphical character assets (located under `/assets/gfx/characters`) are copyright to their respective creators. Which character is created by which author is listed on the in-game credits screen, the source for which is located in `/src/worlds/CreditsWorld.as`. No characters may be used outside of BHP without receiving additional permission from their creators, but they may be used in BHP and any sequels to the game as long as the creator is credited. Upon submission, creators agreed to the following:
> By submitting a character or other work, you agree to that it can be used in the current version of Bimbo Holdem Poker and in any possible future sequels. You also agree to that your work may be changed in any way seen fit by the developer(s) and that you do not have the right to demand the removal of your work.
>
> You do however have the right the be included in or removed from the game’s credits section as long as the game is being developed or looked after.

Any characters whose creator is not listed was created by me (Gardamuse) and are licensed under CC-BY. This also goes for any remaining, by this readme unmentioned, graphical assets.

I do not currently have any copyright information regarding the graphical assets for fonts, chips, cards and the checkmark icon but they were licensed for commercial use under a permissive license. If possible, the creators should be found and credited here.

All remaining code is available under the MIT license. If you do use this code for something, please also tell me about it by sending an e-mail to gardamuse@gmail.com or gardamuse@blushingdefeat.com. I'd be very interested in seeing it used for fun things :)

All license notices can be found under `/licenses/`. Please note that relevant parts of this readme must remain intact and be distributed along with license notices since the work can not otherwise be attributed correctly.

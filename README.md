Darkness Looming: The Dawn
--------------------------
An old-school Action RPG slasher. Made using [d2clone-kit](https://gitlab.com/lockie/d2clone-kit) engine.

Installation
------------
Just grab executables from the [CI pipelines](https://gitlab.com/lockie/darkness-looming-the-dawn/pipelines).

Building from source
--------------------
To build from source, you'll need
* [Git LFS](https://git-lfs.github.com) addon.
* [SBCL](http://sbcl.org) compiler.
* [Quicklisp](https://www.quicklisp.org) installation.
* [liballegro](https://liballeg.org) (to install on Debian derivatives, run `sudo apt-get install liballegro-acodec5.2 liballegro-audio5.2 liballegro-image5.2 liballegro-dialog5.2 liballegro-ttf5.2 liballegro-physfs5.2 liballegro-video5.2`).
* [d2clone-kit](https://gitlab.com/lockie/d2clone-kit) in your Quicklisp's `local-projects` directory.

FAQ
---
**Q: I'm building from source and I'm getting errors about assets, like _failed to open 'maps/map.tmx'_. Am I missing something?**

A: As a matter of fact you are. The assets in this repository are stored using [Git LFS](https://git-lfs.github.com), please make sure you have installed it and run `git lfs fetch` after installation.

Used art
--------
* [Alegreya SC font](https://fontsquirrel.com/fonts/alegreya) by Juan Pablo del Peral, licensed under SIL Open Font License v1.10.
* [Noto Mono font](https://google.com/get/noto) by Google, licensed under SIL Open Font License v1.10.
* [Backgrounds](https://opengameart.org/content/backgrounds-0) by Écrivain, licensed under Public Domain.
* [Flare buttons](https://opengameart.org/content/flare-buttons) by Blarumyrran, licensed under Public Domain.
* [Health orb](https://opengameart.org/content/health-orb-11) by itsmars, licensed under Public Domain.
* [Grassland tileset](https://opengameart.org/content/grassland-tileset) by Clint Bellanger, licensed under CC BY-SA 3.0.
* [SFX - 5 Menu Screen Slides](https://opengameart.org/content/sfx-5-menu-screen-slides) by Cleyton Kauffman, licensed under CC BY-SA 4.0.
* [Sound effects pack](https://opengameart.org/content/sound-effects-pack) by OwlishMedia, licensed under Public Domain.
* [Female gruntwork](https://opengameart.org/content/female-gruntwork-1) by Simone Bruhn, licensed under CC BY-SA 4.0.
* [RPG sound pack](https://opengameart.org/content/rpg-sound-pack) by artisticdude, licensed under Public Domain.
* [50 RPG sound effects](https://opengameart.org/content/50-rpg-sound-effects) by [Kenney](https://kenney.nl), licensed under Public Domain.
* [Cracking sounds](https://opengameart.org/content/cracking-sounds) by [Hansjörg Malthaner](http://opengameart.org/users/varkalandar), licensed under CC BY 4.0.
* [Horror sound effects library](https://opengameart.org/content/horror-sound-effects-library) by Little Robot Sound Factory, licensed under CC BY 3.0.
* [Bone, fall, ledge climbing, impact from Yo Frankie!](https://opengameart.org/content/bone-fall-ledge-climbing-impact-yo-frankie) by Blender Foundation, licensed under CC BY 3.0.
* [Walking skeleton](https://opengameart.org/content/walking-skeleton) by Sebastian Riedel, licensed under CC BY 3.0.
* [Punches, hits, swords and squishes](https://opengameart.org/content/punches-hits-swords-and-squishes) by Philippe Groarke, licensed under CC BY-SA 3.0.
* [Zombie, spider and monster](https://opengameart.org/content/zombie-spider-and-monster) by Jute, licensed under GPL 3.0.
* [Zombies sound pack](https://opengameart.org/content/zombies-sound-pack) by artisticdude, licensed under Public Domain.
* [Footsteps leather, cloth, armor](https://opengameart.org/content/footsteps-leather-cloth-armor) by Brandon Morris, licensed under Public Domain.
* [Isometric hero and heroine](https://opengameart.org/content/isometric-hero-and-heroine) by Clint Bellanger, licensed under CC BY 3.0.
* [Flying loot animations](https://opengameart.org/content/flying-loot-animations) by Clint Bellanger, licensed under CC BY 3.0.
* [Skeleton warrior](https://opengameart.org/content/skeleton-warrior) by Clint Bellanger, licensed under CC BY 3.0.
* [Antlion](https://opengameart.org/content/antlion) by Clint Bellanger, licensed under CC BY 3.0.
* [Zombie](https://opengameart.org/content/zombie-0) by Clint Bellanger, licensed under CC BY 3.0.

License
-------
This project is licensed under GNU GPL license version 3. See [LICENSE](LICENSE).

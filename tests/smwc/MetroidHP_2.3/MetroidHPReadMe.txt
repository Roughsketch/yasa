Metroid Health Patch
By ICB (by way of Killozapit)
Please credit both if used.

What is included in this package:

ASM:
-MetroidHP.asm
The actual patch itself. It turns bonus stars into HP that goes up to 99. Once you collect a Reserve Tank
you gain a new health box on the status bar, which adds 100HP (another 00-99HP). When HP reaches zero, Mario
dies, unless there is a full reserve health box, then HP rolls back over to 99 and the current reserve health 
box empties. Mushrooms heal by 20 points by default, while midway points fill all reserve health boxes and maxes
HP. Standard enemies deal 20 points worth of damage by default, but you can add a few lines of code to a custom
sprite to make it do more or less damage (See ASM file for more info, or study the two sprites included). Like
how $7E:0F48 is used as HP counter, $7E:1900 is also used for increment/decrement effect, only two ram address
are recycled as non-freeram address.

Note that if you are using this, you must disable two-player and only play as mario, there is a major bug
with luigi, unless if you have ASM knowledge around that.

Sprites:
[Reserve Tanks]
-reserve_tank.asm and 7 cfg files.
These add another box of reserve health to the status bar
giving you 100HP (another 00-99) for each one, just like Metroid.

[Enemies]
-Power_koopa.asm/cfg
A Koopa Troopa who takes away 50 HP
-Poison_goomba.asm/cfg
A goomba who takes away a whopping 100 HP
-new_metroid.asm/cfg
Schwa's Metroid sprite with a simple edit to make it compatible
with this patch. Instead of draining coins, it drains HP. Shake it off by
jumping around.

Blocks:
-slow_drain.asm
This block drains your health at a slow rate, like the lava in Metroid.
-fast_drain.asm
This block drains your health at a fast rate, like the super hot lava in Metroid.
-heal.asm
Stand in this to quickly replenish your energy.
-hidden_tank.asm
A reserve tank hidden in a wall or floor that can be revealed by a fireball, as in all 
Metroid games. Be sure to set the appropriate sprite.

Graphics
-GFX28.bin
The replacement graphics for the new health bar. Put it in your Graphics folder (If you haven't extracted
the GFX from your ROM you need to do so.) It will ask if you want to replace the old GFX28.bin. Select yes.
Go to LM and insert it with the green mushroom (For all of this, you need to uncheck 'Use joined GFX' under
Options in LM).
-ExGFX_T.bin
This is an ExGFX page for SP02, which has the Reserve Tank GFX (it replaces the smiley face coin). Use 
it in the levels where your Reserve Tanks are found, and feel free to redraw the GFX
as you see fit. You need to replace the "_T" before .bin with a suitable number for ExGFX insertion.
-ExGFX_M.bin
Metroid graphics from the original Metroid sprite package. Change "_M" to a suitable number.

**Setting custom HP decrement for custom sprites**
The hurt flag is $58 by default. If this is not set, it will increment the HP instead. #$01 is for
normal sprites (Which you should never have to use) but #$02 tells the code that it's a custom HP.
We use this here.

In most custom sprites, there is a routine to check if Mario is touching the sprite. This is where
you will insert the code to make it take away any ammount of HP (up to 255, or #$FF in Hex). 

In your sprite's ASM, Ctrl+F to Find this:
JSL $01A7DC			

It will usually be followed by a return label with an RTS, like:
RETURN2:
RTS

If left alone, the sprite will run the routine in the patch, which removes 20 HP.
If you want to change it, add this after the JSL line:
BCC RETURN2 (orwhatever your return label is)	

The BCC will go to Return if Mario isn't touching the sprite.

Then after that, place this:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------------------
!Damage_flag = $58		;>this on top!!

LDA $1497				;\If mario is Invulnerable
BNE (whatever your return label is)	;/then don't damage mario
LDA #$02				;\set the hurt flag for custom sprites (#$02)
STA !Damage_flag			;/in the heal/hurt routine
LDA #$**				;\This is the number of points
STA $1900				;/to take away IN HEX.

Obviously, change out the **'s for your number (Use a Hex calculator to figure what
hex value your decimal count is). 

If there is other code, place the code above before that code, and it should be fine, unless your code
puts any branches out of range, then you'll just have to figure out a way around it, but that doesn't
happen too often, really.
------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GHB's updates & bugfixes:

2.0:
	-Fix a bug that if the player has no tanks left, takes damage equal to how much remaining HP he has
	left (for example: takes 20 damage while having 20HP left), will cause his HP to be 00 without dying
	until another hit.
	-the hurt routine is updated due to a bug that if the player touches an enemy while his "afterhit
	invincibility" is still active ($7E:1497 isn't zero), mario is still able to get his HP drained even
	while flashing.
	-the drain and heal blocks didn't use the "db $42", this means that the corners and certain other
	offsets won't run while mario touches them when behaving 130, (example: the blocks not work when
	standing on the corners and head-touching).
2.1:
	-fix the miscalculation that if you grab 1 mushroom and grab the the second before the increment
	counter stops, the first mushroom's value gets interrupt by the second and will add less than the
	actual total healing (so if mario has 19HP left, grabs two mushrooms, wouldn't add up to 59). The
	only glitch that is possable is when the decrement/increment record counter exceeds 255.
	-some unessary lines are removed like AND #$00 and CMP #$00 to save space.
	-added defines (the patch, sprites and blocks), so you can edit the freeram eaisier. You
	can also edit the freespace within the patch so it doesn't conflict with other patches/
	tools.
	-$0670 is a ram address that isn't safe to use as freeram address, I have change that to
	use $58 by default.
2.2
	-now compatable with asar, thanks to MarioE.
2.3
	-fix the sprite problems with the defines being xkas style and should be trasm style.
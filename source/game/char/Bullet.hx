package game.char;

class Bullet extends FlxSprite {
	public var atk:Int = 1;

	public function setBulletType(turretName:String) {
		// Bullet Sizes Uniform
		var bulletSize = 4;
		switch (turretName) {
			case ARROW:
				makeGraphic(bulletSize, bulletSize, KColor.WHITE);
			case NATURE:
				makeGraphic(bulletSize, bulletSize, KColor.GREEN);
			case BOMB:
				makeGraphic(bulletSize, bulletSize, KColor.YELLOW);
			case ICE:
				makeGraphic(bulletSize, bulletSize, KColor.BEAU_BLUE);
			case FLAMING:
				makeGraphic(bulletSize, bulletSize, KColor.BURGUNDY);
			case _:
				// Not valid turret
		}
	}
}
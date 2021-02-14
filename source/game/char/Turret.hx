package game.char;

class Turret extends Actor {
	public var atkSpd:Int;

	public function new(x:Float, y:Float, turretData:TurretData) {
		super(x, y, turretData);
	}

	override public function assignStats() {
		super.assignStats();
		var turretData:TurretData = cast data;
		atkSpd = turretData.atkSpd;
	}
}
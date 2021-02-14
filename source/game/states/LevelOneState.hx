package game.states;

class LevelOneState extends LevelState {
	override public function create() {
		super.create();
		createLevel('assets/maps/love-defense/tiled/LevelOne.tmx');
	}
}
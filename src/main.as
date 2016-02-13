package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.Timer;

	public class main extends Sprite {

		public function main(): void {

			var cpuscore: int = 0;
			//a square that is 200, 200 px and is at 175, 100 on the stage
			var customSquare: Rectangle = new Rectangle(175, 100, 200, 200);

			var enem: MovieClip = new Enem();
			var enemt: MovieClip = new Enemt();
			initTargetSetup();

			var gunShot: Sound = new Shot();
			var time: int = 60;


			var myTim: Timer = new Timer(500, 0);
			myTim.start();

			myTim.addEventListener(TimerEvent.TIMER, timerListen);
			function timerListen(e: TimerEvent): void {
				enemt.visible = true;
				enem.visible = true;
				time -= 1;
				updateTextFields();

				if (time == 0) {
					myTim.stop()
					enem.visible = false;
					enemt.visible = false;
				}
				enem.alpha++;
				randTargetPos();
			}

			function initTargetSetup(): void {
				randTargetPos();
				addChild(enemt);
				addChild(enem);
				addChild(gun);
				enemt.buttonMode = enem.buttonMode = true;
			}

			function randTargetPos(): void {
				enem.x = (Math.random() * customSquare.width) + customSquare.x;
				enem.y = (Math.random() * customSquare.height) + customSquare.y;
				enemt.x = (Math.random() * customSquare.width) + customSquare.x;
				enemt.y = (Math.random() * customSquare.height) + customSquare.y;
			}


			function updateTextFields(): void {
				tet.text = ("Score: " + cpuscore);
				ti.text = ("Time:" + time);
			}

			stage.addEventListener(MouseEvent.MOUSE_MOVE, gunmoving);
			function gunmoving(e: MouseEvent): void {
				gun.x = stage.mouseX + 20;
				var dist_Y: Number = -1 * (stage.mouseY - this.y - 400);
				var dist_X: Number = stage.mouseX - this.x;
				var angle: Number = Math.atan2(dist_Y, dist_X);
				var degrees: Number = angle * 180 / Math.PI;
				gun.rotation = degrees;
			}
			stage.addEventListener(MouseEvent.CLICK, gunShoot);
			function gunShoot(e: MouseEvent): void {
				gunShot.play();
				gun.gun.play();
			}

			enem.addEventListener(MouseEvent.CLICK, ew);
			function ew(e: MouseEvent): void {
				cpuscore += 1;
				updateTextFields();
			}

			enemt.addEventListener(MouseEvent.CLICK, e);
			function e(e: MouseEvent): void {
				myTim.stop()
				enem.visible = false;
				enemt.visible = false;
			}

			enem.addEventListener(MouseEvent.CLICK, el);
			function el(e: MouseEvent): void {
				enem.alpha -= 1;
			}
		}
	}

}
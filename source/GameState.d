module GameState;

import std.stdio;
import std.math;

import Dgame.Window.Window;
import Dgame.Window.Event;
import Dgame.Graphic.Surface;
import Dgame.Graphic.Texture;
import Dgame.Graphic.Sprite;
import Dgame.System.Keyboard;
import Dgame.System.StopWatch;

import GameObject;

struct Tracker {
  static enum {TITLE, PLAYING};
  static int currentState = TITLE;
  static bool running = true;
  static StopWatch sw;
}

class GameState {
  Window* win;
  Event evt;

  this(ref Window win) {
    this.win = &win;
  }

  void render() {}
}

class TitleState : GameState {

  Texture tex;
  Sprite title;

  this(ref Window win) {
    super(win);
    tex = Texture(Surface("resources/title.png"));
    title = new Sprite(tex);
  }

  override void render() {
    //while(Tracker.running) {
      while(win.poll(&evt)) {
        switch(evt.type) {
          case Event.Type.KeyDown:
            if (evt.keyboard.key == Keyboard.Key.Return) {
              Tracker.currentState = Tracker.PLAYING;
              Tracker.sw.reset();
            }
          break;
          case Event.Type.Quit:
            Tracker.running = false;
          break;
          default: break;
        }
      }

      win.draw(title);
      win.display();
    //}
  }
}

class PlayingState : GameState {

  Texture stars1T;
  Sprite stars1;
  Ship ship;

  this(ref Window win) {
    super(win);
    stars1T = Texture(Surface("resources/stars1.png"));
    stars1 = new Sprite(stars1T);
    ship = new Ship("resources/ship.png");
    ship.speed = 0;
    ship.turnSpeed = 0.2;
    ship.acceleration = 0.0006;
    ship.maxSpeed = 0.6;
    ship.sprite.setRotationCenter(ship.tex.width() / 2, ship.tex.height() / 2);
    ship.sprite.setPosition(win.getSize().width / 2, win.getSize().height / 2);
  }

  override void render() {
    //while(Tracker.running) {
      while(win.poll(&evt)) {
        switch(evt.type) {
          case Event.Type.KeyDown:
            if (evt.keyboard.key == Keyboard.Key.Left) {
              ship.turnLeft = true;
            }
            else if (evt.keyboard.key == Keyboard.Key.Right) {
              ship.turnRight = true;
            }
            if (evt.keyboard.key == Keyboard.Key.Up) {
              ship.shipUp = true;
              ship.speed = ship.acceleration;
            }
          break;
          case Event.Type.KeyUp:
            if (evt.keyboard.key == Keyboard.Key.Left) {
              ship.turnLeft = false;
            }
            else if (evt.keyboard.key == Keyboard.Key.Right) {
              ship.turnRight = false;
            }
            if (evt.keyboard.key == Keyboard.Key.Up) {
              ship.shipUp = false;
              ship.speed = 0;
            }
          break;
          case Event.Type.Quit:
            Tracker.running = false;
          break;
          default: break;
        }
      }

      uint dt = Tracker.sw.getElapsedTicks();
      Tracker.sw.reset();
      if (ship.turnLeft) {
        ship.sprite.rotate(-ship.turnSpeed * dt);
      }
      else if (ship.turnRight) {
        ship.sprite.rotate(ship.turnSpeed * dt);
      }
      //if (ship.shipUp) {
        //ship.sprite.move(0, -ship.speed * dt);
        ship.move(dt);
      //}

      win.draw(stars1);
      win.draw(ship.sprite);
      win.display();
    //}
  }
}

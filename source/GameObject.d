module GameObject;

import std.stdio;
import std.math;

import Dgame.Graphic.Surface;
import Dgame.Graphic.Texture;
import Dgame.Graphic.Sprite;

class GameObject {
  Texture tex;
  Sprite sprite;

  uint width;
  uint height;

  this(string file) {
    tex = Texture(Surface(file));
    tex.setSmooth(true);
    width = tex.width();
    height = tex.height();
    sprite = new Sprite(tex);
  }

  void move(uint dt) {}
}

class Ship : GameObject {

  float speed;
  float turnSpeed;
  float maxSpeed;
  float velx = 0;
  float vely= 0;

  bool turnLeft = false;
  bool turnRight = false;
  bool shipUp = false;

  this(string file) {
    super(file);
  }

  override void move(uint dt) {
    float deg = sprite.getRotation() * PI / 180.0;
    float dx = cos(deg);
    writeln("dx ", dx);
    float dy = sin(deg);
    writeln("dy ", dy);
    velx += dx * speed * dt;
    writeln("speed ", speed);
    writeln("velx ", velx);
    vely += dy * speed * dt;
    writeln("vely ", vely);
    writeln("dt ", dt);
    sprite.move(velx, vely);
    writeln(velx, ":", vely);
  }
}

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
  float velx;
  float vely;

  bool turnLeft = false;
  bool turnRight = false;
  bool shipUp = false;

  this(string file) {
    super(file);
  }

  override void move(uint dt) {
    //float deg = sprite.getRotation() * PI / 180.0;
    float deg = sprite.getRotation();
    float dx = cos(deg);
    float dy = sin(deg);
    velx += dx * speed * dt;
    vely += dy * speed * dt;
    sprite.move(velx, vely);
    writeln(velx, ":", vely);
  }
}

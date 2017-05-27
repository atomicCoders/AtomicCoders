class Electron {

  // Basic physics model (position, velocity, acceleration, mass)
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  int count = 0;
  PVector[] trail = new PVector[50];
  Electron(float m, float x, float y, float z) {
    mass = m;
    position = new PVector(x, y, z);
    velocity = new PVector(1, 0);   // Arbitrary starting velocity
    acceleration = new PVector(0, 0);
  }

  // Newton's 2nd Law (F = M*A) applied
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // Our motion algorithm (aka Euler Integration)
  void update() {
    velocity.add(acceleration); // Velocity changes according to acceleration
    position.add(velocity);     // position changes according to velocity
    acceleration.mult(.01);
    trail[count % trail.length] = new PVector(position.x, position.y, position.z);
    count++;
  }

  // Draw the Planet
  void show() {
    noStroke(); 

    pushMatrix(); 
    noFill(); 
    strokeWeight(2); 
    stroke(155, 155, 0); 
    //beginShape();
    for (int i = 0; i < constrain(count, 0, trail.length); i++) {
      point(trail[i].x, trail[i].y, trail[i].z);
    }
    translate(position.x, position.y, position.z); 
    noStroke(); 
    fill(155, 155, 0); 
    ellipse(0, 0, 10, 10); 
    popMatrix();
  }
}
//Conan Wong
//APCS2 pd9
//HW47 -- All That Bouncin'
//2016-05-30

class ball {
	int c;
	float xpos;
	float ypos;
	float xspeed;
	float yspeed;
	float radius;
	int b;

	ball(){
		c = color(random(256),random(256),random(256));
		xpos = random(width + 1);
		ypos = random(height + 1);
		xspeed = random(5) * (float).7 + (float).3;
		yspeed = random(5) * (float).7 + (float).3;
		radius = 20;
		b = 0;
	}

	void draw(){
	background(0);
  move();
	display();
	}

	void display(){
		fill(c);
		if (b == 1){
			fill(0);
		}
		ellipse(xpos,ypos,radius,radius);
	}
	
	void move(){
		xpos = xpos + xspeed;
		ypos = ypos + yspeed;
		if (xpos >= width){ //x bounce
				xpos = width;
				xspeed *= -1;
		}
		else if (xpos <= 0){
				xpos = 0;
				xspeed *= -1;
		}

		if (ypos >= height){ //y bounce
				ypos = height;
				yspeed *= -1;
		}
		else if (ypos <= 0){
				ypos = 0;
				yspeed *= -1;
		}		
	}
	
	void DEAD(){
		b = 1;
		yspeed = 0;
		xspeed = 0;
		ypos = 0;
		xpos = 0;
		radius = 0;
	}
	
	void blowUp(){
		b = 2;
    if (b != 3){
		radius += .75;}
		if (radius >= 110){
			b = 3;
		}
	}
}

ball[] re = new ball[25];
int tries;

void setup(){
	for (int x = 0; x < 25; x++){
		re[x] = new ball();
	}
	size(400,500);
	re[0].DEAD();
	tries = 1;
}

void draw(){
	background(0);
	for (int x = 0; x < 25; x++){
		re[x].display();
		re[x].move();

		if (re[x].b != 0 && re[x].b != 1){
      if (re[x].b == 2) re[x].blowUp();
      if (re[x].b == 3){
        re[x].radius -= 2;
        if (re[x].radius <= 0){
          re[x].DEAD();
        }
      }
			for (int y = 0; y < 25; y++){
					if(dist(re[y].xpos,re[y].ypos,re[x].xpos,re[x].ypos) < re[x].radius/1.5 && re[y].b != 1 && re[y].b != 3){
						re[y].xspeed = 0;
						re[y].yspeed = 0;
						re[y].blowUp();
					}
			}
    }
	}
}

void mouseClicked(){
	if (tries == 1){
		re[0].xpos = mouseX;
		re[0].ypos = mouseY;
		re[0].blowUp();
		tries = 0;
	}	
}
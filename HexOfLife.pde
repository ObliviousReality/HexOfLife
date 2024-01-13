final int GRIDSIZE = 20;

final int WINDOWSIZE = 800;

boolean[][] colourGrid = new boolean[GRIDSIZE][GRIDSIZE];

int optionSet = 1;

int refreshCounter = 60;

final color ALIVE = color(0, 255, 0);
final color DEAD = color(255, 0, 0);

void setColours() {
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            colourGrid[i][j] = !colourGrid[i][j];
        }
    }
}

void setup() {
    size(1000, 800);
    frameRate(60);
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            if ((int)random(100) % 4 == 0) {
                colourGrid[i][j] = false;
            }
            else {
                colourGrid[i][j] = true;
            }
        }
    }
}

void draw() {
    background(0);
    stroke(255);
    strokeWeight(0);
    int cellSize = WINDOWSIZE / GRIDSIZE;
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            int half = cellSize / 2;
            int quarter = cellSize / 4;

            int x = i * cellSize + (half * (j % 2 == 0 ? 1 : 2));
            int y = j * cellSize + (half) - (j * quarter);
            if (colourGrid[i][j]) {
                fill(ALIVE);
            }
            else {
                fill(DEAD);
            }
            beginShape();
            vertex(x, y - half);
            vertex(x + half, y - quarter);
            vertex(x + half, y + quarter);
            vertex(x, y + half);
            vertex(x - half, y + quarter);
            vertex(x - half, y - quarter);
            endShape();
        }
    }
    refreshCounter--;
    if (refreshCounter == 0) {
        refreshCounter = 60;
        setColours();
    }
}


void keyPressed() {
    if (key == 'p') {
        exit();
    }
    if (key == 'r') {
        setColours();
    }
}

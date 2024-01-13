final int GRIDSIZE = 80;

final int WINDOWSIZE = 800;

boolean[][] colourGrid = new boolean[GRIDSIZE][GRIDSIZE];

int optionSet = 1;

int refreshCounter = 60;

// final color ALIVE = color(0, 255, 0);
final color ALIVE = color(255, 255, 255);
// final color DEAD = color(255, 0, 0);
final color DEAD = color(0, 0, 0);

boolean checkAlive(int x, int y) {
    int aliveNeighbours = 0;
    /*
    x - 1 y x>0
    x + 1 y x<GRIDSIZE
    x y - 1 y>0
    x y + 1 y<GRIDSIZE
    x + 1 y - 1 x<GRIDSIZE y>0
    x + 1 y + 1 x<GRIDSIZE y<GRIDSIZE

    */
    if (x > 0) {
        aliveNeighbours += colourGrid[x - 1][y] ? 1 : 0;
    }
    if (x < GRIDSIZE - 1) {
        aliveNeighbours += colourGrid[x + 1][y] ? 1 : 0;
        if (y > 0) {
            aliveNeighbours += colourGrid[x + 1][y - 1] ? 1 : 0;
        }
        if (y < GRIDSIZE - 1) {
            aliveNeighbours += colourGrid[x + 1][y + 1] ? 1 : 0;
        }
    }
    if (y > 0) {
        aliveNeighbours += colourGrid[x][y - 1] ? 1 : 0;
    }
    if (y < GRIDSIZE - 1) {
        aliveNeighbours += colourGrid[x][y + 1] ? 1 : 0;
    }

    if(aliveNeighbours < 2) {
        return false;
    }
    if(aliveNeighbours > 3) {
        return false;
    }
    if(aliveNeighbours == 2 && !colourGrid[x][y]) {
        return false;
    }
    return true;
}

void setColours() {
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            colourGrid[i][j] = !colourGrid[i][j];
        }
    }
}

void buildStartingCells() {
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            if ((int)random(100) % 4 == 0) {
                colourGrid[i][j] = true;
            }
            else {
                colourGrid[i][j] = false;
            }
        }
    }
}

void setup() {
    size(825, 650);
    frameRate(60);
    buildStartingCells();
}

void draw() {
    background(0);
    stroke(0);
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
        refreshCounter = 10;
        for (int i = 0; i < GRIDSIZE; i++) {
            for (int j = 0; j < GRIDSIZE; j++) {
                colourGrid[i][j] = checkAlive(i, j);
            }
        }
    }
}


void keyPressed() {
    if (key == 'p') {
        exit();
    }
    if (key == 'r') {
        buildStartingCells();
    }
}

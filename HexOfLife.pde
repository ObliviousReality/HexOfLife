final int GRIDSIZE = 40;

final int WINDOWSIZE = 800;

boolean[][] colourGrid = new boolean[GRIDSIZE][GRIDSIZE];
boolean[][] newGrid = new boolean[GRIDSIZE][GRIDSIZE];

int optionSet = 1;

int refreshCounter = 60;

final color ALIVE = color(255, 255, 255);
final color DEAD = color(0, 0, 0);

boolean pause = false;
boolean doLoop = true;
boolean spacePressed = false;

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
    }
    if (y > 0) {
        aliveNeighbours += colourGrid[x][y - 1] ? 1 : 0;
    }
    if (y < GRIDSIZE - 1) {
        aliveNeighbours += colourGrid[x][y + 1] ? 1 : 0;
    }
    // Needed in Square Mode
    // if (x > 0 && y > 0) {
    //     aliveNeighbours += colourGrid[x - 1][y - 1] ? 1 : 0;
    // }
    // if (x > 0 && y < GRIDSIZE - 1) {
    //     aliveNeighbours += colourGrid[x - 1][y + 1] ? 1 : 0;
    // }
    if (x < GRIDSIZE - 1 && y > 0) {
        aliveNeighbours += colourGrid[x + 1][y - 1] ? 1 : 0;
    }
    if (x < GRIDSIZE - 1 && y < GRIDSIZE - 1) {
        aliveNeighbours += colourGrid[x + 1][y + 1] ? 1 : 0;
    }


    if (colourGrid[x][y]) {
        if (aliveNeighbours == 2 || aliveNeighbours == 3) {
            return true;
        }
        return false;
    }
    if (aliveNeighbours == 3) {
        return true;
    }
    return false;
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
            if ((int)random(100) % 10 == 0) {
                colourGrid[i][j] = true;
            }
            else {
                colourGrid[i][j] = false;
            }
        }
    }
}


void setup() {
    size(1000, 1000);
    frameRate(60);
    buildStartingCells();
}

void draw() {
    background(0);
    noStroke();
    int cellSize = WINDOWSIZE / GRIDSIZE;
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            int half = cellSize / 2;
            int quarter = cellSize / 4;

            int x = i * cellSize + (half * (j % 2 == 0 ? 1 : 2));
            int y = j * cellSize + (half) - (j * quarter) - j * 2;
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
            // square(i * cellSize, j * cellSize, cellSize);

        }
    }
    if (!pause && doLoop)
        refreshCounter--;
    if (refreshCounter == 0) {
        refreshCounter = 10;
        for (int i = 0; i < GRIDSIZE; i++) {
            for (int j = 0; j < GRIDSIZE; j++) {
                newGrid[i][j] = checkAlive(i, j);
            }
        }
        colourGrid = newGrid;
    }
}


void keyPressed() {
    if (key == 'p') {
        exit();
    }
    if (key == 'r') {
        refreshCounter = 60;
        buildStartingCells();
    }
    if (key == ' ' && !spacePressed) {
        pause = !pause;
        if(!doLoop) {
            spacePressed = true;
            for (int i = 0; i < GRIDSIZE; i++) {
                for (int j = 0; j < GRIDSIZE; j++) {
                    newGrid[i][j] = checkAlive(i, j);
                }
            }
            colourGrid = newGrid;
        }
    }
    if (key == 'l') {
        doLoop = !doLoop;
    }
}

void keyReleased() {
    spacePressed = false;
}

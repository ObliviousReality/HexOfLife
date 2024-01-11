final int GRIDSIZE = 10;

final int WINDOWSIZE = 800;

color [][] colourGrid = new color[GRIDSIZE][GRIDSIZE];

int optionSet = 1;

void setColours(int option) {
    color colourA = color(0);
    color colourB = color(0);
    if (option == 1) {
        colourA = color(0, 255, 255, 255);
        colourB = color(255, 0, 255, 255);
    }
    else if (option == 2) {
        colourA = color(255, 0, 255, 255);
        colourB = color(0, 255, 255, 255);
    }
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            if ((i + j) % 2 == 0) {
                colourGrid[i][j] = colourA;
            }
            else {
                colourGrid[i][j] = colourB;
            }
        }
    }
}

void setup() {
    size(1000, 800);
    setColours(1);
    draw();
}


void draw() {
    background(0);
    stroke(255);
    strokeWeight(0);
    int cellSize = WINDOWSIZE / GRIDSIZE;
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            // fill(255, 255, 0, 255);
            // square(i * cellSize, j * cellSize, cellSize);


            int half = cellSize / 2;
            int quarter = cellSize / 4;

            int x = i * cellSize + (half * (j % 2 == 0 ? 1 : 2));
            int y = j * cellSize + (half) - (j * quarter);
            fill(colourGrid[i][j]);
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
    delay(1000);
    optionSet++;
    if(optionSet > 2) {
        optionSet = 1;
    }
    setColours(optionSet);
}


void keyPressed() {
    if (key == 'p') {
        exit();
    }

    if (key == 'a') {
        setColours(1);
    }
    if (key == 'b') {
        setColours(2);
    }
}

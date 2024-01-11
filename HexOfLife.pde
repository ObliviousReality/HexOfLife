final int GRIDSIZE = 10;

final int WINDOWSIZE = 800;

void setup() {
    size(1000, 800);
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
            fill(255, 0, 255, 255);
            if ((i + j) % 2 == 0) {
                fill(0, 255, 255, 255);
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
    noLoop();
}


void keyPressed() {
    if (key == 'p') {
        exit();
    }
}

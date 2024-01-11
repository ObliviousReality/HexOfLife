final int GRIDSIZE = 10;

final int WINDOWSIZE = 800;

void setup() {
    size(800, 800);
}


void draw() {
    background(0);
    stroke(255);
    int cellSize = WINDOWSIZE / GRIDSIZE;
    for (int i = 0; i < GRIDSIZE; i++) {
        for (int j = 0; j < GRIDSIZE; j++) {
            // fill(255, 255, 0, 255);
            // square(i * cellSize, j * cellSize, cellSize);
            fill(0, 255, 255, 255);
            int half = cellSize / 2;
            int quarter = cellSize / 4;
            int x = i * cellSize + (half);
            int y = j * cellSize + (half);

            strokeWeight(2);
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

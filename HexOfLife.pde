final int GRIDSIZE = 10;

final int WINDOWSIZE = 800;

void setup() {
    size(800, 800);
}


void draw() {
    background(0);
    stroke(255);
    int cellSize = WINDOWSIZE / GRIDSIZE;
    for (int i = 0; i < WINDOWSIZE; i+=cellSize) {
        for (int j = 0; j < WINDOWSIZE; j+=cellSize) {
            // fill(255, 255, 0, 255);
            // square(i, j, cellSize);
            fill(0, 255, 255, 255);
            int half = cellSize / 2;
            int quarter = cellSize / 4;
            int x = i + (half);
            int y = j + (half);

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

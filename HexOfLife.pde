final int GRIDSIZE = 10;

final int WINDOWSIZE = 800;

void setup() {
    size(800, 800);
}


void draw() {
    background(0);
    fill(255, 255, 0, 255);
    stroke(0);
    int cellSize = WINDOWSIZE / GRIDSIZE;
    int sqCount = 0;
    for (int i = 0; i < WINDOWSIZE; i+=cellSize) {
        for (int j = 0; j < WINDOWSIZE; j+=cellSize) {
            square(i, j, cellSize);
            sqCount++;
        }
    }
    print(sqCount);
    noLoop();
}

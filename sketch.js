const GRIDSIZE = 100;

const WINDOWSIZE = 1300;

let colourGrid;
let newGrid;

let cellSize = WINDOWSIZE / GRIDSIZE;
let half = cellSize / 2;
let quarter = cellSize / 4;

let optionSet = 1;

let refreshCounter = 60;

let ALIVE;
let DEAD;

let pause = false;
let doLoop = true;
let spacePressed = false;

var DEBUGMODE = false;

function make2DArray(cols, rows) {
  let arr = new Array(cols);
  for (let i = 0; i < arr.length; i++) {
    arr[i] = new Array(rows);
    for (let j = 0; j < arr[i].length; j++) {
      arr[i][j] = false;
    }
  }
  return arr;
}

function getCenterCoord(x, y) {
  let r = new Array(2);
  r[0] = x * cellSize + (half * (y % 2 == 0 ? 1 : 2));
  r[1] = y * cellSize + (half) - (y * quarter) - y * 2;
  return r;
}

function lineTo(start, end) {
  if (!DEBUGMODE) {
    return;
  }
  push();
  stroke(0, 0, 255, 64);
  strokeWeight(5);
  line(start[0], start[1], end[0], end[1]);
  pop();
}

function textAt(coord, count) {
  push();
  fill(255, 0, 0, 255);
  strokeWeight(5);
  textSize(10);
  textAlign(CENTER, CENTER);
  text(count, coord[0], coord[1]);
  pop();
}

function checkAlive(x, y) {
  let aliveNeighbours = 0;
  /*
  x - 1 y x>0
  x + 1 y x<GRIDSIZE
  x y - 1 y>0
  x y + 1 y<GRIDSIZE
  x + 1 y - 1 x<GRIDSIZE y>0
  x + 1 y + 1 x<GRIDSIZE y<GRIDSIZE

  */
  let centerPos = getCenterCoord(x, y);
  if (x > 0) {
    if (colourGrid[x - 1][y]) {
      aliveNeighbours++;
      lineTo(centerPos, getCenterCoord(x - 1, y));
    }
  }
  if (x < GRIDSIZE - 1) {
    if (colourGrid[x + 1][y]) {
      aliveNeighbours++;
      lineTo(centerPos, getCenterCoord(x + 1, y));
    }
  }
  if (y > 0) {
    if (colourGrid[x][y - 1]) {
      aliveNeighbours++;
      lineTo(centerPos, getCenterCoord(x, y - 1));
    }
  }
  if (y < GRIDSIZE - 1) {
    if (colourGrid[x][y + 1]) {
      aliveNeighbours++;
      lineTo(centerPos, getCenterCoord(x, y + 1));
    }
  }
  if (y % 2 == 0) {
    if (x > 0 && y > 0) {
      if (colourGrid[x - 1][y - 1]) {
        aliveNeighbours++;
        lineTo(centerPos, getCenterCoord(x - 1, y - 1));
      }
    }
    if (x > 0 && y < GRIDSIZE - 1) {
      if (colourGrid[x - 1][y + 1]) {
        aliveNeighbours++;
        lineTo(centerPos, getCenterCoord(x - 1, y + 1));
      }
    }
  }
  else {
    if (x < GRIDSIZE - 1 && y > 0) {
      if (colourGrid[x + 1][y - 1]) {
        aliveNeighbours++;
        lineTo(centerPos, getCenterCoord(x + 1, y - 1));
      }
    }
    if (x < GRIDSIZE - 1 && y < GRIDSIZE - 1) {
      if (colourGrid[x + 1][y + 1]) {
        aliveNeighbours++;
        lineTo(centerPos, getCenterCoord(x + 1, y + 1));
      }
    }
  }
  if (DEBUGMODE) {
    textAt(centerPos, aliveNeighbours);
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

function setColours() {
  for (let i = 0; i < GRIDSIZE; i++) {
    for (let j = 0; j < GRIDSIZE; j++) {
      colourGrid[i][j] = !colourGrid[i][j];
    }
  }
}

function buildStartingCells() {
  for (let i = 0; i < GRIDSIZE; i++) {
    for (let j = 0; j < GRIDSIZE; j++) {
      if (floor(random(100)) % 6 == 0) {
        colourGrid[i][j] = true;
      }
      else {
        colourGrid[i][j] = false;
      }
    }
  }
}

function setup() {
  createCanvas(1300, 825);
  frameRate(60);

  colourGrid = make2DArray(GRIDSIZE, GRIDSIZE);
  newGrid = make2DArray(GRIDSIZE, GRIDSIZE);

  ALIVE = color(255, 255, 255);
  DEAD = color(18, 18, 18);
  buildStartingCells();
}

function draw() {
  background(18);
  noStroke();
  for (let i = 0; i < GRIDSIZE; i++) {
    for (let j = 0; j < GRIDSIZE; j++) {

      let center = getCenterCoord(i, j);
      let x = center[0];
      let y = center[1];
      if (colourGrid[i][j]) {
        fill(ALIVE);
        beginShape();
        vertex(x, y - half);
        vertex(x + half, y - quarter);
        vertex(x + half, y + quarter);
        vertex(x, y + half);
        vertex(x - half, y + quarter);
        vertex(x - half, y - quarter);
        endShape();
      }
      // square(i * cellSize, j * cellSize, cellSize);

    }
  }
  if (!pause && doLoop)
    refreshCounter--;
  if (refreshCounter == 0) {
    if (DEBUGMODE) {
      refreshCounter = 1;
    }
    else {
      refreshCounter = 5;
    }
    for (let i = 0; i < GRIDSIZE; i++) {
      for (let j = 0; j < GRIDSIZE; j++) {
        newGrid[i][j] = checkAlive(i, j);
      }
    }
    colourGrid = newGrid;
  }
}


function keyPressed() {
  if (key == 'p') {
    exit();
  }
  if (key == 'r') {
    refreshCounter = 60;
    buildStartingCells();
  }
  if (key == ' ' && !spacePressed) {
    pause = !pause;
    if (!doLoop) {
      spacePressed = true;
      for (let i = 0; i < GRIDSIZE; i++) {
        for (let j = 0; j < GRIDSIZE; j++) {
          newGrid[i][j] = checkAlive(i, j);
        }
      }
      colourGrid = newGrid;
    }
  }
  if (key == 'l') {
    doLoop = !doLoop;
  }

  if (key == 'D') {
    console.log("HELLO!");
    DEBUGMODE = !DEBUGMODE;
  }
}

function keyReleased() {
  spacePressed = false;
}

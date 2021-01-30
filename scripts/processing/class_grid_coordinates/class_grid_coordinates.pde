// DESCRIPTION
// Grid of rectangles with random stroke colors from hard-coded array of colors.

// USAGE
// Open this file in the Processing IDE (or anything else that can run a Processing file), and run it with the triangle "Play" button.


// CODE
// by Richard Alexander Hall

// TO DO; * = doing:
// - fix code smell of casting grid constructor's float x and y params to ints?

// class for grid of coordinates
class grid {
  // members
  float gridWidth, gridHeight;    // total width and height of grid
  float cellWidth, cellHeight;    // width and height of each cell in the grid
  int cellXcount, cellYcount;     // number of cells accross and down in the grid.
  float gridUpperLeftXoffset = 0; float gridUpperLeftYoffset = 0;   // to center grid coordinates on the canvas if cellWidth and cellHeight don't evenly divide into gridWidth and/or gridHeight. Otherwise, the grid could be in the upper left with padding on the right and below. Note that defaults (initialization) are provided here; they will be overriden if necessary.
  PVector[][] coordinates;       // two-dimensional array of PVectors of cells organized like [cellXcount][cellYcount], where each vector is the x and y coordinate of the center of the cell.

  // constructor requires string that declares a construction mode declaration, for which the options are:
  // - "setCellCountXY", to init with wanted number of cells across and down, and the constructor will do the math on cell width and height.
  // - "setCellWidthAndHeight", to init with wanted width and height of cells, and the constructor will do the math on how many cells across and down that means. as setCellWidthAndHeight can lead to a grid fixed to the upper left with padding on the right and below if the x and/or y parameters don't evenly divide into wantedGridWidth and wantedGridHeight, the function does math to offset the coordinates so that the grid is centered on the canvas.
  grid (int wantedGridWidth, int wantedGridHeight, float x, float y, String initMode) {
    gridWidth = wantedGridWidth; gridHeight = wantedGridHeight;
        // debug print of values passed to function:
        print("grid class constructor called with these values: wantedGridWidth:" + wantedGridWidth + " wantedGridHeight:" + wantedGridHeight + " x:" + x + " y:" + y + " initMode:" + initMode + "\n");
		// init cell width, height, and number of cells according to value of String initMode:
    switch(initMode) {
      case "setCellWidthAndHeight":
        cellWidth = x; cellHeight = y;
        cellXcount = int(gridWidth / cellWidth); cellYcount = int(gridHeight / cellHeight);
        // calc offsets which will be used to center grid (coordinates) on canvas:
        gridUpperLeftXoffset = (gridWidth - cellXcount * cellWidth) / 2;
        gridUpperLeftYoffset = (gridHeight - cellYcount * cellHeight) / 2;
        break;
      case "setCellCountXY":
        // set number of cells across and down from wanted cell width and height, then calc cellWidth and cellHeight from that:
				cellXcount = int(x); cellYcount = int(y);
        cellWidth = gridWidth / cellXcount; cellHeight = gridHeight / cellYcount;
        break;
      default:
        print("ERROR: grid class constructor called with wrong string parameter! Use either \"setCellWidthAndHeight\" or \"setCellCountXY\".\n");
        exit();
        break;
    }
    // debug print of resultant values:
    print("result values of grid constructor call: gridWidth:" + gridWidth + " gridHeight:" + gridHeight + " cellWidth:" + cellWidth + " cellHeight:" + cellHeight + " cellXcount:" + cellXcount + " cellYcount:" + cellYcount + " gridUpperLeftXoffset: " + gridUpperLeftXoffset + " gridUpperLeftYoffset:" + gridUpperLeftYoffset + "\n");

    // allocate memory for PVector array named "coordinates":
    coordinates = new PVector[int(cellXcount)][int(cellYcount)];

    // init coordinates two-dimensional array:
    // last y pos should be canvas height - (cell height / 2), or: 500-(9.615385/2) = 495.1923075. But it's 485.57697; why? :
    for (int yIter = 0; yIter < int(cellYcount); yIter++) {
      for (int xIter = 0; xIter < int(cellXcount); xIter++) {
        float pvector_x_coord = ((xIter+1) * cellWidth) - (cellWidth / 2) + gridUpperLeftXoffset;
        float pvector_y_coord = ((yIter+1) * cellHeight) - (cellHeight / 2) + gridUpperLeftYoffset;
        // debug print of values:
        print("xIter:" + xIter + " yIter:" + yIter + " pvector_x_coord:" + pvector_x_coord + " pvector_y_coord: " + pvector_y_coord + "\n");
        coordinates[xIter][yIter] = new PVector(pvector_x_coord, pvector_y_coord);
      }
    }

  }

}

// have to declare here or draw() won't know it exists; but have to initialize in settings to get width and height that result from size() in settings():
grid mainGrid;

void setup() {
  // fullScreen();
  size(350,350);
  // function reference: grid (int wantedGridWidth, int wantedGridHeight, float x, float y, String initMode) {
  // mainGrid = new grid(width, height, 7, 7, "setCellCountXY");
  mainGrid = new grid(width, height, 40, 40, "setCellWidthAndHeight");
}

// main Processing draw function (it loops infinitely)
void draw() {
  ellipseMode(CENTER);
	int circle_size = 40;
  // [col][row]:
  PVector coord = mainGrid.coordinates[0][0];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.coordinates[7][0];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.coordinates[7][7];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.coordinates[0][7];
  circle(coord.x, coord.y, circle_size);
}

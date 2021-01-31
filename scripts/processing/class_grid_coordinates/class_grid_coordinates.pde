// DESCRIPTION
// Grid of rectangles with random stroke colors from hard-coded array of colors.

// USAGE
// Open this file in the Processing IDE (or anything else that can run a Processing file), and run it with the triangle "Play" button.


// CODE
// by Richard Alexander Hall


// class for grid of coordinates
class grid {
  // members
  int gridWidth, gridHeight;    // total width and height of grid
  int cellWidth, cellHeight;    // width and height of each cell in the grid
  int cellXcount, cellYcount;     // number of cells accross and down in the grid.
  int gridUpperLeftXoffset = 0; int gridUpperLeftYoffset = 0;   // to center grid coordinates on the canvas if cellWidth and cellHeight don't evenly divide into gridWidth and/or gridHeight. Otherwise, the grid could be in the upper left with padding on the right and below. Note that defaults (initialization) are provided here; they will be overriden if necessary.
  // THE FOLLOWING are two-dimensional arrays of PVectors of cells organized like [cellXcount][cellYcount] (or [cols][rows] or [accross][down], where each vector is an x and y coordinate associated with a cell:
  PVector[][] centerCoordinates;        // center of cell
  PVector[][] upperLeftCoordinates;     // upper left corner of cell
  PVector[][] upperRightCoordinates;    // upper right corner of cell
  PVector[][] lowerRightCoordinates;    // lower right corner of cell
  PVector[][] lowerLeftCoordinates;     // lower left corner of cell

  // constructor requires string that declares a construction mode declaration, for which the options are:
  // - "setCellCountXY", to init with wanted number of cells across and down, and the constructor will do the math on cell width and height.
  // - "setCellWidthAndHeight", to init with wanted width and height of cells, and the constructor will do the math on how many cells across and down that means. as setCellWidthAndHeight can lead to a grid fixed to the upper left with padding on the right and below if the x and/or y parameters don't evenly divide into wantedGridWidth and wantedGridHeight, the function does math to offset the coordinates so that the grid is centered on the canvas.
  grid (int wantedGridWidth, int wantedGridHeight, int x, int y, String initMode) {
    gridWidth = wantedGridWidth; gridHeight = wantedGridHeight;
        // debug print of values passed to function:
        print("grid class constructor called with these values: wantedGridWidth:" + wantedGridWidth + " wantedGridHeight:" + wantedGridHeight + " x:" + x + " y:" + y + " initMode:" + initMode + "\n");
		// init cell width, height, and number of cells according to value of String initMode:
    switch(initMode) {
      case "setCellWidthAndHeight":
        cellWidth = x; cellHeight = y;
        cellXcount = gridWidth / cellWidth; cellYcount = gridHeight / cellHeight;
        // calc offsets which will be used to center grid (coordinates) on canvas:
        gridUpperLeftXoffset = (gridWidth - cellXcount * cellWidth) / 2;
        gridUpperLeftYoffset = (gridHeight - cellYcount * cellHeight) / 2;
        break;
      case "setCellCountXY":
        // set number of cells across and down from wanted cell width and height, then calc cellWidth and cellHeight from that:
				cellXcount = x; cellYcount = y;
        cellWidth = gridWidth / cellXcount; cellHeight = gridHeight / cellYcount;
        break;
      default:
        print("ERROR: grid class constructor called with wrong string parameter! Use either \"setCellWidthAndHeight\" or \"setCellCountXY\".\n");
        exit();
        break;
    }
    // debug print of resultant values:
    print("result values of grid constructor call: gridWidth:" + gridWidth + " gridHeight:" + gridHeight + " cellWidth:" + cellWidth + " cellHeight:" + cellHeight + " cellXcount:" + cellXcount + " cellYcount:" + cellYcount + " gridUpperLeftXoffset: " + gridUpperLeftXoffset + " gridUpperLeftYoffset:" + gridUpperLeftYoffset + "\n");

    // allocate memory for PVector arrays of two-dimensional coordinates:
    centerCoordinates = new PVector[cellXcount][cellYcount];

    // init two-dimensional array centerCoordinates:
    for (int yIter = 0; yIter < cellYcount; yIter++) {
      for (int xIter = 0; xIter < cellXcount; xIter++) {
        float pvector_x_coord = ((xIter+1) * cellWidth) - (cellWidth / 2) + gridUpperLeftXoffset;
        float pvector_y_coord = ((yIter+1) * cellHeight) - (cellHeight / 2) + gridUpperLeftYoffset;
        // debug print of values:
        print("xIter:" + xIter + " yIter:" + yIter + " pvector_x_coord:" + pvector_x_coord + " pvector_y_coord: " + pvector_y_coord + "\n");
        centerCoordinates[xIter][yIter] = new PVector(pvector_x_coord, pvector_y_coord);
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
  mainGrid = new grid(width, height, 13, 8, "setCellCountXY");
  // mainGrid = new grid(width, height, 70, 70, "setCellWidthAndHeight");
}

// main Processing draw function (it loops infinitely)
void draw() {
  ellipseMode(CENTER);
	int circle_size = mainGrid.cellWidth;
  // [col][row]:
  PVector coord = mainGrid.centerCoordinates[0][0];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.centerCoordinates[4][0];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.centerCoordinates[2][4];
  circle(coord.x, coord.y, circle_size);
  coord = mainGrid.centerCoordinates[0][3];
  circle(coord.x, coord.y, circle_size);
  
  coord = mainGrid.centerCoordinates[4][1];
  circle(coord.x, coord.y, circle_size);
}

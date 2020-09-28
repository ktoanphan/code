#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>

typedef struct Color
{
	uint8_t R;
	uint8_t G;
	uint8_t B;
} Color;

typedef struct Image
{
	Color **image;
	uint32_t rows;
	uint32_t cols;
} Image;

Image *readData(char *filename)
{
	Image *img;
	img = (Image *)malloc(sizeof(Image));
	if (img == NULL)
	{
		printf("allocation failed\n");
		exit(0);
	}

	FILE *fp = fopen(filename, "r");
	if (fp == NULL)
	{
		printf("no such file.");
		return 0;
	}

	char format[3];
	int cols, rows;
	int range;
	fscanf(fp, "%s %d %d %d", format, &cols, &rows, &range);

	img->cols = cols;
	img->rows = rows;
	img->image = (Color **)malloc((cols * rows) * sizeof(Color *));
	if (img->image == NULL)
	{
		printf("allocation failed\n");
		exit(0);
	}

	for (int i = 0; i < rows * cols; i++)
	{
		int red, green, blue;
		fscanf(fp, "%d %d %d", &red, &green, &blue);
		Color *c;
		c = (Color *)malloc(sizeof(Color));
		if (c == NULL)
		{
			printf("allocation failed\n");
			exit(0);
		}
		c->R = red;
		c->G = green;
		c->B = blue;
		img->image[i] = c;
	}

	fclose(fp);
	return img;
}

//Frees an image
void freeImage(Image *image)
{
	// no need to free if it's NULL
	if (image == NULL)
	{
		printf("allocation failed\n");
		exit(-1);
	}

	uint32_t rows, cols;
	rows = image->rows;
	cols = image->cols;

	for (int i = 0; i < rows * cols; i++)
	{
		free(image->image[i]);
	}

	free(image->image);
	free(image);
}

void printCell(Image *image, int row, int col)
{

	int numRows = image->rows;
	int numCols = image->cols;

	int pos = numCols * row + col;

	int above, below, left, right, upperLeft, upperRight, lowerLeft, lowerRight;

	int colIncr = (col + 1) % numCols;
	int colDecr = (col - 1) % numCols;
	if (colDecr < 0)
	{
		colDecr = numCols - 1;
	}
	int rowIncr = (row + 1) % numRows;
	int rowDecr = (row - 1) % numRows;
	if (rowDecr < 0)
	{
		rowDecr = numRows - 1;
	}

	above = numCols * rowDecr + col;
	below = numCols * rowIncr + col;
	left = numCols * row + colDecr;
	right = numCols * row + colIncr;
	upperLeft = numCols * rowDecr + colDecr;
	upperRight = numCols * rowDecr + colIncr;
	lowerLeft = numCols * rowIncr + colDecr;
	lowerRight = numCols * rowIncr + colIncr;

	Color *cell = (Color *)malloc(sizeof(Color));
	cell = image->image[pos];
	Color *top = image->image[above];
	Color *bottom = image->image[below];
	Color *l = image->image[left];
	Color *r = image->image[right];
	Color *upperL = image->image[upperLeft];
	Color *upperR = image->image[upperRight];
	Color *lowerL = image->image[lowerLeft];
	Color *lowerR = image->image[lowerRight];

	printf("cell:  %d\n", cell->B & 1);
	printf("top:  %d\n", top->B & 1);
	printf("bottom:  %d\n", bottom->B & 1);
	printf("left: %d\n", l->B & 1);
	printf("right:  %d\n", r->B & 1);
	printf("upperLeft:  %d\n", upperL->B & 1);
	printf("upperRight:  %d\n", upperR->B & 1);
	printf("lowerLeft:  %d\n", lowerL->B & 1);
	printf("lowerRight:  %d\n\n", lowerR->B & 1);
}

int fun(int x) {
		return -x * (x + 1);
}

int main()
{

	char *filename = "file.txt";
	Image *image = readData(filename);
	int row = image->rows;
	int col = image->cols;
	printf("Hello: %d %d\n", col, row);

	uint8_t count = 0;
	uint8_t R, G, B;
	for (int i = 0; i < row * col; i++)
	{
		Color *c = (Color *)image->image[i];
		R = image->image[i]->R;
		G = image->image[i]->G;
		B = image->image[i]->B;
		printf("%3d", R);
		printf(" ");
		printf("%3d", G);
		printf(" ");
		printf("%3d", B);
		printf("   ");

		count++;
		if (count == col)
		{
			printf("\n");
			count = 0;
		}
	}

	//creating a multi array in C
	int multiArray[3][4] = {
		{0, 1, 2, 3},
		{4, 5, 6, 7},
		{8, 9, 10, 11}};

	printf("\n\n");
	printf("Cell at 11: \n");
	printCell(image, 1, 1);
	freeImage(image);



	int aliveNeighbors[3] = {0, 0, 0}; // red - green - blue

	int a = 0x1808; // 0b00 0001 1000 0000 1000

	int alive = a >> 9;
	int dead = a & ((1 << 9) - 1);
	// int dead = (rule << 23) >> 23;
	int aliveBit[9] =  {-1, -1, -1, -1, -1, -1, -1, -1, -1};
	int deadBit[9] =  {-1, -1, -1, -1, -1, -1, -1, -1, -1};
	for (int i = 0; i < 9; i++)
	{
		if ((alive & 1) == 1)
		{
			printf(" %d ", i);
			aliveBit[i] = 1;
			printf(" %d\n", aliveBit[i]);
		}

		if ((dead & 1) == 1)
		{
			printf(" %d ", i);
			deadBit[i] = 1;
			printf(" %d\n", deadBit[i]);
		}

		alive = alive >> 1;
		dead = dead >> 1;
	}


	int source[] = {3, 1, 4, 1, 5, 9, 0};
	int dest[10];


int fun(int x) {
		return -x * (x + 1);
}

    int k;
    int sum = 0;
    for (k = 0; source[k] != 0; k++) {
        dest[k] = fun(source[k]);
        sum += dest[k];
    }
    printf("sum: %d\n", sum);

	return 0;
}

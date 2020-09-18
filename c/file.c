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
	img = (Image *) malloc (sizeof(Image));
	if (img == NULL) {
		printf("allocation failed\n"); 
		exit(0);
	}

	FILE *fp = fopen(filename, "r"); 
	if (fp == NULL) {
		printf("no such file."); 
		return 0;
	}
	
	char format[3]; 
	int cols, rows;
	int range; 
	fscanf(fp, "%s %d %d %d", format, &cols, &rows, &range);

	img->cols = cols;
	img->rows = rows;
	img->image = (Color **) malloc( (cols * rows) * sizeof(Color*));
	if (img->image == NULL) {
		printf("allocation failed\n"); 
		exit(0);
	}
	
	//change size(image) to row*cols
	for (int i = 0; i < rows * cols; i++) 
	{
		int red, green, blue;
		fscanf(fp, "%d %d %d", &red, &green, &blue);
		Color *c;
		c = (Color *) malloc(sizeof(Color));
		if (c == NULL) {
			printf("allocation failed\n"); 
			exit(0);
		}
		c->R = red; 
		c->G = green;
		c->B = blue;
		img->image[i] = c;
		// free(c);
	} 

	// free(img->image);
	// free(img); 
	fclose(fp); 
	return img; 
}

int main() {

	char *filename = "file.txt";
	Image *image = readData(filename);
	int row = image->rows; 
	int col = image->cols; 
	printf("Hello: %d %d\n", col, row);

	uint8_t count = 0;
	uint8_t R, G, B; 
	for (int i = 0; i < row * col; i++) {
		Color *c = (Color *) image->image[i];
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
		if (count == col) {
			printf("\n"); 
			count = 0;
		}

	}

	printf("\n\n\nHello\n");
	unsigned b = 201; 
	printf("b: %d\n", b); 
	unsigned c = b & 1; 
	printf("c: %d\n", c);

	return 0;
}

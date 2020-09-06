#include <stdio.h>

void swap(int *a, int*b) {
	int temp;
	temp = *a;
	*a = *b; 
	*b = temp; 
}

int main() {
	int a, b; 
	a = 1; 
	b = 2;
	printf("%d\n", a);
	printf("%d\n", b);
	swap(&a, &b);
	printf("%d, %d\n", a, b);
}

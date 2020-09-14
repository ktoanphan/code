#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define PASSWORD "hunter2"


void swap(int *a, int*b) {
	int temp;
	temp = *a;
	*a = *b; 
	*b = temp; 
}

char *check_permissions (char *user_guess) {
     if (user_guess == PASSWORD) {
          return "access granted";
     }
     return "access denied";
}

int foo () {
     int *x = malloc(20);
     x[0] = x[1] = 1;
     x[2] = x[0] + x[1];
     x[3] = 99;
     return x[3];
}

int main() {
//	int a, b; 
//	a = 1; 
//	b = 2;
//	printf("%d, %d\n", a, b);
//	swap(&a, &b);
//	printf("%d, %d\n", a, b);

	// int x[5];
	// x[0] = 254; x[1] = 649; x[2] = 971; x[3] = 1678;
	// unsigned char *y = (unsigned char*) x;
	// printf("address of array x: %p\n", x);
	// printf("address of x+1: %p\n", x+1);
	// printf("address of x+9%p\n", x+9);
	// printf("address of first elem of array x: %p\n", &x);	
	// printf("address of y pointer: %p\n", y);
	// printf("address of y with the sign:  %p\n", &y);
	// printf("printing *y: %d\n", *y);
	// printf("print *(y+3): %d\n", *(y+3));
	// printf("%zu\n", sizeof(x));
	// printf("%zu\n", sizeof(x[0]));

	// char* a = "hello";
	// int len = 0; 
	// printf("len: %zu\n", sizeof(a));
	// printf("len1: %zu\n", strlen(a));

	// while (*a++) {
	// 	len++;
	// }
	// printf("len2: %d\n", len);

	// int x = 0; 
	// int y = x++; 
	// int z = ++x;
	// printf("hi: %d %d\n", y, z);

	// char *c = malloc(0xFFFFFFFF * sizeof(char));
    // c[0] = '!';
	// printf("c: %c\n", c[0]);

	// int *b = malloc(20);

	// int hello = foo();
	// printf("hello foo: %d\n", hello);


	// char *user_guess = "hunter2";
	// printf("guess: %s\n", check_permissions(user_guess));

	char *a = "foobar";
	printf("sizeof(a) pointer: %lu \n", sizeof(a));
	printf("sizeof(*a) the first element of the string array: %lu \n", sizeof(*a));
	printf("first char: %c \n", *a);
	printf("strlen(a): %lu \n", strlen(a));
	printf("print a pointer: %p \n", a);


	char b[] = "foobar"; 
	printf(" \n\n");
	printf("sizeof(b) pointer: %lu \n", sizeof(b));
	printf("sizeof(*b) the first element of the string array: %lu \n", sizeof(*b));
	printf("first char: %c \n", *b);
	printf("strlen(b)): %lu \n", strlen(b));
	printf("print b pointer: %p \n", b);
}

#include <stdlib.h>
#include <stdio.h>

int main() {

    int x = 0;
    if (x < 5) {
        goto label;
    }

    label: 
        printf("hello world! ");
}
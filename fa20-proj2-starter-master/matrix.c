#include<stdio.h>

int main(){
    int sum[6] ={0,0,0,0,0,0};
    int A[9]={1,2,2,1};
    int B[6]={6,5,4,3,2,1};
    int heightA = 3;
    int widthA = 3;
    int heightB = 3;
    int widthB = 2;

    // Matrix multiplication
    for (int i = 0; i < heightA; i++) { // Rows of A
        for (int j = 0; j < widthB; j++) { // Columns of B
            for (int k = 0; k < widthA; k++) { // Columns of A / Rows of B
                sum[i*widthB+j] += A[i*widthA+k] * B[j+k*widthB];
            }
        }
    }

    // // Print the result matrix
    // for (int i = 0; i < heightA; i++) { // Loop over rows
    //     for (int j = 0; j < widthB; j++) { // Loop over columns
    //         printf("%d ", sum[i*widthB+j]); // Print each element
    //     }
    //     printf("\n"); // New line after each row
    // }
}
#include <stdio.h>
#include <stdlib.h>

void checksum_col_generator(float **A, int A_row, int A_col, float ***Ac_point) {
    float temp_sum;
    float **Ac = *Ac_point;

    for (int i = 0; i < A_row+1; i++) {
        temp_sum = 0;
        for (int j = 0; j < A_col; j++) {
            temp_sum += A[j][i];
            Ac[j][i] = A[j][i];
        }
        Ac[A_row][i] = temp_sum;
    }
}

void checksum_row_generator(float ***A_point, int A_row, int A_col, float ***Arp) {
    float temp_sum;

    float **A = *A_point;
    float **Ar = *Arp;

    for (int i=0; i<A_row; i++) {
        temp_sum = 0;
        for (int j = 0; j<A_col; j++) {
            temp_sum += A[i][j];
            Ar[i][j] = A[i][j];
        }
        Ar[i][A_col] = temp_sum;
    }
}

void checksum_matrix_generator(float ***A, int A_row, int A_col, float ***Afp) {
    float **Af = *Afp;
    float **A_temp = (float **) calloc(A_row+1, sizeof(float *));

    for (int i = 0; i < A_row+1; i++) {
        A_temp[i] = (float *) calloc(A_col+1, sizeof(float));
    }

    checksum_row_generator(A, A_row, A_col, &A_temp);


    for (int i = 0; i < A_row+1; i++) {
        for (int j = 0; j < A_col+1; j++) {
            printf("%f\t", A_temp[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    
    checksum_col_generator(A_temp, A_row, A_col+1, Afp);

    for (int i = 0; i < A_row+1; i++) {
        for (int j = 0; j < A_col+1; j++) {
            printf("%f\t", Af[i][j]);
        }
        printf("\n");
    }

    free(A_temp);
}

int main() {
    float **test = (float **) calloc(3,sizeof(float *));
    float **A_f = (float **) calloc(4,sizeof(float *));

    float counter = 1;

    for (int i = 0; i < 3; i++) {
        test[i] = (float *) calloc(3,sizeof(float));
        for (int j = 0; j < 3; j++) {
            test[i][j] = counter;
            counter++;
        }
    }

    for (int i = 0; i < 4; i++) {
        A_f[i] = (float *) calloc(4,sizeof(float));
    }

    checksum_matrix_generator(&test, 3, 3, &A_f);
    
    free(test);
    free(A_f);
}
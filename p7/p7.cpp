#include <iostream>
#include <vector>

using namespace std;

typedef vector<vector<int>>  matrix;

float div_by_two(int val);
float sum(matrix mat, int filas, int cols);


int main(void) {

  int noFilas, noColumnas;
  
  //Pedimos filas y columnas
  do {
    cout << "Filas > "; cin >> noFilas;
    cout << "Columnas > "; cin >> noColumnas;
  } while (noFilas < 0 || noColumnas <0);

  //Definimos la matriz
  matrix mat(noColumnas);
  for (int i = 0; i < noColumnas; i++)
    mat[i] = vector<int>(noFilas);



  //Pedimos los datos de la matriz
  for (int i = 0; i < noFilas; i++) {
    for (int j = 0; j < noColumnas; j++){
      cout << "Dato [" << i << "][" << j << "] > ";
      cin >> mat[i][j];
    }
  }


  //Imprimimos la matriz
  for (int i = 0; i < noFilas; i++) {
    for (int j = 0; j < noColumnas; j++)
      cout << mat[i][j] << "  ";
    cout << endl;
  }

  cout << "Suma > " << sum(mat, noFilas, noColumnas) << endl;
  return 0;
}


float div_by_two(int val) {
  return (float)val/2.0;
}



float sum(matrix mat, int filas, int cols) {
  float res = 0;
  for (int i = 0; i < filas; i++) 
    for (int j = 0; j < cols; j++) 
      res += div_by_two(mat[i][j]);
   return res; 
}



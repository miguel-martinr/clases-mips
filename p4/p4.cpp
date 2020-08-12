#include <iostream>

using namespace std;

int main(void) {

  const int nrows = 4, ncols = 3;
  int matrix[nrows][ncols] = {
    {11,12,13},
    {21,22,23},
    {31,32,33},
    {41,42,43}
  };

  cout << "Practica 4. Trabajando con matrices\n";





  int selection;


  do {

    int i,j;
    for (i = 0; i < nrows; i++) {
      for (j = 0; j < ncols; j++) {
        cout << matrix [i][j] << " ";
      }
      cout << endl;
    }

    do {
      cout << "Elija una opción\n" 
           << "<0> Salir\n"
           << "<1> Invertir fila\n"
           << "<2> Invertir columna\n";
      cout << ">"; cin >> selection;
    } while (selection <0 || selection > 2);

    if (selection != 0) {

      if (selection == 1) {
        int f, aux;
        do {
          cout << "Seleccione fila [1," << nrows << "]: ";
          cin >> f;
        } while (f < 1 || f > nrows);
        f--;
    
    
    // {13,12,11},
    // {21,22,23},
    // {31,32,33},
    // {41,42,43}
    // aux = 11
    // matrix[f][j] = 13
    // maa        = aux
    //
        //Invertir fila
        for (j = 0; j <= (ncols-1) / 2; j++) {
          aux = matrix[f][j];
          matrix[f][j] = matrix[f][ncols-1-j];
          matrix[f][ncols-1-j] = aux;
        }



      } else {
        int c, aux;
        do {
          cout << "Seleccione columna [1," << ncols << "]: ";
          cin >> c; 
        } while (c < 1 || c > ncols);
        c--;
        for (i = 0; i <= (nrows-1) / 2; i++) {
          aux = matrix[i][c];
          matrix[i][c] = matrix[nrows-1-i][c];
          matrix[nrows-1-i][c] = aux;
        }
      }
    }
  } while (selection != 0);

  return 0;
}
#include <iostream>

using namespace std;
int main()
{
    cout << "Encuentra el número de veces que aparece una cifra en un entero." << endl;




    int cifra;  
    do {
        cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
        cin >> cifra;
    } while ((cifra < 0) || (cifra > 9));



    int numero;
    do {
        cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
        cin >> numero;
    } while (numero < 0);



    cout << "Buscando " << cifra << " en " << numero << " ... " << endl;



    int encontrado = 0;
    do {
        int resto = numero % 10;
        if (resto == cifra) 
          encontrado++;
        numero = numero / 10;
    } while (numero != 0);

    cout << "La cifra buscada se encontró en " << encontrado << " ocasiones." << endl;

    return 0;
}

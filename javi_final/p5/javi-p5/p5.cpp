#include <iostream>
#include <stdio.h>

using namespace std;


int strlen(char* str_) {
  char* str = str_;

  int cont = 0;
  while (*str != '\0') {
    cont++;
    str++;
  }

  if (*(--str) == '\n') {
    *str = '\0';
    --cont;
  } 

  return cont;
}

bool reverse_rr(char* str, int length, bool& es_pal) {

  //char* str = str_;
  if (length == 0 || length == 1)
    return es_pal;

  length--;

  char aux = *str; 

  *str = *(str + length);

  if (aux != *str) {
    es_pal = false;
  }

  *(str + length) = aux;

  str++;
  length--;

  reverse_rr(str, length, es_pal);

}

bool reverse_r(char* str, int length) {
  bool es_pal = true;
  return reverse_rr(str, length, es_pal);
}


// c a d e n a
// 0 1 2 3 4 5

//c a d d e n a
//0 1 2 3 4 5 6

//r o t o r r
//0 1 2 3 4

int main(void) {


  char str[50];

  cout << " > "; 
  cin >> str;

 bool pal = reverse_r(str, strlen(str));

 cout << str << endl;
 if (pal) {
   cout << "es pal\n";
 } else {
   cout << "no es pal\n";
 }



  return 0;
}
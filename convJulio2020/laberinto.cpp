#include <iostream>
#include <vector>

using namespace std;
typedef vector<vector<char>> matrix;

void print_matriz(matrix mat) {
  for (int i = 0; i < mat.size(); i++) {
    for (int j = 0; j < mat[i].size(); j++)
      cout << mat[i][j] << "  ";
    cout << endl;
  }
  cout << endl;
}

void print(vector<int> vec) {
  cout << "{ ";
  for (auto value : vec) {
    cout << value << ",";
  }
  cout << "} " << endl;
}




vector<int> paso(matrix &mat, int lado, int i, int j) {
  vector<int> res;

  i--;
  j--;
  bool solved = false;


  //i-1,j  up
  if (i-1 >= 0) {
    if (mat[i-1][j] == '0') {
      res.push_back(i-1);
      res.push_back(j);
      solved = true;
    }
  }
  
  //i,j-1  left
  if (j-1 >= 0 && !solved) {
    if (mat[i][j-1] == '0') {
      res.push_back(i);
      res.push_back(j-1);
      solved = true;
    }
  }

  //i,j+1 right
  if (j+1 < mat.size() && !solved) {
    if (mat[i][j+1] == '0') {
      res.push_back(i);
      res.push_back(j+1);
      solved = true;
    }
  }

  //i+1,j down
  if (i+1 < mat.size() && !solved) {
    if (mat[i+1][j] == '0') {
      res.push_back(i+1);
      res.push_back(j);
    }
  }
  

  mat[res[0]][res[1]] = 'X';
  ++res[0];
  ++res[1];
  return res;

  } 


double recorrer_camino(matrix &mat, double costeH, double costeV) {

  double costeTotal = 0;
  vector<int> oldPos, newPos;

  mat[0][0] = 'X';

  
  newPos = {1,1};
  do {
    print(newPos);
    print_matriz(mat);
    
    oldPos = newPos;
    newPos = paso(mat, mat.size(), oldPos[0], oldPos[1]);
    
    //Vertical?
    if (oldPos[0] != newPos[0])
      costeTotal += costeV;
    if (oldPos[1] != newPos[1]) 
      costeTotal += costeH;

  }  while (newPos[1] < mat.size());


  print_matriz(mat);
  return costeTotal;
}


int main() {


  const int ncols = 7, nrows = 7;
  matrix mat = { {'0','#','#','#','#','#','#'},
                 {'0','0','#','#','0','0','0'},
                 {'#','0','#','#','0','#','#'},
                 {'#','0','#','#','0','#','#'},
                 {'#','0','0','0','0','#','#'},
                 {'#','#','#','#','#','#','#'},
                 {'#','#','#','#','#','#','#'}
  };


  print_matriz(mat);

  double coste = recorrer_camino(mat,1,1);
  cout << "\nCoste > " << coste << endl;


  return 0;
}
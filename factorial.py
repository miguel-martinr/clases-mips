def factorial(n):
  if (n == 1 or n == 0):
    return n
  else:
    return n*factorial(n-1)

print(factorial(5))
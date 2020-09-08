def addition(n): 
    return n + n 

def factorial(n):
	factorial = 1
	for i in range(1, n+1):
		  factorial *= i 
	return factorial 

# We double all numbers using map() 
numbers = (1, 2, 3, 4) 
result = map(addition, numbers) 
print(list(result))
print(factorial(8))

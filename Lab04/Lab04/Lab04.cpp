/**
* Parallel and distributed computing
* Lab 4. Processes in Win32
*
* Func1: D:=MIN(A+B)*(B+C)*(MA*MD)
* Func2: MF:=MAX(MG)*(MH*MK)
* Func3: T:=(MO*MP)*S+MR*SORT(S)
*
* @author: Anna Doroshenko
* @group: IO-52
* @date: 13.10.2017
*/

#include <iostream>	
#include <windows.h>
#include <vector>
#include <algorithm>

typedef std::vector <int> Vector;
typedef std::vector < std::vector <int>> Matrix;

int N;
CRITICAL_SECTION criticalSection;

void T1();
void T2();
void T3();
Vector addVectors(Vector a, Vector b);
int minElemVect(Vector a);
Matrix multMatrix(Matrix ma, Matrix mb);
Vector multScalarVect(int scalar, Vector a);
Vector multVectMatrix(Vector a, Matrix ma);
int maxElemMatrix(Matrix ma);
Matrix multScalarMatrix(int scalar, Matrix matrixA);
Vector sortVector(Vector a);
Vector func1(Vector a, Vector b, Vector c, Matrix ma, Matrix md);
Matrix func2(Matrix mg, Matrix mh, Matrix mk);
Vector func3(Matrix mo, Matrix mp, Vector s, Matrix mr);
Vector inputVector();
Matrix inputMatrix();
Vector oneVector();
Matrix oneMatrix();
void outputVector(Vector a);
void outputMatrix(Matrix ma);


int main(void) {

	std::cout << "Lab04 started" << std::endl;
	std::cout << "Input n: " << std::endl;
	std::cin >> N;

	DWORD Tid1, Tid2, Tid3;
	HANDLE hThread1, hThread2, hThread3;
	InitializeCriticalSection(&criticalSection);	

	// 1st arg - security attributes
	// 2nd arg - stack size
	// 3rd arg - start address (thread function)
	// 4th arg - parameter
	// 5th arg - creation flags
	// 6th arg - thread id
	hThread1 = CreateThread(NULL, 30000000, (LPTHREAD_START_ROUTINE)T1, NULL, 0, &Tid1);
	hThread2 = CreateThread(NULL, 30000000, (LPTHREAD_START_ROUTINE)T2, NULL, 0, &Tid2);
	hThread3 = CreateThread(NULL, 30000000, (LPTHREAD_START_ROUTINE)T3, NULL, 0, &Tid3);

	SetThreadPriority(hThread1, THREAD_PRIORITY_NORMAL);
	SetThreadPriority(hThread2, THREAD_PRIORITY_LOWEST);
	SetThreadPriority(hThread3, THREAD_PRIORITY_HIGHEST);

	WaitForSingleObject(hThread1, INFINITE);
	WaitForSingleObject(hThread2, INFINITE);
	WaitForSingleObject(hThread3, INFINITE);

	CloseHandle(hThread1);
	CloseHandle(hThread2);
	CloseHandle(hThread3);

	DeleteCriticalSection(&criticalSection);

	std::cout << "Lab04 finished" << std::endl;	
	std::cin.get();
	std::cin.get();
	return 0;
}

//--------------------------------------------------------------------------------
// Func1: D = MIN(A+B)*(B+C)*(MA*MD)
void T1()
{
	Vector a;
	Vector b;
	Vector c;
	Vector d;
	Matrix ma;
	Matrix md;

	EnterCriticalSection(&criticalSection);
		std::cout << "Thread 1 started" << std::endl;
	LeaveCriticalSection(&criticalSection);

	a = oneVector();
	b = oneVector();
	c = oneVector();
	ma = oneMatrix();
	md = oneMatrix();
	//EnterCriticalSection(&criticalSection);
		//std::cout << "a: ";
		//a = inputVector();
		//std::cout << "b: ";
		//b = inputVector();
		//std::cout << "c: ";
		//c = inputVector();
		//std::cout << "ma: ";
		//ma = inputMatrix();
		//std::cout << "mb: ";
		//mb = inputMatrix();
	//LeaveCriticalSection(&criticalSection);
	d = func1(a, b, c, ma, md);
	Sleep(1000);
	if (N <= 10)
	{
		EnterCriticalSection(&criticalSection);
		std::cout << "d = ";
		outputVector(d);
		LeaveCriticalSection(&criticalSection);
	}
	std::cout << "Thread 1 finished" << std::endl;
}

//---------------------------------------------------------------------------------
// Func2: MF = MAX(MG)*(MH*MK)
void T2()
{
	Matrix mg;
	Matrix mh;
	Matrix mk;
	Matrix mf;

	EnterCriticalSection(&criticalSection);
		std::cout << "Thread 2 started" << std::endl;
	LeaveCriticalSection(&criticalSection);

	mg = oneMatrix();
	mh = oneMatrix();
	mk = oneMatrix();
	//EnterCriticalSection(&criticalSection);
		//std::cout << "mg: ";
		//mg = inputMatrix();
		//std::cout << "mh: ";
		//mh = inputMatrix();
		//std::cout << "mk: ";
		//mk = inputMatrix();
	//LeaveCriticalSection(&criticalSection);
	mf = func2(mg, mh, mk);
	Sleep(3000);
	if (N <= 10)
	{
		EnterCriticalSection(&criticalSection);
			std::cout << "mf = ";
			outputMatrix(mf);
		LeaveCriticalSection(&criticalSection);
	}
	std::cout << "Thread 2 finished" << std::endl;
}

//---------------------------------------------------------------------------------
// Func3: T = (MO*MP)*S+MR*SORT(S)
void T3()
{
	Vector s;
	Vector t;
	Matrix mo;
	Matrix mp;
	Matrix mr;

	EnterCriticalSection(&criticalSection);
		std::cout << "Thread 3 started" << std::endl;
	LeaveCriticalSection(&criticalSection);
	
	s = oneVector();
	mo = oneMatrix();
	mp = oneMatrix();
	mr = oneMatrix();
	//EnterCriticalSection(&criticalSection);
		//std::cout << "s: ";
		//s = inputVector();
		//std::cout << "mo: ");
		//mo = inputMatrix();
		//std::cout << "mp: ");
		//mp = inputMatrix();
		//std::cout << "mr: ");
		//mr = inputMatrix();
	//LeaveCriticalSection(&criticalSection);
	t = func3(mo, mp, s, mr);
	Sleep(2500);
	if (N <= 10)
	{
		EnterCriticalSection(&criticalSection);
			std::cout << "t = ";
			outputVector(t);
		LeaveCriticalSection(&criticalSection);
	}
	std::cout << "Thread 3 finished" << std::endl;
}

//--------------------------------------------------------------------------------
Vector addVectors(Vector a, Vector b)
{
	Vector res(N);
	for (int i = 0; i < N; i++)
	{
		res[i] = a[i] + b[i];
	}
	return res;
}

int minElemVect(Vector a)
{
	int minElem = a[0];
	for (int i = 1; i < N; i++)
	{
		if (a[i] < minElem)
		{
			minElem = a[i];
		}
	}
	return minElem;
}

Matrix multMatrix(Matrix ma, Matrix mb)
{
	int current;
	Matrix resMatrix(N);
	for (int i = 0; i < N; i++)
	{
		//resMatrix[i] = std::vector<int>(N);
		resMatrix[i] = Vector(N);
		for (int j = 0; j < N; j++)
		{
			current = 0;
			for (int k = 0; k < N; k++)
			{
				current = current + ma[i][k] * mb[k][j];
			}
			resMatrix[i][j] = current;
		}
	}
	return resMatrix;
}

Vector multScalarVect(int scalar, Vector a)
{
	Vector resVect(N);
	for (int i = 0; i < N; i++)
	{
		resVect[i] = scalar * a[i];
	}
	return resVect;
}

Vector multVectMatrix(Vector a, Matrix ma)
{
	int current;
	Vector resVect(N);
	for (int i = 0; i < N; i++)
	{
		current = 0;
		for (int j = 0; j < N; j++)
		{
			current = current + a[j] * ma[j][i];
		}
		resVect[i] = current;
	}
	return resVect;
}

int maxElemMatrix(Matrix ma)
{
	int maxElem = ma[0][0];
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			if (ma[i][j] > maxElem)
			{
				maxElem = ma[i][j];
			}
		}
	}
	return maxElem;
}

Matrix multScalarMatrix(int scalar, Matrix matrixA)
{
	Matrix resMatrix(N);
	for (int i = 0; i < N; i++)
	{
		resMatrix[i] = std::vector<int>(N);
		for (int j = 0; j < N; j++)
		{
			resMatrix[i][j] = scalar * matrixA[i][j];
		}
	}
	return resMatrix;
}

Vector sortVector(Vector a)
{
	std::sort(a.begin(), a.end());
	return a;
}

// Calculate function 1
// D = MIN(A+B)*(B+C)*(MA*MD)
Vector func1(Vector a, Vector b, Vector c, Matrix ma, Matrix md)
{
	return multVectMatrix(multScalarVect(minElemVect(addVectors(a, b)), addVectors(b, c)), multMatrix(ma, md));
}

// Calculate function 2
// MF = MAX(MG)*(MH*MK)
Matrix func2(Matrix mg, Matrix mh, Matrix mk)
{
	return multScalarMatrix(maxElemMatrix(mg), multMatrix(mh, mk));
}

// Calculate function 3
// T = (MO*MP)*S+MR*SORT(S)
Vector func3(Matrix mo, Matrix mp, Vector s, Matrix mr)
{
	return addVectors(multVectMatrix(s, multMatrix(mo, mp)), multVectMatrix(sortVector(s), mr));
}

Vector inputVector()
{
	Vector a(N);
	for (int i = 0; i < N; i++)
	{
		std::cin >> a[i];
	}
	return a;
}

Matrix inputMatrix()
{
	Matrix ma(N);
	for (int i = 0; i < N; i++)
	{
		Vector row(N);
		for (int j = 0; j < N; j++)
		{
			std::cin >> row[j];
		}
		ma[i] = row;
	}
	return ma;
}

Vector oneVector()
{
	Vector a(N);
	for (int i = 0; i < N; i++)
	{
		a[i] = 1;
	}
	return a;
}

Matrix oneMatrix()
{
	Matrix ma(N);
	for (int i = 0; i < N; i++)
	{
		Vector row(N);
		for (int j = 0; j < N; j++)
		{
			row[j] = 1;
		}
		ma[i] = row;
	}
	return ma;
}

void outputVector(Vector a)
{
	for (int i = 0; i < N; i++)
	{
		std::cout << a[i] << " ";
	}
	std::cout << std::endl;
}

void outputMatrix(Matrix ma)
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			std::cout << ma[i][j] << " ";
		}
		std::cout << std::endl;
	}
}
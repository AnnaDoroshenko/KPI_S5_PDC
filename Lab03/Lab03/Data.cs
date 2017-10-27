using System;

namespace Lab03
{
    class Data
    {
        private int N;

        public int getN()
        {
            return N;
        }

        public Data(int N)
        {
            this.N = N;
        }

        private int[] AddVectors(int[] a, int[] b)
        {
            int[] res = new int[N];
            for (int i = 0; i < N; i++)
            {
                res[i] = a[i] + b[i];
            }
            return res;
        }

        private int MinElemVect(int[] a)
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

        private int[,] MultMatrix(int[,] ma, int[,] mb)
        {
            int current;
            int[,] resMatrix = new int[N, N];
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    current = 0;
                    for (int k = 0; k < N; k++)
                    {
                        current = current + ma[i, k] * mb[k, j];
                    }
                    resMatrix[i, j] = current;
                }
            }
            return resMatrix;
        }

        private int[] MultScalarVect(int scalar, int[] a)
        {
            int[] resVect = new int[N];
            for (int i = 0; i < N; i++)
            {
                resVect[i] = scalar * a[i];
            }
            return resVect;
        }

        private int[] MultVectMatrix(int[] a, int[,] ma)
        {
            int current;
            int[] resVect = new int[N];
            for (int i = 0; i < N; i++)
            {
                current = 0;
                for (int j = 0; j < N; j++)
                {
                    current = current + a[j] * ma[j, i];
                }
                resVect[i] = current;
            }
            return resVect;
        }

        private int MaxElemMatrix(int[,] ma)
        {
            int maxElem = ma[0, 0];
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    if (ma[i, j] > maxElem)
                    {
                        maxElem = ma[i, j];
                    }
                }
            }
            return maxElem;
        }

        private int[,] MultScalarMatrix(int scalar, int[,] matrixA)
        {
            int[,] resMatrix = new int[N, N];
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    resMatrix[i, j] = scalar * matrixA[i, j];
                }
            }
            return resMatrix;
        }

        private int[] SortVector(int[] a)
        {
            int[] resVector = new int[N];
            Array.Copy(a, resVector, N);
            Array.Sort(resVector);
            return resVector;
        }

        // Solving function 1
        // D = MIN(A+B)*(B+C)*(MA*MD)
        public int[] Func1(int[] a, int[] b, int[] c, int[,] ma, int[,] md)
        {
            return MultVectMatrix(MultScalarVect(MinElemVect(AddVectors(a, b)), AddVectors(b, c)), MultMatrix(ma, md));
        }

        // Solving function 2
        // MF = MAX(MG)*(MH*MK)
        public int[,] Func2(int[,] mg, int[,] mh, int[,] mk)
        {
            return MultScalarMatrix(MaxElemMatrix(mg), MultMatrix(mh, mk));
        }

        // Solving function 3
        // T = (MO*MP)*S+MR*SORT(S)
        public int[] Func3(int[,] mo, int[,] mp, int[] s, int[,] mr)
        {
            return AddVectors(MultVectMatrix(s, MultMatrix(mo, mp)), MultVectMatrix(SortVector(s), mr));
        }

        public int[] InputVector()
        {
            int[] a = Array.ConvertAll(Console.ReadLine().Split(' '), int.Parse);
            return a;
        }

        public int[,] InputMatrix()
        {
            int[,] ma = new int[N, N];
            for (int i = 0; i < N; i++)
            {
                int [] a = Array.ConvertAll(Console.ReadLine().Split(' '), int.Parse);
                for (int j = 0; j < N; j++)
                {
                    ma[i, j] = a[j];
                }
            }
            return ma;
        }

        public void OneVector(int[] a)
        {
            for (int i = 0; i < N; i++)
            {
                a[i] = 1;
            }
        }

        public void OneMatrix(int[,] ma)
        {
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    ma[i, j] = 1;
                }
            }
        }

        public void OutputVector(int[] a)
        {
            for (int i = 0; i < N; i++)
            {
                Console.Write(a[i] + " ");
            }
            Console.WriteLine("");
        }

        public void OutputMatrix(int[,] ma)
        {
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    Console.Write(ma[i, j] + " ");
                }
                Console.WriteLine("");
            }
        }
    }
}

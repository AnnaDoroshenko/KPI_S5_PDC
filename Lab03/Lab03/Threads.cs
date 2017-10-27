using System;
using System.Threading;

namespace Lab03
{
    class Threads
    {
        Data data;
        static readonly object ThreadLock = new object();
        public Threads(Data data)
        {
            this.data = data;
        }

        // Func1: D = MIN(A+B)*(B+C)*(MA*MD)
        public void T1()
        {
            int N;
            int[] a, b, c, d;
            int[,] ma, md;
            //Data data;
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            N = data.getN();
            a = new int[N];
            b = new int[N];
            c = new int[N];
            ma = new int[N, N];
            md = new int[N, N];
            lock (ThreadLock)
            {
                data.OneVector(a);
                data.OneVector(b);
                data.OneVector(c);
                data.OneMatrix(ma);
                data.OneMatrix(md);
                //Console.WriteLine("a:");
                //a = data.InputVector();
                //Console.WriteLine("b:");
                //b = data.InputVector();
                //Console.WriteLine("c:");
                //c = data.InputVector();
                //Console.WriteLine("ma:");
                //ma = data.InputMatrix();
                //Console.WriteLine("mb:");
                //md = data.InputMatrix();
            }
            d = data.Func1(a, b, c, ma, md);
            Thread.Sleep(1000);
            if (N <= 10) lock (ThreadLock)
                {
                    Console.Write("d = ");
                    data.OutputVector(d);
                }
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }

        //---------------------------------------------------------------------------------
        // Func2: MF = MAX(MG)*(MH*MK)
        public void T2()
        {
            int N;
            int[,] mg, mh, mk, mf;
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            N = data.getN();
            mg = new int[N, N];
            mh = new int[N, N];
            mk = new int[N, N];
            lock (ThreadLock)
            {
                data.OneMatrix(mg);
                data.OneMatrix(mh);
                data.OneMatrix(mk);
                //Console.WriteLine("mg:");
                //mg = data.InputMatrix();
                //Console.WriteLine("mh:");
                //mh = data.InputMatrix();
                //Console.WriteLine("mk:");
                //mk = data.InputMatrix();
            }
            mf = data.Func2(mg, mh, mk);
            Thread.Sleep(3000);
            if (N <= 10)
            {
                lock (ThreadLock)
                {
                    Console.Write("mf = ");
                    data.OutputMatrix(mf);
                }
            }
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }

        //---------------------------------------------------------------------------------
        // Func3: T = (MO*MP)*S+MR*SORT(S)
        public void T3()
        {
            int N;
            int[] s, t;
            int[,] mo, mp, mr;
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            N = data.getN();
            s = new int[N];
            mo = new int[N, N];
            mp = new int[N, N];
            mr = new int[N, N];
            lock (ThreadLock)
            {
                data.OneVector(s);
                data.OneMatrix(mo);
                data.OneMatrix(mp);
                data.OneMatrix(mr);
                //Console.WriteLine("s:");
                //s = data.InputVector();
                //Console.WriteLine("mo:");
                //mo = data.InputMatrix();
                //Console.WriteLine("mp:");
                //mp = data.InputMatrix();
                //Console.WriteLine("mr:");
                //mr = data.InputMatrix();
            }
            t = data.Func3(mo, mp, s, mr);
            Thread.Sleep(2500);
            if (N <= 10)
            {
                lock (ThreadLock)
                {
                    Console.Write("t = ");
                    data.OutputVector(t);
                }
            }
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }
    }
}

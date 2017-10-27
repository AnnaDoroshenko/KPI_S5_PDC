/**
 * Parallel and distributed computing
 * Lab 3. Processes in C#
 *
 * Func1: D:=MIN(A+B)*(B+C)*(MA*MD)
 * Func2: MF:=MAX(MG)*(MH*MK)
 * Func3: T:=(MO*MP)*S+MR*SORT(S)
 *
 * @author: Anna Doroshenko
 * @group: IO-52
 * @date: 06.10.2017
 */

using System;
using System.Threading;

namespace Lab03
{
    class Lab03
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Lab03 started");
            Console.WriteLine("Input n: ");
            int N = int.Parse(Console.ReadLine());
            Data data = new Data(N);
            Threads t = new Threads(data);
            Thread t1 = new Thread(t.T1);
            Thread t2 = new Thread(t.T2);
            Thread t3 = new Thread(t.T3);

            t1.Name = "Thread 1";
            t1.Priority = ThreadPriority.AboveNormal;
            t2.Name = "Thread 2";
            t2.Priority = ThreadPriority.Highest;
            t3.Name = "Thread 3";
            t3.Priority = ThreadPriority.Normal;

            t1.Start();
            t2.Start();
            t3.Start();

            t1.Join();
            t2.Join();
            t3.Join();

            Console.WriteLine("Lab03 finished");
            Console.ReadKey();
        }
    }
}

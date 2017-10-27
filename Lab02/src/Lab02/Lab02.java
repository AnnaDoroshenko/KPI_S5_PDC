package Lab02;

/**
 * Parallel and distributed computing
 * Lab 2. Processes in Java
 *
 * Func1: D:=MIN(A+B)*(B+C)*(MA*MD)
 * Func2: MF:=MAX(MG)*(MH*MK)
 * Func3: T:=(MO*MP)*S+MR*SORT(S)
 *
 * @author: Anna Doroshenko
 * @group: IO-52
 * @date: 21.09.2017
 */

import java.util.Scanner;

public class Lab02 {

    public static void main(String[] args) {
        System.out.println("Lab02 started");
        int n;
        System.out.println("Input n: ");
        Scanner inputN = new Scanner(System.in);
        n = inputN.nextInt();
        Data data = new Data(n);
        T1 t1 = new T1("Task 1", 2, data);
        T2 t2 = new T2("Task 2", Thread.MAX_PRIORITY, data);
        T3 t3 = new T3("Task 3", Thread.MIN_PRIORITY, data);
        t1.start();
        t2.t.start();
        t3.start();
        try{
            t1.join();
            t2.t.join();
            t3.join();
        } catch (InterruptedException e){
            System.out.println("The main thread interrupted");
        }
        System.out.println("Lab02 finished");
    }
}

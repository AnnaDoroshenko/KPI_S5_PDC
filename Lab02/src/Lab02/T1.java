package Lab02;

import java.util.Arrays;

// Func1: D = MIN(A+B)*(B+C)*(MA*MD)
public class T1 extends Thread {
    int [] a, b, c, d;
    int [][] ma, md;
    Data data;

    public T1 (String name, int priority, Data data){
        super(name);
        setPriority(priority);
        this.data = data;
    }

     public void run(){
        System.out.println(getName() + " started");
        int n = data.getN();
        a = new int[n];
        b = new int[n];
        c = new int[n];
        ma = new int[n][n];
        md = new int[n][n];
        synchronized (data){
//            data.oneVector(a);
//            data.oneVector(b);
//            data.oneVector(c);
//            data.oneMatrix(ma);
//            data.oneMatrix(md);
            System.out.println("a:");
            a = data.inputVector();
            System.out.println("b:");
            b = data.inputVector();
            System.out.println("c:");
            c = data.inputVector();
            System.out.println("ma:");
            ma = data.inputMatrix();
            System.out.println("mb:");
            md = data.inputMatrix();
        }
        d = data.func1(a, b, c, ma, md);
        try {
            sleep(1000);
        } catch (InterruptedException e){
            System.out.println(getName() + " interrupted");
        }
            if (n <= 10) synchronized (data) {
                System.out.print("d = ");
                System.out.println(Arrays.toString(d));
            }
        System.out.println(getName() + " finished");
    }
}

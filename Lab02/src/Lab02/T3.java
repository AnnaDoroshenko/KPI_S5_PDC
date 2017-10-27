package Lab02;

import java.util.Arrays;

// Func3: T = (MO*MP)*S+MR*SORT(S)
public class T3 extends Thread {
    int [] s, t;
    int [][] mo, mp, mr;
    Data data;

    public T3 (String name, int priority, Data data){
        super(name);
        setPriority(priority);
        this.data = data;
    }

    public void run(){
        System.out.println(getName() + " started");
        int n = data.getN();
        s = new int [n];
        mo = new int[n][n];
        mp = new int[n][n];
        mr = new int[n][n];
        synchronized (data){
//            data.oneVector(s);
//            data.oneMatrix(mo);
//            data.oneMatrix(mp);
//            data.oneMatrix(mr);
            System.out.println("s:");
            s = data.inputVector();
            System.out.println("mo:");
            mo = data.inputMatrix();
            System.out.println("mp:");
            mp = data.inputMatrix();
            System.out.println("mr:");
            mr = data.inputMatrix();
        }
        t = data.func3(mo, mp, s, mr);
        try {
            sleep(2500);
        } catch (InterruptedException e){
            System.out.println(getName() + " interrupted");
        }
        if (n <= 10) {
            synchronized (data){
                System.out.print("t = ");
                System.out.println(Arrays.toString(t));
            }
        }
        System.out.println(getName() + " finished");
    }
}

package Lab02;

import java.util.Arrays;

// Func2: MF = MAX(MG)*(MH*MK)
public class T2 implements Runnable{
    String threadName;
    Data data;
    Thread t;
    int [][] mg, mh, mk, mf;

    public T2 (String name, int priority, Data data){
        threadName = name;
//        super(name);
        t = new Thread(this, threadName);
        t.setPriority(priority);
        this.data = data;
    }

    public void run(){
        System.out.println(t.getName() + " started");
        int n = data.getN();
        mg = new int[n][n];
        mh = new int[n][n];
        mk = new int[n][n];
        synchronized (data){
//            data.oneMatrix(mg);
//            data.oneMatrix(mh);
//            data.oneMatrix(mk);
            System.out.println("mg:");
            mg = data.inputMatrix();
            System.out.println("mh:");
            mh = data.inputMatrix();
            System.out.println("mk:");
            mk = data.inputMatrix();
        }
        mf = data.func2(mg, mh, mk);
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e){
            System.out.println(t.getName() + " interrupted");
        }
        if (n <= 10) {
            synchronized (data){
                System.out.print("mf = ");
                System.out.println(Arrays.deepToString(mf));
            }
        }
        System.out.println(t.getName() + " finished");
    }
}

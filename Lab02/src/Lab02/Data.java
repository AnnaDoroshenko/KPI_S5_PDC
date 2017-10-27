package Lab02;

import java.util.Arrays;
import java.util.Scanner;

public class Data {

    private int n;

    public int getN(){
        return n;
    }

    public Data(int n){
        this.n = n;
    }

    private int[] addVectors(int[] a, int[] b) {
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = a[i] + b[i];
        }
        return res;
    }

    private int minElemVect(int[] a) {
        int minElem = a[0];
        for (int i = 1; i < n; i++) {
            if (a[i] < minElem) {
                minElem = a[i];
            }
        }
        return minElem;
    }

    private int[][] multMatrix(int[][] ma, int[][] mb) {
        int current;
        int[][] resMatrix = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                current = 0;
                for (int k = 0; k < n; k++) {
                    current = current + ma[i][k] * mb[k][j];
                }
                resMatrix[i][j] = current;
            }
        }
        return resMatrix;
    }

    private int[] multScalarVect(int scalar, int[] a) {
        int[] resVect = new int[n];
        for (int i = 0; i < n; i++) {
            resVect[i] = scalar * a[i];
        }
        return resVect;
    }

    private int[] multVectMatrix(int[] a, int[][] ma) {
        int current;
        int[] resVect = new int[n];
        for (int i = 0; i < n; i++) {
            current = 0;
            for (int j = 0; j < n; j++) {
                current = current + a[j] * ma[j][i];
            }
            resVect[i] = current;
        }
        return resVect;
    }

    private int maxElemMatrix(int[][] ma) {
        int maxElem = ma[0][0];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (ma[i][j] > maxElem) {
                    maxElem = ma[i][j];
                }
            }
        }
        return maxElem;
    }

    private int[][] multScalarMatrix(int scalar, int[][] matrixA) {
        int[][] resMatrix = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                resMatrix[i][j] = scalar * matrixA[i][j];
            }
        }
        return resMatrix;
    }

    private int[] sortVector(int[] a) {
        int[] resVector = Arrays.copyOf(a, n);
        Arrays.sort(resVector);
        return resVector;
    }

    // Solving function 1
    // D = MIN(A+B)*(B+C)*(MA*MD)
    public int[] func1(int[] a, int[] b, int[] c, int[][] ma, int[][] md) {
        return multVectMatrix(multScalarVect(minElemVect(addVectors(a, b)), addVectors(b, c)), multMatrix(ma, md));
    }

    // Solving function 2
    // MF = MAX(MG)*(MH*MK)
    public int[][] func2(int[][] mg, int[][] mh, int[][] mk) {
        return multScalarMatrix(maxElemMatrix(mg), multMatrix(mh, mk));
    }

    // Solving function 3
    // T = (MO*MP)*S+MR*SORT(S)
    public int [] func3(int [][] mo, int [][] mp, int [] s, int [][] mr){
        return addVectors(multVectMatrix(s, multMatrix(mo, mp)), multVectMatrix(sortVector(s), mr));
    }

    public int [] inputVector(){
        int [] a = new int [n];
        Scanner input = new Scanner(System.in);
        for (int i = 0; i < n; i++){
            a[i] = input.nextInt();
        }
        return a;
    }

    public int [][] inputMatrix(){
        int [][] ma = new int [n][n];
        Scanner input = new Scanner(System.in);
        for (int i = 0; i < n; i++){
            for (int j = 0; j < n; j++){
                ma[i][j] = input.nextInt();
            }
        }
        return ma;
    }

    public void oneVector(int [] a){
        Arrays.fill(a, 1);
    }

    public void oneMatrix (int [][] ma){
        for (int i = 0; i < ma.length; i++){
            Arrays.fill(ma[i], 1);
        }
    }

    public void outputVector(int [] a){
        for (int i = 0; i < a.length; i++){
            System.out.println(a[i] + " ");
        }
    }

    public void outputMatrix(int [][] ma){
        for (int i = 0; i < n; i++){
            for (int j = 0; j < n; j++){
                System.out.println(ma[i][j] + " ");
            }
            System.out.println("");
        }
    }
}
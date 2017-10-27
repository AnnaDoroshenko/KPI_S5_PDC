with Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Text_IO, Ada.Integer_Text_IO;

-- Package Data, body --
package body Data is

   subtype RangeRandom is Integer range -10..10;
   package NewRandom is new Ada.Numerics.Discrete_Random(RangeRandom);
   use NewRandom;
   R : NewRandom.Generator;
   RandomNumber : RangeRandom;
   
   procedure RandomInVect (A : out Vector) is
   begin
      Reset(R);
      for i in 1..N loop
         RandomNumber := Random(R);
         A(i) := RandomNumber;
      end loop;
   end RandomInVect;
   
   procedure RandomInMatrix (MA : out Matrix) is
   begin
      Reset(R);
      for i in 1..N loop
         for j in 1..N loop
            RandomNumber := Random(R);
            MA(i, j) := RandomNumber;
         end loop;
      end loop;
   end RandomInMatrix;
   
   procedure OneVector (A : out Vector) is
   begin
      for i in 1..N loop
         A(i) := 1;
      end loop;      
   end OneVector;
   
   procedure OneMatrix (MA : out Matrix) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            MA(i,j) := 1;
         end loop;
      end loop;
   end OneMatrix;
     
   -- Function of vectors` sum --
   function AddVectors (A, B : Vector) return Vector is  
      res : Vector;
   begin 
      for i in 1..N loop
         res(i) := A(i) + B(i);
      end loop;
      return res;
   end Addvectors;
   
   -- Function of searching of min element of vector -- 
   function MinElemVect (A : Vector) return Integer is
      minElem : Integer := A(1);
   begin
      for i in 2..N loop
         if A(i) < minElem then
            minElem := A(i);
         end if;
      end loop;
      return minElem;  
   end MinElemVect;
   
   -- Function of multiplication of matrices --
   function MultMatrix (MA, MB : Matrix) return Matrix is
      current : Integer;
      mRes : Matrix;
   begin
      for i in 1..N loop
         for j in 1..N loop
            current := 0;
            for k in 1..N loop
               current := current + MA (i, k) * MB (k, j);
            end loop;
            mRes (i, j) := current;
         end loop;
      end loop;
      return mRes;
   end MultMatrix;
   
   -- Function of multiplication of scalar and vector --
   function MultScalarVect (scalar: Integer; A : Vector) return Vector is
      resVect : Vector;
   begin
      for i in 1..N loop 
        resVect(i) := scalar * A(i);
      end loop;
      return resVect;
   end MultScalarVect;
   
   -- Function of multiplication of vector and matrix -- 
   function MultVectMatrix (A : Vector; MA : Matrix) return Vector is
      current : Integer;
      resVect : Vector;
   begin
      for i in 1..N loop
         current := 0;
         for j in 1..N loop
            current := current + A(j) * MA (j, i);
         end loop;
         resVect(i) := current;
      end loop;
      return resVect;
   end MultVectMatrix;
     
   -- Function of searching of max element of matrix --
   function MaxElemMatrix (MA : Matrix) return Integer is
      maxElem : Integer := MA(1, 1);
   begin
      for i in 1..N loop
         for j in 1..N loop
            if MA(i, j) > maxElem then
               maxElem := MA(i, j);
            end if;
         end loop;
      end loop;
      return maxElem;
   end MaxElemMatrix;
   
   -- Function of multiplication of scalar and matrix --
   function MultScalarMatrix (scalar : Integer; MA : Matrix) return Matrix is
      resMatrix : Matrix;
   begin 
      for i in 1..N loop
         for j in 1..N loop
            resMatrix(i, j) := scalar * MA(i,j);
         end loop;
      end loop;
      return resMatrix;
   end MultScalarMatrix;
   
   -- Function of vector sorting (ascending) --
   function SortVector (A : Vector) return Vector is
      V : Vector := A;
      elem : Integer;
      resVect : Vector;
   begin
      for i in 1..N loop
         for j in i..N loop
            if V(i) > V(j) then
               elem := A(j);
               V(j) := V(i);
               V(i) := elem;
            end if;
         end loop;
      end loop;
      for k in 1..N loop
         resVect(k) := V(k);
      end loop;
      return resVect;
   end SortVector;
   
   -- Solving Func1 --
   -- D:=MIN(A+B)*(B+C)*(MA*MD) --
   procedure Func1 (A, B, C : in Vector; MA, MD : in Matrix; D : out Vector) is
   begin
      D := MultVectMatrix(MultScalarVect(MinElemVect(AddVectors(A, B)), 
                          AddVectors(B, C)), MultMatrix(MA, MD));
   end Func1;      
             
   -- Solving Func2 --
   -- MF:=MAX(MG)*(MH*MK) --
   procedure Func2 (MG, MH, MK : in Matrix; MF : out Matrix) is
   begin
      MF := MultScalarMatrix(MaxElemMatrix(MG), MultMatrix (MH, MK));
   end Func2;
                          
   -- Solving Func3 --
   -- T:=(MO*MP)*S+MR*SORT(S) --                                            
   procedure Func3 (MO, MP, MR : in Matrix; S : in Vector; T : out Vector) is
   begin
      T := AddVectors(MultVectMatrix (S, MultMatrix(MO, MP)), 
                                          MultVectMatrix(SortVector(S), MR));
   end Func3;
       
   procedure InputVector (A : out Vector) is
   begin
      for i in 1..N loop
          Get(A(i));     
      end loop;
   end InputVector;
                          
   procedure OutputVector (A : in Vector) is
   begin
      for i in 1..N loop
          Put(A(i));
      end loop;
   end OutputVector;
     
   procedure InputMatrix (MA : out Matrix) is
   begin
      for i in 1..N loop
          New_Line;
          for j in 1..N loop
              Get(MA(i, j));
          end loop;
      end loop;
   end InputMatrix;
                                                  
   procedure OutputMatrix (MA : in Matrix) is
   begin
      for i in 1..N loop
          New_Line;
          for j in 1..N loop
              Put(MA(i, j));
          end loop;
      end loop;
   end OutputMatrix;
                          
end Data;

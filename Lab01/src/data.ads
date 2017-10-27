generic
   N : Integer;
   
package Data is

   -- Declaration of private types --
   type Vector is private;
   type Matrix is private;
   
   -- D:=MIN(A+B)*(B+C)*(MA*MD) --
   procedure Func1 (A, B, C : in Vector; MA, MD : in Matrix; D : out Vector);
   
   -- MF:=MAX(MG)*(MH*MK) --
   procedure Func2 (MG, MH, MK : in Matrix; MF : out Matrix);
   
   -- T:=(MO*MP)*S+MR*SORT(S) --                                            
   procedure Func3 (MO, MP, MR : in Matrix; S : in Vector; T : out Vector);
      
   procedure InputVector (A : out Vector);
                         
   procedure OutputVector (A : in Vector);
   
   procedure InputMatrix (MA : out Matrix);
                     
   procedure OutputMatrix (MA : in Matrix);
   
   procedure RandomInVect (A : out Vector);
   
   procedure RandomInMatrix (MA : out Matrix);
   
   procedure OneVector (A : out Vector);
   
   procedure OneMatrix (MA : out Matrix);
   
   -- Definition of private types --
private
   type Vector is array(1..N) of Integer;
   type Matrix is array(1..N, 1..N) of Integer;
   
end Data;

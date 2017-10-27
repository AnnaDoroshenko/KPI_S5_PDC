--------------------------------------------------------------------------------
-- Parallel and distributed computing --
-- Lab 1. Processes in Ada. Tasks --

-- Func1: D:=MIN(A+B)*(B+C)*(MA*MD) --
-- Func2: MF:=MAX(MG)*(MH*MK) --
-- Func3: T:=(MO*MP)*S+MR*SORT(S) --

-- Author: Anna Doroshenko --
-- Group: IO-52 --
-- Date: 04.09.2017 --
--------------------------------------------------------------------------------

with Data, Ada.Text_IO, Ada.Integer_Text_IO, System.Multiprocessors;
use Ada.Text_IO, Ada.Integer_Text_IO, System.Multiprocessors;

procedure Lab01 is

   N : Integer;
   Storage : Integer := 50000000;

begin

   Put_line("Input N");
   Get(N);

   Block:
   declare

   CPU_1 : CPU_Range := 1;
   CPU_2 : CPU_Range := 2;

   package newData is new Data(N);
   use newData;

   -- Specification of task 1 --
   task T1 is
      pragma Task_Name("Task 1");
      pragma Priority(1);
      pragma Storage_Size(Storage);
      pragma CPU(CPU_2);
   end T1;

   -- Specification of task 2 --
   task T2 is
      pragma Task_Name("Task 2");
      pragma Priority(5);
      pragma Storage_Size(Storage);
      pragma CPU(CPU_1);
   end T2;

   -- Specification of task 3 --
   task T3 is
      pragma Task_Name("Task 3");
      pragma Priority(3);
      pragma Storage_Size(Storage);
      pragma CPU(CPU_1);
   end T3;

--------------------------------------------------------------------------------
   -- Body of task 1 --
   -- Func1: D:=MIN(A+B)*(B+C)*(MA*MD) --
   task body T1 is
      A, B, C, D : Vector;
      MA, MD : Matrix;
      begin
         delay 6.0;
         Put_Line("Task T1 started");

         if (N < 5) then
         Put_Line("Input vector A");
         InputVector(A);
         OutputVector(A);
         New_Line;

         Put_Line("Input vector B");
         InputVector(B);
         OutputVector(B);
         New_Line;

         Put_Line("Input vector C");
         InputVector(C);
         OutputVector(C);
         New_Line;

         Put_Line("Input matrix MA");
         InputMatrix(MA);
         OutputMatrix(MA);
         New_Line;

         Put_Line("Input matrix MD");
         InputMatrix(MD);
         OutputMatrix(MD);
         New_Line;

         else
         OneVector(A);
         OneVector(B);
         OneVector(C);
         OneMatrix(MA);
         OneMatrix(MD);
         end if;

         Func1(A, B, C, MA, MD, D);

         if (N < 5) then
            Put_Line("Result of function 1:");
            OutputVector(D);
            New_Line;
         end if;

	Put_Line("Task T1 finished");

  end T1;

--------------------------------------------------------------------------------
  -- Body of task 2 --
  -- Func2: MF:=MAX(MG)*(MH*MK) --
  task body T2 is
  	MF, MG, MH, MK : Matrix;
      begin
         delay 4.0;
         Put_Line("Task T2 started");

         if (N < 5) then
         Put_Line("Input matrix MG");
         InputMatrix(MG);
         OutputMatrix(MG);
         New_Line;

         Put_Line("Input matrix MH");
         InputMatrix(MH);
         OutputMatrix(MH);
         New_Line;

         Put_Line("Input matrix MK");
         InputMatrix(MK);
         OutputMatrix(MK);
         New_Line;

         else
         OneMatrix(MG);
         OneMatrix(MH);
         OneMatrix(MK);
         end if;

         Func2(MG, MH, MK, MF);

         if (N < 5) then
            Put_Line("Result of function 2:");
            OutputMatrix(MF);
            New_Line;
         end if;

	Put_Line("Task T2 finished");

  end T2;

--------------------------------------------------------------------------------
  -- Body of task 3 --
  -- Func3: T:=(MO*MP)*S+MR*SORT(S) --
  task body T3 is
  	T, S : Vector;
	MO, MP, MR : Matrix;
      begin
         delay 2.0;
         Put_Line("Task T3 started");

         if (N < 5) then
         Put_Line("Input vector S");
         InputVector(S);
         OutputVector(S);
         New_Line;

         Put_Line("Input matrix MO");
         InputMatrix(MO);
         OutputMatrix(MO);
         New_Line;

         Put_Line("Input matrix MP");
         InputMatrix(MP);
         OutputMatrix(MP);
         New_Line;

         Put_Line("Input matrix MR");
         InputMatrix(MR);
         OutputMatrix(MR);
         New_Line;

         else
         OneVector(S);
         OneMatrix(MO);
         OneMatrix(MP);
         OneMatrix(MR);
         end if;

         Func3(MO, MP, MR, S, T);

         if (N < 5) then
            Put_Line("Result of function 3:");
            OutputVector(T);
            New_Line;
         end if;

	Put_Line("Task T3 finished");

  end T3;

   begin
     null;
   end Block;

end Lab01;

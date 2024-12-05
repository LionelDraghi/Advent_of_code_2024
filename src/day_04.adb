
-- -----------------------------------------------------------------------------
-- My Ada proposals for the Advent of code 2024
--   (https://github.com/LionelDraghi/Advent_of_code_2024)
-- Author : Lionel Draghi
-- SPDX-License-Identifier: APSL-2.0
-- SPDX-FileCopyrightText: 2024, Lionel Draghi
-- -----------------------------------------------------------------------------

with Ada.Text_IO,
     Ada.Command_Line,
     Ada.Containers.Indefinite_Vectors,
     Ada.Exceptions,
     Ada.Strings.Fixed;

procedure Day_04 is

-- --------------------------------------------------------------------------
   function Mirror (S : String) return String is
      Tmp : String (1 .. S'Length);
      J   : Positive := Tmp'First;
   begin
      for I in reverse S'Range loop
         Tmp (J) := S (I);
         J := @ + 1; -- the last add is useless, but not worth optimizing!
      end loop;
      return Tmp;
   end Mirror;

   -- --------------------------------------------------------------------------
   procedure Put_Help is
   begin
      Ada.Text_IO.Put_Line ("usage : ./day_04 pattern input_file");
   end Put_Help;

   -- --------------------------------------------------------------------------
   function Get_Pattern return String is
   begin
      return Ada.Command_Line.Argument (1);
   exception
      when others => Put_Help; raise;
   end Get_Pattern;

   -- --------------------------------------------------------------------------
   function Get_File_Name return String is
   begin
      return Ada.Command_Line.Argument (2);
   exception
      when others => Put_Help; raise;
   end Get_File_Name;

   Pattern        : constant String := Get_Pattern;
   Mirror_Pattern : constant String := Mirror (Pattern);
   -- In AoC 2024:
   -- Pattern        = XMAS
   -- Mirror_Pattern = SMAX

   -- --------------------------------------------------------------------------
   function Count_Horizontal_Patterns (In_Line : String) return Natural
   is (Ada.Strings.Fixed.Count (In_Line, Pattern => Pattern) +
         Ada.Strings.Fixed.Count (In_Line, Pattern => Mirror_Pattern));

   type Direction is (Top, Top_Left, Top_Right);

   -- --------------------------------------------------------------------------
   function Next_Char (Position     : Natural;
                       In_Direction : Direction) return Natural is
   begin
      case In_Direction is
         when Top       => return Position;
         when Top_Left  => return Position - 1;
         when Top_Right => return Position + 1;
      end case;
   end Next_Char;

   package Line_Vectors is new Ada.Containers.Indefinite_Vectors
     (Positive, String);
   Lines : Line_Vectors.Vector := Line_Vectors.Empty_Vector;

   -- --------------------------------------------------------------------------
   function Find_Patterns (Pattern               : String;
                           Starting_To_Line,
                           Starting_To_Character : Natural;
                           In_Direction          : Direction) return Boolean is
   begin
      if Lines.Element (Starting_To_Line) (Starting_To_Character) =
        Pattern (Pattern'First)
      then
         -- Character matches
         if Pattern'Length = 1 then
            -- We are on the last character of the pattern, good!
            --  Ada.Text_IO.Put_Line ("Found pattern ending with " & Pattern
            --                        & " Line :" & Starting_To_Line'Image
            --                        & " Character :" & Starting_To_Character'Image);
            return True;
         else
            -- let's test the next one
            return Find_Patterns
              (Pattern               => Pattern (Pattern'First + 1 .. Pattern'Last),
               Starting_To_Line      => Starting_To_Line - 1,
               Starting_To_Character => Next_Char (Starting_To_Character, In_Direction),
               In_Direction          => In_Direction);
         end if;
      else
         return False;
      end if;
   end Find_Patterns;

   L : Natural := 1; -- Last read line (number)

   -- --------------------------------------------------------------------------
   procedure Print_Found (Pattern               : String;
                          Starting_To_Line,
                          Starting_To_Character : Natural;
                          In_Direction          : Direction) is
   begin
      null;
      --  Ada.Text_IO.Put_Line ("Found pattern " & Pattern
      --                        & " Line :" & L'Image
      --                        & " Character :" & Starting_To_Character'Image
      --                        & " in direction " & In_Direction'Image);
   end Print_Found;

   -- --------------------------------------------------------------------------
   function Count_Vertical_Patterns (Pattern : String -- ;
                                     --  Line    : Positive
                                    )
                                     return Natural is
      I     : Natural;
      Count : Natural := 0;
      Found : Boolean := False;

   begin
      -- Lets first process stricly vertical pattern
      for I in Lines.Last_Element'Range loop
         Found := Find_Patterns (Pattern               => Pattern,
                                 Starting_To_Line      => Lines.Last_Index,
                                 Starting_To_Character => I,
                                 In_Direction          => Top);
         if Found then
            Count := @ + 1;
            Print_Found (Pattern, Lines.Last_Index, I, Top);
         end if;
      end loop;

      -- Then diagonal going to top left, we start with an offset so that
      -- there is engouh place for the pattern on the left
      for I in Lines.Last_Element'First + Pattern'Length - 1
        .. Lines.Last_Element'Last
      loop
         Found := Find_Patterns (Pattern               => Pattern,
                                 Starting_To_Line      => Lines.Last_Index,
                                 Starting_To_Character => I,
                                 In_Direction          => Top_Left);
         if Found then
            Count := @ + 1;
            Print_Found (Pattern, Lines.Last_Index, I, Top_Left);
         end if;
      end loop;

      -- Then diagonal going to top right
      for I in Lines.Last_Element'First
        .. Lines.Last_Element'Last - Pattern'Length + 1
      loop
         Found := Find_Patterns (Pattern               => Pattern,
                                 Starting_To_Line      => Lines.Last_Index,
                                 Starting_To_Character => I,
                                 In_Direction          => Top_Right);
         if Found then
            Count := @ + 1;
            Print_Found (Pattern, Lines.Last_Index, I, Top_Right);
         end if;
      end loop;

      return Count;
   end Count_Vertical_Patterns;

   Pattern_Match : Natural := 0;

   -- --------------------------------------------------------------------------
   procedure Process_Line (Line : String) is
      use Ada.Strings.Fixed;
   begin
      Lines.Append (Line);
      -- The easy part, finding horizontal patterns:
      Pattern_Match := Pattern_Match + Count (Line, Pattern => Pattern);
      Pattern_Match := Pattern_Match + Count (Line, Pattern => Mirror_Pattern);
      -- Strange bug here, even prefixed with Ada.Strings.Fixed,
      -- Count cause a GNAT error when using @ instead of Pattern_Count

      if L >= Pattern'Length then
         -- the complex part, finding vertical and diagonal patterns:
         Pattern_Match := @ + Count_Vertical_Patterns (Pattern);
         Pattern_Match := @ + Count_Vertical_Patterns (Mirror_Pattern);
      end if;

      if L > Pattern'Length then
         -- The pattern cannot extend over this line, so
         -- let's free some memory:
         Lines.Delete_First;
      end if;
   end Process_Line;

   File : Ada.Text_IO.File_Type;

begin
   -- --------------------------------------------------------------------------
   Ada.Text_IO.Open (File, Ada.Text_IO.In_File, Get_File_Name);

   loop
      declare
         Ligne : constant String := Ada.Text_IO.Get_Line (File);
      begin
         Process_Line (Ligne);
         exit when Ada.Text_IO.End_Of_File (File);
         L := @ + 1;
      end;
   end loop;

   Ada.Text_IO.Put_Line ("Pattern Count =" & Pattern_Match'Image);

end Day_04;

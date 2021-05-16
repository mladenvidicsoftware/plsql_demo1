/* Author: Mladen Vidic
   E-mail: mladen.vidic@gmail.com
   Date Signed: 7.5.2021.
   Scope: Task 1.   
   
   Note: Procedures and function could have shorter names. These names are used for self describing purposes for better readability 
   and easier following of code development pathway.
*/

/*
Task 1. Create stored procedure to return substrings from input string value. Substring delimiter shall be input parameter.

Task description
Stored procedure shall have input parameters: 
•	STRING
•	DELIMITER //any symbol
•	STRING_NUMBER //number of substring to be returned

Input example: STRING => ‘one,two,three’,
                            DELIMITER => ‘e’,
                            STRING_NUMBER => null
Output shall be: ‘on’
                              ‘,two,thr’
                              ‘’
                              ‘’

If STRING_NUMBER => 2, output shall be: ‘,two,thr’

*/

/* SOLUTION DEMO 1: 
Author: Mladen Vidic
Location: Belgrade, Serbia
Date: 4.4.2021. "DD.MM.YYYY"
Scope: Demonstration that shows the way how can be solved task described above.
*/
 
/* This type helps to implement operations with string lists needed in "sets"  attribute of visibility by Oracle VARRAY type.
*/
create type &&DEMO_OWNER..MV_StringList_Type as 
   varray(50) of varchar2(50);
/
/* WARNING! - It has a restriction that the number of allowed elements in a shredding string is finite and each element can has the most 25 caracters.
It is for demonstration purposes. In real production system it is better to use ASSOCIATEIVE VARRAY or NESTED TABLE types in Oracle
that have no restriction to declared number of elements.
*/

CREATE OR REPLACE Package &&DEMO_OWNER..MV_string_utils IS

	/*  Parameters: 
			p_string 			- Any string that will be shredded by delimiter character/sub-string
			p_delim  			- Delimiter can be a non-blank character or any string with more than one character. 
								  Input p_string can be shredded by any sub-string, not just a character, in input p_delim. 
			p_show_string_index - Indicator to show all elements or just one dedicated.
								Allowed values: null or (not null and >=0)
								If null: 				Shows all sub-strings between delimiter
								If not null and >=0:	Extracts n-th element of all delimited sub-strings, if presented. Special cases:
														if 0 then ''
														if > num of substrings then ''
	*/
	
	/*  printShrededStringToList / printShrededStringToListRecursive
			- Prints list of substrings in main string delimeted by delimiter string to output. For solution demo purposes.
		printShrededStringToList is iterative version
		printShrededStringToListRecursive is recursive version of the same functionality.
	*/	
	PROCEDURE printShrededString(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null); 
	
	PROCEDURE printShrededStringRecursive(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null);
	/* Details about recursive implementation of the procedure are in the package body. */
	
	/* CONCLUSION: Two procedures above are an example that each iteratively solved problem could be solved recursively. This conclusion also has been 
					proven in theory of recursive functions which has been used in Computability theory.
		ATTENTION: It has also been proven in that theory that the 'vice versa' is not always true. 
					There are some recursive functions that cannot be solved iteratively. 
					For example, algorithms for lists and push lists, stacks, with an unlimited number of elements.
	*/
	
	
	/*  getShrededStringToList - Similar to previous procedure, but if list has to be implemented as function that 
								returns list that can be used in expressions with list of strings it will return StringList_Type list of
								elements in delimiter separated string list.
	
	*/
	FUNCTION getShrededStringToList(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null) return MV_StringList_Type; 
	-- Recursive version for thos function could be implemented even it is not suggested option. Why? Because in each recursive step we have to do 
	-- type conversion between string and stringlist_type what causes slower final result than iterative version.
	
END;
/

CREATE OR REPLACE Package Body &&DEMO_OWNER..MV_string_utils IS
	zero_string varchar2(1):=' '; -- better than CHAR when compares with varchar2.
	no_string varchar2(1):='';
	
	PROCEDURE printShrededString(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null) is
		cs varchar2(1299); 				
		l_i integer;
		l_count integer;
		delim_len integer;
		
	begin 
	    --cs:=replace(p_delim,' ','');
		/* Compare with '' is not OK hence it is treated as NULL value.
		 cs = ''  , length (substr (cs,1,1))=0 must be checked by cs is null */		 
		-- check input delimiter char/string that it has no blanks
		if p_delim is null or length (substr (p_delim,1,1))=0 then
			return;
		end if; 
		
		-- check if p_string is not just a clear string
		cs:=replace(p_string,' ','');
		
		if cs is null or length (substr (cs,1,1))=0 then
			DBMS_OUTPUT.PUT_LINE(''''||''||'''');
			return;
		end if;
		
		/* checks if p_show_string_index is null or (not null and >=0) */
		if p_show_string_index is not null then 
			if p_show_string_index<0 then
				DBMS_OUTPUT.PUT_LINE('Error: Illegal value for index variable!');
				return;
			elsif p_show_string_index=0 then
				DBMS_OUTPUT.PUT_LINE(''''||''||'''');
				return;
			else -- not null and >0
				null; -- Go further
			end if;
		end if;
		
		/* This procedure could have been implemented without previous checks, with less restrictions and borders for empty strings. */
		
		l_count:=0;
		cs:=p_string;
		delim_len:=length(p_delim);		 
		
		while length(cs)>0 and (p_show_string_index is null or l_count<p_show_string_index) LOOP
			l_i:=instr(cs,p_delim,1,1);			
			l_count:=l_count+1;
			
			if l_i>0 then
				if p_show_string_index is null or l_count=p_show_string_index then
					
					if l_i>1 then 
						DBMS_OUTPUT.PUT_LINE(''''||substr(cs,1,l_i-1)||'''');
					else 
						DBMS_OUTPUT.PUT_LINE(''''||''||'''');
					end if;
				end if;
				cs:= substr(cs,l_i+delim_len);
			else 
				if p_show_string_index is null or l_count=p_show_string_index then 
					DBMS_OUTPUT.PUT_LINE(''''||cs||'''');					
				else -- p_show_string_index is not null and l_count<p_show_string_index 
					DBMS_OUTPUT.PUT_LINE(''''||''||'''');
				end if;
				cs:= no_string; --'' -- to end loop
				-- exit;
			end if;			
						
		end LOOP;
		
		return;		
	end;

	/*	Recursive version must have recursive steps and recursion stop point conditions.
		* The Recursive steps: printShrededStringRecursive(cs, p_delim, n):=
											l_i:=find(cs,p_delim);
											if l_i>0 then {if n-1=0 print(	substring(cs,1,l_i-1)); 
																			printShrededStringRecursive(substring(cs,l_i+length(p_delim)), p_delim, n-1);}
											else {if n-1=0 print(cs);}
		* The Recursion stop conditions: cs is empty or (cs is not empty and p_show_string_index<=0)
		
		Details: 
		My notation for recursion by SML and C-like semi-Lambda calculus with logical or, not, and operators:  	
			printShrededStringRecursive('', p_delim, _):='';
			printShrededStringRecursive(cs, p_delim, n):=not null(n) and n<0, error;
			printShrededStringRecursive(cs, p_delim, 0):='';					
			printShrededStringRecursive(cs, p_delim, n):=null(n) or (not null(n) and n>0),
								l_i:=find(cs,p_delim); -- looks for substring p_delim in string cs
								-- if (null(n)) n-1 is also null 
								if (not null(l_i) and l_i>0)
								{ 	if (null(n) or n-1=0) print(substring(cs,1,l_i-1)); 
									if (null(n) or n-1>0) printShrededStringRecursive(substring(cs,l_i+length(p_delim)), p_delim, n-1);
								}
								else 
								{	if (null(n) or n-1=0) print(cs);
									else print('');
								}
		Comment: 	Logical functions 'known(a)' and 'unkown(a)' coulld have been used instead of 'not null(a)' and 'null(a)' in some theoretical paper.
					Instead, we used null and not null for readability by SQL related readers.  
	*/
	PROCEDURE printShrededStringRecursive(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null) is
		cs varchar2(1299); 				
		l_i integer;
		--l_count integer;
		delim_len integer;
		
	begin 
	    --cs:=replace(p_delim,' ','');
		/* Compare with '' is not OK hence it is treated as NULL value.
		 cs = ''  , length (substr (cs,1,1))=0 must be checked by cs is null */		 
		-- check input delimiter char/string that it has no blanks
		if p_delim is null or length (substr (p_delim,1,1))=0 then
			return;
		end if; 
		
		-- Check if p_string is not just a non-empty clear string?
		cs:=replace(p_string,' ','');
		
		if cs is null or length (substr (cs,1,1))=0 then
			DBMS_OUTPUT.PUT_LINE(''''||''||'''');
			return;
		end if;
		
		cs:=p_string;
		delim_len:=length(p_delim);
		
		/* checks if p_show_string_index is null or (not null and >=0) */
		if p_show_string_index is not null then 
			if p_show_string_index<0 then
				DBMS_OUTPUT.PUT_LINE('Error: Illegal value for index variable!');
				return;
			elsif p_show_string_index=0 then
				DBMS_OUTPUT.PUT_LINE(''''||''||'''');
				return;
			-- else -- not null and >0
				-- null; -- Go further
			end if;
		-- else -- is null
		--		null; -- Go further
		end if;				 
		
		if (p_show_string_index is null or p_show_string_index>0) then
			l_i:=instr(cs,p_delim,1,1);			
			--l_count:=l_count+1;
			
			if l_i>0 then
				if p_show_string_index is null or p_show_string_index-1=0 then
					if l_i>1 then 
						DBMS_OUTPUT.PUT_LINE(''''||substr(cs,1,l_i-1)||'''');
					else 
						DBMS_OUTPUT.PUT_LINE(''''||''||'''');
					end if;
				end if;
				
				/* Less readable
				if p_show_string_index is not null and p_show_string_index-1=0 then 
					return;
				else	
					printShrededStringRecursive(substr(cs,l_i+delim_len), p_delim, p_show_string_index-1);
				end if;
				*/
				
				/* More readable because already checked that p_show_string_index>0 if p_show_string_index is not null. */
				if p_show_string_index is null or p_show_string_index-1>0 then 
					printShrededStringRecursive(substr(cs,l_i+delim_len), p_delim, p_show_string_index-1);					
				-- else -- p_show_string_index is not null and p_show_string_index-1=0	
					-- return;
				end if;
			else 
				if p_show_string_index is null or p_show_string_index-1=0 then
					DBMS_OUTPUT.PUT_LINE(''''||cs||'''');
				else -- p_show_string_index is not null and p_show_string_index-1>0
					DBMS_OUTPUT.PUT_LINE(''''||''||'''');					
				end if;
			end if;				
		
		-- else -- never reachable
			-- return;						
		end if;	

		return;				
	end;

	
	FUNCTION getShrededStringToList(p_string IN varchar2, p_delim IN varchar2, p_show_string_index IN integer default null) return MV_StringList_Type is
		cs varchar2(1299); --;--
		--cs2 varchar2(1299); --;--
		slt MV_StringList_Type:=MV_StringList_Type();
		l_i integer;
		l_count integer;
		delim_len integer;
		
	begin 
		--cs:=replace(p_delim,' ','');
		
		if p_delim is null or length (substr (p_delim,1,1))=0 then
			return slt;
		end if; 

	    cs:=replace(p_string,' ','');
		
		if cs is null or length (substr (cs,1,1))=0 then
			return slt;
		end if;		
		
		/* checks if p_show_string_index is null or (not null and >=0) */
		/*if p_show_string_index is not null then 
			if p_show_string_index<0 then
				-- DBMS_OUTPUT.PUT_LINE('Error: Illegal value for index variable!');
				return slt;
			elsif p_show_string_index=0 then
				-- DBMS_OUTPUT.PUT_LINE(''''||''||'''');
				return slt;
			else -- not null and >0
				null; -- Go further
			end if;
		end if;
		*/
		if p_show_string_index is not null and p_show_string_index<=0 then
			return slt;
		end if;
		
		l_count:=0;
		cs:=p_string;
		delim_len:=length(p_delim);		
		
		while length(cs)>0 and (p_show_string_index is null or l_count<p_show_string_index) and slt.count<slt.limit LOOP
			l_i:=instr(cs,p_delim,1,1);			
			l_count:=l_count+1;
			
			if l_i>0 then
				if p_show_string_index is null or l_count=p_show_string_index then
					slt.EXTEND;
					if l_i>1 then 
						slt(slt.COUNT) := substr(cs,1,l_i-1);
					else 
						slt(slt.COUNT) := '';
					end if;
				end if;
				cs:= substr(cs,l_i+delim_len);
			else -- ubaciti preostali element iz stringa u listu, a zatim isprazniti listu
				if p_show_string_index is null or l_count=p_show_string_index then 
					slt.EXTEND;
					slt(slt.COUNT) := cs;
				else -- p_show_string_index is not null and l_count<p_show_string_index 
					null; -- will not add '' into list
				end if;
				cs:= no_string; --'';
				-- exit;
			end if;			
			
		end LOOP;
		
		return slt;		
	end;

END;
/
/* Author: Mladen Vidic
   E-mail: mladen.vidic@gmail.com
   Date Signed: 7.5.2021.
   Scope:
*/


MLADEN@DEMO_INSTANCE> set serveroutput on

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('one,two,three','e',null);
'on'
',two,thr'
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('one,two,three','e',2);
',two,thr'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',null) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',NULL)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('on', ',two,thr', '')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',2) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',2)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE(',two,thr')

1 row selected.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',null);
'A1'
' b2'
' c3'
'd4'
'skup5'
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',3);
' c3'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',null) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',NULL)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('A1', ' b2', ' c3', 'd4', 'skup5', 'drugiskup6 ')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',3) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',3)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE(' c3')

1 row selected.

MLADEN@DEMO_INSTANCE>
MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',null) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',NULL)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('on', ',two,thr', '')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',3) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',3)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',2) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',2)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE(',two,thr')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',1) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',1)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('on')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('one,two,three','e',5) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('ONE,TWO,THREE','E',5)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',10) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',10)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',0) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',0)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',2) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',2)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE(' b2')

1 row selected.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',10);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',0);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',2);
' b2'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE>

----------------------------------- ADDED
MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',2) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',2)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE(' b2')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',-5) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',-5)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',0) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',0)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',1) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',1)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('A1')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',5) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',5)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('skup5')

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',12) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',12)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE()

1 row selected.

MLADEN@DEMO_INSTANCE> select MV_string_utils.getShrededStringToList('A1, b2, c3,d4,skup5,drugiskup6 ',',',null) from dual;

MV_STRING_UTILS.GETSHREDEDSTRINGTOLIST('A1,B2,C3,D4,SKUP5,DRUGISKUP6',',',NULL)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
MV_STRINGLIST_TYPE('A1', ' b2', ' c3', 'd4', 'skup5', 'drugiskup6 ')

1 row selected.

MLADEN@DEMO_INSTANCE> set serveroutput on
MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('',',',2);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',2);
' b2'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',-2);
Error: Illegal value for index variable!

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',0);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',9);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',5);
'skup5'

PL/SQL procedure successfully completed.


MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededString('A1, b2, c3,d4,skup5,drugiskup6 ',',',null);
'A1'
' b2'
' c3'
'd4'
'skup5'
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE>

-- RECURSIVE

MLADEN@DEMO_INSTANCE> set serveroutput on
MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',9);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',7);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',6);
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',null);
'A1'
' b2'
' c3'
'd4'
'skup5'
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',5);
'skup5'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',0);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,skup5,drugiskup6 ',',',-5);
Error: Illegal value for index variable!

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',4);
'd4'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',3);
' c3'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',null);
'A1'
' b2'
' c3'
'd4'
''
'skup5'
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',7);
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',2);
' b2'

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',null);
'A1'
' b2'
' c3'
'd4'
''
'skup5'
'drugiskup6 '

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE> exec MV_string_utils.printShrededStringRecursive('A1, b2, c3,d4,,skup5,drugiskup6 ',',',0);
''

PL/SQL procedure successfully completed.

MLADEN@DEMO_INSTANCE>
--------------------------------------------------------
--  File created - Tuesday-August-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package STUDENT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HARVY"."STUDENT_PKG" AS

  

  ----------Overloading procedures with same name but different parameters------------
  
  
  ----------------Search a student by Student ID-----------------
  PROCEDURE p_view_student (p_student_id in student.student_id%type);


  ----------------Search a student by Student Email--------------
  PROCEDURE p_view_student (p_student_email in student.email%type);


  ---------------------Delete a student------------------------
  PROCEDURE p_delete_student (p_student_id in student.student_id%type);


  ----------------------UPDATE Student--------------------------
  PROCEDURE p_update_student (p_student_id in student.student_id%type,
                              v_field_name in VARCHAR2,
                              v_value in VARCHAR2);


  -----------------------Get Student Record---------------------
  PROCEDURE p_student_record (p_student_id in student.student_id%type);


END student_pkg;

/

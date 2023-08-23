--------------------------------------------------------
--  DDL for Package Body STUDENT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HARVY"."STUDENT_PKG" AS


  ----------------Search a student by Student ID-----------------

  PROCEDURE p_view_student (p_student_id in student.student_id%type) AS
  
  r_student student%rowtype;


  BEGIN

    SELECT * into r_student from STUDENT where student_id = p_student_id;

    dbms_output.put_line('Student name: ' || r_student.first_name || ' ' || r_student.last_name);
    dbms_output.put_line('Email address: ' || r_student.email);
    dbms_output.put_line('Phone number: ' || r_student.phone_number);
    dbms_output.put_line('Date of bith: ' || r_student.dob);

    EXCEPTION 
      WHEN no_data_found THEN
        dbms_output.put_line('The is no student with Student ID: '|| p_student_id);
      WHEN OTHERS then
        dbms_output.put_line('Something went wrong!');


  END p_view_student;  


  ---------------Method overloaded by using same name but different data type Parameters-----------------
  ----------------Search a student by Student Email--------------

  PROCEDURE p_view_student (p_student_email in student.email%type) AS

  r_student student%rowtype;


  BEGIN

    SELECT * into r_student from STUDENT where email = p_student_email;

    dbms_output.put_line('Student name: ' || r_student.first_name || ' ' || r_student.last_name);
    dbms_output.put_line('Email address: ' || r_student.email);
    dbms_output.put_line('Phone number: ' || r_student.phone_number);
    dbms_output.put_line('Date of bith: ' || r_student.dob); 

  EXCEPTION 
      WHEN no_data_found THEN
        dbms_output.put_line('The is no student with Email: '|| p_student_email);
      WHEN OTHERS then
        dbms_output.put_line('Something went wrong!');


  END p_view_student;  



  ---------------------DELETE Student------------------------

  PROCEDURE p_delete_student (p_student_id in student.student_id%type) AS

  v_exist number;

  BEGIN

  SELECT COUNT(1) into v_exist FROM STUDENT where student_id = p_student_id;

  if v_exist = 1 then

    DELETE from student where student_id = p_student_id;
    dbms_output.put_line('Student is deleted form the database.');

  else
    dbms_output.put_line('Student with this ID does not exist.');

  end if;





  END p_delete_student;


  ----------------------UPDATE Student--------------------------

  PROCEDURE p_update_student (p_student_id in student.student_id%type,
                              v_field_name in VARCHAR2,
                              v_value in VARCHAR2) AS

  BEGIN

    IF v_field_name = 'first_name' then
      UPDATE student
      SET first_name = v_value
      WHERE student_id = p_student_id;

      dbms_output.put_line('Update complete');

    ELSIF v_field_name = 'last_name' then
      UPDATE student
      SET last_name = v_value
      WHERE student_id = p_student_id;

      dbms_output.put_line('Update complete');

    ELSIF v_field_name = 'email' then
      UPDATE student
      SET email = v_value
      WHERE student_id = p_student_id;

      dbms_output.put_line('Update complete');

    ELSIF v_field_name = 'phone_number' then
      UPDATE student
      SET phone_number = v_value
      WHERE student_id = p_student_id;

      dbms_output.put_line('Update complete');

    ELSIF v_field_name = 'dob' then
      UPDATE student
      SET dob = v_value
      WHERE student_id = p_student_id;

      dbms_output.put_line('Update complete');

    ELSE
    dbms_output.put_line('Wrong column name entered!');

    END IF;


  END p_update_student;



  -----------------------Get Student Record---------------------


 PROCEDURE p_student_record (p_student_id in student.student_id%type) AS

 TYPE t_rec is record (s_id student.student_id%type,
                          fname student.first_name%type,
                          grade registration.grade%type,
                          amount transactions.amount%type,
                          course_name course.course_name%type,
                          f_fname faculty.first_name%type);

  r_student t_rec;

  CURSOR c_student is 
  SELECT s.student_id, s.first_name, r.grade, t.amount, c.course_name, f.first_name into r_student FROM Student s
  INNER JOIN registration r on s.student_id = r.student_id
  INNER JOIN transactions t on r.tr_id = t.transaction_id
  INNER JOIN course_assignment ca on r.assign_id = ca.assign_id
  INNER JOIN course c on ca.course_id = c.course_id
  INNER JOIN faculty f on ca.faculty_id = f.faculty_id
  WHERE s.student_id = p_student_id
  ORDER by s.student_id ASC;


 BEGIN

  OPEN c_student;

  loop  

    fetch c_student into r_student;

    exit when c_student%notfound;

    dbms_output.put_line('Student ID: ' || r_student.s_id || ', Name: ' || r_student.fname || 
                         ', Grade: ' || r_student.grade || ', Fees Amount: $' || r_student.amount || 
                         ', Course Name:  ' || r_student.course_name || 
                         ', Instructor Name: ' || r_student.f_fname);

  end loop;

  close c_student;


 END p_student_record;




END student_pkg;

/

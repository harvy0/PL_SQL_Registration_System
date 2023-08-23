--------------------------------------------------------
--  DDL for Package Body REG_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HARVY"."REG_PKG" AS

  function calc_fees_paid RETURN number AS
    v_total_paid number;

    Type t_rec is record (s_id student.student_id%type,
                          s_name student.first_name%type,
                          s_amount transactions.amount%type);

    r_amount t_rec;

  Cursor c_amount is
  SELECT s.student_id, s.first_name, SUM(t.amount) as Total from student s
  INNER JOIN registration r on s.student_id = r.student_id
  INNER JOIN transactions t on r.tr_id = t.transaction_id
  GROUP by s.student_id,s.first_name
  ORDER by s.student_id;


  BEGIN

  Open c_amount;
  v_total_paid := 0;

  loop 

    fetch c_amount into r_amount;

    exit when c_amount%notfound;

    v_total_paid := v_total_paid + r_amount.s_amount;

    -------------------Printing total paid by each student ----------------------

    dbms_output.put_line('Student '||r_amount.s_name || ' with Student ID: '|| r_amount.s_id ||
                          ' has paid total of $'||r_amount.s_amount);


  end loop;

  Close c_amount;

  RETURN v_total_paid;

  END;



END reg_pkg;

/

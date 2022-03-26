-- DELIVERABLE 1: The Number of Retiring Employees by Title
 
-- Follow the instructions below to complete Deliverable 1.
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;
-- DELIVERABLE 2: The Employees Eligible for the Mentorship Program


-- Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
INTO mentorship_eligibilty
FROM employees as e
Left outer Join dept_emp as de
ON (e.emp_no = de.emp_no)
Left outer Join titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date  = '9999-01-01')  
ORDER BY e.emp_no ASC, de.to_date DESC;


SELECT * FROM mentorship_eligibilty;



--delivarable 3
SELECT DISTINCT ON (emp_no) e.emp_no, d.dept_name, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO employees_leaving_by_dept
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
LEFT JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
    AND (de.from_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no ASC;

SELECT COUNT(first_name) "Count", dept_name
FROM employees_leaving_by_dept
GROUP BY dept_name
ORDER BY "Count" desc;

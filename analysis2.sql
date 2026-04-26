{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 Salary by industry:\
\
SELECT \
job_title,\
industry,\
Round(AVG(salary),0) AS 'Industry_Salary'\
FROM job_salary_prediction_dataset\
WHERE job_title = 'Data Analyst'\
GROUP BY\
JOB_TITLE, \
industry\
ORDER BY industry_salary desc;\
\
Salary by industry and with year:\
\
SELECT \
job_title,\
industry,\
Round(AVG(salary),0) AS 'Industry_Salary',\
experience_years\
FROM job_salary_prediction_dataset\
WHERE job_title = 'Data Analyst'\
GROUP BY\
JOB_TITLE, \
industry,\
experience_years\
ORDER BY industry_salary desc;\
\
Rows compared to avg salary by experience:\
\
SELECT \
job_title,\
industry,\
salary,\
ROUND((salary - AVG(salary) OVER (PARTITION BY experience_years)) / AVG(salary) OVER (PARTITION BY experience_years) * 100, 1) AS pct_diff_from_avg,\
experience_years,\
ROUND(AVG(salary) OVER (PARTITION BY experience_years), 0) AS avg_salary_by_experience\
FROM job_salary_prediction_dataset\
WHERE job_title = 'Data Analyst'\
Order BY pct_diff_from_avg DESC;\
\
\
Organize by industry with entries that offer above average salary per experience salary average \
\
 WITH avg_by_experience AS (\
    SELECT \
    experience_years,\
    ROUND(AVG(salary), 0) AS avg_salary\
    FROM job_salary_prediction_dataset\
    WHERE job_title = 'Data Analyst'\
    GROUP BY experience_years\
)\
SELECT j.industry, COUNT(*) AS above_avg_count\
FROM job_salary_prediction_dataset j\
JOIN avg_by_experience a ON j.experience_years = a.experience_years\
WHERE j.salary > a.avg_salary\
AND j.job_title = 'Data Analyst'\
GROUP BY j.industry\
ORDER BY above_avg_count DESC;\
\
\
\
\
}
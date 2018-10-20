create database Election;
select * from candidate;
select * from committee;
select * from committee2candidate;
select * from marylandcontributions;

/* Choosing a candidate*/
select c.CAND_ID,c.CAND_NAME,c.CAND_PTY_AFFILIATION,c.CAND_ELECTION_YR,c.CAND_STATUS,c.CAND_ST 
from candidate c where cand_id like 'H0AL02087';
select c.CAND_ID,c.CAND_NAME,c.CAND_PTY_AFFILIATION,c.CAND_ELECTION_YR,c.CAND_STATUS,c.CAND_ST 
from candidate c where cand_id like 'H0AL07086';
select cc.CMTE_ID, cc.name, cc.state, cc.transaction_Amt, cc.transaction_dt from committee2candidate cc where cc.CAND_ID like 'H0AL02087';
select cc.CMTE_ID, cc.name, cc.state, cc.transaction_Amt, cc.transaction_dt from committee2candidate cc where cc.CAND_ID like 'H0AL07086';


/*Total contribution to candidate 1*/

SELECT SUM(c.transaction_amt) from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'MARTHA%'; /*Ans: 18,97,000$*/

/*Total contribution to candidate 2*/

SELECT SUM(c.transaction_amt) from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'TERRI%'; /*Ans: 16,47500*/

/*Joining the committee2candidate table with the committee table for candidadate1-TERRY*/
select cc.CMTE_ID,cc.NAME,cc.city,cc.transaction_amt,cc.transaction_dt from committee2candidate cc  
WHERE cc.CAND_ID LIKE 'H0AL07086';
/*Joining the committee2candidate table with the committee table for candidate 2-MARTHA*/
select cc.CMTE_ID,cc.NAME,cc.city,cc.transaction_amt,cc.transaction_dt from committee2candidate cc 
WHERE cc.CAND_ID LIKE 'H0AL02087';

/*Finding common supporting committe members*/
select cc.CMTE_ID from committee2candidate cc
WHERE cc.CMTE_ID IN 
(SELECT c.CMTE_ID FROM committee2candidate c where c.CAND_ID LIKE 'H0AL02087') 
and cc.CAND_ID LIKE 'H0AL07086';

/*Finding the funding given to opponent candidate by common committees*/
select cc.TRANSACTION_AMT, cc.CAND_ID, cc.name,cc.transaction_dt from committee2candidate cc
Where (cc.CMTE_ID like 'C00035683' or cc.CMTE_ID like 'C00002972') AND cc.CAND_ID LIKE 'H0AL07086';


select cc.TRANSACTION_AMT, cc.CAND_ID, cc.name,cc.transaction_dt,cc.CMTE_ID  from committee2candidate cc
Where (cc.CMTE_ID like 'C00035683' or cc.CMTE_ID like 'C00002972') AND cc.CAND_ID LIKE 'H0AL02087';


/*Finding info about the common committees*/
select * from committee where CMTE_ID like 'C00002972' or CMTE_ID like 'C00035683';

/*---------------------------------------------------------------------------------------------------*/

/*Data of contributors and committees for candidate 1*/
SELECT m.CMTE_ID,m.name,m.state,m.occupation,m.employer,m.transaction_amt,c.name,c.transaction_amt,c.transaction_dt 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'MARTHA ROBY FOR CONGRESS';

SELECT max(m.transaction_amt), m.name,m.state,m.occupation,m.employer,c.transaction_dt 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'MARTHA ROBY FOR CONGRESS';

/*Focusing on influence of contributors from Maryland based on occupation and transaction amount*/
SELECT m.CMTE_ID,m.name,m.state,m.occupation,m.employer,m.transaction_amt,c.name,c.transaction_dt 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'MARTHA ROBY FOR CONGRESS' 
AND (m.OCCUPATION LIKE '%president%' 
or m.OCCUPATION like '%CHIEF EXECUTIVE OFFICER'
or m.OCCUPATION like '%government%');

/*Data of contributors and committees for candidate 2*/
SELECT m.CMTE_ID,m.name,m.state,m.occupation,m.employer,m.transaction_amt,c.name,c.transaction_amt,c.transaction_dt 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'TERRI SEWELL FOR CONGRESS';

SELECT max(m.transaction_amt), m.name,m.state,m.occupation,m.employer,c.transaction_dt 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'TERRI SEWELL FOR CONGRESS';

/*Focusing on influence of contributors from Maryland based on occupation and transaction amount*/
SELECT m.CMTE_ID,m.name,m.state,m.occupation,m.employer,m.transaction_amt,c.name 
from marylandcontributions m left join committee2candidate c 
on m.CMTE_ID = c.CMTE_ID 
WHERE c.name like 'TERRI SEWELL FOR CONGRESS' 
AND (m.OCCUPATION LIKE '%president%' 
or m.OCCUPATION like '%CHIEF EXECUTIVE OFFICER'
or m.OCCUPATION like '%government%');







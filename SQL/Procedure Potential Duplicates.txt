--identifying potential duplicates and putting them in a new table
Select * Into [DAEN690].[dbo].[current_Procedures_counting_dupes] 
from (
SELECT [Dim_Procedure_PK]
      ,[PatientId]
      ,[Procedure_Performed_Code]
      ,[Procedure_Performed_Description]
      ,[FRDPersonnelID]
      ,[Procedure_Performed_Date_Time], count(*)
FROM [DAEN690].[dbo].[current_Procedures$] 
GROUP BY [Dim_Procedure_PK]
      ,[PatientId]
      ,[Procedure_Performed_Code]
      ,[Procedure_Performed_Description]
      ,[FRDPersonnelID]
      ,[Procedure_Performed_Date_Time]
HAVING count(*) > 1
)x 

--creating new table with 1,294 potential duplicates
Select * Into [DAEN690].[dbo].[current_Procedures_1294_potential_dupes]
from (
SELECT [GMU_Orig_Line]
      ,[Dim_Procedure_PK]
      ,[PatientId]
      ,[Procedure_Performed_Code]
      ,[Procedure_Performed_Description]
      ,[FRDPersonnelID]
      ,[Procedure_Performed_Date_Time]
  FROM [DAEN690].[dbo].[current_Procedures$]
  where [Dim_Procedure_PK] in (select [Dim_Procedure_PK] from [DAEN690].[dbo].[current_Procedures_counting_dupes])
  )x

--creating new column [Potential Duplicate]
Update [DAEN690].[dbo].[current_Procedures_1294_potential_dupes]
Set [Potential Duplicate] = 'Yes'

--querying for entire data set with new column [Potential Duplicate]
SELECT t1.[GMU_Orig_Line]
      ,t1.[Dim_Procedure_PK]
      ,t1.[PatientId]
      ,t1.[Procedure_Performed_Code]
      ,t1.[Procedure_Performed_Description]
      ,t1.[FRDPersonnelID]
      ,t1.[Procedure_Performed_Date_Time]
	  ,t2.[potential duplicate]
  FROM [DAEN690].[dbo].[current_Procedures$] t1
  left join [dbo].[current_Procedures_1294_potential_dupes] t2
  on t1.[GMU_Orig_Line] = t2.[GMU_Orig_Line] 
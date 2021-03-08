--identifying potential duplicates and putting them in a new table
Select * Into [DAEN690].[dbo].[current_Medications_counting_dupes] 
from (
SELECT 
      [Dim_Medication_PK]
      ,[PatientId]
      ,[Medication_Given_RXCUI_Code]
      ,[Medication_Given_Description]
      ,[FRDPersonnelID]
      ,[Medication_Administered_Date_Time], COUNT(*) as 'count'
  FROM [DAEN690].[dbo].[current_Medications$]
  Group By
      [Dim_Medication_PK]
      ,[PatientId]
      ,[Medication_Given_RXCUI_Code]
      ,[Medication_Given_Description]
      ,[FRDPersonnelID]
      ,[Medication_Administered_Date_Time]
	  HAVING count(*) > 1
	  )x

--creating new table with 516 potential duplicates
	  Select * Into [DAEN690].[dbo].[current_Medications_516_potential_dupes]
from (
Select  [GMU_Orig_Line]
,[Dim_Medication_PK]
      ,[PatientId]
      ,[Medication_Given_RXCUI_Code]
      ,[Medication_Given_Description]
      ,[FRDPersonnelID]
      ,[Medication_Administered_Date_Time]
	  From [dbo].[current_Medications$]
	  Where [Dim_Medication_PK] in (select [Dim_Medication_PK] From [DAEN690].[dbo].[current_Medications_counting_dupes])
	  )x

--creating new column [Potential Duplicate]
	  Update [DAEN690].[dbo].[current_Medications_516_potential_dupes]
Set [potential duplicate] = 'Yes'

--querying for entire data set with new column [Potential Duplicate]
SELECT t1.[GMU_Orig_Line]
      ,t1.[Dim_Medication_PK]
      ,t1.[PatientId]
      ,t1.[Medication_Given_RXCUI_Code]
      ,t1.[Medication_Given_Description]
      ,t1.[FRDPersonnelID]
      ,t1.[Medication_Administered_Date_Time]
	  ,t2.[potential duplicate] 
  FROM [DAEN690].[dbo].[current_Medications$] t1
  left join [dbo].[current_Medications_516_potential_dupes] t2
  on t1.[GMU_Orig_Line] = t2.[GMU_Orig_Line] 
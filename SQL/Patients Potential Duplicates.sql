--identifying potential duplicates and putting them in a new table
Select * Into [DAEN690].[dbo].[current_Patients_counting_dupes] 
from (
SELECT [PatientId]
      ,[FRDPersonnelID]
      ,[Shift]
      ,[UnitId]
      ,[FireStation]
      ,[Battalion]
      ,[PatientOutcome]
      ,[PatientGender]
      ,[CrewMemberRoles]
      ,[DispatchTime]
      ,[FRDPersonnelGender]
      ,[FRDPersonnelStartDate], count(*) as 'count'
  FROM [DAEN690].[dbo].[current_Patients$]
  Group By [PatientId]
      ,[FRDPersonnelID]
      ,[Shift]
      ,[UnitId]
      ,[FireStation]
      ,[Battalion]
      ,[PatientOutcome]
      ,[PatientGender]
      ,[CrewMemberRoles]
      ,[DispatchTime]
      ,[FRDPersonnelGender]
      ,[FRDPersonnelStartDate]
	  HAVING count(*) > 1
)x

--creating new table with 26 potential duplicates
Select * Into [DAEN690].[dbo].[current_Patients_27_potential_dupes]
from (
Select [GMU_Orig_Line]
, [PatientId]
      ,[FRDPersonnelID]
      ,[Shift]
      ,[UnitId]
      ,[FireStation]
      ,[Battalion]
      ,[PatientOutcome]
      ,[PatientGender]
      ,[CrewMemberRoles]
      ,[DispatchTime]
      ,[FRDPersonnelGender]
      ,[FRDPersonnelStartDate]
	  From [dbo].[current_Patients$]
	  Where [PatientId] in (select [PatientId] from [DAEN690].[dbo].[current_Patients_counting_dupes])
	  )x --no primary key like the Procedures & Medications queries so had to manually review 55 rows for 27 dupes
--couldnt limit results to just 27 potential dupes 

--creating new column [Potential Duplicate]
Update [DAEN690].[dbo].[current_Patients_27_potential_dupes]
Set [potential duplicate] = 'Yes'

--querying for entire data set with new column [Potential Duplicate]
Select t1.[GMU_Orig_Line]
,t1.[PatientId]
      ,t1.[FRDPersonnelID]
      ,t1.[Shift]
      ,t1.[UnitId]
      ,t1.[FireStation]
      ,t1.[Battalion]
      ,t1.[PatientOutcome]
      ,t1.[PatientGender]
      ,t1.[CrewMemberRoles]
      ,t1.[DispatchTime]
      ,t1.[FRDPersonnelGender]
      ,t1.[FRDPersonnelStartDate]
	  ,t2.[potential duplicate] 
	  From [dbo].[current_Patients$] t1
	  left join [dbo].[current_Patients_27_potential_dupes] t2
	   on t1.[GMU_Orig_Line] = t2.[GMU_Orig_Line] 
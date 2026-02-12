  use [DCS_CRTS];


  drop table if exists tempDCSHB1;

select 
  newid() as applicationId,
  newid() as premiseId,
  d.cr_reference_number as CRRefNum,
  newid() as addressId, --AddressId
  d.CR_Street as address1, -- Address
  d.CR_Municipality as city, -- Address
  d.statusnumber as statusid, --Status
  d.CR_Amendment as isCRAmendment, --Attributes (
  1 as active, -- Attributes (inUse)
  --d.Assess_Map_and_Page as mapPage, --PremiseAddress
  --concat(d.staffNotes,' ',d.Gen_Comments,' ',d.state_funds_involved) as staffNotes, --StaffNotes
  d.[Project_Name] as  CRProjectName, --Application
  --newid() as organizationId, --grantorOrganizationId
  case when d.Grantor_Org is not null then newid() end as orgId,
  d.grantor_org as grantorOrgName, -- Organization (name)
  case when d.Grantor_First is not null or d.grantor_last is not null then newid() end as personId,
  d.Grantor_First as grantorFirstName, --Person
  d.Grantor_Last as grantorlastName, --Person
  --d.title as grantorTitle,
  case when d.Grantor_Org2 is not null then newid() end as org2Id,
  d.grantor_org2 as grantororgname2,
  case when d.Grantor2_First is not null or d.grantor2_last is not null then newid() end as person2Id,
  d.grantor2_first as grantorFirstName2,
  d.grantor2_last as grantorLastName2,
  case when d.Grantor_Org3 is not null then newid() end as org3Id,
  d.grantor_org3 as grantororgname3,
  case when d.Grantor_Org4 is not null then newid() end as org4Id,
  d.grantor_org4 as grantororgname4,
--d.title2 as grantorTitle2,
  case when d.Grantee_Org is not null then newid() end as GranteeorgId,
  d.Grantee_org as granteeOrgName, --Organization (name)
  case when d.Grantee2_Org is not null then newid() end as Grantee2orgId,
  d.Grantee2_org as granteeOrgName2,
  d.DCS_Grant_Program as fundingSource, --Funding
  d.submission_type as applicationSubmissionType, --Application questions
  d.Restriction_Acres as premiseAcres, --Premise
  DATEADD(HOUR, 5, cast(d.[received_date] as datetime2)) as submitteddate, --Application
  d.DCS_grant_Program,
  case when DCS_grant_Program like '%Conservation Land Tax Credit - CLTC%'	or	DCS_grant_Program like '%Conservation Land Tax Credit'	or	DCS_grant_Program like '%CLTC%' then 1
	when	DCS_grant_Program like '%Conservation Partnership - CP%'	or	DCS_grant_Program like '%Conservation Partnership'	or	DCS_grant_Program like '%CP%' then 2
	when	DCS_grant_Program like '%Cranberry Bog - CRAN-BOG%'	or	DCS_grant_Program='Cranberry Bog'	or	DCS_grant_Program like '%CRAN-BOG%' then 3
	when	DCS_grant_Program like '%Drinking Water Supply Protection Grant - DWSP%'	or	DCS_grant_Program like '%Drinking Water Supply Protection Grant%'	or	DCS_grant_Program like '%DWSP%' then 4
	when	DCS_grant_Program like '%Local Acquisitions for Natural Diversity - LAND%'	or	DCS_grant_Program like '%Local Acquisitions for Natural Diversity%'	or	DCS_grant_Program like '%LAND%' then 5
	when	DCS_grant_Program like '%Landscape Partnership - LP%'	or	DCS_grant_Program like '%Landscape Partnership%'	or	DCS_grant_Program like '%LP%' then 6
	when	DCS_grant_Program like '%Land and Water Conservation Fund Grant - LWCF%'	or	DCS_grant_Program like '%Land and Water Conservation Fund Grant%'	or	DCS_grant_Program like'%LWCF%' then 7
	when	DCS_grant_Program like '%Municipal Vulnerability Program Grant - MVP%'	or	DCS_grant_Program like '%Municipal Vulnerability Program Grant%'	or	DCS_grant_Program like '%MVP%' then 8
	when	DCS_grant_Program like '%Park Acquisition and Renovations for Communities - PARC%'	or	DCS_grant_Program like '%Park Acquisition and Renovations for Communities'	or	DCS_grant_Program like '%PARC%' then 9
	when	DCS_grant_Program like '%Community Preservation Act - CPA%'	or	DCS_grant_Program like '%Community Preservation Act%'	or	DCS_grant_Program like '%CPA%' then 11
	when	DCS_grant_Program like '%Forestry Legacy - FL%'	or	DCS_grant_Program like '%Forestry Legacy%'	or	DCS_grant_Program like '%FL%' then 12
	when	DCS_grant_Program like '%Forest Reserves Grant Program - FRGP%'	or	DCS_grant_Program like '%Forest Reserves Grant Program%'	or	DCS_grant_Program like '%FRGP%' then 13
	when	DCS_grant_Program like '%Agricultural Conservation Easement Program - ACEP%'	or	DCS_grant_Program like '%Agricultural Conservation Easement Program%'	or	DCS_grant_Program like '%ACEP%' then 14
	when	DCS_grant_Program like '%Other%' then 10 end as fundingid,
	--case when a.denied_withdrawn='TRUE' then 1 else 0 end as isDeleted,
case when d.Submission_Type='MESA' then 1 else 0 end as isMESA,
case when d.Submission_Type='CPA_Requirement' then 1 else 0 end as usePreservationActFunds,
case when d.Submission_Type='Permit' then 1 else 0 end as relatedToOtherPermit,
case when d.Submission_Type='Gift-Year-end' then 1 else null end as isPremisesGift,
d.fundingyear as year
  --d.Deadline_to_Closing as recordingDeadline, --Application
  --d.Deadline_to_Closing_Comm as deadLineExplaination, --Application
  --d.CP_Last as contactLastName, --Person(Contact)
  --d.CP_Email as contactEmail, --Contact email
  --d.CP_Phone as contactPhoneNum, --Phone
  --d.CP_Extension as contactPhoneExt, --Phone
  --d.reviewer as reviewerName,
  --d.Denied_Withdrawn as isDeleted
  into tempDCSHB1  
  from src.HistBatch1 d

-----------------------------------------------------------------------------------------------------------------------

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select orgid,grantorOrgName,1,getdate(),'DataLoad' from tempDCSHB1 where orgid is not null --59
  
insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select org2id,grantororgname2,1,getdate(),'DataLoad' from tempDCSHB1 where org2id is not null --59

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select org3id,grantororgname3,1,getdate(),'DataLoad' from tempDCSHB1 where org3id is not null --59

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select org4id,grantororgname4,1,getdate(),'DataLoad' from tempDCSHB1 where org2id is not null --59
------------------------------------------------------------------------------
--Grantee Org

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select GranteeorgId,granteeorgname,1,getdate(),'DataLoad' from tempDCSHB1 where GranteeorgId is not null --59

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select Grantee2orgId,granteeorgname2,1,getdate(),'DataLoad' from tempDCSHB1 where Grantee2orgId is not null --59

------------------------------------------------------------------------------
--Grantor Person

  insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy)
  select personId,grantorFirstname,grantorlastname,1,getdate(),'DataLoad' from tempDCSHB1 where personid is not null

    insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy)
  select person2id,grantorFirstname2,grantorlastname2,1,getdate(),'DataLoad' from tempDCSHB1 where person2id is not null
--------------------------------------------------------------------------------------------------------
--Application

insert into application (applicationid,CRProjectName,submittedDate,
isDeleted,CRRefNum,isMESAPermit,
usePreservationActFunds,relatedToOtherPermit,isPremisesGift,statusid,accessorId,
inuse,lastModifiedDt,lastModifiedBy,loggedInUser)
select 
applicationId,
--recordingDeadline,
--deadLineExplaination,
CRProjectName,
submitteddate,
'0' as isDeleted,
CRRefNum,
isMesa,
usePreservationActFunds,
relatedToOtherPermit,
isPremisesGift,
statusid,
1 as accessorId,
1 as inuse,
getdate() as lastmodifiedDt,
'Heather.Furrow@mass.gov' as lastModifiedBy,
'Heather.Furrow@mass.gov' as loggedInUser
from tempDCSHB1 
--join status s on s.internalName=a.status
-----------------------------------------------------------------------------------------------------
--Address, Premise, PremiseAddress

insert into address(addressid,address1,city,inuse,lastmodifieddt,lastmodifiedby)
select
addressId,address1,city,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby
from tempDCSHB1


insert into Premise(premiseid,applicationid,totalacres,inuse,lastmodifieddt,lastmodifiedby)
select
premiseid,applicationid,premiseAcres,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby
from tempDCSHB1


insert into PremiseAddress(premiseId,addressid,inuse,lastModifiedDt,lastModifiedBy)
select
premiseid,addressid,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy--,
--mapPage as accesormapparcel
from tempDCSHB1
------------------------------------------------------------------------------------------------------------
--Attributes

insert into attributes(applicationid,iscramendment,inuse,lastmodifieddt,lastmodifiedby)
select applicationid,
--recordingdeadline as targetdeadline,
case when iscramendment='FALSE' then NULL else 1 end as iscramendment,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempDCSHB1
-----------------------------------------------------------------------------------------
--ApplicationFunding

insert into applicationfunding(applicationid,fundingid,year,inuse,lastmodifieddt,lastmodifiedby)
select applicationid,fundingid,year,
	1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempDCSHB1 where fundingid is not null or year is not null

-----------------------------------------------------------------------------------------------------
--ApplicationPartyRole

insert into applicationpartyrole(applicationid,organizationid,personid,partyroleid,isorg,isPrimary,inuse,lastmodifieddt,lastmodifiedby)
select
t.applicationid,
o.organizationid,
p.personid,
1 as partyroleid,
case when organizationid is null then 0 else 1 end as isOrg,
1 as isprimary,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempDCSHB1 t
left join organization o on t.orgid=o.organizationid or t.org2id=o.organizationid or t.org3id=o.organizationid or t.org4id=o.organizationid
left join person p on t.personId=p.personId or t.person2Id=p.personid


/* 
insert into applicationstaffrole(applicationid,personid,organizationid,partyroleid,isPrimary,inuse,lastmodifieddt,lastmodifiedby,isorg)
select
t.applicationid,
p.personid,
1 as isprimary,
0 as isOrg,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempDCS2 t
join person p on t.grantorfirstname=p.firstname and t.grantorlastname=p.lastname
*/


insert into applicationpartyrole(applicationid,organizationid,partyroleid,isPrimary,isorg,inuse,lastmodifieddt,lastmodifiedby)
select
t.applicationid,
o.organizationid,
--p.personid,
2 as partyroleid,
0 as isprimary,
1 as isOrg,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempDCSHB1 t
left join organization o on o.organizationid=t.GranteeorgId or o.organizationId=t.Grantee2orgId
--left join person p on t.granteefirstname=p.firstname and t.granteelastname=p.lastname

------------------------------------------------------------------------------------------------------------------------
/*
update Application
set submitteddate=DATEADD(HOUR, 5, a.submitteddate)
from application a
join tempDCSHB1 t on t.applicationId=a.applicationid
*/

update ApplicationFunding 
set inuse=0
from ApplicationFunding where fundingid is null and year is null and inuse=1



SET IDENTITY_INSERT dbo.PriorityReason ON;
INSERT INTO dbo.PriorityReason
    (reasonId, reason, inUse, lastModifiedDt, lastModifiedBy)
VALUES
    (7, 'Grant Funding', 1, GETDATE(), 'System');
SET IDENTITY_INSERT dbo.PriorityReason OFF;


update Staff
set inUse=0
where staffid in (7,9,10,11,12);


SET IDENTITY_INSERT [dbo].[DocumentType] ON
INSERT [dbo].[DocumentType] ([docTypeId], [docTypeName], [docDescription], [inUse], [lastModifiedDt], [lastModifiedBy]) VALUES (42, N'Meeting Minutes', N'Meeting Minutes', 1, CAST(N'2026-02-12T20:26:09.2200000' AS DateTime2), N'System')
SET IDENTITY_INSERT [dbo].[DocumentType] OFF


update Staff
set email='megan.knott@mass.gov'
where staffid=6;
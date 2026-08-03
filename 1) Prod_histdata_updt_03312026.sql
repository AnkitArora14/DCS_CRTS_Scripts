use dcs_crts;


update partyrole
set partyrolename='Contact Person'
where partyroleid=3


update status
set inuse=1 where statusid=15;



drop table if exists tempHistData;

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
  d.documenttypeid2_registry as premiseRegistryAddress,
  d.documenttypeid2_book as book, --Attributes
  d.documenttypeid2_page as page, --Attriibutes
  d.accessormapparcel as accessorMapParcel, --Premise
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
  case when d.Grantor3_First is not null or d.grantor3_last is not null then newid() end as person3Id,
  d.grantor3_first as grantorFirstName3,
  d.grantor3_last as grantorLastName3,
--d.title2 as grantorTitle2,
  case when d.Grantee_Org is not null then newid() end as GranteeorgId,
  d.Grantee_org as granteeOrgName, --Organization (name)
  case when d.Grantee2_Org is not null then newid() end as Grantee2orgId,
  d.Grantee2_org as granteeOrgName2,
  d.DCS_Grant_Program as fundingSource, --Funding
  case when d.apr3_firstname is not null or d.apr3_lastname is not null then newid() end as apr3perId,
  d.apr3_firstname as apr3FirstName,
  d.apr3_lastname as apr3LastName,  
  case when d.apr3_Org is not null then newid() end as apr3OrgId,
  d.apr3_org as apr3Org,
  d.apr3_title as apr3title,
  case when d.apr3_address1 is not null then newid() end as apr3addressId,
  d.apr3_address1 as apr3Address1,
  d.apr3_address2 as apr3Address2,
  d.apr3_town as apr3Town,
  d.apr3_zip as apr3Zip,
  d.apr3_phone as apr3Phone,
  d.apr3_email as apr3Email,
  case when d.apr3_firstname_2 is not null or d.apr3_lastname_2 is not null then newid() end as apr3perId2,
  d.apr3_firstname_2 as apr3FirstName2,
  d.apr3_lastname_2 as apr3LastName2,  
  case when d.apr3_Org_2 is not null then newid() end as apr3OrgId2,
  d.apr3_org_2 as apr3Org2,
  d.apr3_title_2 as apr3title2,
  case when d.apr3_address1 is not null then newid() end as apr3addressId2,
  d.apr3_address1_2 as apr3Address1_2,
  d.apr3_address2_2 as apr3Address2_2,
  d.apr3_town_2 as apr3Town2,
  d.apr3_zip_2 as apr3Zip2,
  d.apr3_phone_2 as apr3Phone2,
  d.apr3_email_2 as apr3Email2,
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
case when d.consFocus_Forest=1 then 2 else null end as consFocusId1,
case when d.consFocus_PublicAccessAllowed=1 then 18 else null end as consFocusId2,
case when d.consFocus_AgriculturalWorkingFarmland=1 then 1 else null end as consFocusId3,
case when d.consFocus_WatersupplyProtectionCR=1 then 19 else null end as consFocusId4,
d.permit as isMESPAPermit,
d.secretarySignedDate as secretarySignedDate,
d.PremisesRegistryLoc as premiseRegistryLoc,
d.docTypeId31_book as docType31_book,
d.docTypeId31_page as docType31_page,
d.docTypeId31_certificateNum as docType31_certNum,
d.docTypeId31_instrumentNum as docType31_instruNum,
d.docTypeId31_documentNum as docType31_docNum,
d.fundingyear as [year],
d.RecordingDeadline as recordingDeadline, --Application
d.DeadlineExplaination as deadLineExplaination, --Application
  --d.CP_Last as contactLastName, --Person(Contact)
  --d.CP_Email as contactEmail, --Contact email
  --d.CP_Phone as contactPhoneNum, --Phone
  --d.CP_Extension as contactPhoneExt, --Phone
d.reviewer  as staff,
d.GISCompleteDate as gisCompleteDate,
d.CRRecordedDate as CRrecordedDate,
newid() as documentTypeFieldId,
d.[N-P_list] as NPlist
  --d.Denied_Withdrawn as isDeleted
into tempHistData  
  from src.HistData d

--select * from tempHistData

-------------------------------------------------------------------------------------------------------------------------------

update tempHistData
set premiseRegistryLoc='Middle Berkshire'
where premiseregistryLoc='Berkshire Middle'

update tempHistData
set premiseRegistryLoc='North Berkshire'
where premiseregistryLoc='Berkshire North'

update tempHistData
set premiseRegistryLoc='South Berkshire'
where premiseregistryLoc='Berkshire South'

update tempHistData
set premiseRegistryLoc='North Bristol'
where premiseregistryLoc='Bristol North'

update tempHistData
set premiseRegistryLoc='South Bristol'
where premiseregistryLoc='Bristol South'

update tempHistData
set premiseRegistryLoc='North Middlesex'
where premiseregistryLoc='Middlesex North'

update tempHistData
set premiseRegistryLoc='South Middlesex'
where premiseregistryLoc='Middlesex South'

update tempHistData
set premiseRegistryLoc='South Essex'
where premiseregistryLoc='Southern Essex'

update tempHistData
set premiseRegistryLoc='South Middlesex'
where premiseregistryLoc='Southern Middlesex'

update tempHistData
set premiseRegistryLoc='Fall River Bristol'
where premiseregistryLoc='Bristol'


update tempHistData
set premiseRegistryLoc='Worcester'
where premiseregistryLoc='Worcester South'

--select * from tempHistData where premiseRegistryAddress in ('Middlesex','Essex')

update tempHistData
set premiseRegistryAddress='North Middlesex'
where CRRefNum=10866

update tempHistData
set premiseRegistryAddress='South Middlesex'
where CRRefNum=17237

update tempHistData
set premiseRegistryAddress='North Essex'
where CRRefNum=10867




------------------------------------------------------------------------------------------------------------------------------------



insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select orgid,grantorOrgName,1,getdate(),'DataLoad' from tempHistData where grantorOrgName is not null
and NULLIF(grantorOrgName, '') IS not NULL;
  
insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select org2id,grantororgname2,1,getdate(),'DataLoad' from tempHistData where grantororgname2 is not null
 and NULLIF(grantorOrgName2, '') IS not NULL;--59
  
insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select org3id,grantororgname3,1,getdate(),'DataLoad' from tempHistData where grantororgname3 is not null --59
 and NULLIF(grantorOrgName3, '') IS not NULL;
--insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
-- select org4id,grantororgname4,1,getdate(),'DataLoad' from tempDCSHB1 where org2id is not null --59


insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select apr3orgid,apr3Org,1,getdate(),'DataLoad' from tempHistData where apr3Org is not null --59
 and NULLIF(apr3Org, '') IS not NULL;


insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select apr3OrgId2,apr3Org2,1,getdate(),'DataLoad' from tempHistData where apr3Org2 is not null --59
 and NULLIF(apr3Org2, '') IS not NULL;

------------------------------------------------------------------------------
--Grantee Org

insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select GranteeorgId,granteeorgname,1,getdate(),'DataLoad' from tempHistData where granteeOrgName is not null --59
 and NULLIF(granteeOrgName, '') IS not NULL;


insert into organization(organizationId,organizationName,inUse,lastmodifiedDt,lastModifiedBy)
 select Grantee2orgId,granteeorgname2,1,getdate(),'DataLoad' from tempHistData where granteeOrgName2 is not null --59
 and NULLIF(granteeOrgName2, '') IS not NULL;
------------------------------------------------------------------------------
--Grantor Person

  insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy)
  select personId,grantorFirstname,grantorlastname,1,getdate(),'DataLoad' from tempHistData where (grantorFirstName is not null 
  or grantorlastName is not null)
   and NULLIF(
        LTRIM(RTRIM(
            ISNULL(grantorfirstname, '') + ' ' + ISNULL(grantorlastname, '')
        )),
    '') IS  not NULL;

    insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy)
  select person2id,grantorFirstname2,grantorlastname2,1,getdate(),'DataLoad' from tempHistData where (grantorFirstName2 is not null 
  or grantorlastName2 is not null)
   and NULLIF(
        LTRIM(RTRIM(
            ISNULL(grantorfirstname2, '') + ' ' + ISNULL(grantorlastname2, '')
        )),
    '') IS  not NULL;
  

	insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy)
  select person3id,grantorFirstname3,grantorlastname3,1,getdate(),'DataLoad' from tempHistData where (grantorFirstName3 is not null 
  or grantorlastName3 is not null)
   and NULLIF(
        LTRIM(RTRIM(
            ISNULL(grantorfirstname3, '') + ' ' + ISNULL(grantorlastname3, '')
        )),
    '') IS  not NULL;


  	insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy,email)
  select apr3perId,apr3FirstName,apr3LastName,1,getdate(),'DataLoad',apr3Email from tempHistData where (apr3FirstName is not null 
  or apr3LastName is not null)
   and NULLIF(
        LTRIM(RTRIM(
            ISNULL(apr3firstname, '') + ' ' + ISNULL(apr3lastname, '')
        )),
    '') IS  not NULL;


  	insert into person(personId,firstName,lastName,inUse,lastmodifiedDt,lastModifiedBy,email)
  select apr3perId2,apr3FirstName2,apr3LastName2,1,getdate(),'DataLoad',apr3Email2 from tempHistData where (apr3FirstName2 is not null 
  or apr3LastName2 is not null)
   and NULLIF(
        LTRIM(RTRIM(
            ISNULL(apr3firstname2, '') + ' ' + ISNULL(apr3lastname2, '')
        )),
    '') IS  not NULL;

  
--------------------------------------------------------------------------------------------------------
--Application

insert into application (applicationid,recordingDeadLine,deadLineExplaination,CRProjectName,submittedDate,
isDeleted,CRRefNum,isMESAPermit,
usePreservationActFunds,relatedToOtherPermit,isPremisesGift,statusid,accessorId,
inuse,lastModifiedDt,lastModifiedBy,loggedInUser.,isStaffSubmitted)
select 
applicationId,
recordingDeadline,
deadLineExplaination,
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
'Heather.Furrow@mass.gov' as loggedInUser,
0 as isstaffsubmitted
from tempHistData 
--join status s on s.internalName=a.status
-----------------------------------------------------------------------------------------------------
--Address, Premise, PremiseAddress

insert into address(addressid,address1,city,inuse,lastmodifieddt,lastmodifiedby)
select
addressId,address1,city,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby
from tempHistData


insert into address(addressid,address1,city,inuse,lastmodifieddt,lastmodifiedby,zipCode)
select
apr3addressId,apr3Address1,apr3Town,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby,apr3zip
from tempHistData where 
 NULLIF(LTRIM(RTRIM(apr3address1)), '') IS not NULL
  AND NULLIF(LTRIM(RTRIM(apr3town)), '') IS not NULL;



insert into address(addressid,address1,city,inuse,lastmodifieddt,lastmodifiedby,zipCode)
select
apr3addressId2,apr3Address1_2,apr3Town2, 
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby, apr3zip2
from tempHistData where 
 NULLIF(LTRIM(RTRIM(apr3address1_2)), '') IS not NULL
  AND NULLIF(LTRIM(RTRIM(apr3town2)), '') IS not NULL;


insert into Premise(premiseid,applicationid,totalacres,inuse,lastmodifieddt,lastmodifiedby)
select
premiseid,applicationid,premiseAcres,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedby
from tempHistData


insert into PremiseAddress(premiseId,addressid,inuse,lastModifiedDt,lastModifiedBy,accessorMapParcel)
select
p.premiseid,
a.addressid,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy,
accessorMapParcel as accesormapparcel
from tempHistData t
join premise p on p.premiseid=t.premiseId
join address a on a.addressId=t.addressId

------------------------------------------------------------------------------------------------------------
--Attributes

insert into attributes(applicationid,iscramendment,inuse,lastmodifieddt,lastmodifiedby,GISCompleteDate,NPList)
select applicationid,
--recordingdeadline as targetdeadline,
case when iscramendment='FALSE' then 0 else 1 end as iscramendment,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy,
TRY_CAST(gisCompleteDate AS DATETIME2),
NPlist as NPlist 
from tempHistData
-------------------------------------------------------------------------------------------------

--select * from temphistdata

drop table if exists #tempAttCF1;
select a.attributesid,t.consFocusId1
into #tempAttCF1
from attributes a
left join temphistdata t on a.applicationId=t.applicationId
where t.consFocusId1 is not null

drop table if exists #tempAttCF2;
select a.attributesid,t.consFocusId2
into #tempAttCF2
from attributes a
left join temphistdata t on a.applicationId=t.applicationId
where t.consFocusId2 is not null

drop table if exists #tempAttCF3;
select a.attributesid,t.consFocusId3
into #tempAttCF3
from attributes a
left join temphistdata t on a.applicationId=t.applicationId
where t.consFocusId3 is not null

drop table if exists #tempAttCF4;
select a.attributesid,t.consFocusId4
into #tempAttCF4
from attributes a
left join temphistdata t on a.applicationId=t.applicationId
where t.consFocusId4 is not null


insert into AttributesConservationFocus(attributesId,conservationFocusId,inuse,lastModifiedDt,lastmodifiedby)
select
attributesid, consFocusId1 as conservationfocusid, 1 as inuse, getdate() as lastmodifieddt, 'System' as lastmodifiedby
from #tempAttCF1

insert into AttributesConservationFocus(attributesId,conservationFocusId,inuse,lastModifiedDt,lastmodifiedby)
select
attributesid, consFocusId2 as conservationfocusid, 1 as inuse, getdate() as lastmodifieddt, 'System' as lastmodifiedby
from #tempAttCF2

insert into AttributesConservationFocus(attributesId,conservationFocusId,inuse,lastModifiedDt,lastmodifiedby)
select
attributesid, consFocusId3 as conservationfocusid, 1 as inuse, getdate() as lastmodifieddt, 'System' as lastmodifiedby
from #tempAttCF3

insert into AttributesConservationFocus(attributesId,conservationFocusId,inuse,lastModifiedDt,lastmodifiedby)
select
attributesid, consFocusId4 as conservationfocusid, 1 as inuse, getdate() as lastmodifieddt, 'System' as lastmodifiedby
from #tempAttCF4

-----------------------------------------------------------------------------------------
--ApplicationFunding

insert into applicationfunding(applicationid,fundingid,year,inuse,lastmodifieddt,lastmodifiedby)
select applicationid,fundingid,[year],
	1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempHistData where [year] is not null

--select * from tempHistData where  year is null
--------------------------------------------------------------------------------------------------------
--Phone

 insert into phone(phoneTypeId,personId,phoneNumber,extension,
 inuse,lastModifiedDt,lastModifiedBy)
 select 
 2 as phonetypeid,
 t.apr3perId,
 CASE 
        WHEN CHARINDEX('x', t.apr3phone) > 0 
        THEN LEFT(t.apr3phone, CHARINDEX('x', t.apr3phone) - 1)
        ELSE t.apr3phone
    END AS phone,
 --c.contactPhoneExt,
 CASE 
        WHEN CHARINDEX('x', t.apr3phone) > 0 
        THEN SUBSTRING(
                t.apr3phone,
                CHARINDEX('x', t.apr3phone) + 1,
                LEN(t.apr3phone)
             )
        ELSE NULL
    END AS ext,
 1 as inuse,
 getdate() as lastmodifiedDt,
 'DataLoad'as lastModifiedBy
 from tempHistData t
  --join person p on p.lastname=c.contactlastname and p.email=c.contactemail
 join person p on p.personid=t.apr3perid
 where NULLIF(LTRIM(RTRIM(apr3phone)), '') IS not NULL



 insert into phone(phoneTypeId,personId,phoneNumber,--extension,
 inuse,lastModifiedDt,lastModifiedBy)
 select 
 2 as phonetypeid,
 t.apr3perId2,
 CASE 
        WHEN CHARINDEX('x', t.apr3phone2) > 0 
        THEN LEFT(t.apr3phone2, CHARINDEX('x', t.apr3phone2) - 1)
        ELSE t.apr3phone2
    END AS phone,
 --c.contactPhoneExt,
 CASE 
        WHEN CHARINDEX('x', t.apr3phone2) > 0 
        THEN SUBSTRING(
                t.apr3phone2,
                CHARINDEX('x', t.apr3phone2) + 1,
                LEN(t.apr3phone2)
             )
        ELSE NULL
    END AS ext,
 1 as inuse,
 getdate() as lastmodifiedDt,
 'DataLoad'as lastModifiedBy
 from tempHistData t
 join person p on p.personid=t.apr3perId2
 where NULLIF(LTRIM(RTRIM(apr3phone2)), '') IS not NULL
  
 -----------------------------------------------------------------------------------------------------
 --DocumentTypeField

 insert into DocumentTypeField (documentTypeId,isRegistryBookPage,book,page,applicationId)
 
 select
 case when premiseRegistryAddress is not null and book is not null and page is not null then 2 end as doctypeid,
 1 as isRegistryBookPage,
 case when book is not null then book end as book,
 case when page is not null then page end as page,
 --docType31_certNum as certificateNumber,
 --docType31_instruNum as instrumentNumber,
 --docType31_docNum as documentNumber,
 applicationId as applicationId
 from tempHistData 
 where book is not null and page is not null
 ----------------------------------------------------------------------------------------------------------------

 insert into DocumentTypeField (documentTypeId,isRegistryBookPage,book,page,
 certificateNumber,instrumentNumber,documentnumber,applicationId)
 
 select 
 case when premiseRegistryLoc is not null or doctype31_book is not null and doctype31_page is not null then 31 end as doctypeid,
 1 as isRegistryBookPage,
 case when doctype31_book is not null then doctype31_book end as book,
 case when doctype31_page is not null then doctype31_page end as page,
 docType31_certNum as certificateNumber,
 docType31_instruNum as instrumentNumber,
 docType31_docNum as documentNumber,
 applicationId as applicationId
 from tempHistData
 where docType31_book is not null


 select * from DocumentTypeField dtf
 join temphistdata t on dtf.applicationId=t.applicationId and dtf.documenttypeid=31
 ---------------------------------------------------------------------------------------------------------
 --DocumentTypeFieldRegApp


 select * from temphistdata where premiseRegistryAddress is not null and premiseRegistryLoc is not null

 drop table if exists #temp;
 select crrefnum,
 newid() as documentTypeFieldRegAppId,
 t.documentTypeFieldId,
 dtf.documentTypeFieldId as doctypefieldId,
 t.applicationId,
 case when t.premiseRegistryAddress is not null then pr.premiseRegistryId end as premiseRegistryId,
 1 as inUse,
 'System' as lastModifiedBy,
 getdate() as lastModifiedDt
-- select * 
into #temp
from tempHistData t
left join DocumentTypeField dtf on dtf.applicationid=t.applicationId and dtf.documentTypeId=2
left join PremiseRegistry pr on pr.registryLoc=t.premiseRegistryAddress 
--left join PremiseRegistry pr1 on pr1.registryLoc=t.premiseRegistryLoc
where t.premiseRegistryAddress is not null



 drop table if exists #temp2;
 select crrefnum,
 newid() as documentTypeFieldRegAppId,
 t.documentTypeFieldId,
 dtf.documentTypeFieldId as doctypefieldId,
 t.applicationId,
 case when t.premiseRegistryLoc is not null then pr1.premiseRegistryId end as premiseRegistryId,
 1 as inUse,
 'System' as lastModifiedBy,
 getdate() as lastModifiedDt
-- select * 
into #temp2
from tempHistData t
left join DocumentTypeField dtf on dtf.applicationid=t.applicationId and dtf.documentTypeId=31
--left join PremiseRegistry pr on pr.registryLoc=t.premiseRegistryAddress 
left join PremiseRegistry pr1 on pr1.registryLoc=t.premiseRegistryLoc
where t.premiseRegistryLoc is not null



insert into DocumentTypeFieldRegApp (documentTypeFieldId,applicationId,premiseRegistryId,inUse,lastModifiedBy,lastModifiedDt)
 
select t.doctypefieldId,
t.applicationid,
PremiseRegistryid, 1 as inuse,
'System' as lastmodifiedby,
getdate() as lastmodifieddt
from #temp t


insert into DocumentTypeFieldRegApp (documentTypeFieldId,applicationId,premiseRegistryId,inUse,lastModifiedBy,lastModifiedDt)
 
select t.doctypefieldId,
t.applicationid,
PremiseRegistryid, 1 as inuse,
'System' as lastmodifiedby,
getdate() as lastmodifieddt
from #temp2 t where doctypefieldId is not null


--select CRrefnum from #temp where PremiseRegistryid is not null --1577
--order by CRRefNum

--select CRRefNum from tempHistData where premiseRegistryLoc is not null --1608
--union all
--select CRRefnum from tempHistData where premiseRegistryAddress is not null --11
--order by crrefnum


--select * from tempHistData where crrefnum=10860

 -----------------------------------------------------------------------------------------------------
--ApplicationPartyRole


insert into applicationpartyrole(applicationid,organizationid,personid,partyroleid,isorg,isPrimary,inuse,lastmodifieddt,lastmodifiedby)
select
t.applicationid,
o.organizationid,
p.personid,
1 as partyroleid,
case when organizationid is null then 0 else 1 end as isOrg,
null as isprimary,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempHistData t
left join organization o on t.orgid=o.organizationid or t.org2id=o.organizationid or t.org3id=o.organizationid --or t.org4id=o.organizationid
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


insert into person(personid,firstname,lastname,inuse,lastModifiedDt,lastmodifiedby) values ('CDE66D84-391B-429A-9B57-FCBD41D25440','Primary','Contact',1,getdate(),'System');

--select * from person order by  lastModifiedDt desc;

--'CDE66D84-391B-429A-9B57-FCBD41D25440'

--select * from ApplicationPartyRole


insert into applicationpartyrole(applicationid,personid,partyroleid,isPrimary,inuse,lastmodifieddt,lastmodifiedby,otherContactDescription)
select
t.applicationid,
--o.organizationid,
'CDE66D84-391B-429A-9B57-FCBD41D25440' as personid,
3 as partyroleid,
--case when organizationid is null then 0 else 1 end as isOrg,
1 as isprimary,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy,
'PlaceHolder' as otherContactDescription
from tempHistData t




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
from tempHistData t
left join organization o on o.organizationid=t.GranteeorgId or o.organizationId=t.Grantee2orgId
--left join person p on t.granteefirstname=p.firstname and t.granteelastname=p.lastname



insert into applicationpartyrole(applicationid,organizationid,personid,partyroleid,isPrimary,isorg,inuse,lastmodifieddt,lastmodifiedby)
select
t.applicationid,
o.organizationid,
p.personid,
--t.apr3OrgId,
--t.apr3perId,
3 as partyroleid,
0 as isprimary,
0 as isOrg,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempHistData t
left join person p on t.apr3perid=p.personid 
left join organization o on o.organizationid=t.apr3OrgId 
where NULLIF(LTRIM(RTRIM(apr3org)), '') IS not NULL
  or NULLIF(LTRIM(RTRIM(apr3lastname)), '') IS not NULL--;
-- where o.organizationId is not null and p.personid is not null and t.apr3Org is not null



insert into applicationpartyrole(applicationid,organizationid,personid,partyroleid,isPrimary,isorg,inuse,lastmodifieddt,lastmodifiedby)
select
t.applicationid,
o.organizationid,
p.personid,
--t.apr3OrgId,
--t.apr3perId,
3 as partyroleid,
0 as isprimary,
0 as isOrg,
1 as inuse,
getdate() as lastmodifieddt,
'DataLoad' as lastModifiedBy
from tempHistData t
left join person p on t.apr3perid2=p.personid 
left join organization o on o.organizationid=t.apr3OrgId2
where NULLIF(LTRIM(RTRIM(apr3org2)), '') IS not NULL
  or NULLIF(LTRIM(RTRIM(apr3lastname2)), '') IS not NULL--;



------------------------------------------------------------------------------------------------------------------------
/*
update Application
set submitteddate=DATEADD(HOUR, 5, a.submitteddate)
from application a
join tempDCSHB1 t on t.applicationId=a.applicationid

update ApplicationFunding 
set inuse=0
--select *
from ApplicationFunding where fundingid is null and year is null and inuse=1
*/











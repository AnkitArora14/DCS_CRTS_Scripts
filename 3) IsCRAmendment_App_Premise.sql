use DCS_CRTS;

alter table application
add isCRAmendment bit null;

update application
set isCRamendment=att.isCRAmendment
--select * 
from Application app 
join attributes att on app.applicationId=att.applicationId




ALTER TABLE Attributes
DROP COLUMN isCRAmendment;

ALTER TABLE Premise
ADD isAmendingExistingCR BIT;
use DCS_CRTS

SET IDENTITY_INSERT dbo.PriorityReason ON
  insert into priorityreason(reasonId,reason,inUse,lastModifiedDt,lastModifiedBy) values (6,'Other',1,getdate(),'System')
SET IDENTITY_INSERT dbo.PriorityReason OFF


alter table attributes
  add priorityDescription nvarchar(max);
  
  
alter table Document
  add isExhibit bit;


ALTER TABLE dbo.Notification
  ADD docTypeId INT;

ALTER TABLE dbo.Notification
  ADD CONSTRAINT FK_Notification_DocumentType
  FOREIGN KEY (docTypeId)
  REFERENCES dbo.DocumentType (docTypeId);


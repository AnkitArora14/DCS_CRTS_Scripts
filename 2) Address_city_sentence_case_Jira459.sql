use DCS_CRTS;


select * into address_bkp from address;


UPDATE dbo.Address
SET address1 =
(
    SELECT STRING_AGG(
               UPPER(LEFT(value, 1)) + LOWER(SUBSTRING(value, 2, LEN(value))),
               ' '
           )
    FROM STRING_SPLIT(LOWER(address1), ' ')
)
WHERE address1 = UPPER(address1)
  AND address1 IS NOT NULL;


UPDATE dbo.Address
SET address2 =
(
    SELECT STRING_AGG(
               UPPER(LEFT(value, 1)) + LOWER(SUBSTRING(value, 2, LEN(value))),
               ' '
           )
    FROM STRING_SPLIT(LOWER(address2), ' ')
)
WHERE address2 = UPPER(address2)
  AND address2 IS NOT NULL;


UPDATE dbo.Address
SET city =
(
    SELECT STRING_AGG(
               UPPER(LEFT(value, 1)) + LOWER(SUBSTRING(value, 2, LEN(value))),
               ' '
           )
    FROM STRING_SPLIT(LOWER(city), ' ')
)
WHERE city = UPPER(city)
  AND city IS NOT NULL;




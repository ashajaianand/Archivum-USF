CREATE DEFINER=`coltonwalker`@`%` PROCEDURE `UAP_getGraduateApplications`()
BEGIN
/*                                                                          		Updating table: UAP_graduateApplication*/
UPDATE appiandb.UAP_graduateApplication `ga`
/*Join Banner_gradApplicant to UAP_graduateApplication*/
INNER JOIN appiandb.BANNER_gradApplicant `bga`
/*Where applicationNumber, term, and uNumber match*/
ON  `ga`.`applicationNumber` = `bga`.`applicationNumber`
AND `ga`.`term` = `bga`.`term`
AND `ga`.`uNumber` = `bga`.`uNumber`
SET 
`ga`.`referenceNumber` = `bga`.`confirmationNumber`,
`ga`.`applicationNumber` = `bga`.`applicationNumber`,
`ga`.`term` = `bga`.`term`,
`ga`.`studentType` = `bga`.`studentType`,
`ga`.`uNumber` = `bga`.`uNumber`,
`ga`.`firstName` = `bga`.`firstName`,
`ga`.`middleName` = `bga`.`middleName`,
`ga`.`lastName` = `bga`.`lastName`,
`ga`.`address1` = `bga`.`address1`,
`ga`.`address2` = `bga`.`address2`,
`ga`.`city` = `bga`.`city`,
`ga`.`state` = `bga`.`state`,
`ga`.`country` = `bga`.`country`,
`ga`.`zip` = `bga`.`zip`,
`ga`.`phoneNumber` = `bga`.`phoneNumber`,
/*Change for Prod*/
/*`ga`.`email` = `bga`.`email`,*/
`ga`.`email` = 'usfappian@gmail.com',
`ga`.`appSubmittedOn` = `bga`.`appSubmitedOn`,
`ga`.`campus` = `bga`.`campus`,
`ga`.`college` = `bga`.`college`,
`ga`.`department` = `bga`.`department`,
`ga`.`degree` = `bga`.`degree`,
`ga`.`gpa` = IF(`bga`.`usfGpa` = '', NULL, `bga`.`usfGpa`),
`ga`.`transferGpa` = IF(`bga`.`transferGpa` = '', NULL, `bga`.`transferGpa`),
`ga`.`overallGpa` = IF(`bga`.`overallGpa` = '', NULL, `bga`.`overallGpa`),
`ga`.`isInternational` = IF(`bga`.`isInternational` = 'FALSE', 0, 1),
`ga`.`majorCode` = `bga`.`majorCode`,
`ga`.`concentrationCode` = IF(`bga`.`concentrationCode` = '', NULL, `bga`.`concentrationCode`),
`ga`.`citizenshipCode` = `bga`.`citizenshipCode`,
`ga`.`isFeePaid` = IF(`bga`.`isFeePaid` = 'FALSE', 0, 1),
`ga`.`isEnglishProficient` = IF(`bga`.`applicationDecision`= 'RG', 1, 0),
`ga`.`isClearedForConduct` = IF(`bga`.`applicationDecision`= 'RG', 1, 0),
`ga`.`applicationDecision` = `bga`.`applicationDecision`,
`ga`.`applicationDecisionDate` = `bga`.`applicationDecisionDate`,
`ga`.`isRG` = IF(`bga`.`applicationDecision`= 'RG',1,0),
`ga`.`isRgOn` = IF (`bga`.`applicationDecision`= 'RG',`bga`.`applicationDecisionDate`, NULL);

/*       																				Adding new entries to table: UAP_graduateApplication*/
INSERT INTO appiandb.UAP_graduateApplication
(
`referenceNumber`,
`applicationNumber`,
`term`,
`studentType`,
`uNumber`,
`firstName`,
`middleName`,
`lastName`,
`address1`,
`address2`,
`city`,
`state`,
`country`,
`zip`,
`phoneNumber`,
`email`,
`appSubmittedOn`,
`campus`,
`college`,
`department`,
`degree`,
`gpa`,
`transferGpa`,
`overallGpa`,
`isInternational`,
`majorCode`,
`concentrationCode`,
`citizenshipCode`,
`isFeePaid`,
`isEnglishProficient`,
`isClearedForConduct`,
`applicationDecision`,
`applicationDecisionDate`,
`isRG`,
`isRgOn`
)
SELECT
`bga`.`confirmationNumber`,
`bga`.`applicationNumber`,
`bga`.`term`,
`bga`.`studentType`,
`bga`.`uNumber`,
`bga`.`firstName`,
`bga`.`middleName`,
`bga`.`lastName`,
`bga`.`address1`,
`bga`.`address2`,
`bga`.`city`,
`bga`.`state`,
`bga`.`country`,
`bga`.`zip`,
`bga`.`phoneNumber`,
/*Change for PROD*/
/*`bga`.`email`,*/
'usfappian@gmail.com',
`bga`.`appSubmitedOn`,
`bga`.`campus`,
`bga`.`college`,
`bga`.`department`,
`bga`.`degree`,
IF(`bga`.`usfGpa` = '', NULL, `bga`.`usfGpa`),
IF(`bga`.`transferGpa` = '', NULL, `bga`.`transferGpa`),
IF(`bga`.`overallGpa` = '', NULL, `bga`.`overallGpa`),
IF(`bga`.`isInternational` = 'FALSE', 0, 1),
`bga`.`majorCode`,
IF(`bga`.`concentrationCode` = '', NULL, `bga`.`concentrationCode`),
`bga`.`citizenshipCode`,
IF(`bga`.`isFeePaid` = 'FALSE', 0, 1),
IF(`bga`.`applicationDecision`= 'RG', 1, 0),
IF(`bga`.`applicationDecision`= 'RG', 1, 0),
`bga`.`applicationDecision`,
`bga`.`applicationDecisionDate`,
IF(`bga`.`applicationDecision`= 'RG',1,0),
IF (`bga`.`applicationDecision`= 'RG',`bga`.`applicationDecisionDate`, NULL)
FROM appiandb.BANNER_gradApplicant `bga`
/*Add only entries where applicationNumber, term, and uNumber have no existing match in UAP_graduateApplication*/
WHERE NOT EXISTS (SELECT 1
  FROM UAP_graduateApplication AS ga
  WHERE ga.applicationNumber = bga.applicationNumber AND ga.term = bga.term AND ga.uNumber = bga.uNumber
);



/*																		       Create gradAppDetail objects where they dont exist*/
INSERT INTO appiandb.UAP_gradAppDetail (`applicationId`, `status`)
SELECT
`ga`.`applicationId`,
19
FROM appiandb.UAP_graduateApplication `ga`
WHERE `ga`.`applicationId`
NOT IN (SELECT `applicationId` FROM appiandb.UAP_gradAppDetail);


/*									Update status to 20 (Department Review) wherever status = 19 (inital review) and isRG is true */
UPDATE appiandb.UAP_gradAppDetail `gad`
INNER JOIN appiandb.UAP_v_initialReview `ir`
ON `gad`.`applicationId` = `ir`.`applicationId`
SET
`gad`.`status` = 20,
`gad`.`initialReviewCompletedOn` = NOW();


/*					Update status to 22(admit), 23(deny), 25(cancel) in accordance with the subtype of it's applicationDecision code*/
UPDATE
    appiandb.UAP_gradAppDetail `gad`
        INNER JOIN
    `UAP_v_finalDecision` `fd` ON `gad`.`applicationId` = `fd`.`applicationId`
        INNER JOIN
    `UAP_reference` `ref` ON FIND_IN_SET(`ref`.`code`, `fd`.`applicationDecision`) != 0
    AND
    `ref`.`refType` = 'decisionCode'
    AND
    (
    `ref`.`subType` = 22
    OR
    `ref`.`subType` = 23
    OR
    `ref`.`subType` = 25
    )
SET
    `gad`.`status` = `ref`.`subType`;

END
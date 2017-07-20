CREATE OR REPLACE VIEW `UAP_v_programDegree` AS
    SELECT 
        `three`.`id` AS `levelThreeId`,
        `three`.`levelTwoId` AS `levelTwoId`,
		`two`.`levelOneId` AS `levelOneId`,
        `three`.`type` AS `type`,
        `three`.`director` AS `director`,
        `two`.`name` AS `name`,
        `two`.`code` AS `code`,
        (SELECT 
            GROUP_CONCAT(DISTINCT `reviewer`.`name`
                    SEPARATOR ';')
        FROM
            `appiandb`.`UAP_reviewer` `reviewer`
        WHERE
            ((`two`.`id` = `reviewer`.`levelThreeId`))) AS `reviewerList`,
        `two`.`concentration` AS `concentrationName`,
        `three`.`typeName` AS `degreeName`,
        `one`.`displayName` AS `collegeName`
    FROM
        `appiandb`.`UAP_level3` `three`
		LEFT JOIN `appiandb`.`UAP_level2` `two` ON (`three`.`levelTwoId` = `two`.`id`)
        LEFT JOIN `appiandb`.`UAP_level1` `one` ON (`two`.`levelOneId` = `one`.`id`);
		
CREATE OR REPLACE VIEW `UAP_v_graduateApplication` AS
    SELECT 
        `gradApp`.`applicationId` AS `applicationId`,
        `gradApp`.`referenceNumber` AS `referenceNumber`,
        `gradApp`.`applicationNumber` AS `applicationNumber`,
        `gradApp`.`term` AS `term`,
        `gradApp`.`studentType` AS `studentType`,
        `gradApp`.`uNumber` AS `uNumber`,
        `gradApp`.`firstName` AS `firstName`,
        `gradApp`.`middleName` AS `middleName`,
        `gradApp`.`lastName` AS `lastName`,
        `gradApp`.`address1` AS `address1`,
        `gradApp`.`address2` AS `address2`,
        `gradApp`.`city` AS `city`,
        `gradApp`.`state` AS `state`,
        `gradApp`.`country` AS `country`,
        `gradApp`.`zip` AS `zip`,
        `gradApp`.`phoneNumber` AS `phoneNumber`,
        `gradApp`.`email` AS `email`,
        `gradApp`.`appSubmittedOn` AS `appSubmittedOn`,
        `gradApp`.`campus` AS `campus`,
        `gradApp`.`college` AS `college`,
        `gradApp`.`school` AS `school`,
        `gradApp`.`department` AS `department`,
        `gradApp`.`degree` AS `degree`,
        `gradApp`.`gpa` AS `gpa`,
		`gradApp`.`transferGpa` AS `transferGpa`,
		`gradApp`.`overallGpa` AS `overallGpa`,
        `gradApp`.`isInternational` AS `isInternational`,
        `gradApp`.`majorCode` AS `majorCode`,
        `gradApp`.`concentrationCode` AS `concentrationCode`,
        `gradApp`.`isFeePaid` AS `isFeePaid`,
        IF(ISNULL(`detail`.`verifiedTranscript`),
            IF(ISNULL(`gradApp`.`hasTranscript`),
                0,
                1),
            2) AS `transcript`,
        IF(ISNULL(`detail`.`verifiedGpa`),
            IF(ISNULL(`gradApp`.`gpa`), 0, 1),
            2) AS `gpaVerification`,
        IF(ISNULL(`detail`.`verifiedTestScores`),
            IF(ISNULL(`gradApp`.`hasTestScores`),
                0,
                1),
            2) AS `testScores`,
        IF(ISNULL(`detail`.`verifiedResume`),
            IF(ISNULL(`gradApp`.`hasResume`), 0, 1),
            2) AS `resume`,
        IF(ISNULL(`detail`.`verifiedStatementOfPurpose`),
            IF(ISNULL(`gradApp`.`hasStatementOfPurpose`),
                0,
                1),
            2) AS `statementOfPurpose`,
        IF(ISNULL(`detail`.`verifiedRecLetter1`),
            IF(ISNULL(`gradApp`.`hasRecLetter1`),
                0,
                1),
            2) AS `recLetter1`,
        IF(ISNULL(`detail`.`verifiedRecLetter2`),
            IF(ISNULL(`gradApp`.`hasRecLetter2`),
                0,
                1),
            2) AS `recLetter2`,
        IF(ISNULL(`detail`.`verifiedRecLetter3`),
            IF(ISNULL(`gradApp`.`hasRecLetter3`),
                0,
                1),
            2) AS `recLetter3`,
        IF(ISNULL(`detail`.`verifiedSupplemental`),
            IF(ISNULL(`gradApp`.`hasSupplemental`),
                0,
                1),
            2) AS `supplemental`,
        `gradApp`.`isEnglishProficient` AS `isEnglishProficient`,
        `gradApp`.`isClearedForConduct` AS `isClearedForConduct`,
        `detail`.`status` AS `status`,
        `detail`.`deptRecommendation` AS `deptRecommendation`,
        `three`.`id` AS `levelThreeId`,
        `reviewCycle`.`seeReviews` AS `seeReviews`,
        `reviewCycle`.`reviewCycleId` AS `reviewCycleId`,
        `reviewCycle`.`scoringTypeId` AS `scoringType`,
        `two`.`name` AS `majorName`,
        `two`.`concentration` AS `concentrationName`,
        `three`.`typeName` AS `degreeName`,
		`one`.`displayName` AS `collegeName`,
        `gradApp`.`isRgOn` AS `isRgOn`,
        `gradApp`.`newTermApplicationId` AS `newTermApplicationId`,
        `gradApp`.`originalTerm` AS `originalTerm`
    FROM
        `UAP_graduateApplication` `gradApp`
        LEFT JOIN `UAP_gradAppDetail` `detail` ON (`gradApp`.`applicationId` = `detail`.`applicationId`)
		LEFT JOIN `UAP_reviewCycle` `reviewCycle` ON (`gradApp`.`applicationId` = `reviewCycle`.`applicationId`)
        LEFT JOIN `UAP_level1` `one` ON (`gradApp`.`college` = `one`.`name`)
		LEFT JOIN `UAP_level2` `two` ON ((`one`.`id` = `two`.`levelOneId`) AND (`gradApp`.`majorCode` = `two`.`code`) AND ((`gradApp`.`concentrationCode` <=> `two`.`concentrationCode`) OR (`gradApp`.`concentrationCode` = '' AND `two`.`concentrationCode` IS NULL)))
        LEFT JOIN `UAP_level3` `three` ON ((`two`.`id` = `three`.`levelTwoId`) AND (`gradApp`.`degree` = `three`.`type`));

CREATE OR REPLACE VIEW `UAP_v_directorDashApplication` AS
    SELECT 
        `gradApp`.`applicationId` AS `applicationId`,
        CONCAT(`gradApp`.`firstName`,
                ' ',
                `gradApp`.`lastName`) AS `name`,
        `refStatus`.`displayValue` AS `status`,
        `gradApp`.`isFeePaid` AS `isFeePaid`,
        `gradApp`.`appSubmittedOn` AS `appSubmittedOn`,
        `gradApp`.`gpa` AS `gpa`,
		`gradApp`.`transferGpa` AS `transferGpa`,
		`gradApp`.`overallGpa` AS `overallGpa`,
        `gradApp`.`college` AS `college`,
        `gradApp`.`majorCode` AS `major`,
        `gradApp`.`degree` AS `degree`,
        `gradApp`.`term` AS `term`,
        IF(ISNULL(`cycle`.`scoringTypeId`),
            `three`.`scoringTypeId`,
            `cycle`.`scoringTypeId`) AS `scoringTypeId`,
        `cycle`.`reviewCycleId` AS `reviewCycleId`,
        `refDeptDecision`.`displayValue` AS `deptDecision`,
        `refFinalDecision`.`displayValue` AS `finalDecision`,
        IF(ISNULL(`detail`.`verifiedTranscript`),
            IF(ISNULL(`gradApp`.`hasTranscript`),
                0,
                1),
            2) AS `transcript`,
        IF(ISNULL(`detail`.`verifiedGpa`),
            IF(ISNULL(`gradApp`.`gpa`), 0, 1),
            2) AS `gpaVerification`,
        IF(ISNULL(`detail`.`verifiedTestScores`),
            IF(ISNULL(`gradApp`.`hasTestScores`),
                0,
                1),
            2) AS `testScores`,
        IF(ISNULL(`detail`.`verifiedResume`),
            IF(ISNULL(`gradApp`.`hasResume`), 0, 1),
            2) AS `resume`,
        IF(ISNULL(`detail`.`verifiedStatementOfPurpose`),
            IF(ISNULL(`gradApp`.`hasStatementOfPurpose`),
                0,
                1),
            2) AS `statementOfPurpose`,
        IF(ISNULL(`detail`.`verifiedRecLetter1`),
            IF(ISNULL(`gradApp`.`hasRecLetter1`),
                0,
                1),
            2) AS `recLetter1`,
        IF(ISNULL(`detail`.`verifiedRecLetter2`),
            IF(ISNULL(`gradApp`.`hasRecLetter2`),
                0,
                1),
            2) AS `recLetter2`,
        IF(ISNULL(`detail`.`verifiedRecLetter3`),
            IF(ISNULL(`gradApp`.`hasRecLetter3`),
                0,
                1),
            2) AS `recLetter3`,
        IF(ISNULL(`detail`.`verifiedSupplemental`),
            IF(ISNULL(`gradApp`.`hasSupplemental`),
                0,
                1),
            2) AS `supplemental`,
        `gradApp`.`isEnglishProficient` AS `isEnglishProficient`,
        `gradApp`.`isClearedForConduct` AS `isClearedForConduct`,
        `three`.`id` AS `levelThreeId`,
        COUNT(DISTINCT `gradScoreList`.`reviewer`) AS `reviewCount`,
		COUNT(DISTINCT `reviewer`.`name`) AS `reviewerCount`,		
		(SELECT 
			SUM(`gradScoreList`.`ratingScore`)
		FROM
			`UAP_gradScore` `gradScoreList`
		WHERE
			(`cycle`.`reviewCycleId` = `gradScoreList`.`reviewCycleId`)) AS `scoreList`,
        `two`.`name` AS `majorName`,
        `two`.`concentration` AS `concentrationName`,
        `three`.`typeName` AS `degreeName`,
        `gradApp`.`uNumber` AS `uNumber`,
	`gradApp`.`applicationNumber` AS `applicationNumber`,
    `gradApp`.`concentrationCode` AS `concentration`
    FROM
        `UAP_graduateApplication` `gradApp`
        LEFT JOIN `UAP_gradAppDetail` `detail` ON (`gradApp`.`applicationId` = `detail`.`applicationId`)
        LEFT JOIN `UAP_reference` `refStatus` ON (`detail`.`status` = `refStatus`.`refId`)
        LEFT JOIN `UAP_reference` `refDeptDecision` ON (`detail`.`deptRecommendation` = `refDeptDecision`.`refId`)
        LEFT JOIN `UAP_reference` `refFinalDecision` ON (`detail`.`finalDecision` = `refFinalDecision`.`refId`)
        LEFT JOIN `UAP_level1` `one` ON (`gradApp`.`college` = `one`.`name`)
		LEFT JOIN `UAP_level2` `two` ON ((`one`.`id` = `two`.`levelOneId`) AND (`gradApp`.`majorCode` = `two`.`code`) AND ((`gradApp`.`concentrationCode` <=> `two`.`concentrationCode`) OR (`gradApp`.`concentrationCode` = '' AND `two`.`concentrationCode` IS NULL)))
        LEFT JOIN `UAP_level3` `three` ON ((`two`.`id` = `three`.`levelTwoId`) AND (`gradApp`.`degree` = `three`.`type`))
        LEFT JOIN `UAP_reviewCycle` `cycle` ON (`gradApp`.`applicationId` = `cycle`.`applicationId`)
		LEFT JOIN `UAP_gradScore` `gradScoreList` ON (`cycle`.`reviewCycleId` = `gradScoreList`.`reviewCycleId`)
		LEFT JOIN `UAP_reviewer` `reviewer` ON (`three`.`id` = `reviewer`.`levelThreeId`)
	GROUP BY `gradApp`.`applicationId`
		;


CREATE OR REPLACE VIEW `UAP_v_facultyReviewer` AS
    SELECT 
        `gradApp`.`applicationId` AS `applicationId`,
        `three`.`id` AS `levelThreeId`,
        `three`.`type` AS `levelThreeName`,
        `two`.`name` AS `levelTwoName`,
        IF(ISNULL(`cycle`.`seeReviews`),
            0,
            `cycle`.`seeReviews`) AS `seeReviews`,
        `refStat`.`displayValue` AS `applicationStatus`,
        `gradApp`.`firstName` AS `firstName`,
        `gradApp`.`lastName` AS `lastName`,
        `gradApp`.`term` AS `term`,
        GROUP_CONCAT(DISTINCT `gradScoreList`.`reviewer`
            SEPARATOR ';') AS `reviewerList`,
        (SELECT 
                GROUP_CONCAT(`gradScoreList`.`ratingScore`
                        SEPARATOR ';')
            FROM
                `UAP_gradScore` `gradScoreList`
            WHERE
                (`cycle`.`reviewCycleId` = `gradScoreList`.`reviewCycleId`)) AS `scoreList`,
        COUNT(DISTINCT `gradScoreList`.`reviewer`) AS `reviewCount`,
        COUNT(DISTINCT `reviewer`.`name`) AS `reviewerCount`,
        IF(ISNULL(`cycle`.`scoringTypeId`),
            `three`.`scoringTypeId`,
            `cycle`.`scoringTypeId`) AS `scoringTypeId`,
        `two`.`name` AS `majorName`,
        `two`.`concentration` AS `concentrationName`,
        `three`.`typeName` AS `degreeName`
    FROM
        `UAP_graduateApplication` `gradApp`
            LEFT JOIN
        `UAP_gradAppDetail` `detail` ON (`gradApp`.`applicationId` = `detail`.`applicationId`)
            LEFT JOIN
        `UAP_level1` `one` ON (`gradApp`.`college` = `one`.`name`)
            LEFT JOIN
        `UAP_level2` `two` ON ((`one`.`id` = `two`.`levelOneId`)
            AND (`gradApp`.`majorCode` = `two`.`code`)
            AND ((`gradApp`.`concentrationCode` <=> `two`.`concentrationCode`) OR (`gradApp`.`concentrationCode` = '' AND `two`.`concentrationCode` IS NULL)))
            LEFT JOIN
        `UAP_level3` `three` ON ((`two`.`id` = `three`.`levelTwoId`)
            AND (`gradApp`.`degree` = `three`.`type`))
            LEFT JOIN
        `UAP_reviewCycle` `cycle` ON ((`gradApp`.`applicationId` = `cycle`.`applicationId`)
            AND (`cycle`.`isActive` = 1))
            LEFT JOIN
        `UAP_gradScore` `gradScoreList` ON (`cycle`.`reviewCycleId` = `gradScoreList`.`reviewCycleId`)
            LEFT JOIN
        `UAP_reference` `refStat` ON (`detail`.`status` = `refStat`.`refId`)
            LEFT JOIN
        `UAP_reviewer` `reviewer` ON (`three`.`id` = `reviewer`.`levelThreeId`)
    GROUP BY `gradApp`.`applicationId`;

CREATE OR REPLACE VIEW `UAP_v_initialReview` AS
    SELECT 
        `application`.`applicationId` AS `applicationId`,
        `application`.`isRG` AS `isRG`,
        `gradAppDetail`.`status` AS `statusId`
    FROM
        `appiandb`.`UAP_graduateApplication` `application`
		LEFT JOIN `appiandb`.`UAP_gradAppDetail` `gradAppDetail` ON (`application`.`applicationId` = `gradAppDetail`.`applicationId`)
	WHERE
		`application`.`isRG` = 1
	AND
		`gradAppDetail`.`status` = 19;
        
CREATE OR REPLACE VIEW `UAP_v_finalDecision` AS
	SELECT 
        `application`.`applicationId` AS `applicationId`,
        `application`.`applicationDecision` AS `applicationDecision`,
        `gradAppDetail`.`status` AS `statusId`
    FROM
        `appiandb`.`UAP_graduateApplication` `application`
		LEFT JOIN `appiandb`.`UAP_gradAppDetail` `gradAppDetail` ON (`application`.`applicationId` = `gradAppDetail`.`applicationId`)
	WHERE
		`gradAppDetail`.`status` < 22
	AND
		`application`.`applicationDecision` IS NOT NULL; 

CREATE OR REPLACE VIEW `UAP_v_milestoneDuration` AS
	SELECT 
		`application`.`applicationId` AS `applicationId`,
		`application`.`term` AS `term`,
		`application`.`appSubmittedOn` AS `appSubmittedOn`,
		`application`.`college` AS `college`,
		`one`.`displayName` AS `collegeDisplayName`,
		`application`.`degree` AS `degree`,
		`three`.`typeName` AS `degreeName`,
		`application`.`majorCode` AS `majorCode`,
		`two`.`name` AS `majorName`,
		`application`.`concentrationCode` AS `concentrationCode`,
		`two`.`concentration` AS `concentrationName`,
		`gradAppDetail`.`initialReviewCompletedOn` AS `initialReviewCompletedOn`,
		`gradAppDetail`.`deptRecommendationOn` AS `deptRecommendationOn`,
		`gradAppDetail`.`finalDecisionOn` AS `finalDecisionOn`,
		DATEDIFF(`gradAppDetail`.`initialReviewCompletedOn`,`application`.`appSubmittedOn`) AS `initialReviewDuration`,
		DATEDIFF(`gradAppDetail`.`deptRecommendationOn`,`application`.`isRgOn`) AS `directorReviewDuration`,
		DATEDIFF(`gradAppDetail`.`finalDecisionOn`,`gradAppDetail`.`deptRecommendationOn`) AS `finalReviewDuration`,
		DATEDIFF(`gradAppDetail`.`finalDecisionOn`,`application`.`appSubmittedOn`) AS `totalDuration`
	FROM
		`appiandb`.`UAP_graduateApplication` `application`
			LEFT JOIN `appiandb`.`UAP_gradAppDetail` `gradAppDetail` ON `application`.`applicationId` = `gradAppDetail`.`applicationId`
			LEFT JOIN `appiandb`.`UAP_level1` `one` ON `application`.`college` = `one`.`name`
			LEFT JOIN `appiandb`.`UAP_level2` `two` ON `application`.`majorCode` = `two`.`code` AND ((`application`.`concentrationCode` <=> `two`.`concentrationCode`) OR (`application`.`concentrationCode` = '' AND `two`.`concentrationCode` IS NULL)) AND `one`.`id` = `two`.`levelOneId`
			LEFT JOIN `appiandb`.`UAP_level3` `three` ON `application`.`degree` = `three`.`type` AND `two`.`id` = `three`.`levelTwoId`;

CREATE OR REPLACE VIEW `UAP_v_admissionsByProgram` AS
     SELECT 
		CONCAT(`three`.`id`, "-", `graduateApplication`.`term`) AS `id`,
        `three`.`id` AS `levelThreeId`,
        `three`.`levelTwoId` AS `levelTwoId`,
        `two`.`levelOneId` AS `levelOneId`,
        `three`.`type` AS `type`,
        `three`.`director` AS `director`,
        `two`.`name` AS `majorName`,
        `two`.`code` AS `majorCode`,
        `two`.`concentrationCode` AS `concentrationCode`,
        IF(ISNULL(`two`.`concentration`),
            'None',
            `two`.`concentration`) AS `concentrationName`,
        `three`.`typeName` AS `degreeName`,
        `three`.`type` AS `degreeCode`,
        `one`.`displayName` AS `collegeName`,
        `one`.`name` AS `collegeCode`,
        `three`.`numberOfPositions` AS `numberOfPositions`,
        `graduateApplication`.`term` AS `term`,
        COUNT(`admit`.`applicationId`) AS `admit`,
        COUNT(`deny`.`applicationId`) AS `deny`,
        COUNT(`waitlist`.`applicationId`) AS `waitlist`,
        COUNT(`gradAppDetail`.`applicationId`) AS `pipeline`,
        (COUNT(`admit`.`applicationId`)+COUNT(`deny`.`applicationId`))/CAST(COUNT(`gradAppDetail`.`applicationId`) AS DECIMAL (9,2)) AS `throughput`,
	`three`.`numberOfPositions` - COUNT(`deny`.`applicationId`) - COUNT(`admit`.`applicationId`) AS `spotsLeft`
    FROM
        `UAP_level3` `three`
            LEFT JOIN
        `UAP_level2` `two` ON `three`.`levelTwoId` = `two`.`id`
            LEFT JOIN
        `UAP_level1` `one` ON `two`.`levelOneId` = `one`.`id`
            LEFT JOIN
        `UAP_v_graduateApplication` `graduateApplication` ON `graduateApplication`.`levelThreeId` = `three`.`id`
            LEFT JOIN
        `UAP_gradAppDetail` `admit` ON `admit`.`applicationId` = `graduateApplication`.`applicationId`
            AND `admit`.`deptRecommendation` = 16
            LEFT JOIN
        `UAP_gradAppDetail` `deny` ON `deny`.`applicationId` = `graduateApplication`.`applicationId`
            AND `deny`.`deptRecommendation` = 17
            LEFT JOIN
        `UAP_gradAppDetail` `waitlist` ON `waitlist`.`applicationId` = `graduateApplication`.`applicationId`
            AND `waitlist`.`deptRecommendation` = 18
			LEFT JOIN
		`UAP_gradAppDetail` `gradAppDetail` on `gradAppDetail`.`applicationId` = `graduateApplication`.`applicationId`
        AND `gradAppDetail`.`status` = 19
    WHERE
        `graduateApplication`.`term` IS NOT NULL
    GROUP BY `three`.`id` , `graduateApplication`.`term`;
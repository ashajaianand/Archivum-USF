
    drop table if exists `UAP_level1`;

    drop table if exists `UAP_level2`;

    drop table if exists `UAP_level3`;

    drop table if exists `UAP_reference`;

    drop table if exists `UAP_requiredChecklist`;

    drop table if exists `UAP_reviewer`;
    
    drop table if exists `UAP_applicationNote`;
    
    drop table if exists `UAP_graduateApplication`;
	
	drop table if exists `UAP_gradAppDetail`;
	
	drop table if exists `UAP_gradScore`;
	
	drop table if exists `UAP_reviewCycle`;
	
	CREATE TABLE `UAP_reviewCycle` (
	  `reviewCycleId` int(11) NOT NULL AUTO_INCREMENT,
	  `applicationId` int(11) DEFAULT NULL,
	  `createdOn` datetime DEFAULT NULL,
	  `levelThreeId` int(11) DEFAULT NULL,
	  `isActive` tinyint(1) DEFAULT NULL,
	  `scoringTypeId` int(11) DEFAULT NULL,
	  `seeReviews` tinyint(1) DEFAULT '0',
	  PRIMARY KEY (`reviewCycleId`)
	) ENGINE=InnoDB;

	CREATE TABLE `UAP_gradScore` (
	  `scoreId` int(11) NOT NULL AUTO_INCREMENT,
	  `ratingScore` int(11) DEFAULT NULL,
	  `reviewer` varchar(255) DEFAULT NULL,
	  `createdOn` datetime DEFAULT NULL,
	  `comment` varchar(255) DEFAULT NULL,
	  `reviewCycleId` int(11) DEFAULT NULL,
	  `isRecommended` tinyint(1) DEFAULT NULL,
	  PRIMARY KEY (`scoreId`)
	) ENGINE=InnoDB;
	
   CREATE TABLE `UAP_gradAppDetail` (
	  `applicationId` int(11) NOT NULL AUTO_INCREMENT,
	  `deptRecommendation` int(11) DEFAULT NULL,
	  `deptRecommendationBy` varchar(255) DEFAULT NULL,
	  `milestone` int(11) DEFAULT NULL,
	  `status` int(11) DEFAULT NULL,
	  `finalDecisionOn` datetime DEFAULT NULL,
	  `finalDecisionBy` varchar(255) DEFAULT NULL,
	  `isAdmissionException` varchar(255) DEFAULT NULL,
	  `exceptionComment` varchar(255) DEFAULT NULL,
	  `outcome` int(11) DEFAULT NULL,
	  `deptRecommendationOn` datetime DEFAULT NULL,
	  `initialReviewCompletedOn` datetime DEFAULT NULL,
	  `verifiedTranscript` tinyint(4) DEFAULT NULL,
	  `verifiedTranscriptOn` datetime DEFAULT NULL,
	  `verifiedTranscriptBy` varchar(255) DEFAULT NULL,
	  `verifiedGpa` tinyint(4) DEFAULT NULL,
	  `verifiedGpaOn` datetime DEFAULT NULL,
	  `verifiedGpaBy` varchar(255) DEFAULT NULL,
	  `verifiedTestScores` tinyint(4) DEFAULT NULL,
	  `verifiedTestScoresOn` datetime DEFAULT NULL,
	  `verifiedTestScoresBy` varchar(255) DEFAULT NULL,
	  `verifiedResume` tinyint(4) DEFAULT NULL,
	  `verifiedResumeOn` datetime DEFAULT NULL,
	  `verifiedResumeBy` varchar(255) DEFAULT NULL,
	  `verifiedStatementOfPurpose` tinyint(4) DEFAULT NULL,
	  `verifiedStatementOfPurposeOn` datetime DEFAULT NULL,
	  `verifiedStatementOfPurposeBy` varchar(255) DEFAULT NULL,
	  `verifiedRecLetter1` tinyint(4) DEFAULT NULL,
	  `verifiedRecLetter1On` datetime DEFAULT NULL,
	  `verifiedRecLetter1By` varchar(255) DEFAULT NULL,
	  `verifiedRecLetter2` tinyint(4) DEFAULT NULL,
	  `verifiedRecLetter2On` datetime DEFAULT NULL,
	  `verifiedRecLetter2By` varchar(255) DEFAULT NULL,
	  `verifiedRecLetter3` tinyint(4) DEFAULT NULL,
	  `verifiedRecLetter3On` datetime DEFAULT NULL,
	  `verifiedRecLetter3By` varchar(255) DEFAULT NULL,
	  `verifiedSupplemental` tinyint(4) DEFAULT NULL,
	  `verifiedSupplementalOn` datetime DEFAULT NULL,
	  `verifiedSupplementalBy` varchar(255) DEFAULT NULL,
	  PRIMARY KEY (`applicationId`)
	) ENGINE=InnoDB;

    
    CREATE TABLE `UAP_applicationNote` (
    `noteId` INT(11) NOT NULL AUTO_INCREMENT,
    `applicationId` int(11) DEFAULT NULL,
    `note` VARCHAR(255) DEFAULT NULL,
    `createdBy` VARCHAR(255) DEFAULT NULL,
    `createdOn` DATETIME DEFAULT NULL,
    PRIMARY KEY (`noteId`)
	)  ENGINE=INNODB;

	CREATE TABLE `UAP_graduateApplication` (
	  `applicationId` int(11) NOT NULL AUTO_INCREMENT,
	  `referenceNumber` varchar(255) DEFAULT NULL,
	  `term` varchar(255) DEFAULT NULL,
	  `studentType` varchar(255) DEFAULT NULL,
	  `uNumber` varchar(255) DEFAULT NULL,
	  `firstName` varchar(255) DEFAULT NULL,
	  `middleName` varchar(255) DEFAULT NULL,
	  `lastName` varchar(255) DEFAULT NULL,
	  `address1` varchar(255) DEFAULT NULL,
	  `address2` varchar(255) DEFAULT NULL,
	  `city` varchar(255) DEFAULT NULL,
	  `state` varchar(255) DEFAULT NULL,
	  `country` varchar(255) DEFAULT NULL,
	  `zip` varchar(255) DEFAULT NULL,
	  `phoneNumber` varchar(255) DEFAULT NULL,
	  `email` varchar(255) DEFAULT NULL,
	  `appSubmittedOn` datetime DEFAULT NULL,
	  `campus` varchar(255) DEFAULT NULL,
	  `college` varchar(255) DEFAULT NULL,
	  `school` varchar(255) DEFAULT NULL,
	  `department` varchar(255) DEFAULT NULL,
	  `degree` varchar(255) DEFAULT NULL,
	  `gpa` decimal(19,2) DEFAULT NULL,
	  `isInternational` tinyint(1) DEFAULT NULL,
	  `majorCode` varchar(255) DEFAULT NULL,
	  `isFeePaid` tinyint(1) DEFAULT NULL,
	  `hasTranscript` tinyint(1) DEFAULT NULL,
	  `hasTestScores` tinyint(1) DEFAULT NULL,
	  `hasResume` tinyint(1) DEFAULT NULL,
	  `hasStatementOfPurpose` tinyint(1) DEFAULT NULL,
	  `hasRecLetter1` tinyint(1) DEFAULT NULL,
	  `hasRecLetter2` tinyint(1) DEFAULT NULL,
	  `hasRecLetter3` tinyint(1) DEFAULT NULL,
	  `hasSupplemental` tinyint(1) DEFAULT NULL,
	  `hasOfficialTranscript` tinyint(1) DEFAULT NULL,
	  `hasOfficialTestScores` tinyint(1) DEFAULT NULL,
	  `concentrationCode` varchar(255) DEFAULT NULL,
	  `applicationNumber` varchar(255) DEFAULT NULL,
	  `isEnglishProficient` tinyint(4) DEFAULT NULL,
	  `isEnglishProficientOn` datetime DEFAULT NULL,
	  `isEnglishProficientBy` varchar(255) DEFAULT NULL,
	  `isClearedForConduct` tinyint(4) DEFAULT NULL,
	  `isClearedForConductOn` datetime DEFAULT NULL,
	  `isClearedForConductBy` varchar(255) DEFAULT NULL,
	  `applicationDecision` varchar(255) DEFAULT NULL,
	  `applicationDecisionDate` datetime DEFAULT NULL,
	  `isRG` tinyint(4) DEFAULT NULL,
	  `citizenshipCode` varchar(255) DEFAULT NULL,
      `isRgOn` datetime DEFAULT NULL,
	`transferGpa` double DEFAULT NULL,
	`overallGpa` double DEFAULT NULL,
	`newTermApplicationId` int(11) DEFAULT NULL,
	`originalTerm` varchar(255) DEFAULT NULL,
	  PRIMARY KEY (`applicationId`)
	) ENGINE=InnoDB AUTO_INCREMENT=1;

    create table `UAP_level1` (
        `id` integer not null auto_increment,
        `name` varchar(255),
        `displayName` varchar(255),
        primary key (`id`)
    ) ENGINE=InnoDB;

    create table `UAP_level2` (
        `id` integer not null auto_increment,
        `levelOneId` integer,
        `name` varchar(255),
        `code` varchar(255),
        `concentration` varchar(255),
        `concentrationCode` varchar(255),
        primary key (`id`)
    ) ENGINE=InnoDB;

    create table `UAP_level3` (
        `id` integer not null auto_increment,
        `levelTwoId` integer,
        `type` varchar(255),
        `typeName` varchar(255),
        `director` varchar(255),
        `numberOfPositions` integer,
        `scoringTypeId` integer,
        `admissionStyleId` integer,
        `showTranscript` tinyint(1) DEFAULT NULL,
		`showGPA` tinyint(1) DEFAULT NULL,
		`showTestScore` tinyint(1) DEFAULT NULL,
		`showResume` tinyint(1) DEFAULT NULL,
		`showWritingSample` tinyint(1) DEFAULT NULL,
		`showRec1` tinyint(1) DEFAULT NULL,
		`showRec2` tinyint(1) DEFAULT NULL,
		`showRec3` tinyint(1) DEFAULT NULL,
		`showSupplemental` tinyint(1) DEFAULT NULL,
        primary key (`id`)
    ) ENGINE=InnoDB;
	
	create table `UAP_designee` (
        `id` integer not null auto_increment,
        `levelOneId` integer,
        `uNumber` varchar(255),
        primary key (`id`)
    ) ENGINE=InnoDB;

    create table `UAP_reference` (
        `refId` integer not null auto_increment,
        `refType` varchar(255),
        `subType` integer,
        `code` varchar(255),
        `displayValue` varchar(600),
        `description` varchar(255),
        `displayOrder` integer,
        `createOn` datetime,
        `createBy` varchar(255),
        `updateOn` datetime,
        `updateBy` varchar(255),
        `isActive` boolean,
        primary key (`refId`)
    ) ENGINE=InnoDB;

    create table `UAP_requiredChecklist` (
        `id` integer not null auto_increment,
        `levelThreeId` integer,
        `checklistItemId` integer,
        primary key (`id`)
    ) ENGINE=InnoDB;

    create table `UAP_reviewer` (
        `id` integer not null auto_increment,
        `levelThreeId` integer,
        `name` varchar(255),
        primary key (`id`)
    ) ENGINE=InnoDB;
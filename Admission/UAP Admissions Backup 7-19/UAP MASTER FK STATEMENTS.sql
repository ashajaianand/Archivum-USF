ALTER TABLE UAP_applicationNote ADD FOREIGN KEY (applicationId) REFERENCES UAP_graduateApplication(applicationId);
ALTER TABLE UAP_designee ADD FOREIGN KEY (levelOneId) REFERENCES UAP_level1(id);
ALTER TABLE UAP_gradScore ADD FOREIGN KEY (reviewCycleId) REFERENCES UAP_reviewCycle(reviewCycleId);
ALTER TABLE UAP_level2 ADD FOREIGN KEY (levelOneId) REFERENCES UAP_level1(id);
CREATE INDEX index_level1Name ON UAP_level1 (name);
CREATE INDEX index_level2Codes ON UAP_level2 (code, concentrationCode);
ALTER TABLE UAP_level3 ADD FOREIGN KEY (levelTwoId) REFERENCES UAP_level2(id);
ALTER TABLE UAP_reviewCycle ADD FOREIGN KEY (applicationId) REFERENCES UAP_graduateApplication(applicationId);
ALTER TABLE UAP_reviewer ADD FOREIGN KEY (levelThreeId) REFERENCES UAP_level3(id);

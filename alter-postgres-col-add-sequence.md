# alter-postgres-col-add-sequence
POSTGRES - ALTER table and add an existing sequence to an existing column . restart seq to avoif any PKey conflict
ALTER TABLE reviewersettings ALTER COLUMN id SET DEFAULT nextval('reviewersettings_id_seq');
ALTER SEQUENCE reviewersettings_id_seq RESTART WITH 1000;

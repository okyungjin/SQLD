-- CREATE TABLE
--- 생성 시점에 PK, FK 정의
CREATE TABLE PLAYER (
    PLAYER_ID CHAR(7) NOT NULL,
    PLAYER_NAME VHARCHAR2(20) NOT NULL,
    TEAM_ID CHAR(3) NOT NULL,
    NICKNAME VHARCHAR2(30),
    CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID),
    CONSTRAINT TEAM_ID FOREIGN KEY (PLAYER) REFERENCES TEAM(TEAM_ID)
);

-- ALTER TABLE
   ALTER TABLE PLAYER
ADD CONSTRAINT PLAYER_PK
   PRIMARY KEY (PLAYER_ID);

   ALTER TABLE PLAYER
ADD CONSTRAINT PLAYER_FK
   FOREIGN KEY (TEAM_ID)
    REFERENCES TEAM(TEAM_ID);

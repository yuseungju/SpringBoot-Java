# Spring
스타트업 매물중개 서비스 


1. 요약 
XML,JS,JAVA 소스만 활용가능 
CSS없음(공유 불가)


2. 설정 
C:\Users\user\Desktop\git작업\Gnbang-Server\src\main\resources\db
sql문 3개 실행 필요 
My SQL 서버 구축후
=> init.sql 으로 테이블정의
=> base_data.sql 으로 기본 권한 데이터, 매물정보 데이터 추가 
=> insert_memberRole.sql로 유저 권한 test추가 


3. 중개사.exe 파일 
\src\main\resources\static\application에 중개사.exe 파일이 필요함 
\src\main\resources\static\application\AgentMac.zip 을 압축해제 
-> war로 배포 
-> 윈도우 installer exe파일로 생성
-> 중개사.exe파일이름으로 해당경로에 저장 
-> 중개사 인증파일 다운로드시 중개사.exe를 다운(Mac주소 인증)

* AgentMac.zip도 하나의 스프링 웹 프로젝트로서 war배포하여 윈도우 background에서 실행되는 원리 

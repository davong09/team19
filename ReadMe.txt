[프로젝트 개요]
깃 연결 방법 터득함!! 다른 사람들꺼는 왜 안 되는걸까?..
[주의사항]
1. resources 폴더 아래에 매퍼XML 위치할 경로 생성시 com 폴더 생성 - javalab 폴더생성과 같이 단계적으로 한단계씩 생성할것.


[1] chap04_mybatis_logback 의 리팩토링 버전

	1. 메소드명, URL 매핑 문자열, JSP 페이지명 컨벤션 설정
	
		1)	게시물 목록 조회(get)
		URL 매핑 문자열: /board/list
		컨트롤러 메소드명: listBoard()
		JSP 파일 이름: boardList.jsp
		
		2)	게시물 내용보기(get)
		URL 매핑 문자열: /board/detail
		컨트롤러 메소드명: getBoard
		JSP 파일 이름: boardDetail.jsp
	
		3)	게시물 등록 폼 (get)
		URL 매핑 문자열: /board/create
		컨트롤러 메소드명: createBoard
		JSP 파일 이름: boardCreate.jsp
	
		4)	게시물 등록(저장)(post)
		URL 매핑 문자열: /board/create
		컨트롤러 메소드명: createBoard
		 
		5)	게시물 수정(get)
		URL 매핑 문자열: /board/update
		컨트롤러 메소드명: updateBoard
		JSP 파일 이름: boardUpdate.jsp
		
		6)	게시물 수정(저장)(post)
		URL 매핑 문자열: /board/update
		컨트롤러 메소드명: updateBoard
	
		7)	게시물 삭제(post)
		URL 매핑 문자열: /board/delete
		컨트롤러 메소드명: deleteBoard

	2 database.properties 파일 생성

	3. root-context.xml
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<!-- 속성으로 DataSource가 필요함. -->
		<property name="dataSource" ref="dataSource"></property>
		<!-- 별명파일(Alias) - typeAliasesPackage 선언으로 대신해서 주석처리 -->
		<!-- <property name="configLocation" value="classpath:/config/sqlMapConfig.xml" /> -->		
		<!-- 매퍼 xml(쿼리문 모아놓은 파일) -->
		<!-- mapperLocations : 쿼리문을 모아놓은 매퍼xml의 위치를 알려주는 역할.	 
			classpath: src/main/resources 폴더를 가리킨다. 
			*Mapper.xml : 와일드 카드, 무슨무슨~Mapper.xml로 끝나는 파일은 모두 매퍼XML로 스캔한다. 
			classpath:* : *를 붙이면 여러 패키지에서 매퍼를 검색한다. -->
		<property name="mapperLocations" 
					value="classpath*:/com/javalab/board/mapper/*Mapper.xml" />					
		<!-- 매퍼XML에서 사용할 vo 설정
			원래는 sqlMapConfig.xml에서 별칭을 만들고 그 별칭을 쿼리문에서
			사용한다. 하지만 다음과 같이 typeAliasesPackage 속성을 주게 되면
			그 경로에 있는 vo 클래스들은 자동으로 클래스 이름만으로 쿼리문에서 사용가능. -->					
		<property name="typeAliasesPackage" value="com.javalab.board.vo" />
		
		<!-- mapUnderscoreToCamelCase 설정 
			 ex) 데이터베이스 조회결과 member_id -> 도메인 객체의 memberID 속성으로 자동변환 --> 
		<property name="configuration">
			<bean class="org.apache.ibatis.session.Configuration">
				<property name="mapUnderscoreToCamelCase" value="true"></property>
			</bean>
		</property>				
	</bean>
	
	4. public void testGetBoard() 테스트 완료할것
	4.1. 로그백 로그 레벨 전체적으로 다시 확인할것.
	
	5. 매퍼인터페이스, 매퍼XML 리팩토링 작업후 단위테스트
	
	6. 서비스 레이어 리팩토링 작업후 단위테스트
	
	7. 컨트롤러 리팩토링 작업후 단위테스트
	 1) this.mockMvc.perform(get("/board/detail").param("bno", "1")) 
	
	8. logback 프로젝트에서 jsp 복사후 이름 변경
	 1) boardCreate.jsp <-- boardInsertForm.jsp
	 2) boardUpdate.jsp <-- boardUpdateForm.jsp
	 3) login.jsp <-- loginForm.jsp
	
	9. servlet-context.xml
		1) component-scan 경로 변경
		2) 파일 업로드 의존성 추가 
	    <!-- Commons FileUpload -->
	    <dependency>
	        <groupId>commons-fileupload</groupId>
	        <artifactId>commons-fileupload</artifactId>
	        <version>1.3.3</version>
	    </dependency>
	    
	    <!-- Commons IO -->
	    <dependency>
	        <groupId>commons-io</groupId>
	        <artifactId>commons-io</artifactId>
	        <version>2.6</version>
	    </dependency>

	2. 매퍼XML의 매퍼인터페이스 네임스페이스 변경
	5. 매퍼 인터페이스 메소드명 변경(리팩토링)
	
	6. 매퍼XML 리택토링
	
	7. 서비스 레이어 리팩토링
	
	8. 컨트롤러 레이어 리팩토링
	
	9. jsp 변경
	 1) boardList.jsp 수정
	 2) boardDetail.jsp 수정
	 3) boardUpdate.jsp 수정
	 
	10. 로그인 컨트롤러 수정
	
	11. 작업 끝나면 프로젝트 구동해서 성공여부 확인 후 다음 작업
	
	12. mapUnderScore 설정(중간에 포함)
	
	13. 회원가입 기능 추가
	 1) MemberVo
	 2) member.jsp
	 3) MemberMapper.xml
	 4) Member 인터페이스
	 5) 서비스레이어
	 6) 컨트롤러 레이어

	※ 중요
	 로그인 할때 사용자의 아이디와 비밀번호 갖고 가는 방법
	 URL의 일관성 부족
	URL 변경 없음: 직접 JSP 페이지로 이동하면 클라이언트 브라우저의 URL이 /login으로 남지 않습니다. 이는 사용자가 페이지를 새로 고침하거나 브라우저의 뒤로 가기 버튼을 눌렀을 때, 이전 요청이 다시 제출되는 문제를 일으킬 수 있습니다.
	사용자 혼란: 사용자는 여전히 /login 페이지에 있다고 생각하지만 실제로는 다른 상태가 될 수 있습니다.
	2. PRG 패턴 위반
	Post-Redirect-Get 패턴: PRG 패턴은 폼 제출 후 리다이렉트하여 새로 고침 시 데이터의 중복 제출을 방지하는 방법입니다. PRG 패턴을 사용하면 사용자가 페이지를 새로 고침할 때 중복된 POST 요청이 발생하지 않습니다.
	중복 제출: 직접 포워딩하면 사용자가 페이지를 새로 고침할 때 동일한 POST 요청이 반복될 수 있으며, 이는 데이터 중복 제출 문제를 일으킬 수 있습니다.
	3. 세션 데이터 관리의 복잡성
	Flash Attributes 사용 불가: RedirectAttributes를 사용하여 리다이렉트된 페이지에 일회성 데이터를 전달할 수 있지만, 직접 포워딩하는 경우 이러한 편리한 방법을 사용할 수 없습니다. 대신, 세션에 데이터를 저장하거나 모델에 직접 추가해야 합니다.
	데이터 유지 관리: 세션을 통해 데이터를 관리하면 메모리 사용이 증가할 수 있으며, 세션 관리를 위한 추가 코드가 필요할 수 있습니다.

    14. 게시물 작성시 포인트 지급(1점) : 트랜잭션 적용
     1) 컬럼 추가
     2) BoardServiceImpl에 다음 추가	
	   	@Autowired
	    private MemberMapper memberMapper;
	    @Override
		@Transactional
		public int createBoard(BoardVo boardVo) {
			// 게시물 저장 처리
			int result = boardMapper.createBoard(boardVo);
		    if (result > 0) {
		    	// 게시물 작성 회원 포인트 증가
		        memberMapper.updateMemberPoint(boardVo.getMemberId());
		    }
		    return result;
		}
	15. SelectKey 적용
	 
	14. 파일 업로드
		<!-- Commons FileUpload -->
	    <dependency>
	        <groupId>commons-fileupload</groupId>
	        <artifactId>commons-fileupload</artifactId>
	        <version>1.3.3</version>
	    </dependency>
	    
	    <!-- Commons IO -->
	    <dependency>
	        <groupId>commons-io</groupId>
	        <artifactId>commons-io</artifactId>
	        <version>2.6</version>
	    </dependency>	

	 15. 스프링 인터셉터   
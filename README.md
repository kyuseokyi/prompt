# AI PROMPT PROJECT

규석님의 `prompt` 저장소(중앙 통제실)를 처음 접하는 사람(혹은 미래의 자신)이 봐도 한눈에 이해하고 바로 세팅할 수 있도록, **매우 상세하고 전문적인 `README.md` 내용**을 작성해 드립니다.

이 내용을 복사해서 `prompt/README.md` 파일로 저장하세요.

---

# 🧠 AI Prompt Control Center (Centralized Prompt Repo)

이 저장소는 다양한 플랫폼(Next.js, Flutter, Android 등)과 프로젝트의 **AI 코딩 규칙(Rules)** 및 **도메인 지식(Context)**을 중앙에서 통합 관리하기 위한 저장소입니다. 2026년형 AI 협업 워크플로우를 위해 설계되었습니다.

## 📂 폴더 구조 (Structure)

```text
.
├── install.sh           # 최초 1회 환경 설정 스크립트 (~/.zshrc 등록)
├── setup.sh             # 프로젝트별 심볼릭 링크 생성 스크립트
├── code-review.md       # 전역 코드 리뷰 가이드라인
├── platforms/           # [How] 기술 스택별 표준 구현 규칙
│   ├── nextjs-api/      # Next.js Server Actions & API Route 규칙
│   ├── flutter/         # Riverpod & Clean Architecture 규칙
│   └── android/         # Kotlin & MVVM 패턴 규칙
├── domains/             # [What] 프로젝트별 비즈니스 로직 룰
│   └── stock-project/   # 주식 프로젝트 전용 도메인
│       ├── common/      # 서버/클라 공통 데이터 엔티티 (StockEntity 등)
│       ├── api/         # 서버측 주문 처리 및 트랜잭션 룰
│       └── mobile/      # 클라이언트 화면별 UI/UX 룰
└── templates/           # 반복되는 작업용 프롬프트 템플릿
    ├── unit-test.md     # 단위 테스트 생성 프롬프트
    └── bug-fix.md       # 디버깅 및 에러 해결 프롬프트

```

---

## 🛠️ 스크립트 상세 설명 (Scripts)

### 1. `install.sh` (초기 인프라 구축)

이 스크립트는 새로운 PC에서 개발을 시작할 때 **딱 한 번** 실행합니다.

* **주요 기능:**
* 현재 `prompt` 폴더의 절대 경로를 파악하여 `$MY_PROMPT_ROOT` 환경 변수로 등록합니다.
* `~/.zshrc`에 `aisetup` 단축어(Alias)를 추가하여 어디서든 링크 스크립트를 호출할 수 있게 합니다.
* `setup.sh`에 실행 권한(`chmod +x`)을 부여합니다.


* **사용법:**
```bash
chmod +x install.sh
./install.sh
source ~/.zshrc

```



### 2. `setup.sh` (프로젝트 동기화)

개별 개발 프로젝트(예: `stock_project/server`) 폴더에서 실행하여 중앙 저장소와 연결합니다.

* **주요 기능:**
* 현재 폴더의 `.ai-config` 파일을 읽어 `platform`과 `domain`을 자동 인식합니다.
* 중앙 저장소의 해당 폴더들을 현재 프로젝트 내에 `.ai-platform`, `.ai-domain` 이름으로 **심볼릭 링크**합니다.
* `.gitignore`에 자동 등록하여 프롬프트 자산이 프로젝트 저장소에 커밋되지 않게 방지합니다.


* **사용법:**
```bash
# 프로젝트 폴더로 이동 후
aisetup

```



---

## 🚀 실전 워크플로우 (Workflow)

### Step 1. 프로젝트 설정 파일 작성

개발 프로젝트 루트에 `.ai-config` 파일을 생성합니다.

```text
platform=nextjs-api
domain=stock-project/api
sub_domain=trade-logic

```

### Step 2. AI 환경 연결

터미널에서 `aisetup` 명령어를 실행하면 다음과 같은 링크가 생성됩니다.

* `.ai-platform` -> `$MY_PROMPT_ROOT/platforms/nextjs-api`
* `.ai-domain` -> `$MY_PROMPT_ROOT/domains/stock-project/api`

### Step 3. JetBrains IDE (Gemini) 연동

1. **Settings > Tools > AI Assistant > Rules** 이동.
2. **Project Rules**에서 링크된 파일을 추가:
* `.ai-platform/base-rules.md`
* `.ai-domain/common/trade-rules.md`


3. 이제 AI와 대화할 때 **"도메인 규칙에 맞춰 매수 API를 구현해줘"**라고 요청하면 정확한 코드가 생성됩니다.

---

## 📝 관리 수칙 (Maintenance)

1. **Atomic Rules:** 하나의 파일은 하나의 도메인/플랫폼 지식만 담습니다.
2. **Path Agnostic:** 모든 스크립트는 환경 변수를 기반으로 작동하므로, 다른 PC로 이동 시 `install.sh`만 재실행하면 즉시 복구됩니다.
3. **Sub-Domain 활용:** 프로젝트 규모가 커지면 `.ai-config`의 `sub_domain` 항목을 통해 특정 화면/기능용 룰만 핀포인트로 연결하세요.

---

**Next Step:**
이제 이 `README.md`를 저장소에 커밋하세요!

그다음 작업으로 **`domains/stock-project/common/trade-rules.md`**에 들어갈 **실제 주식 거래 비즈니스 로직(예: 증거금 계산, 체결 우선순위 등)**의 내용을 작성해 드릴까요? 무엇부터 시작할까요?

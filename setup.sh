#!/bin/bash

# 1. 환경 변수 체크 (어떤 PC든 MY_PROMPT_ROOT가 설정되어 있어야 함)
if [ -z "$MY_PROMPT_ROOT" ]; then
    echo "❌ 에러: MY_PROMPT_ROOT 환경 변수가 설정되지 않았습니다."
    exit 1
fi

# 2. 현재 폴더(pwd)에서 .ai-config 파일 찾기
CONFIG_FILE=".ai-config"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❓ .ai-config 파일이 없습니다. 수동 모드로 전환합니다."
    echo "사용법: sh setup.sh [플랫폼] [도메인]"
    PLATFORM=$1
    DOMAIN=$2
else
    # 파일에서 값 읽기 (platform=nextjs -> nextjs)
    PLATFORM=$(grep "platform=" $CONFIG_FILE | cut -d'=' -f2)
    DOMAIN=$(grep "domain=" $CONFIG_FILE | cut -d'=' -f2)
    echo "🔍 자동 감지 완료: 플랫폼($PLATFORM), 도메인($DOMAIN)"
fi

# 3. 필수 값 체크
if [ -z "$PLATFORM" ] || [ -z "$DOMAIN" ]; then
    echo "❌ 플랫폼 또는 도메인 정보가 부족합니다."
    exit 1
fi

## 4. 심볼릭 링크 생성 (기존 링크 제거 후 생성)
#rm -rf .ai-platform .ai-domain .ai-templates
#ln -sn "$MY_PROMPT_ROOT/platforms/$PLATFORM" .ai-platform
#ln -sn "$MY_PROMPT_ROOT/domains/$DOMAIN" .ai-domain
#ln -sn "$MY_PROMPT_ROOT/templates" .ai-templates
# 4. 심볼릭 링크 생성 (기존 링크 제거 후 생성)
rm -rf .ai-platform .ai-domain .ai-templates .ai-global .ai-sub-rule.md

# [추가] 4-1. 전역 규칙(Global) 연결: 모든 에이전트의 기본 정체성(Identity) 설정
ln -sn "$MY_PROMPT_ROOT/global" .ai-global

# 4-2. 기본 플랫폼 및 도메인 연결
ln -sn "$MY_PROMPT_ROOT/platforms/$PLATFORM" .ai-platform
ln -sn "$MY_PROMPT_ROOT/domains/$DOMAIN" .ai-domain
ln -sn "$MY_PROMPT_ROOT/templates" .ai-templates

# [추가] 4-3. 세부 도메인(Sub-Domain) 자동 감지 및 연결
# .ai-config에 sub_domain=screen-trade 식의 설정이 있을 경우 실행
SUB_DOMAIN=$(grep "sub_domain=" "$CONFIG_FILE" 2>/dev/null | cut -d'=' -f2)
if [ ! -z "$SUB_DOMAIN" ]; then
    # OMO의 작업 에이전트(visual-engineering, ultrabrain 등)가 집중할 특정 룰 연결 [cite: 12, 13]
    ln -sn "$MY_PROMPT_ROOT/domains/$DOMAIN/$SUB_DOMAIN.md" .ai-sub-rule.md
    echo "🎯 세부 도메인 룰 연결 완료: $SUB_DOMAIN.md"
fi

# 5. .gitignore 자동 업데이트
if ! grep -q ".ai-" .gitignore 2>/dev/null; then
    echo -e "\n.ai-*" >> .gitignore
fi

echo "✨ [$(basename "$PWD")] 프로젝트에 AI 프롬프트 연결 완료!"

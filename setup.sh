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

# 4. 심볼릭 링크 생성 (기존 링크 제거 후 생성)
rm -rf .ai-platform .ai-domain .ai-templates
ln -sn "$MY_PROMPT_ROOT/platforms/$PLATFORM" .ai-platform
ln -sn "$MY_PROMPT_ROOT/domains/$DOMAIN" .ai-domain
ln -sn "$MY_PROMPT_ROOT/templates" .ai-templates

# 5. .gitignore 자동 업데이트
if ! grep -q ".ai-" .gitignore 2>/dev/null; then
    echo -e "\n.ai-*" >> .gitignore
fi

echo "✨ [$(basename "$PWD")] 프로젝트에 AI 프롬프트 연결 완료!"

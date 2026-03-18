#!/bin/bash

# 1. 현재 스크립트가 실행되는 절대 경로 파악 (중앙 저장소 루트)
PROMPT_ROOT=$(pwd)
ZSHRC="$HOME/.zshrc"

echo "🛠️ Gemini AI 프롬프트 환경 설정을 시작합니다..."
echo "📍 현재 경로: $PROMPT_ROOT"

# 2. .zshrc에 이미 설정이 있는지 확인 (중복 등록 방지)
if grep -q "MY_PROMPT_ROOT" "$ZSHRC"; then
    echo "⚠️ 이미 ~/.zshrc 에 설정이 존재합니다. 기존 설정을 유지하거나 수동으로 수정하세요."
else
    # 3. .zshrc 하단에 환경 변수 및 Alias 추가
    echo -e "\n# --- Gemini AI Prompt Settings ---" >> "$ZSHRC"
    echo "export MY_PROMPT_ROOT=\"$PROMPT_ROOT\"" >> "$ZSHRC"
    echo "alias aisetup='sh \$MY_PROMPT_ROOT/setup.sh'" >> "$ZSHRC"
    echo "alias gem-review='gemini --system \"\$(cat \$MY_PROMPT_ROOT/code-review.md)\"'" >> "$ZSHRC"
    echo "# ----------------------------------" >> "$ZSHRC"

    echo "✅ ~/.zshrc 에 환경 변수와 'aisetup' 단축어가 등록되었습니다."
fi

# 4. setup.sh에 실행 권한 부여
chmod +x "$PROMPT_ROOT/setup.sh"

echo "🚀 설정이 완료되었습니다! 새로운 터미널을 열거나 다음 명령어를 입력하세요:"
echo "source ~/.zshrc"

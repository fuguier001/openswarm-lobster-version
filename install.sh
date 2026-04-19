#!/bin/bash

# OpenSwarm 龙虾版 - 一键安装脚本
# 将 OpenSwarm 的核心模式安装到 OpenClaw

set -e

echo "🌊 OpenSwarm 龙虾版 - 安装中..."

# 检查 OpenClaw 安装目录
OPENCLAW_SKILLS_DIR="${HOME}/.agents/skills"

if [ ! -d "$OPENCLAW_SKILLS_DIR" ]; then
    echo "❌ 错误：未找到 OpenClaw 安装目录"
    echo "   预期目录：$OPENCLAW_SKILLS_DIR"
    exit 1
fi

# 检查 ChromaDB
if ! docker ps | grep -q chroma; then
    echo "⚠️  警告：ChromaDB 未运行"
    echo "   cognitive-memory skill 需要 ChromaDB"
    echo "   启动命令：docker run -d -p 8000:8000 chromadb/chroma"
    echo ""
fi

# 安装 skills
echo "📦 安装 skills..."

# pair-coding
if [ -d "skills/pair-coding" ]; then
    echo "   ✓ 安装 pair-coding skill..."
    cp -r skills/pair-coding "$OPENCLAW_SKILLS_DIR/"
else
    echo "   ❌ 未找到 pair-coding skill"
fi

# code-registry
if [ -d "skills/code-registry" ]; then
    echo "   ✓ 安装 code-registry skill..."
    cp -r skills/code-registry "$OPENCLAW_SKILLS_DIR/"
else
    echo "   ❌ 未找到 code-registry skill"
fi

# cognitive-memory
if [ -d "skills/cognitive-memory" ]; then
    echo "   ✓ 安装 cognitive-memory skill..."
    cp -r skills/cognitive-memory "$OPENCLAW_SKILLS_DIR/"
else
    echo "   ❌ 未找到 cognitive-memory skill"
fi

# 复制 HEARTBEAT 配置
if [ -f "HEARTBEAT.md" ]; then
    echo "   ✓ 配置 HEARTBEAT..."
    cp HEARTBEAT.md "${HOME}/.openclaw/workspace/HEARTBEAT.md"
else
    echo "   ⚠️  未找到 HEARTBEAT.md"
fi

echo ""
echo "✅ 安装完成！"
echo ""
echo "📚 已安装的 skills："
echo "   - pair-coding: Worker/Reviewer 对模式"
echo "   - code-registry: 代码注册表 + BS 检测器"
echo "   - cognitive-memory: 认知记忆系统"
echo ""
echo "🚀 使用方法："
echo "   1. 重启 OpenClaw"
echo "   2. 查看 USAGE.md 了解如何使用"
echo "   3. 配置 HEARTBEAT.md 启用自动化"
echo ""
echo "📖 文档："
echo "   - USAGE.md: 使用说明"
echo "   - docs/: 详细文档"
echo "   - skills/<name>/README.md: 各 skill 文档"

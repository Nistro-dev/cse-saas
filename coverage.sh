#!/bin/bash

echo "🚀 Running Code Coverage for CSE SaaS Project"
echo "=============================================="

echo ""
echo "📊 BACKEND COVERAGE (Node.js + Fastify + Jest)"
echo "-----------------------------------------------"
cd backend
npm run test:coverage
BACKEND_EXIT_CODE=$?

echo ""
echo "📊 FRONTEND COVERAGE (React + Vite + Vitest)"
echo "----------------------------------------------"
cd ../frontend
npm run test:coverage
FRONTEND_EXIT_CODE=$?

echo ""
echo "📊 COVERAGE SUMMARY"
echo "==================="

if [ $BACKEND_EXIT_CODE -eq 0 ]; then
    echo "✅ Backend Coverage: PASSED"
else
    echo "❌ Backend Coverage: FAILED"
fi

if [ $FRONTEND_EXIT_CODE -eq 0 ]; then
    echo "✅ Frontend Coverage: PASSED"
else
    echo "❌ Frontend Coverage: FAILED"
fi

echo ""
echo "📁 Coverage Reports Generated:"
echo "  - Backend:  backend/coverage/lcov-report/index.html"
echo "  - Frontend: frontend/coverage/index.html"

# Exit with error if any project failed
if [ $BACKEND_EXIT_CODE -ne 0 ] || [ $FRONTEND_EXIT_CODE -ne 0 ]; then
    exit 1
fi

echo ""
echo "🎉 All coverage tests passed!"

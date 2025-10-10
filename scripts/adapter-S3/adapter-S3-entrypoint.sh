#!/bin/bash
set -e

# Main test job entrypoint script - coordinates all modules
echo "🔧 Starting test job entrypoint script..."
echo "📁 Working directory: $(pwd)"
echo "📅 Timestamp: $(date)"

# Set default upload method
export UPLOAD_METHOD="${UPLOAD_METHOD:-sync}"
echo "📤 Upload method: $UPLOAD_METHOD"
echo "📦 Report view host URL: $ALLURE_REPORT_VIEW_HOST_URL"
echo "📦 S3 bucket: $ALLURE_S3_BUCKET"
echo "📦 S3 type: $ALLURE_S3_TYPE"
echo "📦 S3 API host: $ALLURE_S3_API_HOST"
echo "📦 S3 UI URL: $ALLURE_S3_UI_URL"
echo "📦 Environment name: $ALLURE_ENV_NAME"

# Import modular components
source "${ROBOT_HOME}"/scripts/adapter-S3/init.sh
source "${ROBOT_HOME}"/scripts/adapter-S3/test-runner.sh
source "${ROBOT_HOME}"/scripts/adapter-S3/upload-monitor.sh

# Execute main workflow
echo "🚀 Starting test execution workflow..."

# Store all arguments passed to this script
echo "📋 Robot arguments:" "$@"

init_environment
start_upload_monitoring
run_tests "$@"
finalize_upload

echo "✅ Test job finished successfully!"

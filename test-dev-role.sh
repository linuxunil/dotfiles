#!/bin/bash

# Test script for the dev role using Molecule
# Usage: ./test-dev-role.sh [scenario]

set -e

SCENARIO=${1:-default}

echo "🧪 Testing dev role with Molecule (scenario: $SCENARIO)"
echo "======================================================="

# Activate UV environment and run molecule
cd roles/dev
uv run molecule test -s $SCENARIO

echo "✅ Test completed successfully!"
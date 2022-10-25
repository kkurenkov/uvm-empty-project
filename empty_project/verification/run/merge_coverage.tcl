preferences -set workDir $::env(COVERAGE_DIR)
merge -out $::env(COVERAGE_DIR)/merged_coverage *

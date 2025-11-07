# Hook: Validate Structure

## Trigger

Manual execution when user wants to verify that all placeholders have been replaced and the skeleton is ready for code generation.

## Context Files

- `.kiro/specs/agentic-full-stack-skeleton/requirements.md`
- `.kiro/specs/agentic-full-stack-skeleton/design.md`
- `.kiro/specs/agentic-full-stack-skeleton/tasks.md`
- `.kiro/steering/product.md`
- `.kiro/steering/structure.md`
- `.kiro/steering/tech.md`

## Actions

1. **Scan for Unreplaced Placeholders**
   - Read all template and steering files
   - Search for any remaining `<PLACEHOLDER_NAME>` patterns
   - Create a list of unreplaced placeholders with their locations
   - Categorize by file and section

2. **Validate Placeholder Syntax**
   - Check that all placeholders follow `<SCREAMING_SNAKE_CASE>` format
   - Identify any malformed placeholder markers
   - Report inconsistent placeholder naming

3. **Check File Structure**
   - Verify all required template files exist:
     - requirements.md
     - design.md
     - tasks.md
   - Verify all steering files exist:
     - product.md
     - structure.md
     - tech.md
   - Verify all agent hooks exist:
     - scaffold-app.md
     - validate-structure.md
     - generate-boilerplate.md

4. **Validate Content Completeness**
   - Check that requirements.md has user stories and acceptance criteria
   - Verify design.md has all required sections (Architecture, Frontend, Backend, Data Layer, Extension Points)
   - Confirm tasks.md has actionable implementation steps
   - Ensure steering files have meaningful content (not just placeholders)

5. **Check Cross-References**
   - Verify task items reference specific requirements
   - Check that design addresses all requirements
   - Confirm steering files align with design decisions

6. **Validate Markdown Syntax**
   - Check for proper markdown formatting
   - Verify code blocks are properly closed
   - Ensure heading hierarchy is correct
   - Validate list formatting

## Validation

1. **Placeholder Check Results**
   - Report count of unreplaced placeholders
   - List each placeholder with file location
   - Provide severity (critical, warning, info)

2. **Structure Check Results**
   - Confirm all required files present
   - Report any missing files
   - Verify directory structure is correct

3. **Content Quality Check**
   - Assess completeness of each document
   - Flag sections that appear to be incomplete
   - Identify potential inconsistencies

4. **Generate Validation Report**
   - Summary of validation status (Pass/Fail)
   - Detailed findings by category
   - Actionable recommendations for fixes

## Expected Output

### Success Case
```
✓ Placeholder Validation: All placeholders replaced (0 remaining)
✓ File Structure: All required files present (9/9)
✓ Content Completeness: All sections properly filled
✓ Cross-References: All requirements referenced in tasks
✓ Markdown Syntax: No syntax errors found

Status: READY FOR SCAFFOLDING
You can now run the scaffold-app hook to generate your application.
```

### Failure Case
```
✗ Placeholder Validation: 12 unreplaced placeholders found

Unreplaced Placeholders:
  requirements.md:
    - Line 15: <APP_NAME>
    - Line 23: <APP_DESCRIPTION>
    - Line 45: <USER_STORIES>
  
  design.md:
    - Line 67: <FRONTEND_TECH>
    - Line 89: <BACKEND_TECH>
  
  product.md:
    - Line 8: <PRODUCT_VISION>
    - Line 15: <TARGET_USERS>

✓ File Structure: All required files present (9/9)
✗ Content Completeness: 3 sections appear incomplete
✗ Markdown Syntax: 2 unclosed code blocks found

Status: NOT READY
Please replace all placeholders before proceeding with scaffolding.
```

## Error Handling

- **Missing Files**: Report which required files are missing and provide guidance on creating them
- **Read Errors**: Handle file access issues gracefully with clear error messages
- **Malformed Content**: Report specific line numbers and issues for easier fixing
- **Partial Validation**: Continue validation even if some checks fail to provide complete feedback

## Recommendations

After validation, provide specific recommendations:

1. **For Unreplaced Placeholders**
   - "Replace `<APP_NAME>` in requirements.md with your application name"
   - "Update `<FRONTEND_TECH>` in design.md with your chosen frontend stack"

2. **For Missing Content**
   - "Add user stories to requirements.md Section 3"
   - "Complete the Data Layer section in design.md"

3. **For Syntax Issues**
   - "Close code block at line 45 in tech.md"
   - "Fix heading hierarchy in design.md (h3 should follow h2)"

4. **Next Steps**
   - If validation passes: "Run scaffold-app hook to generate application structure"
   - If validation fails: "Fix the issues listed above and run validation again"

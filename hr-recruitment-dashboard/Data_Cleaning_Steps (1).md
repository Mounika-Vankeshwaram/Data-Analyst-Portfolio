# 🧹 Data Cleaning Steps — HR Recruitment Dataset

## Issues Found in Raw Data

| # | Issue | Column | Severity | Fix Applied |
|---|-------|--------|----------|-------------|
| 1 | Missing interview dates | Interview_Date | Medium | Followed up with HR coordinator |
| 2 | Duplicate candidate record | Candidate_ID | High | Removed duplicate, kept latest entry |
| 3 | Inconsistent department names | Department | Low | Find & Replace standardization |
| 4 | Blank salary for hired candidates | Salary_Offered | Medium | Requested from Finance team |
| 5 | Negative Days_to_Hire value | Days_to_Hire | High | Corrected date entry error |
| 6 | Offer_Date after Joining_Date | Offer_Date | High | Confirmed correct dates with recruiter |
| 7 | Blank Source field (8 records) | Source | Low | Marked 'Unknown', pending clarification |
| 8 | Status = Hired but no Joining_Date | Joining_Date | Medium | Raised to HR team |

---

## Excel Cleaning Steps

### Step 1 — Backup the Raw File
- Saved original as `HR_Raw_Backup.xlsx` before making any changes

### Step 2 — Remove Duplicates
- Data Tab → Remove Duplicates → Selected `Candidate_ID` column
- Found and removed 1 duplicate record

### Step 3 — Fix Blank Cells
- CTRL+G → Special → Blanks → Identified empty cells across key columns
- Applied "Unknown" or followed up with team to fill missing values

### Step 4 — Standardize Department Names
- Used Find & Replace (CTRL+H):
  - "Engg" → "Engineering"
  - "Mktg" → "Marketing"
  - "Fin"  → "Finance"

### Step 5 — Date Format Correction
- Selected all date columns → Format Cells → Date → YYYY-MM-DD
- Checked for Offer_Date > Joining_Date anomalies using formula:
  `=IF(H2>I2,"DATE ERROR","OK")`

### Step 6 — Days to Hire Validation
- Checked for negative values: `=IF(L2<0,"NEGATIVE","OK")`
- Corrected 1 record with wrong year in application date

### Step 7 — Conditional Formatting Added
- Green: Hired candidates
- Amber: In Progress candidates
- Red: Data errors flagged for review

---

## Data Quality Checklist

| Check | Result |
|-------|--------|
| Duplicate Candidate IDs | ✅ Resolved (1 removed) |
| Missing Interview Dates | ✅ Resolved |
| Negative Days to Hire | ✅ Resolved |
| Date Sequence Errors | ✅ Resolved |
| Blank Source Fields | ⚠️ 8 records marked Unknown (In Progress) |
| Missing Joining Dates | ⚠️ 2 records pending HR confirmation |
| Salary Blanks | ✅ Resolved |
| Department Name Consistency | ✅ Resolved |

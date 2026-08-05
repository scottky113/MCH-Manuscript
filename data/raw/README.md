# data/raw/

Place the downloaded public-use (or restricted-use) data file(s) here, untouched.

This folder is git-ignored (see `.gitignore`) — secondary datasets are often
large, licensed, or subject to a data use agreement, so they should not be
committed to the repository. Document where the file came from and how to
obtain it instead, e.g.:

- **Source:** _(name of database/survey and cycle/year)_
- **Access:** _(public download URL, or restricted-access request process)_
- **File(s):** _(expected filename(s), format)_
- **Date obtained:** _(date)_
- **Codebook/documentation:** _(link or citation)_

`R/01_import_data.R` looks for a `.csv`, `.sas7bdat`, `.xpt`, `.dta`, or
`.sav` file in this folder and imports it automatically.

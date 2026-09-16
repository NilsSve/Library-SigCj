# SigCj for DataFlex 26

DataFlex wrapper classes for the Codejock ActiveX controls, targeting
**DataFlex 26.0 and CodeJock 24.3.0**.

This is a fork of **SigCj** by [VDF SIG UK](http://www.vdfsig.co.uk/), taken from their
Subversion repository at `https://subversion.asckey.co.uk/svn/sigcj/trunk`, **revision 930**.
All the original work is theirs; this fork exists only because upstream has no DataFlex 26
build yet. It is published under the same licence, and contributions back upstream are welcome.

DataFlex 27.0 ships the same CodeJock 24.3.0, so this build covers it too.

## Licence

**GNU LGPL 2.1 or later** — see [LICENSE](LICENSE). Every source file keeps its original
copyright notice: *Copyright (c) 2008-2025 VDF SIG UK, All rights reserved.*

## Using it

Add it as a dependency of your workspace:

```
df-cli package install <your-workspace.sws> https://github.com/NilsSve/Library-SigCj.git
```

or reference it directly in a JSON `.sws`:

```json
{
  "dependencies": [
    { "source": "https://github.com/NilsSve/Library-SigCj.git",
      "sws":    "SigCj-Library-DF26.0.sws",
      "version": "<commit sha>" }
  ]
}
```

`SigCj-Library-DF26.0.sws` is the entry point. It chains to the wrapper workspace, so both the
classes and the COM wrappers land on your include path.

Then `Use SigCJLibraries.pkg`, or the individual `cSigCJ*.pkg` classes you need. Most classes in
`SigCJLibraries.pkg` are commented out by design — uncomment the ones you want.

## What you need

- **DataFlex 26.0 or later.**
- **The CodeJock controls.** DataFlex itself ships CommandBars, GridControl and SkinFramework,
  so those work out of the box. The other eleven components are part of Codejock SuitePro and
  you must own and register it to use them.

## What changed from upstream r930

Required by the LGPL, and useful to know:

**Brought to CodeJock 24.3.0**
- New `SigCjLicense_v24.3.0.pkg`: 132 CLSIDs re-prefixed `C0DE2400` -> `C0DE2430`, the 14
  licence keys moved to `ActiveX.v24.3`. The VALIDATE-CODE strings are unchanged.
- **64 `psEventId` GUIDs corrected.** These are embedded in the wrapper sources, were still
  `C0DE2400` (one was `C0DE2010`, from CodeJock 20.1), and are what COM events bind on. Every
  replacement was checked against the real 24.3.0 type library.
- 19 member and signature differences reconciled across ChartControl, Controls and PropertyGrid,
  generated from the live 24.3.0 type libraries. The other eleven components needed nothing.
- Package headers and the SuitePro registry probe updated to 24.3.0.

**Upstream defects fixed** — all pre-existing, none caused by the version bump
- `SigCjW_CheckBox.pkg` and `SigCjW_Controls.pkg` both declared the same three CheckBox classes,
  so anything reaching both failed with 422 errors. CheckBox.pkg now keeps only
  `cSigCjComDbCheckBox`, which exists nowhere else.
- `#Replace phoReportPaintManager phoGridPaintManager` renamed a property **DataFlex itself
  owns**, silently retargeting `cSigGrid`/`cSigdbGrid` to a property their base class lacks.
- `cSigCJMonthCalendar.pkg` set its min/max dates from the literals `"01/01/1899"` and
  `"01/01/2050"`. DataFlex parses a date literal in the *runtime locale's* field order, so on a
  year-month-day locale these became 2001-01-18 and 2001-01-20 — a three-day range that froze
  the calendar in January 2001 and disabled its navigation. Now built with `DateSet()`.
- `cSigCJToolTipContext.pkg` used `SigCjC_ToolTipContext.pkg`, renamed at wrapper 18.3.0.
- `cSigCJTrackControl.pkg`: a malformed class declaration, the removed ReportControl wrapper,
  seven renamed enumerations, and 1415 lines of an orphaned copy of the wrapper's dispatch
  interface.
- `cSigCJFieldChooser.pkg` became a version dispatcher instead of a third copy of the same
  classes.
- Error 4544 (ambiguous private colour properties) in six classes, using the workaround upstream
  already applies elsewhere.
- Obsolete `ToOEM` replaced with `Utf8ToOem` in `cSigCJGridControl.pkg`.
- `cSigCJCalendarControl.pkg`: the standard-file switches are now `#IFNDEF`-guarded, so
  `SigCj_Skip_StdFiles` / `StdDates` / `StdResources` avoids editing a library file; and six
  calls to hidden COM members are bound by name, since hidden members never appear in a
  generated wrapper.

**Removed**
- The 20 older wrapper workspaces and every pre-DF26 `.sws`. Upstream still serves DataFlex
  16.1-25.0; this fork is 26.0 and later only.
- The `SigCodejock Demo v1` workspace, which upstream has not updated since DataFlex 19.1.

## How far this is verified

- All 14 components match the live CodeJock 24.3.0 type libraries — no missing members, no
  members the type library no longer has, no class gaps.
- The classes layer compiles clean on DataFlex 26 in **both 32- and 64-bit**.
- Verified **at run time** against upstream's own demo application: CodeJock COM events fire,
  and the grid, task panel, command bars and month calendar all work.
- The eleven components DataFlex does not ship are compile-verified and type-library-verified,
  but have not each been exercised at run time.

## Known issues

- `cSigCJdbCheckBox` raises Error 57 on create in a data-bound view (`Get Value` without its
  item argument, from the DataFlex data-binding layer). The plain `cSigCJCheckBox` is fine.
- `cSigCJGridControl` raises Error 4509 if created with no columns: `Create_Columns` loops
  inclusively over `piColumn_Count`, which is a max-index initialising to 0, so empty is
  indistinguishable from one column. Give the grid a column.
- `oSigCJMonthCalendar.dg` is dead code — a duplicate of the popup defined in
  `SigCJMonthCalendar.sl`, included by nothing.

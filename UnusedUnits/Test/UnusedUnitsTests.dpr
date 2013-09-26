program UnusedUnitsTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options 
  to use the console test runner.  Otherwise the GUI test runner will be used by 
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestListUnits in 'TestListUnits.pas',
  ListUnits in '..\Src\ListUnits.pas',
  ListUnusedUnits in '..\Src\ListUnusedUnits.pas',
  ListUses in '..\Src\ListUses.pas',
  CreateTestFiles in 'Utils\CreateTestFiles.pas',
  TestListUnusedUnits in 'TestListUnusedUnits.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.


program UnusedUnitsTests;

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


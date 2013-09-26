program UnusedUnits;

uses
  Forms,
  UnusedUnitsView in 'UnusedUnitsView.pas' {UnusedUnitsForm},
  ListUnusedUnits in 'ListUnusedUnits.pas',
  ListUnits in 'ListUnits.pas',
  ListUses in 'ListUses.pas';

{$R *.res}

var
  UnusedUnitsForm: TUnusedUnitsForm;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUnusedUnitsForm, UnusedUnitsForm);
  Application.Run;
end.

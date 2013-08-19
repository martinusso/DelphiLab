unit TestCPF;

interface

uses
  TestFramework, DocsBR;
type
  TestTCPF = class(TTestCase)
  published
    procedure TestRejectsBlankCPF;
    procedure TestRejectsBlacklistCPF;
    procedure TestValidatesFormattedCPF;
    procedure TestValidatesUnformattedCPF;
  end;

implementation

procedure TestTCPF.TestRejectsBlankCPF;
var
  CPF: TCPF;
begin
  CPF := '';
  CheckFalse(CPF.IsValid, 'Should reject blank CPF');
end;

procedure TestTCPF.TestRejectsBlacklistCPF;
var
  CPF: TCPF;
begin
  CPF := '00000000000';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "00000000000"');
  CPF := '11111111111';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "11111111111"');
  CPF := '22222222222';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "22222222222"');
  CPF := '33333333333';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "33333333333"');
  CPF := '44444444444';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "44444444444"');
  CPF := '55555555555';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "55555555555"');
  CPF := '66666666666';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "66666666666"');
  CPF := '77777777777';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "77777777777"');
  CPF := '88888888888';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "88888888888"');
  CPF := '99999999999';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF "99999999999"');
end;

procedure TestTCPF.TestValidatesFormattedCPF;
var
  CPF: TCPF;
begin
  CPF := '999.999.001-00';
  CheckTrue(CPF.IsValid, 'Should validate formatted CPF');

  CPF := '999.999.002-00';
  CheckFalse(CPF.IsValid, 'Should reject invalid CPF');
end;

procedure TestTCPF.TestValidatesUnformattedCPF;
var
  CPF: TCPF;
begin
  CPF := '99999900100';
  CheckTrue(CPF.IsValid, 'Should validate unformatted CPF');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCPF.Suite);
end.


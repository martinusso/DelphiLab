unit TestCNPJ;

interface

uses
  TestFramework, DocsBR;
type
  TestTCNPJ = class(TTestCase)
  published
    procedure TestRejectsBlankCNPJ;
    procedure TestRejectsBlacklistCNPJ;
    procedure TestValidatesFormattedCNPJ;
    procedure TestValidatesUnformattedCNPJ;
  end;

implementation

procedure TestTCNPJ.TestRejectsBlacklistCNPJ;
var
  CNPJ: TCNPJ;
begin
  CNPJ := '00000000000000';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "00000000000000"');
  CNPJ := '11111111111111';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "11111111111111"');
  CNPJ := '22222222222222';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "22222222222222"');
  CNPJ := '33333333333333';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "33333333333333"');
  CNPJ := '44444444444444';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "44444444444444"');
  CNPJ := '55555555555555';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "55555555555555"');
  CNPJ := '66666666666666';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "66666666666666"');
  CNPJ := '77777777777777';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "77777777777777"');
  CNPJ := '88888888888888';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "88888888888888"');
  CNPJ := '99999999999999';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ "99999999999999"');
end;

procedure TestTCNPJ.TestRejectsBlankCNPJ;
var
  CNPJ: TCNPJ;
begin
  CNPJ := '';
  CheckFalse(CNPJ.IsValid, 'Should reject blank CNPJ');
end;

procedure TestTCNPJ.TestValidatesFormattedCNPJ;
var
  CNPJ: TCNPJ;
begin
  CNPJ := '99.999.999/0001-91';
  CheckTrue(CNPJ.IsValid, 'Should validate formatted CNPJ');

  CNPJ := '99.999.999/0002-91';
  CheckFalse(CNPJ.IsValid, 'Should reject invalid CNPJ');
end;

procedure TestTCNPJ.TestValidatesUnformattedCNPJ;
var
  CNPJ: TCNPJ;
begin
  CNPJ := '99999999000191';
  CheckTrue(CNPJ.IsValid, 'Should validate unformatted CNPJ');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCNPJ.Suite);
end.


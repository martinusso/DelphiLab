{
-----------------------------------------------------
|Compiler	         |CompilerVersion |Defined Symbol |
-----------------------------------------------------
|Delphi XE3        |24              |VER240         |
|Delphi XE2	       |23              |VER230         |
|Delphi XE	       |22              |VER220         |
|Delphi 2010	     |21              |VER210         |
|Delphi 2009	     |20              |VER200         |
|Delphi 2007 .NET	 |19              |VER190         |
|Delphi 2007	     |18.5            |VER185         |
|Delphi 2006	     |18              |VER180         |
|Delphi 2005	     |17              |VER170         |
|Delphi 8 .NET	   |16              |VER160         |
|Delphi 7	         |15              |VER150         |
|Delphi 6	         |14              |VER140         |
|Delphi 5	         |13              |VER130         |
|Delphi 4	         |12              |VER120         |
|Delphi 3	         |10              |VER100         |
|Delphi 2	         |9               |VER90          |
|Delphi 1	         |8               |VER80          |
-----------------------------------------------------
}
unit DelphiUP;

interface

uses SysUtils;

{$if CompilerVersion < 22 }
function FormatSettings: TFormatSettings;
{$ifend}

implementation

{$if CompilerVersion < 22 }
function FormatSettings: TFormatSettings;
var
  i: Integer;
begin
  Result.CurrencyFormat := CurrencyFormat;
  Result.NegCurrFormat := NegCurrFormat;
  Result.ThousandSeparator := ThousandSeparator;
  Result.DecimalSeparator := DecimalSeparator;
  Result.CurrencyDecimals := CurrencyDecimals;
  Result.DateSeparator := DateSeparator;
  Result.TimeSeparator := TimeSeparator;
  Result.ListSeparator := ListSeparator;
  Result.CurrencyString := CurrencyString;
  Result.ShortDateFormat := ShortDateFormat;
  Result.LongDateFormat := LongDateFormat;
  Result.TimeAMString := TimeAMString;
  Result.TimePMString := TimePMString;
  Result.ShortTimeFormat := ShortTimeFormat;
  Result.LongTimeFormat := LongTimeFormat;
  for i := 1 to Length(ShortMonthNames) do
    Result.ShortMonthNames[i] := ShortMonthNames[i];
  for i := 1 to Length(LongMonthNames) do
    Result.LongMonthNames[i] := LongMonthNames[i];
  for i := 1 to Length(ShortDayNames) do
    Result.ShortDayNames[i] := ShortDayNames[i];
  for i := 1 to Length(LongDayNames) do
    Result.LongDayNames[i] := LongDayNames[i];
  Result.TwoDigitYearCenturyWindow := TwoDigitYearCenturyWindow;
end;
{$ifend}

end.

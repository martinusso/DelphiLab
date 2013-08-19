# Usage

This way to use is the same for both CNPJ/CPF, so only CPF is documented below.

```delphi
var
  CPF: TCPF;
begin
  // Assignd CPF
  CPF := '999.999.001-00';
  
  // Return unformatted CPF 00000000000
  // implicit
  CPF            
  // or explicit
  CPF.unformatted
  
  
  // Return formatted CPF 000.000.000-00
  // only explicit
  CPF.formatted
  
  
  // Check if CPF is valid
  CPF.IsValid()
end;
```

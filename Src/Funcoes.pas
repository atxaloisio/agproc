unit Funcoes;

//{$MODE Delphi}

interface

uses
  Classes, SysUtils;

function Cripto(par: string; par2: string): string;

implementation

function Cripto(par: string; par2: string): string;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
begin
  Result := par;
  TamanhoString := Length(par);
  TamanhoChave := Length(par2);
  for i := 1 to TamanhoString do
  begin
    pos := (i mod TamanhoChave);

    if pos = 0 then
      pos := TamanhoChave;

    PosLetra := ord(Result[i]) xor ord(par2[pos]);

    if PosLetra = 0 then
      PosLetra := ord(Result[i]);
    Result[i] := chr(PosLetra);
  end;
end;

end.


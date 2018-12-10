unit Modelo;

interface

  Type

    TModelo = Class(TObject)
      Private
          fNome: String;
          fSituacao: String;
          fCodigoAbacos: Integer;
      Public
          Constructor Create (nome: String);
          Destructor Destroy;
          Property Nome: String read fNome write fNome;
          Property Situacao: String read fSituacao write fSituacao;
          Property CodigoAbacos: Integer read fCodigoAbacos write fCodigoAbacos;
    End;

implementation

{ TModelo }

constructor TModelo.Create (nome: String);
begin
  Self.fNome := nome;
  Self.fSituacao := '1';
  Self.fCodigoAbacos := -2
end;

destructor TModelo.Destroy;
begin
  Self.fNome := '';
  Self.fSituacao := '';
  Self.fCodigoAbacos := 0;
end;

end.

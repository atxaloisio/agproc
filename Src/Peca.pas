unit Peca;

interface

  uses
    hashes, classes, SysUtils, dialogs, Modelo;

  Type
    TProduto = Class(TObject)
      Private
        fCodigoExterno: String;
        fCodigoAbacos: Integer;
        fSituacao: String;
        fDescricao: String;
        fModelos: TList;
      Public
        Property CodigoExterno: String read fCodigoExterno write fCodigoExterno;
        Property Descricao: String read fDescricao write fDescricao;
        Property Modelos: TList read fModelos write fModelos;
        Property CodigoAbacos: Integer read fCodigoAbacos write fCodigoAbacos;
        Property Situacao: String read fSituacao write fSituacao;
        Procedure AdicionaModelo (model: TModelo);
        Constructor Create; Overload;
        Constructor Create (cod, desc, model: String); Overload;
        Destructor Destroy;
    End;

implementation

{ TProduto }

procedure TProduto.AdicionaModelo(model: TModelo);
begin
  Self.fModelos.Add(model);
end;

constructor TProduto.Create(cod, desc, model: String);
var aux: String;
    a: Integer;
    m: TModelo;
begin
  Self.fCodigoExterno := cod;
  Self.fDescricao := desc;
  Self.fSituacao := '';

  // Adicionar Modelos
  Self.fModelos := TList.Create;
  aux := model;
  a := Pos('/', aux);
  While a > 0 do
  begin
    m := TModelo.Create( Trim ( Copy(aux,0,a-1) ) );
    Self.AdicionaModelo(m);
    aux := Copy(aux, a+1, Length(aux));
    a := Pos('/', aux);
  end;

  if Length(Trim(aux)) > 0 then
  begin
    m := TModelo.Create(Trim(aux));
    Self.AdicionaModelo(m);
  end;
end;

constructor TProduto.Create;
begin
  Self.fModelos := TList.Create;
end;

destructor TProduto.Destroy;
begin
  While fModelos.Count > 0 do
    fModelos.Delete(0);

  inherited;
end;

end.

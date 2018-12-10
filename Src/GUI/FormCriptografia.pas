unit FormCriptografia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Funcoes;

type
  TfrmCriptografia = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnDescriptografar: TButton;
    btnCriptografar: TButton;
    btnFechar: TButton;
    edtDescriptografada: TEdit;
    edtCriptografada: TEdit;
    procedure btnCriptografarClick(Sender: TObject);
    procedure btnDescriptografarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografia: TfrmCriptografia;

implementation

{$R *.dfm}

procedure TfrmCriptografia.btnCriptografarClick(Sender: TObject);
begin
  edtCriptografada.Text := Cripto(edtDescriptografada.Text,'S');
end;

procedure TfrmCriptografia.btnDescriptografarClick(Sender: TObject);
begin
  edtDescriptografada.Text := Cripto(edtCriptografada.Text,'S');
end;

procedure TfrmCriptografia.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCriptografia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

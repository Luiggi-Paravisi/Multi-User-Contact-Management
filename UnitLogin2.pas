unit UnitLogin2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

var
  usuario: string;

type
  TForm2 = class(TForm)
    PnlLogin: TPanel;
    Image3: TImage;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Image4: TImage;
    Label2: TLabel;
    PnlCadastroLogin: TPanel;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Login = record

    Username: string[20];
    Password: string[20];
    status: boolean;

  end;

var
  Form2: TForm2;
  vlogin: array [1 .. 100] of Login;
  arquivol: file of Login;

implementation

{$R *.dfm}

uses UntAgenda,About;

procedure TForm2.Button1Click(Sender: TObject);
var
  I: Integer;
  existe: Integer;
begin
  if (Edit3.Text = '') or (Edit4.Text = '') then
  begin
    MessageDlg('usuário ou senha não informados', mtWarning, [mbOk], 0);
  end
  else if (Edit3.Text <> '') and (Edit4.Text <> '') then
  begin

    existe := 0;
    for I := 1 to 100 do
    begin

      if vlogin[I].status = true then
      begin

        if (vlogin[I].Username = Edit3.Text) then
        begin

          if vlogin[I].Password = Edit4.Text then
          begin

            MessageDlg('Fazendo login!', mtWarning, [mbOk], 0);
            usuario := Edit3.Text;

            Form1 := Tform1.Create(Self);
            Form1.Show;

            existe := 1;
            Break;

          end
          else
          begin

            MessageDlg('Senha Incorreta!', mtWarning, [mbOk], 0);
            existe := 1;
            Break

          end;

        end

      end;

    end;

  end;

  if existe = 0 then
  begin

    MessageDlg('Usuário Incorreto!', mtWarning, [mbOk], 0);

  end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  PnlCadastroLogin.Visible := true;
  PnlLogin.Visible := false;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  I: Integer;
  exist: Integer;

begin

  exist := 0;
  for I := 1 to 100 do
  begin

    if (Edit1.Text = vlogin[I].Username) and (vlogin[I].status = true) then
    begin
      exist := 1;
      Break;
    end;

  end;

  if exist = 0 then
  begin

    for I := 1 to 100 do
    begin

      if vlogin[I].status = false then
      begin

        vlogin[I].Username := Edit1.Text;
        vlogin[I].Password := Edit2.Text;
        vlogin[I].status := true;

        showmessage('usuário criado com sucesso');
        Break;
      end;

    end;
  end
  else
  begin
    showmessage('Nome já existente!');
  end;

  // Laço que procura no vetor por um usuário igual (status)
  // Se já existir nome igual, não cadastra

  // Caso contrário cadastra
  // Percorrer no vetor por um espaço vazio (status) e cadastrar o novo usuário

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  PnlCadastroLogin.Visible := false;
  PnlLogin.Visible := true;

end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin

  Rewrite(arquivol);
  I := 0;
  WHILE I <= 100 DO
  BEGIN

    IF (vlogin[I].status = true) THEN
    BEGIN
      WRITE(arquivol, vlogin[I]);
    END;
    I := I + 1;
  END;
  CloseFile(arquivol);

  Form1.Close();
  AboutBox.Close();
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  I: Integer;
  c: Integer;
  l: Integer;
  s: String;

begin

  // inicialização

  for I := 1 to 100 do
  begin
    vlogin[I].status := false;
  end;

  AssignFile(arquivol, 'LOGIN.DAT');
  IF FILEEXISTS('LOGIN.DAT') THEN
  BEGIN
    RESET(arquivol);
  END
  ELSE
  begin
    Rewrite(arquivol);
  END;

  SEEK(arquivol, 0); // posiciona o ponteiro de registros no início do arquivo

  I := 1;
  WHILE (NOT EOF(arquivol)) DO
  BEGIN
    READ(arquivol, vlogin[I]);
    vlogin[I].status := true;

    I := I + 1;
  END;

end;

end.

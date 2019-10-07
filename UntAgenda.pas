unit UntAgenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.Grids, Vcl.Mask,
  Vcl.WinXCalendars, Vcl.WinXCtrls, Vcl.Themes, Vcl.Styles,MMSystem,ShellAPI;

type
  TForm1 = class(TForm)
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Image1: TImage;
    Panel1: TPanel;
    editbotao: TButton;
    excluibotao: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Image2: TImage;
    StringGrid1: TStringGrid;
    TabSheet3: TTabSheet;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    CalendarPicker1: TCalendarPicker;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    MaskEdit3: TMaskEdit;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Principal: TPageControl;
    ComboBox2: TComboBox;
    Labelfiltro: TLabel;
    Button3: TButton;
    LabeledEdit2: TLabeledEdit;
    SearchBox1: TSearchBox;
    Label8: TLabel;
    ComboBox3: TComboBox;
    Label9: TLabel;
    BitBtn3: TBitBtn;
    function verificaPosicaoLivre(): Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure limpacadastro();

    function retornaposicaonome(pName: String): Integer;
    function verificanome(pName: String): Integer;
    function procuraposicaolivre(): Integer;
    procedure StringGrid1Click(Sender: TObject);
    procedure excluibotaoClick(Sender: TObject);
    procedure redesenhaGrid();
    procedure editbotaoClick(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure limpargrade();
    procedure atualizagrade();
    procedure LabeledEdit2Change(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type

  contato = record
    nome: string[50];
    idade: Integer;
    dataNascimento: TDate;
    telefonec: string[30];
    telefoner: string[30];
    bairro: string[200];
    estadocivil: string[15];
    cep: string[30];
    endereço: string[200];
    sexo: string[1];
    status: boolean;

  end;

var
  Form1: TForm1;

  agenda: array [0 .. 99] of contato;
  arquivo: file of contato;
  edicao: Integer;

implementation

{$R *.dfm}
{ TForm1 }

{ TForm1 }
uses About,UnitLogin2;
procedure TForm1.atualizagrade;
var
  x, I: Integer;
begin
  I := 1;
  for x := 0 to 99 do
  begin
    if agenda[x].status = true then
    begin
      StringGrid1.Cells[0, I] := agenda[x].nome;
      StringGrid1.Cells[1, I] := IntToStr(agenda[x].idade);
      StringGrid1.Cells[2, I] := DateToStr(agenda[x].dataNascimento);
      StringGrid1.Cells[3, I] := agenda[x].telefonec;
      StringGrid1.Cells[4, I] := agenda[x].telefoner;
      StringGrid1.Cells[7, I] := agenda[x].bairro;
      StringGrid1.Cells[8, I] := agenda[x].estadocivil;
      StringGrid1.Cells[9, I] := agenda[x].cep;
      StringGrid1.Cells[6, I] := agenda[x].endereço;
      StringGrid1.Cells[5, I] := agenda[x].sexo;
      Inc(I);
    end;

  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  Confirmar: Integer;
begin
  Confirmar := MessageDlg('quer mesmo fechar a agenda?', mtconfirmation,
    mbyesno, 0);
  if Confirmar = mrYes then
  begin
    Form1.Close;


  end;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
sndPlaySound('xpAlto Question.wav', SND_NODEFAULT Or SND_ASYNC);
  ShowMessage('Criar Contato:Você cria um contato que adiciona.' + #13 +
    'Editar Contato:Você edita um contato .' + #13 +
    'Excluir Contato: Você exclui um contato.');
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  myYear: Word;
  myMonth: Word;
  myDay: Word;
  a: Integer;
  posicao: Integer;
  I: Integer;
begin
sndPlaySound('Roblox Death Sound Effect.wav', SND_NODEFAULT Or SND_ASYNC);
  if verificanome(LabeledEdit1.Text) = 1 then
  begin

    // Verificar se existe uma posição livre (false) na agenda
    posicao := procuraposicaolivre();

    if posicao <> -1 then
    begin

      if Edit1.Text <> ' ' then
      begin

        a := StrToInt(Edit1.Text);
        if ((a > 0) and (a <= 150)) then
        begin

          if (LabeledEdit9.Text = 'Casado') or
            (LabeledEdit9.Text = 'Divorciado') or (LabeledEdit9.Text = 'Viúvo')
            or (LabeledEdit9.Text = 'Solteiro') or
            (LabeledEdit9.Text = 'solteiro') or (LabeledEdit9.Text = 'viúvo') or
            (LabeledEdit9.Text = 'divorciado') or (LabeledEdit9.Text = 'casado')
          then
          begin

            if edicao = 1 then
            begin

              // Andar na agenda (em memória) e procurar o nome antigo
              I := 0;
              for I := 0 to 99 do
              begin
                if ((agenda[I].status = true) and
                  (agenda[I].nome = StringGrid1.Cells[0, StringGrid1.row])) then
                begin
                  posicao := I;
                  break;
                end;
              end;

              agenda[posicao].nome := LabeledEdit1.Text;
              agenda[posicao].idade := StrToInt(Edit1.Text);
              agenda[posicao].dataNascimento := CalendarPicker1.Date;
              agenda[posicao].telefonec := MaskEdit1.Text;
              agenda[posicao].telefoner := MaskEdit2.Text;
              agenda[posicao].sexo := ComboBox1.Text;
              agenda[posicao].endereço := LabeledEdit7.Text;
              agenda[posicao].bairro := LabeledEdit8.Text;
              agenda[posicao].estadocivil := LabeledEdit9.Text;
              agenda[posicao].cep := MaskEdit3.Text;
              agenda[posicao].status := true;

              TabSheet2.Show;

            end
            else
            begin

              agenda[posicao].nome := LabeledEdit1.Text;
              agenda[posicao].idade := StrToInt(Edit1.Text);
              agenda[posicao].dataNascimento := CalendarPicker1.Date;
              agenda[posicao].telefonec := MaskEdit1.Text;
              agenda[posicao].telefoner := MaskEdit2.Text;
              agenda[posicao].sexo := ComboBox1.Text;
              agenda[posicao].endereço := LabeledEdit7.Text;
              agenda[posicao].bairro := LabeledEdit8.Text;
              agenda[posicao].estadocivil := LabeledEdit9.Text;
              agenda[posicao].cep := MaskEdit3.Text;
              agenda[posicao].status := true;

            end;
          end
          else
          begin
            ShowMessage('estado civil não válido');
          end;

        end
        else
        begin

          ShowMessage('Idade inválida!');

        end;
      end
      else
      begin
        ShowMessage('Não posso cadastrar pois a idade não foi informada');
      end;

    end
    else
    begin
      ShowMessage('Agenda está cheia!');
    end;

  end
  else
  begin
    ShowMessage('Este nome já está cadastrado na agenda');
  end;

  limpacadastro();
  edicao := 0;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  limpacadastro();

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
sndPlaySound('xpAlto Recycle.wav', SND_NODEFAULT Or SND_ASYNC);
  LabeledEdit2.Clear;

  SearchBox1.Clear;
  ComboBox2.ItemIndex := -1;
  ComboBox2.Enabled := true;
  SearchBox1.Enabled := true;
  LabeledEdit2.Enabled := true;
  atualizagrade();

  // limpa
  // atualiza

end;

procedure TForm1.ComboBox2Select(Sender: TObject);
var
  I, cs: Integer;
begin

  LabeledEdit2.Enabled := false;
  SearchBox1.Enabled := false;
  limpargrade();
  cs := 1;
  for I := 0 to 99 do
    if (agenda[I].status = true) and
      (agenda[I].sexo = ComboBox2.Items[ComboBox2.ItemIndex]) then
    begin

      StringGrid1.Cells[0, cs] := agenda[I].nome;
      StringGrid1.Cells[1, cs] := IntToStr(agenda[I].idade);
      StringGrid1.Cells[2, cs] := DateToStr(agenda[I].dataNascimento);
      StringGrid1.Cells[3, cs] := agenda[I].telefonec;
      StringGrid1.Cells[4, cs] := agenda[I].telefoner;
      StringGrid1.Cells[5, cs] := agenda[I].sexo;
      StringGrid1.Cells[6, cs] := agenda[I].endereço;
      StringGrid1.Cells[7, cs] := agenda[I].bairro;
      StringGrid1.Cells[8, cs] := agenda[I].estadocivil;
      StringGrid1.Cells[9, cs] := agenda[I].cep;

      // ..
      Inc(cs);

    end;

end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin

  TStyleManager.TrySetStyle(ComboBox3.Items[ComboBox3.ItemIndex]);



end;

procedure TForm1.editbotaoClick(Sender: TObject);
begin
sndPlaySound('Mines.wav', SND_NODEFAULT Or SND_ASYNC);
  agenda[retornaposicaonome(StringGrid1.Cells[0, StringGrid1.row])
    ].status := false;
  LabeledEdit1.Text := StringGrid1.Cells[0, StringGrid1.row];
  Edit1.Text := StringGrid1.Cells[1, StringGrid1.row];
  CalendarPicker1.Date := StrToDate(StringGrid1.Cells[2, StringGrid1.row]);
  MaskEdit1.Text := StringGrid1.Cells[3, StringGrid1.row];
  MaskEdit2.Text := StringGrid1.Cells[4, StringGrid1.row];
  ComboBox1.Text := StringGrid1.Cells[5, StringGrid1.row];
  LabeledEdit7.Text := StringGrid1.Cells[6, StringGrid1.row];
  LabeledEdit8.Text := StringGrid1.Cells[7, StringGrid1.row];
  LabeledEdit9.Text := StringGrid1.Cells[8, StringGrid1.row];
  MaskEdit3.Text := StringGrid1.Cells[9, StringGrid1.row];

  edicao := 1;
  TabSheet3.Show;

end;

procedure TForm1.excluibotaoClick(Sender: TObject);
var
  I: Integer;
begin

  if (MessageDlg('Quer mesmo apagar ' + StringGrid1.Cells[0, StringGrid1.row],
    mtconfirmation, mbyesno, 0) = mrYes) then
  begin

    for I := 0 to 99 do
    begin
      if (StringGrid1.Cells[0, StringGrid1.row] = agenda[I].nome) and
        (agenda[I].status = true) then
      begin

        agenda[I].status := false;
        break;

      end;
    end;

  end
  else
  begin
    ShowMessage('Contato Não excluído');
  end;

  excluibotao.Enabled := false;
  redesenhaGrid;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin

  Rewrite(arquivo);
  I := 0;
  WHILE I <= 99 DO
  BEGIN

    IF (agenda[I].status = true) THEN
    BEGIN
      WRITE(arquivo, agenda[I]);
    END;
    I := I + 1;
  END;
  CloseFile(arquivo);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
  c: Integer;
  l: Integer;
  s: String;
begin

  //Form2.Hide;
  sndPlaySound('Windows.wav', SND_NODEFAULT Or SND_ASYNC);

  edicao := 0;
  for c := 0 to 10 do
  begin
    for l := 1 to 99 do
    begin
      StringGrid1.Cells[c, l] := '';
    end;
  end;

  StringGrid1.Cells[0, 0] := ('Nome');
  StringGrid1.Cells[1, 0] := ('Idade');
  StringGrid1.Cells[2, 0] := ('Data de Nascimento');
  StringGrid1.Cells[3, 0] := ('Telefone Comercial');
  StringGrid1.Cells[4, 0] := ('Telefone Residencial');
  StringGrid1.Cells[5, 0] := ('Sexo');
  StringGrid1.Cells[6, 0] := ('Endereço');
  StringGrid1.Cells[7, 0] := ('Bairro');
  StringGrid1.Cells[8, 0] := ('Estado Civil');
  StringGrid1.Cells[9, 0] := ('CEP');
  for I := 0 to 99 do
  begin
    agenda[I].status := false;
  end;
  AssignFile(arquivo, usuario + '.DAT');
  IF FILEEXISTS(usuario + '.DAT') THEN
  BEGIN
    RESET(arquivo);
  END
  ELSE
  begin
    Rewrite(arquivo);
  END;
  SEEK(arquivo, 0); // posiciona o ponteiro de registros no início do arquivo
  I := 0;
  WHILE (NOT EOF(arquivo)) DO
  BEGIN
    READ(arquivo, agenda[I]);
    I := I + 1;
  END;

  ComboBox3.Items.BeginUpdate;
  try
    ComboBox3.Items.Clear;
    for s in TStyleManager.StyleNames do
      ComboBox3.Items.Add(s);
    ComboBox3.Sorted := true;
    // Select the style that's currently in use in the combobox
    ComboBox3.ItemIndex := ComboBox3.Items.IndexOf
      (TStyleManager.ActiveStyle.Name);
  finally
    ComboBox3.Items.EndUpdate;
  end;

  TStyleManager.TrySetStyle('Windows');
  ComboBox3.ItemIndex := 0;
  TabSheet1.Show;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
ShellExecute(Handle,'open','http://www.ucs.br/cetec',nil,nil,SW_SHOWMAXIMIZED);

end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
var
  I, cs: Integer;
begin
  ComboBox2.Enabled := false;
  SearchBox1.Enabled := false;
  if (LabeledEdit2.Text <> '') then
  begin

    limpargrade();
    cs := 1;
    for I := 0 to 99 do
      if (agenda[I].status = true) and
        (agenda[I].idade = StrToInt(LabeledEdit2.Text)) then
      begin

        StringGrid1.Cells[0, cs] := agenda[I].nome;
        StringGrid1.Cells[1, cs] := IntToStr(agenda[I].idade);
        StringGrid1.Cells[2, cs] := DateToStr(agenda[I].dataNascimento);
        StringGrid1.Cells[3, cs] := agenda[I].telefonec;
        StringGrid1.Cells[4, cs] := agenda[I].telefoner;
        StringGrid1.Cells[5, cs] := agenda[I].sexo;
        StringGrid1.Cells[6, cs] := agenda[I].endereço;
        StringGrid1.Cells[7, cs] := agenda[I].bairro;
        StringGrid1.Cells[8, cs] := agenda[I].estadocivil;
        StringGrid1.Cells[9, cs] := agenda[I].cep;

        // ..
        Inc(cs);

      end;

  end;
end;

procedure TForm1.limpacadastro;
begin
  LabeledEdit1.Clear;
  Edit1.Clear;
  CalendarPicker1.Date := now;
  MaskEdit1.Text := '';
  MaskEdit2.Text := '';
  ComboBox1.ItemIndex := 0;
  LabeledEdit7.Clear;
  LabeledEdit8.Clear;
  LabeledEdit9.Clear;
  MaskEdit3.Text := '';

end;

procedure TForm1.limpargrade;
var
  c, r: Integer;
begin
  for c := 0 to StringGrid1.ColCount - 1 do
  begin
    for r := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[c, r] := '';

    end;
  end;

end;

function TForm1.procuraposicaolivre: Integer;
var
  I: Integer;

begin

  for I := 0 to 99 do
  begin
    if agenda[I].status = false then
    begin
      result := I;
      exit;
    end;
  end;

  result := (-1);
  exit;

end;

procedure TForm1.redesenhaGrid;
var
  c, l: Integer;
  I: Integer;
  G: Integer;
  x: Integer;
  ano: Word;
  mes: Word;
  dia: Word;
begin

  for c := 0 to 10 do
  begin
    for l := 1 to 99 do
    begin
      StringGrid1.Cells[c, l] := '';
    end;
  end;

  x := 0;
  for I := 0 to 99 do
  begin

    if agenda[I].status = true then
    begin

      Inc(x);

      DecodeDate(agenda[I].dataNascimento, ano, mes, dia);
      StringGrid1.Cells[0, x] := agenda[I].nome;
      StringGrid1.Cells[1, x] := IntToStr(agenda[I].idade);
      StringGrid1.Cells[2, x] := IntToStr(dia) + '/' + IntToStr(mes) + '/' +
        IntToStr(ano);
      StringGrid1.Cells[3, x] := agenda[I].telefonec;
      StringGrid1.Cells[4, x] := agenda[I].telefoner;
      StringGrid1.Cells[5, x] := agenda[I].sexo;
      StringGrid1.Cells[6, x] := agenda[I].endereço;
      StringGrid1.Cells[7, x] := agenda[I].bairro;
      StringGrid1.Cells[8, x] := agenda[I].estadocivil;
      StringGrid1.Cells[9, x] := agenda[I].cep;

    end;

  end;

end;

procedure TForm1.SearchBox1Change(Sender: TObject);
var
  cs, I: Integer;
begin
  ComboBox2.Enabled := false;
  LabeledEdit2.Enabled := false;
  if (SearchBox1.Text <> '') then
  begin

    limpargrade();
    cs := 1;
    for I := 0 to 99 do
      if (agenda[I].status = true) and (agenda[I].nome = SearchBox1.Text) then
      begin

        StringGrid1.Cells[0, cs] := agenda[I].nome;
        StringGrid1.Cells[1, cs] := IntToStr(agenda[I].idade);
        StringGrid1.Cells[2, cs] := DateToStr(agenda[I].dataNascimento);
        StringGrid1.Cells[3, cs] := agenda[I].telefonec;
        StringGrid1.Cells[4, cs] := agenda[I].telefoner;
        StringGrid1.Cells[5, cs] := agenda[I].sexo;
        StringGrid1.Cells[6, cs] := agenda[I].endereço;
        StringGrid1.Cells[7, cs] := agenda[I].bairro;
        StringGrid1.Cells[8, cs] := agenda[I].estadocivil;
        StringGrid1.Cells[9, cs] := agenda[I].cep;

        // ..
        Inc(cs);

      end;

  end;
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin

  if (StringGrid1.Cells[0, StringGrid1.row].Length <> 0) and
    (StringGrid1.row <> 0) then
  begin
    excluibotao.Enabled := true;
    editbotao.Enabled := true;
  end;
end;

procedure TForm1.TabSheet2Show(Sender: TObject);

var
  x, y: Integer;
  ano, mes, dia: Word;
  I: Integer;

begin

  x := 0;
  for I := 0 to 99 do
  begin

    if agenda[I].status = true then
    begin

      Inc(x);

      DecodeDate(agenda[I].dataNascimento, ano, mes, dia);
      StringGrid1.Cells[0, x] := agenda[I].nome;
      StringGrid1.Cells[1, x] := IntToStr(agenda[I].idade);
      StringGrid1.Cells[2, x] := IntToStr(dia) + '/' + IntToStr(mes) + '/' +
        IntToStr(ano);
      StringGrid1.Cells[3, x] := agenda[I].telefonec;
      StringGrid1.Cells[4, x] := agenda[I].telefoner;
      StringGrid1.Cells[5, x] := agenda[I].sexo;
      StringGrid1.Cells[6, x] := agenda[I].endereço;
      StringGrid1.Cells[7, x] := agenda[I].bairro;
      StringGrid1.Cells[8, x] := agenda[I].estadocivil;
      StringGrid1.Cells[9, x] := agenda[I].cep;

    end;

  end;
  editbotao.Enabled := false;
  excluibotao.Enabled := false;

end;

procedure TForm1.TabSheet3Show(Sender: TObject);
begin
  if (edicao <> 1) then
  begin

    LabeledEdit1.Clear;
    Edit1.Clear;
    CalendarPicker1.Date := now;
    MaskEdit1.Text := '';
    MaskEdit2.Text := '';
    ComboBox1.ItemIndex := 0;
    LabeledEdit7.Clear;
    LabeledEdit8.Clear;
    LabeledEdit9.Clear;
    MaskEdit3.Text := '';
  end;

end;

function TForm1.retornaposicaonome(pName: String): Integer;
var
  I: Integer;
begin

  // Percorrer a agenda procurando todas as posições true
  // Nestas posições vou perguntar se o pName é igual a agenda[i].Nome
  // Se sim vou retornar retornar 0 e dar exit
  // retorno 1 e dou exit

  for I := 0 to 99 do
  begin

    if (pName = agenda[I].nome) AND (agenda[I].status = true) then
    begin
      result := I;
      exit;
    end;
  end;

  result := 1;
  exit;

end;

function TForm1.verificanome(pName: String): Integer;
var
  I: Integer;
begin

  // Percorrer a agenda procurando todas as posições true
  // Nestas posições vou perguntar se o pName é igual a agenda[i].Nome
  // Se sim vou retornar retornar 0 e dar exit
  // retorno 1 e dou exit

  for I := 0 to 99 do
  begin

    if (pName = agenda[I].nome) AND (agenda[I].status = true) then
    begin
      result := 0;
      exit;
    end;
  end;

  result := 1;
  exit;

end;

function TForm1.verificaPosicaoLivre: Integer;
var
  I: Integer;
begin
  for I := 0 to 9 do
  begin
    if agenda[I].status = false then
    begin
      result := 1;
    end;
    result := -1;

  end;
end;

end.

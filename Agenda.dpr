program Agenda;

uses
  Vcl.Forms,
  ABOUT in 'ABOUT.pas' {AboutBox},
  UnitLogin2 in 'UnitLogin2.pas' {Form2},
  UntAgenda in 'UntAgenda.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

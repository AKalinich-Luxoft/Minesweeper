program Minesweeper;

uses
  Forms,
  unMain in 'unMain.pas' {fmMain},
  unSettings in 'unSettings.pas' {fmSettings},
  unVictory in 'unVictory.pas' {fmVicrory},
  unAnimate in 'unAnimate.pas' {ANM},
  unLose in 'unLose.pas' {fmLose},
  unAbout in 'unAbout.pas' {AboutBox},
  unPots in 'unPots.pas' {fmPots},
  unPantenon in 'unPantenon.pas' {fmPantenon},
  unChack in 'unChack.pas' {fmChack},
  unHall in 'unHall.pas' {fmHall},
  unHelp in 'unHelp.pas' {fmHelp};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Саперчикэ';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSettings, fmSettings);
  Application.CreateForm(TfmVicrory, fmVicrory);
  Application.CreateForm(TANM, ANM);
  Application.CreateForm(TfmLose, fmLose);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfmPots, fmPots);
  Application.CreateForm(TfmPantenon, fmPantenon);
  Application.CreateForm(TfmChack, fmChack);
  Application.CreateForm(TfmHall, fmHall);
  Application.CreateForm(TfmHelp, fmHelp);
  Application.Run;
end.

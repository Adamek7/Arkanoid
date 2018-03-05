program Arkanoid;

{$mode objfpc}{$H+}
{$APPTYPE GUI}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, allegro, poczatek, panel, paletka, kulka, poziomy, bonusy
  { you can add units after this };


begin

  start();
  init_menu();
  init_panel();
  init_paletke();
  init_kulka();
  init_pzm1();
  init_bonusy1();
  init_pzm2();
  init_bonusy2();
  while ( nr_menu <> 0 ) do
  begin
    if (nr_menu <> 4) then
    begin
      if (nr_menu = 1) AND ((zycie=0) OR (pzm>2)) then
      begin
        init_panel();
        init_paletke();
        init_kulka();
        init_pzm1();
        init_bonusy1();
        init_pzm2();
        init_bonusy2();
      end;
      czysc_tlo();
      wys_menu();
      klik_myszka();
      bufor_na_ekran();
    end;
    if (nr_menu = 4) then
    begin
      {czysc_tlo();
      wys_panel();
      wys_pzm();
      wys_paletke();
      wys_kulka_start();
      wys_bonusy();
      bufor_na_ekran();
      if( al_key[ AL_KEY_SPACE ] ) then
      begin}
        while( kulka1.kulka_y < 600 ) and (al_key[ AL_KEY_ESC ] = false) do
        begin
          czysc_tlo();
          wys_panel();
          wys_pzm();
          wys_paletke();
          wys_kulka_ruch();
          wys_bonusy();
          //writeln(al_readkey());
          bufor_na_ekran();
          if(spr_wygranej()) then begin kulka1.kulka_y:=600; zycie:=zycie+1; end;
        end;
        if( al_key[ AL_KEY_ESC ] ) then begin nr_menu:=3; end
        else
        begin
          po_porazce_paletka();
          po_porazce_kulka();

          if (zycie=0) or (pzm>2) then
          begin
            if (zycie=0) then
            begin
              al_textout_ex( al_screen, font_pcx, 'Przegrales! Aby kontynowac wcisnij Enter.', 50, 300, al_makecol( 0, 0, 0 ), - 1 );
              while (al_readkey() <> 17165) do
            end;
            if (pzm>2) then
            begin
              al_textout_ex( al_screen, font_pcx, 'Wygrales! Aby kontynowac wcisnij Enter.', 50, 300, al_makecol( 0, 0, 0 ), - 1 );
              while (al_readkey() <> 17165) do
            end;

            al_destroy_bitmap(paletka1.paletka_bm);
            al_destroy_bitmap(kulka1.kulka_bm);
            nr_menu:=1;
          end;
        end;
      //end;
    end;
  end;
  stop();
end.


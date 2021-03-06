unit poczatek;

{$mode objfpc}{$H+}


interface

uses
  Classes, SysUtils, allegro;

const wysokosc = 600;
const szerokosc = 1000;

var
  bufor : ^AL_BITMAP;

procedure start();
procedure stop();
procedure czysc_tlo();
procedure bufor_na_ekran();



implementation



procedure start();
begin
  al_init();
  al_install_keyboard();
  al_install_mouse();
  al_set_color_depth(16);
  al_set_gfx_mode(AL_GFX_AUTODETECT_WINDOWED, szerokosc, wysokosc, 0, 0);
  bufor := NIL;
  bufor := al_create_bitmap( szerokosc, wysokosc );
  if( bufor = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'Nie mogę utworzyć bufora !' );
    al_exit();
    exit();
  end;
  al_show_mouse( al_screen );
  al_unscare_mouse();
end;

procedure czysc_tlo();
begin
  al_clear_to_color( bufor, al_makecol( 67, 191, 199 ) );
end;

procedure bufor_na_ekran();
begin
  al_blit( bufor, al_screen, 0, 0, 0, 0, szerokosc, wysokosc);
end;


procedure stop();
begin
  //al_clear_keybuf();
  al_destroy_bitmap(bufor);
  //al_readkey();
  al_exit();
end;

end.


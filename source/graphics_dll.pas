(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Graphics_dll;

{$mode objfpc}

interface

uses
  // GRAPHICS LIBS

  GLUT, GL, GLU, Graphics, Biblioteka_Grow_4_grafika,

  //GENERAL LIBS

  Classes, SysUtils, General_dll;

  Function Main3DDrawFunction():boolean;

  Function Draw3dAtoms():boolean;

implementation

Uses
  Unit1, Unit20, Unit22, Unit12;

Function Main3DDrawFunction():boolean;
Begin
//-- INITIALIZE

  glViewport(0, 0, IVM.Openglcontrol1.width, IVM.Openglcontrol1.Height); // okienko (rozmiary)

  glClearColor(Red(Settings.BackgroundColor.ButtonColor), // red,green,blue,alpha Kolor, którym czysci sie ekran
             Green(Settings.BackgroundColor.ButtonColor),
             Blue(Settings.BackgroundColor.ButtonColor),
             0);

//-- PROJECT MATRIX

   glMatrixMode( GL_PROJECTION );
   glLoadIdentity();

   if g4g_Projections = 'Orthographic' then
   begin
    glOrtho (-IVM.OpenGLcontrol1.width/2, // zut prostopadly    - zrobic perspektywe !!!
              IVM.OpenGLcontrol1.width/2,
              IVM.OpenGLcontrol1.height/2,
             -IVM.OpenGLcontrol1.height/2,
             -50000, 50000);
    end;

   if g4g_Projections = 'Perspective' then
   begin
     gluPerspective(22,IVM.OpenGLControl1.Width/IVM.OpenGLControl1.Height,0.1,1000);
   end;

   gluLookAt( 0, 0, g4g_LookZ,   // współrzędne x, y, z położenia kamery
              0, 0, 0,     // x, y, z punktu na który patrzy kamera
              0, 1, 0 );  // stałe liczby

//-- ENAGLE GENERAL FUNCTIONS

   glEnable (GL_COLOR_MATERIAL) ;
   glEnable(GL_DEPTH_TEST);
   glEnable(GL_CULL_FACE);
   glCullFace(GL_FRONT); // glCullFace(GL_BACK);

   glEnable (GL_BLEND);
   glBlendFunc (GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);

//-- RENDERING QUALITY

  If g4g_rendering_quality ='Best' then
     begin
       glEnable (GL_POINT_SMOOTH);
       glEnable (GL_LINE_SMOOTH);
       glEnable( GL_POLYGON_SMOOTH );

       glHint( GL_FOG_HINT, GL_NICEST);
       glHint( GL_LINE_SMOOTH_HINT, GL_NICEST);
       glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
       glHint( GL_POINT_SMOOTH_HINT , GL_NICEST);
       glHint( GL_POLYGON_SMOOTH_HINT, GL_NICEST);

       glEnable (GL_POLYGON_SMOOTH);
       glEnable (GL_BLEND);
       glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

       glShadeModel(GL_SMOOTH);
   end;

  If g4g_rendering_quality ='Low' then
     begin
       glDisable (GL_POINT_SMOOTH);
       glDisable (GL_LINE_SMOOTH);
       glDisable( GL_POLYGON_SMOOTH );

       glHint( GL_FOG_HINT, GL_FASTEST);
       glHint( GL_LINE_SMOOTH_HINT, GL_FASTEST);
       glHint( GL_LINE_SMOOTH_HINT, GL_FASTEST);
       glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST);
       glHint( GL_POINT_SMOOTH_HINT , GL_FASTEST);
       glHint( GL_POLYGON_SMOOTH_HINT, GL_FASTEST);

       glShadeModel(GL_SMOOTH);
     end;

//-- MODEL MATRIX

     glMatrixMode( GL_MODELVIEW );

     glClear(GL_COLOR_BUFFER_BIT  or GL_DEPTH_BUFFER_BIT);

     glLoadIdentity();

//-- LIGHTS

     Lights(0); // When after glLoadIdentity(); rigit position

//-- GENERAL MATERIALS

    Materials(Settings.ComboBox2.ItemIndex); // materialy dla calej sceny

//-- TRANSFORMATIONS

   // CENTER SCENE or MOVE ALL VISIBLE OBJECTS

    if g4g_center = True then
       begin
         glTranslatef(0,0,0); g4g_TranslateX:=0; g4g_TranslateY:=0; // ZERO
       end else begin glTranslatef(g4g_TranslateX, g4g_TranslateY,0);  end;

    // ROTATION

    glRotatef(g4g_rotationy, 0, 1, 0); // Y
    glRotatef(g4g_rotationx, 1, 0, 0); // X

    // ZOOM / SCALE

    glScalef(g4g_scale, g4g_scale, g4g_scale); // skalowanie zoom

//-- MAIN 3D DRAW FUNCTIONS

       Draw3dAtoms();

//-- SWITCH BUFFORS

    IVM.OpenGLControl1.SwapBuffers;
end;

Function  Draw3dAtoms():boolean;
Var                             //   0       1 2 3   4     5
  a,b:integer;
  color:string;
begin

Try

  for a:=0 to ObjectsListRowCount() - 1 do
    begin

     // console.AddCommunicate('a:'+inttostr(a),true);

      if ObjectsList[a, ObjectsList_Included] = '1' then
       begin

         // console.AddCommunicate('b:'+inttostr(a),true);

         for b:= 0 to ObjectRowsCount(a) -1 do
           begin
             if (Objects[a, b, Object_Vis] = '1') or (Objects[a, b, Object_Inc] = '1') then
              begin

               glPushMatrix();

               // console.AddCommunicate(Objects[a, b, Atom_X]+' '+Objects[a, b, Atom_Y]+' '+Objects[a, b, Atom_Z]+' '+Objects[a, b, Object_Color]+' '+ Objects[a, b, Object_Radius],true);

                  // ustal wspolrzedne
                  glTranslatef(StrToFloat(Objects[a, b, Atom_X]),  //X
                               StrToFloat(Objects[a, b, Atom_Y]),  //Y
                               StrToFloat(Objects[a, b, Atom_Z])); //Z

                  // pobierz kolor atomu
                  color:= Objects[a, b, Object_Color]; // KOLORY USTALONE W GRIDZIE

                  glColor4ub(Red(StringToColor(color)),   // Kolory atomow  glColor3f
                            Green(StringToColor(color)), // glColor4ub(red, green, blue, alpha)
                            Blue(StringToColor((color))),g4g_AN1_color_alpha);

                  // rodzaj kuli
                  if settings.CheckBox1.Checked then
                      begin
                         glutWireSphere(StrToFloat(Objects[a, b, Object_Radius])*StrToFloat(settings.LabeledEdit1.Text), 25, 25); // radius, ilosc kresek, ilosc kresek
                      end;
                  if settings.CheckBox2.Checked then
                      begin
                        glutSolidSphere(StrToFloat(Objects[a, b, Object_Radius])*StrToFloat(settings.LabeledEdit1.Text), 25, 25); // radius, ilosc kresek, ilosc kresek
                      end;

                  glPopMatrix();

              end;
           end;
       end;
    end;

    Result:=true;
  except
    Result:=False;
    console.AddCommunicate('Ups! Something went wrong in OpenGL: Draw3dAtoms() !',true);
  end;
end;

end.

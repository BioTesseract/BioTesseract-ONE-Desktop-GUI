Function RMSDR(x1,y1,x1,x2,y2,z2:TstringList);
var
  tresc_wyniku: string;
  iloscpom:integer;
  wynik_cal,wynik_cal_bezdz,xc,yc,zc,temp,chiralny:currency;
  policz:Boolean;
begin

wynik_cal:=0;
iloscpom:=0;

if (x1.Count=x2.Count) and (y1.Count=y2.Count) and (z1.Count=z2.Count) then
  begin
   For i:=1 to x1.Count-1 do
         begin                       // potêgowanie roznicy w danych np. xc=(x2-x1)2
          if (strtocurrDef(x1[i],-1)<>-1) and (strtocurrDef(x1[i],1)<>1)
            and (strtocurrDef(x2[i],-1)<>-1) and (strtocurrDef(x2[i],1)<>1) then
              begin
                xc:= strtocurr(x2[i]) - strtocurr(x1[i]);
                xc:= Power(xc,2);
                policz:=True;
              end else begin policz:=False end;

         if (strtocurrDef(y1[i],-1)<>-1) and (strtocurrDef(y1[i],1)<>1)
            and (strtocurrDef(y2[i],-1)<>-1) and (strtocurrDef(y2[i],1)<>1) then
              begin
                yc:= strtocurr(y2[i]) - strtocurr(y1[i]);
                yc:= Power(yc,2);
                policz:=True;
              end else begin policz:=False end;

         if (strtocurrDef(z1[i],-1)<>-1) and (strtocurrDef(z1[i],1)<>1)
            and (strtocurrDef(z2[i],-1)<>-1) and (strtocurrDef(z2[i],1)<>1) then
              begin
                zc:= strtocurr(z2[i]) - strtocurr(z1[i]);
                zc:= Power(zc,2);
                policz:=True;
              end else begin policz:=False end;

           temp:= xc+yc+zc;    // suma potegowanych
           temp:= sqrt(temp);  // pierwiastek z sumy, czyli odleglosc

           wynik_cal:=wynik_cal + temp;   // pierwiastkowanie sumy
          if policz=True then
           begin 
		     iloscpom:=iloscpom + 1; 
		   end else begin  Showmessage(com22); break; end;

      // przesyniêcie wêgla chiralnego
     if (strtoint(labelededit7.Text)<> 0) and (i=strtoint(labelededit7.Text)) then
       begin
         chiralny:= temp;
       end;
     //<-

         end;

     wynik_cal_bezdz := wynik_cal;
     
     if wynik_cal <> 0 then
      begin
       wynik_cal := wynik_cal/iloscpom;
      end;

     wynik_cal := sqrt(wynik_cal);  			// pierwiastek po dzieleniu
	 wynik_cal_bezdz := sqrt(wynik_cal_bezdz);  // pierwiastek bez dzielenia
	 
     tresc_wyniku:=('[z dzieleniem]: '+ currtostr(wynik_cal)
                  +#13#10'[bez dzielenia]: '+ currtostr(wynik_cal_bezdz)
				   );
				   
   end else showmessage(com16);
   
   Return:=tresc_wyniku;
end;
end;

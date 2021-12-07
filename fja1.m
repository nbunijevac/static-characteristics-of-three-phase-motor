function [Me,Is,Ir] = fja1(ws,P,Us,Rs,Rr,lr,ls,M,w)

    wr = ws - w;
    s = wr/ws;
    
    zs = Rs + 1j*ws*ls;
    zr = Rr/s + 1j*ws*lr;
    zm = 1j*ws*M;
    ze = zs + zm*zr/(zm+zr);

    if (w==ws)
        Me = 0;
        Ir = 0;
        Is = Us/(zs + zm);
    else
        

    Is = Us/ze;
    E = Us - zs*Is;
    Im = E/zm;
    Ir = Is - Im;
    Me = 3*P*Rr*abs(Ir)^2/wr;
    
    end
end
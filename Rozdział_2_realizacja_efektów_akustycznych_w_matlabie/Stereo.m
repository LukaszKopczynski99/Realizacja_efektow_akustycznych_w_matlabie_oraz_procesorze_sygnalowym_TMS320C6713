function Stereo (sciezka,nazwa,rozszerzenie)
    ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);
    
    [x,Fs] = audioread(ProbkaSygnalu); 
    
    [m,kanal]=size(x); 
    
    if kanal == 1 
        
        y=x;      
         
    elseif kanal == 2 
        
        y=sum(x,2); 
    
        Maxi_Amp=max(abs(y)); 
    
        y=y/Maxi_Amp; 
        Maxi_Amp_Left=max(abs(x(:,1))); 
        Maxi_Amp_Right=max(abs(x(:,2))); 
    
        Maxi_Amp=max([Maxi_Amp_Left Maxi_Amp_Right]); 
    
        y=y*Maxi_Amp; 
    else
        disp('Blad wyboru'); 
        return;
    end
    
    audiowrite("Zapisane_pliki_koncowe\Stereo_efekt_koncowy.wav",y,Fs); 
    t = (0:length(y)-1)/Fs; 
    
    subplot(3,1,1)
    plot(t,x)
    if kanal == 2 
        legend('Wejście L','Wejscie P');
    else
    legend('Wejście')
    end
    title("Przebieg sygnału wejściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    subplot(3,1,2)
    plot(t,y)
    legend('Wyjście')
    title("Przebieg sygnału wyjściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    figure(2)

    subplot(4, 1, 1)
    FFT_sig = fft(x);
    Y = abs(FFT_sig(1:round(length(x) / 2 + 1)));
    freq = (0:length(FFT_sig) - 1) * Fs / length(FFT_sig);
    l = floor(length(Y)/6);
    plot(freq(1:l) / 1000, Y(1:l))

    title('Analizowany sygnał wejściowy w dziedzinie częstotliwości')
    xlabel('Częstotliwość [kHz]')
    ylabel('Amplituda')
    grid on
    
    subplot(4,1,2)
    FFT_sig2=fft(y);
    Z = abs(FFT_sig2(1:round(length(y)/2+1)));
    u = floor(length(Z)/6);
    plot(freq(1:u) / 1000, Z(1:u))
      
    title('Analizowany sygnał zmodulowany w dziedzinie częstotliwości')
    xlabel('Częstotliwość [kHz]')
    ylabel('Amplituda')
    grid on
    
    syg_wej=audioplayer(x,Fs); 
    playblocking(syg_wej); 
    sound(y,Fs); 
    
   x=1;
   m=x;
   y=m;
end
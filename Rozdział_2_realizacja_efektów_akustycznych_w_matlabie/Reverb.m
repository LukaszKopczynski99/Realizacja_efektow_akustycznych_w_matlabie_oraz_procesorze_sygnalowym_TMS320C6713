function Reverb ( sciezka , nazwa , rozszerzenie , G , Opoznienie ) 

    ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

    [x, Fs] =audioread(num2str(ProbkaSygnalu)); 

    LEN = length(x); 

    y = zeros(LEN,1); 

    D =round( 0.001 * Opoznienie * Fs );

for n=D+1:LEN 
    
    y(n)= x(n) + G * y(n-D); 
    
end
    
    Reverb_zapis_pliku = y * 0.7; 

    audiowrite("Zapisane_pliki_koncowe\Reverb_efekt_koncowy.wav",Reverb_zapis_pliku,Fs); 

    t = (0:length(y)-1)/Fs; 
    
    subplot(3,1,1)
    plot(t,x)
    legend('Sygnal wejsciowy')
    title("Przebieg sygnału wejściowego")
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
end
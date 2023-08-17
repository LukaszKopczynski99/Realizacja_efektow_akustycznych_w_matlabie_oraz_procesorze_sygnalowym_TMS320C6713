 function flanger (sciezka , nazwa , rozszerzenie , G , Opoznienie, Czestotliwosc_modulacji)

ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

[x, fs] =audioread(num2str(ProbkaSygnalu)); 

LEN = length(x); 
D =round( 0.001 * Opoznienie * fs ) ;%(zakres 0.25 - 25 ms)
y = zeros(LEN,1); 
fcycle = Czestotliwosc_modulacji/fs; 

for n=D+1:LEN 
    opoznienie_flanger = round((D/2)*(1-cos(2*pi*n*fcycle)));
    y(n) = 0.5 * x(n) + G * x(n-opoznienie_flanger); 
end

    audiowrite("Zapisane_pliki_koncowe\Flanger_efekt_koncowy.wav",y,fs); 

    t = (0:length(y)-1)/fs;
    
    figure(1)
    
    subplot(3,1,1)
    plot(t,x)
    legend('Sygnal wejsciowy')
    title("Przebieg sygnału wejściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    subplot(3,1,2)
    plot(t,y)
    legend('Sygnal wyjsciowy')
    title("Przebieg sygnału wyjściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    figure(2)
    
    subplot(4,1,1)
    FFT_sig=fft(x);
    Y = abs(FFT_sig(1:round(length(x)/2+1)));
    freq = (0:length(FFT_sig)-1)*fs/length(FFT_sig);
    plot(freq(1:length(Y))/1000,Y)
  
    title('Analizowany sygnał wejściowy w dziedzinie częstotliwości')
    xlabel('Częstotliwość [kHz]')
    ylabel('Amplituda')
    grid on
    
 figure(2)

    subplot(4, 1, 1)
    FFT_sig = fft(x);
    Y = abs(FFT_sig(1:round(length(x) / 2 + 1)));
    freq = (0:length(FFT_sig) - 1) * fs / length(FFT_sig);
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

    syg_wej=audioplayer(x,fs); 
    playblocking(syg_wej); 
    sound(y,fs); 

 end
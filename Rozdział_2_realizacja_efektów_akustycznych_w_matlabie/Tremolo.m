function Tremolo (sciezka , nazwa , rozszerzenie , Amplituda , Czestotliwosc_modulacji)

ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

[x, Fs] =audioread(num2str(ProbkaSygnalu)); 
 
LEN = length(x);
y = zeros(LEN,1);
fmod = Czestotliwosc_modulacji/Fs;



for n=1:LEN 
    
    Tremolo_delay = (cos(2*pi*fmod*n));
    y(n) = 0.5 * ( x(n) ) * (1 + Amplituda * Tremolo_delay); 
    
end

tremolo_zapis_pliku = y * 0.3; 

audiowrite("Zapisane_pliki_koncowe\Tremolo_efekt_koncowy.wav",tremolo_zapis_pliku,Fs); 

t = (0:length(y)-1)/Fs; 

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
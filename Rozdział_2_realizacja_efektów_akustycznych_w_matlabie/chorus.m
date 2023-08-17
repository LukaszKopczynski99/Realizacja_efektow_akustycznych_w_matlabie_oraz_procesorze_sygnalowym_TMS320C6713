function chorus (sciezka , nazwa , rozszerzenie , Czas_opoznienia , Czestotliwosc_modulacji )

ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

[x, Fs] =audioread(num2str(ProbkaSygnalu)); 

LEN = length(x);
y = zeros(LEN,1); 
fdelay = Czestotliwosc_modulacji /Fs; 

for n=Czas_opoznienia+1:LEN 
    Chorus_delay = round(Czas_opoznienia*(0.5+(2*pi*n*fdelay))); 
    y(n) = 0.5 *( x(n) + x(n-Chorus_delay));
end
    
    audiowrite("Zapisane_pliki_koncowe\Chorus_efekt_koncowy.wav",y,Fs);

    t = (0:length(y)-1)/Fs;
    
    sygnal_wejsciowy=sum(x,2); 
    
    figure(1)
    
    subplot(3,1,1)
    plot(t,sygnal_wejsciowy)
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
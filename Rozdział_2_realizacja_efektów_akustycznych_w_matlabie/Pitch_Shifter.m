function Pitch_Shifter (sciezka , nazwa , rozszerzenie ,G, Czas_opoznienia , Czestotliwosc_sygnalu , up_or_down )

ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

[x, Fs] =audioread(num2str(ProbkaSygnalu)); 

LEN = length(x);  
D = round( 0.001 * Czas_opoznienia * Fs ) ; 
y = zeros(LEN,1); 
fshift = Czestotliwosc_sygnalu / Fs; 

if up_or_down == ("up")
    
    for n=D+1:LEN 
    Pitch_delay = round(D*(-sawtooth(2*pi*n*fshift)));
    y(n) = G *(x(n-Pitch_delay)); 
    end
    
elseif up_or_down == ("down")
    
    for n=D+1:LEN 
    Pitch_delay = round(D*(sawtooth(2*pi*n*fshift))); 
    y(n) = G *(x(n-Pitch_delay)); 
    end
    
else
    disp('Blad wyboru');
        return;
end

    audiowrite("Zapisane_pliki_koncowe\Pitch_Shifter_efekt_koncowy.wav",y,Fs); 

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
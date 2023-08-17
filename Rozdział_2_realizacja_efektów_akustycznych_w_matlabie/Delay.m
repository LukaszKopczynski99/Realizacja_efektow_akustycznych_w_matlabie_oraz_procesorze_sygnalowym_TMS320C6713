function Delay (sciezka , nazwa , rozszerzenie , G , Opoznienie )

    ProbkaSygnalu = strcat(sciezka,'\',nazwa, rozszerzenie);

    [x, Fs] =audioread(num2str(ProbkaSygnalu));

    D =round( 0.001 * Opoznienie * Fs ) ;

    bufor_wejsciowy = [x;zeros(D,1)];
    bufor_wyjsciowy = [zeros(D,1);x]*G;
    
    y = bufor_wejsciowy+bufor_wyjsciowy;

    audiowrite("Zapisane_pliki_koncowe\Delay_efekt_koncowy.wav",y,Fs); 
    
    t = (0:length(y)-1)/Fs; 
    
    subplot(3,1,1)
    plot(t,bufor_wejsciowy)
    legend('Sygnal wejsciowy')
    title("Przebieg sygnału wejściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    subplot(3,1,2)
    plot(t,y)
    legend('Sygnal wyjsciowy ')
    title("Przebieg sygnału wyjściowego")
    xlabel("Czas [s]")
    ylabel("Amplituda")
    grid on
    
    subplot(3,1,3)
    plot(t,[bufor_wejsciowy bufor_wyjsciowy])
    legend('Sygnal wejsciowy','Sygnal opozniony ')
    title("Przebieg sygnału wyjściowego z rodzielonymi sygnałami")
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
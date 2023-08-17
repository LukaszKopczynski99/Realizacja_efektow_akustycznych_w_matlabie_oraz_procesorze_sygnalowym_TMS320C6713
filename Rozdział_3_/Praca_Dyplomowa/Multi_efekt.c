#include "Multi_efekt.h"

Uint32 fs = DSK6713_AIC23_FREQ_8KHZ;
#define DSK6713_AIC23_INPUT_MIC 0x0015
#define DSK6713_AIC23_INPUT_LINE 0x0011
Uint16 inputsource = DSK6713_AIC23_INPUT_MIC;

#define BUFFER_SIZE 8000
short buffer[BUFFER_SIZE];
short wejscie, wyjscie, opoznienie, suma_delay, efekt_flanger, efekt_chorus,
        efekt_tremolo;
int n;

#define Gain 0.6
#define pi 3.14
#define fcycle 8 / fs
#define fdelay 3 / fs
#define fmod 11 / fs
#define D 0.001 * 1 * 8000
#define Amplituda 0.7

union
{
    Uint32 uint;
    short channel[2];
} AIC23_data;

void ByPass()
{
    wejscie = input_sample();
    output_sample(wejscie);
}

void Sumowanie_kanalow()
{
    AIC23_data.channel[RIGHT] = input_right_sample();
    AIC23_data.channel[LEFT] = input_left_sample();

    wyjscie = ((AIC23_data.channel[LEFT]) + (AIC23_data.channel[RIGHT])) / 2;

    output_sample(wyjscie);
}


void Delay()
{

    {
        wejscie = input_left_sample();

        opoznienie = buffer[n];
        buffer[n] = wejscie;

        wyjscie = opoznienie;
        suma_delay = wejscie + Gain * wyjscie;

        output_left_sample(suma_delay);
    }
}


void Poglos()
{


    {
        wejscie = input_left_sample();

        opoznienie = buffer[n];

        wyjscie = wejscie + opoznienie;

        output_left_sample(wyjscie);

        buffer[n] = wejscie + opoznienie * Gain;
    }
}

void Flanger()
{


    {

        wejscie = input_left_sample();

        opoznienie = round((D / 2) * (1 - cos(2 * pi * n * fcycle)));

        buffer[n] = wejscie * opoznienie;

        efekt_flanger = (0.5 * wejscie) + (Gain * buffer[n]);


        wyjscie = efekt_flanger;

        output_left_sample(wyjscie);

    }
}

void Chorus()
{

    {
        wejscie = input_left_sample();

        opoznienie = round((0.5 + (cos(2 * pi * n * fdelay))));

        buffer[n] = (wejscie * opoznienie);

        efekt_chorus = (0.5 * wejscie) + (0.5 * buffer[n]);

        wyjscie = efekt_chorus;

        output_left_sample(wyjscie);
    }
}

void Tremolo()
{

    {
        wejscie = input_left_sample();

        opoznienie = (1 + Amplituda * (cos(2 * pi * fmod * n)));

        buffer[n] = wejscie;

        efekt_tremolo = buffer[n] * opoznienie;

        wyjscie = efekt_tremolo;

        output_left_sample(wyjscie);
    }
}

#include "stdio.h"
#include "dsk6713.h"
#include "dsk6713_aic23.h"
#include "c6713dskinit.h"
#include "math.h"
#include "dsk6713_led.h"
#include "dsk6713_dip.h"
#include "Multi_efekt.h"
#include "dsk6713_flash.h"

Uint32 DSK6713_DIP_GetValue(void)
{
    Uint32 value = 0; int i;
    for (i = 0; i < 4; i++)
    {
        if (DSK6713_DIP_get(i) == 1)
        {
            value |= (1 << i);
        }
    }
    return value;
}

void DSK6713_LED_SetValue(Uint32 value)
{
    int i;
    for (i = 0; i < 4; i++)
    {
        if (value & (1 << i))
        {
            DSK6713_LED_on(i);
        }
        else
        {
            DSK6713_LED_off(i);
        }
    }
}

typedef enum{
    EFECT_NONE,
    EFECT_CHANNEL_SUM,
    EFECT_DELAY,
    EFECT_,
    EFECT_FLANGER,
    EFECT_CHORUS,
    EFECT_TREMOLO
}EFECT;

void (*EfectFunction[7])(void) = {
    ByPass,
    Sumowanie_kanalow,
    Delay,
    Poglos,
    Flanger,
    Chorus,
    Tremolo
};

void main()
{

    comm_poll();
    DSK6713_LED_init();
    DSK6713_DIP_init();

    printf("Multi_efekt realizujacy efekty akustyczne w procesorze sygnalowym TMS320C6713.\n\n");


    while (1)
    {
        Uint32 dip = DSK6713_DIP_GetValue();
        DSK6713_LED_SetValue(dip);
        EfectFunction[dip]();

    }
}

#include <main.h>

void SysTick_Handler(void)
{
    HAL_IncTick();
}

int main(void)
{
    HAL_Init();

    __GPIOD_CLK_ENABLE();

    GPIO_InitTypeDef gpio;
    gpio.Pin = GPIO_PIN_13;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_PULLUP;
    gpio.Speed = GPIO_SPEED_HIGH;
    HAL_GPIO_Init(GPIOD, &gpio);

    while (1)
    {
        HAL_GPIO_TogglePin(GPIOD, GPIO_PIN_13);
        HAL_Delay(++i % 100);
    }
    return 0;
}


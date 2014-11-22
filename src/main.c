#include <main.h>
#include <usbd_core.h>
#include <usbd_desc.h>
#include <usbd_hid.h>

#include <FreeRTOS.h>
#include <task.h>

USBD_HandleTypeDef  hUSBDDevice;

static void SystemClock_Config(void)
{
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_OscInitTypeDef RCC_OscInitStruct;

  /* Enable Power Control clock */
  __PWR_CLK_ENABLE();

  /* The voltage scaling allows optimizing the power consumption when the device is
     clocked below the maximum system frequency, to update the voltage scaling value
     regarding system frequency refer to product datasheet.  */
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE2);

  /* Enable HSE Oscillator and activate PLL with HSE as source */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = 8;
  RCC_OscInitStruct.PLL.PLLN = 336;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV4;
  RCC_OscInitStruct.PLL.PLLQ = 7;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);

  /* Select PLL as system clock source and configure the HCLK, PCLK1 and PCLK2
     clocks dividers */
  RCC_ClkInitStruct.ClockType = (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2);
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;
  HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);
}

void HAL_SYSTICK_Callback(void)
{
    // Create a buffer for the USBD_HID device
    // We are going to simulate a mouse
    static uint8_t buf[4] = {0};

    // Make the mouse... SHAKE WILDLY!
    buf[1] = rand() % 30 - 15;
    buf[2] = rand() % 30 - 15;

    USBD_HID_SendReport (&hUSBDDevice, buf, 4);
}

void BlinkTask(void* pParams)
{
    while (1)
    {
        HAL_GPIO_TogglePin(GPIOD, GPIO_PIN_12);
        vTaskDelay(1000 /*ticks*/);
    }
}

int main(void)
{
    HAL_Init();

    SystemClock_Config();

    // Confgiure the GPIOs associated with the LEDs
    __GPIOD_CLK_ENABLE();
    GPIO_InitTypeDef gpio;
    gpio.Pin = GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_PULLUP;
    gpio.Speed = GPIO_SPEED_HIGH;
    HAL_GPIO_Init(GPIOD, &gpio);

    // Add the LED blink task
    xTaskHandle taskHandle;
    xTaskCreate(
        BlinkTask,
        (const signed char*)"BlinkTask",
        1024, /* Stack size */
        NULL /* pParam */,
        tskIDLE_PRIORITY,
        &taskHandle);

    USBD_Init(&hUSBDDevice, &HID_Desc, 0);
    USBD_RegisterClass(&hUSBDDevice, USBD_HID_CLASS);
    USBD_Start(&hUSBDDevice);

    vTaskStartScheduler();

    while (1)
    {

        HAL_Delay(1000);
    }
    return 0;
}


/*
 * motor.c
 *
 * Created: 5/13/2014 3:48:15 PM
 *  Author: erikhk
 */ 

#define BIT(x) (1 << (x))
#define SETBITS(x,y) ((x) |= (y))
#define CLEARBITS(x,y) ((x) &= (~(y)))
#define SETBIT(x,y) SETBITS((x), (BIT((y))))
#define CLEARBIT(x,y) CLEARBITS((x), (BIT((y))))

#define W 1
#define R 0

#include <avr/io.h>
#define F_CPU 1000000UL
#include <util/delay.h>
#include "nRF24L01.h"

//SCK = PB7
//MOSI = PB5
//MISO = PB6
//CSN = PB0
//CE = PB1

uint8_t *data;
uint8_t test = 0;

uint8_t values[3] = {0x00, 0x94, 0x93};


void InitSPI(void)
{
	//Set SCK, MISO, CSN and CE as output
	DDRB |= (1 << DDB0) | (1 << DDB1) | (1 << DDB6) | (1 << DDB7);
	
	//Set MOSI as input
	DDRB &= ~(1<<PB5);
	PORTB |= (1<<PB5);
	
	USICR |= (1<<USIWM0)|(1<<USICS1)|(1<<USICLK);
	
	//Set CSN to high to start with
	SETBIT(PORTB, 0);
	//CE low
	CLEARBIT(PORTB, 1);
}


char WriteByteSPI(uint8_t cData)
{
	USIDR = cData;
	//clear flag so we can receive new data
	USISR |= (1<<USIOIF); 
	
	while((USISR & (1<<USIOIF)) == 0)
	{
		//Toggle SCK and count a 4-bit 
		//counter from 0-15, when it reaches
		//15 USIOIF is set!
		USICR |= (1<<USITC);
		
	}
	
	return USIDR;
}

uint8_t GetReg(uint8_t reg)
{
	_delay_us(10);
	//CSN low - nRF starts to listen
	CLEARBIT(PORTB, 0);
	_delay_us(10);
	WriteByteSPI(R_REGISTER + reg);
	_delay_us(10);
	reg = WriteByteSPI(NOP);
	_delay_us(10);
	//CSN high - go back to doing nothing
	SETBIT(PORTB, 0);
	return reg;
}

uint8_t *WriteToNrf(uint8_t ReadWrite, uint8_t reg, uint8_t *val, uint8_t antVal)
{
	
	if(ReadWrite == W)
	{
		reg = W_REGISTER + reg;
	}
	
	static uint8_t ret[32];
	
	_delay_us(10);
	CLEARBIT(PORTB, 0);
	_delay_us(10);
	WriteByteSPI(reg);
	_delay_us(10);
	
	int i;
	for (i=0; i<antVal; i++)
	{
		if(ReadWrite == R && reg != W_TX_PAYLOAD)
		{
			ret[i] = WriteByteSPI(NOP);
			_delay_us(10);
		}
		else
		{
			WriteByteSPI(val[i]);
			_delay_us(10);
		}
	}
	
	//Set CSN high again
	SETBIT(PORTB, 0);
	
	return ret;
}


void nrf24L01_init(void)
{
	
	_delay_ms(100);
	
	uint8_t val[5];
	
	val[0] = 0x01;
	WriteToNrf(W, EN_AA, val, 1);
	
	//retry etc, F (15) times
	val[0] = 0x2F;
	WriteToNrf(W, SETUP_RETR, val, 1);
	
	val[0] = 0x01;
	//enable data pipe 0
	WriteToNrf(W, EN_RXADDR, val, 1);
	
	val[0] = 0x03;
	WriteToNrf(W, SETUP_AW, val, 1);
	
	val[0] = 0x01;
	WriteToNrf(W, RF_CH, val, 1);
	
	val[0] = 0x07;
	WriteToNrf(W, RF_SETUP, val, 1);
	
	
	int i;
	for (i=0; i<5; i++)
	{
		val[i] = 0x12;
	}
	
	WriteToNrf(W, RX_ADDR_P0, val, 5);
	
	for (i=0; i<5; i++)
	{
		val[i] = 0x12;
	}
	
	WriteToNrf(W, TX_ADDR, val, 5);
	
	val[0] = 5;
	WriteToNrf(W, RX_PW_P0, val, 1);
	
	//choose if transmitter or receiver!
	//TRANSMITTER
	//val[0] = 0x1E;
	//RECEIVER
	val[0] = 0x1F;
	WriteToNrf(W, CONFIG, val, 1);
	
	
	
	_delay_ms(100);
}



void reset_tx(void)
{
	
	_delay_ms(10);
	
	uint8_t val[5];
	
	//val[0] = 0x01;
	//WriteToNrf(W, EN_AA, val, 1);
	
	//retry etc, F (15) times
	//val[0] = 0x2F;
	//WriteToNrf(W, SETUP_RETR, val, 1);
	
	//val[0] = 0x01;
	//enable data pipe 0
	//WriteToNrf(W, EN_RXADDR, val, 1);
	
	//val[0] = 0x03;
	//WriteToNrf(W, SETUP_AW, val, 1);
	
	val[0] = 0x01;
	WriteToNrf(W, RF_CH, val, 1);
	
	val[0] = 0x07;
	WriteToNrf(W, RF_SETUP, val, 1);
	
	
	int i;
	/*
	for (i=0; i<5; i++)
	{
		val[i] = 0x12;
	}
	
	WriteToNrf(W, RX_ADDR_P0, val, 5);
	*/
	
	for (i=0; i<5; i++)
	{
		val[i] = 0x12;
	}
	
	WriteToNrf(W, TX_ADDR, val, 5);
	
	
	
	val[0] = 5;
	WriteToNrf(W, RX_PW_P0, val, 1);
	
	//choose if transmitter or receiver!
	//TRANSMITTER
	val[0] = 0x1E;
	WriteToNrf(W, CONFIG, val, 1);
	
	
	
	_delay_ms(10);
}




void reset(void)
{
	_delay_us(10);
	//CSN low
	CLEARBIT(PORTB, 0);
	_delay_us(10);
	//Write to status registry
	WriteByteSPI(W_REGISTER + STATUS);
	_delay_us(10);
	//Reset all irq in STATUS reg
	WriteByteSPI(0x70);
	_delay_us(10);
	//CSN high again
	SETBIT(PORTB,0);
	
}

void receive_payload(void)
{
	//CE high - listens
	SETBIT(PORTB, 1);
	_delay_ms(20);
	
	//CE low again - stop listening
	CLEARBIT(PORTB, 1);
	
}


void transmit_payload(uint8_t * W_buff)
{
	//flush registry
	WriteToNrf(R, FLUSH_TX, W_buff, 0);
	WriteToNrf(R, W_TX_PAYLOAD, W_buff, 5);
	
	_delay_ms(10);
	//CE high - transmit data!
	SETBIT(PORTB, 1);
	//delay at least 10
	_delay_ms(20);
	CLEARBIT(PORTB, 1);
	_delay_ms(10);
	
	
	
}



int main(void)
{
	//DDRD = 0xff;
	//DDRB = 0xff;
	DDRD |= (1<<DDD5);
	DDRD |= (1<<DDD4);
	DDRD |= (1<<DDD1);
	
	DDRB |= (1<<DDB2);
	
	//receiver!
	
	DDRB |= (1<<DDB2);
	DDRB |= (1<<DDB3);
	DDRB |= (1<<DDB4);
	
	//PD4 - ENABLE 1
	SETBIT(PORTD, 4);
	//PB2 - INPUT 1			PIN 2
	SETBIT(PORTB, 2);
	//PD5 - INPUT 2			PIN 7
	CLEARBIT(PORTD, 5);
	//PD1 - ENABLE 2		PIN 9
	SETBIT(PORTD, 1);
	//PB3 - INPUT 3			PIN 10
	SETBIT(PORTB, 3);
	//PB4 - INPUT 4			PIN 15
	CLEARBIT(PORTB, 4);
	
	
	
	
	//PORTB = 0xff;
	//PORTD = 0xff;
	
	InitSPI();
	nrf24L01_init();
	
	//flash LED
	SETBIT(PORTD, 5);
	_delay_ms(1000);
	CLEARBIT(PORTD, 5);
	
	
	/*
	//BUTTONS FOR TRANSMITTER!
	CLEARBIT(DDRB, DDB2);
	CLEARBIT(DDRD, DDD5);
	
	//enable pull-up!
	SETBIT(PORTB, 2);
	SETBIT(PORTD, 5);
	*/
	
    while(1)
    {
		test=0;
		//_delay_ms(100);
		//IF TRANSMITTER!
		/*
		//if other button is pressed
		if ((PIND & (1<<PD5)) == 0)
		//SETBIT(PORTD, 5);
		test = 2;
		//else
		//test = 0;
		
		_delay_ms(10);
		
		
		//if button is pressed
		if ((PINB & (1<<PB2)) == 0)
		//SETBIT(PORTD, 5);
		test = 1;
		//else
		//test = 0;
		

		_delay_ms(10);
		
		
		//nrf24L01_init();
		reset();
		reset_tx();
		uint8_t W_buffer[5];
		int i;
		for (i=0;i<5;i++)
		{
			W_buffer[i] = values[test];
		}
		transmit_payload(W_buffer);
		
		*/
		
		
		
		
		
		//IF RECEIVER!
		
		reset();
		receive_payload();
		
		if ((GetReg(STATUS)&(1<<RX_DR))!=0)
		{
			data=WriteToNrf(R, R_RX_PAYLOAD, data, 5);
			//SETBIT(PORTD, 5);
			//mindata = data[0];
		}
		
		
		
		
		//if data is 0x93, enable motor or LED
		if(data[1] == 0x93)
		{
			//PD4 - ENABLE 1		PIN 1
			SETBIT(PORTD, 4);
			//PB2 - INPUT 1			PIN 2
			SETBIT(PORTB, 2);
			//PD5 - INPUT 2			PIN 7
			CLEARBIT(PORTD, 5);
			
			
		}
		
		if(data[1] == 0x94)
		{
			/*
			//other motor!
			//PD1 - ENABLE 2		PIN 9
			SETBIT(PORTD, 1);
			//PB3 - INPUT 3			PIN 10
			SETBIT(PORTB, 3);
			//PB4 - INPUT 4			PIN 15
			CLEARBIT(PORTB, 4);
			*/
			//change direction instead
			//PD4 - ENABLE 1		PIN 1
			SETBIT(PORTD, 4);
			//PB2 - INPUT 1			PIN 2
			CLEARBIT(PORTB, 2);
			//PD5 - INPUT 2			PIN 7
			SETBIT(PORTD, 5);
			
		}
		
		//shut off LED! nein, shut off motors!
		if (data[1] == 0x00)
		{
			SETBIT(PORTD, 5);
			SETBIT(PORTB, 4);
			CLEARBIT(PORTD, 4);
			//PB2 - INPUT 1			PIN 2
			//CLEARBIT(PORTB, 2);
		}		
		
		
		/*
		_delay_ms(1000);
		//PD4 - ENABLE 1		PIN 1
		SETBIT(PORTD, 4);
		//PB2 - INPUT 1			PIN 2
		SETBIT(PORTB, 2);
		//PD5 - INPUT 2			PIN 7
		SETBIT(PORTD, 5);
		_delay_ms(1000);
		//change direction!
		//PD4 - ENABLE 1		PIN 1
		SETBIT(PORTD, 4);
		//PB2 - INPUT 1			PIN 2
		CLEARBIT(PORTB, 2);
		//PD5 - INPUT 2			PIN 7
		SETBIT(PORTD, 5);
		*/
		
		/*
		if(GetReg(STATUS) == 0x0E)
		{
			//activate LED at pin 9
			SETBIT(PORTD, 5);
		}
		
		*/
		
		
        //TODO:: Please write your application code 
    }
}


#ifndef GLUE_DEBUG_H_H
#define GLUE_DEBUG_H

//ignore this thing
void glue_strcat( int* initial_text, int* added_text ){
    while( *initial_text )
      ++initial_text;
    while( *added_text )
    {*initial_text = *added_text;++initial_text;++added_text;}
    *initial_text = 0;
}

void glue_itoa( int value, int* result_text, int base )
{int[ 16+1 ] hex_characters = "0123456789ABCDEF";int[ 33 ] reversed_digits;
    if( base < 2 || base > 16 )
      return;
    if( base == 10 && value < 0 )
    {*result_text = '-';++result_text;value = -value;
    }
    int* next_digit = reversed_digits;
    do
    {*next_digit = hex_characters[ value % base ];++next_digit;value /= base;}
    while( value );
    do
    {--next_digit;*result_text = *next_digit;++result_text;}
    while( next_digit != &reversed_digits[0] );*result_text = 0;}

//ftoa again
void glue_ftoa( float value, int* result_text ){
	if( value < 0 ){*result_text = '-';++result_text;value = -value;
    }int integer_part, decimal_part;
    asm{
        "mov R0, {value}"
        "flr R0"
        "cfi R0"
        "mov {integer_part}, R0"
    }
    asm{
        "push R1"
        "mov R0, {value}"
        "mov R1, {integer_part}"
        "cif R1"
        "fsub R0, R1"
        "fmul R0, 100000.0"
        "round R0"
        "cfi R0"
        "mov {decimal_part}, R0"
        "pop R1"
    }
	glue_itoa( integer_part, result_text, 10 );
    if( !decimal_part )
    return;
    glue_strcat( result_text, "." );
    while( !(decimal_part % 10) )
    decimal_part /= 10;int[ 8 ] decimal_string;glue_itoa( decimal_part, decimal_string, 10 );glue_strcat( result_text, decimal_string );}


void print_int(int posx,int posy, float num){
	
	int[20] hlt;
	glue_itoa(num,hlt,10);
	print_at(posx,posy,hlt);
}
void print_float(int px,int py,float flnum){
	
	int[20] text;
	glue_ftoa(flnum,text);
	print_at(px,py,text);
}

void print_bool(int posx,int posy, bool val){
	if(val){
		print_at(posx,posy,"true");
	}else{
		print_at(posx,posy,"false");
	}	
	
}

#endif
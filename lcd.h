#ifndef LCD_H_
#define LCD_H_

void clear_lcd();
void write_string(char* c);
void write_lcd(char c);
void set_position(char x, char y);
void init_lcd();

#endif
-- Muhammad Izzulmakin 2017-10
-- oled is popular i2c 128x64 display
-- requires firmware with i2c enabled

local oled = {}

oled.const_chargepump = 0x8d
oled.const_columnaddr = 0x21
oled.const_comscandec = 0xc8
oled.const_comscaninc = 0xc0
oled.const_displayallon = 0xa5
oled.const_displayallon_resume = 0xa4
oled.const_displayoff = 0xae
oled.const_displayon = 0xaf
oled.const_externalvcc = 0x1
oled.const_invertdisplay = 0xa7
oled.const_memorymode = 0x20
oled.const_normaldisplay = 0xa6
oled.const_pageaddr = 0x22
oled.const_segremap = 0xa0
oled.const_setcompins = 0xda
oled.const_setcontrast = 0x81
oled.const_setdisplayclockdiv = 0xd5
oled.const_setdisplayoffset = 0xd3
oled.const_sethighcolumn = 0x10
oled.const_setlowcolumn = 0x00
oled.const_setmultiplex = 0xa8
oled.const_setprecharge = 0xd9
oled.const_setsegmentremap = 0xa1
oled.const_setstartline = 0x40
oled.const_setvcomdetect = 0xdb
oled.const_switchcapvcc = 0x2

oled.cmd_mode = 0x00
oled.data_mode = 0x40
oled.address = 0x3C
oled.width = 128
oled.height = 64
oled.pages = oled.height / 8

oled.pin_sda = 1
oled.pin_scl = 2
oled.i2c_id = 0 --always 0 for now https://nodemcu.readthedocs.io/en/master/en/modules/i2c/

function oled.set_address(addr)
	oled.address = addr
end

-- initialize oled, which also setup i2c to sda_pin and scl_pin
function oled.init(pin_sda, pin_scl)
	i2c.setup(oled.i2c_id, pin_sda, pin_scl, i2c.SLOW) --i2c.setup(id, pinSDA, pinSCL, speed)
	
	i2c.start(oled.i2c_id)
	
	i2c.address(oled.i2c_id, oled.address, i2c.TRANSMITTER)
	
	-- i2c.write(id, data1[, data2[, ..., datan]]
	i2c.write(oled.i2c_id, oled.const_displayoff)
	i2c.write(oled.i2c_id, oled.const_setdisplayclockdiv, 0x80)
	i2c.write(oled.i2c_id, oled.const_setmultiplex, 0x3f)
	i2c.write(oled.i2c_id, oled.const_setdisplayoffset, 0)
	i2c.write(oled.i2c_id, oled.const_setstartline)
	i2c.write(oled.i2c_id, oled.const_chargepump, 0x14)
	i2c.write(oled.i2c_id, oled.const_memorymode, 0)
	i2c.write(oled.i2c_id, oled.const_segremap)
	i2c.write(oled.i2c_id, oled.const_comscandec)
	i2c.write(oled.i2c_id, oled.const_setcompins, 0x12)
	i2c.write(oled.i2c_id, oled.const_setcontrast, 0xcf)
	i2c.write(oled.i2c_id, oled.const_setprecharge, 0xf1)
	i2c.write(oled.i2c_id, oled.const_setvcomdetect, 0x40)
	i2c.write(oled.i2c_id, oled.const_displayallon_resume)
	i2c.write(oled.i2c_id, oled.const_normaldisplay)
	i2c.write(oled.i2c_id, oled.const_displayon)
	
	
end

function oled.display()
	i2c.write(oled.i2c_id, oled.const_columnaddr, 0, oled.width-1) -- column start,end
	i2c.write(oled.i2c_id, oled.const_pageaddr, 0, oled.pages-1) -- page start,end
	
	
end

--~ function oled


return oled

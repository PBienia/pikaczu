
class TesterController < ApplicationController
			@@SLEEPTIME = 0.2
			@@TEST_OUTPUT = 12 # analog test signal output definition
			@@TEST_INPUT =	18 # analog test signal input definition
			#			   | mux 1  |   mux 2
			#			   s0,s1,s2,s0,s1,s2,s3
			@@MUX_OUTPUT= [21,20,16,6 ,13,19,26]	 # pins definitions for MUX - output
			@@MUX_INPUT = [7 ,8 ,25,4 ,17,27,22]    # pins definitions for MUX - output
			@@mux8 = {0 => [0,0,0], 1 => [1,0,0], 2 => [0,1,0], 3 => [1,1,0], 4 => [0,0,1], 5 => [1,0,1], 6 => [0,1,1], 7 => [1,1,1]}
			@@mux16 ={0 => [0,0,0,0], 1 => [1,0,0,0], 2 => [0,1,0,0], 3 => [1,1,0,0], 4 => [0,0,1,0], 5 => [1,0,1,0], 6 => [0,1,1,0], 7 => [1,1,1,0], 8 => [0,0,0,1], 9 => [1,0,0,1], 10 => [0,1,0,1],11 => [1,1,0,1], 12 => [0,0,1,1], 13 => [1,0,1,1], 14 => [0,1,1,1], 15 => [1,1,1,1]}
# 1---------------------------------------------------------
  def main
    @projects = Project.all
  end
# 2---------------------------------------------------------
  def test
	  	@project = Project.find(params[:id])
  		@pinouts = Pinout.where(project_id: params[:id])

			RPi::GPIO.set_numbering :bcm

			RPi::GPIO.setup @@TEST_OUTPUT, :as => :output, :initialize => :low
			RPi::GPIO.setup @@TEST_INPUT,  :as => :input

				@@MUX_OUTPUT.each do |s|
						RPi::GPIO.setup s, :as => :output
		 						end

		 		@@MUX_INPUT.each do |s|
						RPi::GPIO.setup s, :as => :output
		 						end
		 						return("funstion: test")
  end
# 3 ---------------------------------------------------------

  def mux(pin)   #ustawienie wyjsc sterujacych multiplekserami w RPi dla danego pinu

	       i8 = ((pin-1)/16)
	  	   i16= ((pin-1)%16)
	  	   @@mux8[i8]
	  	   @@mux16[i16]
	  	 #mux=[1,1,1,1,1]
	  	  p mux = @@mux8[i8]+@@mux16[i16]
	   	return(mux)
  end

	#---------------------------------------------------------
		def SetOutput(pin)
	i=0
					puts " Output For pin: #{pin}"
					mux(pin).each do |p|

					if p == 1
					  RPi::GPIO.set_high @@MUX_OUTPUT[i] #puts" set High on RPi pin no: #{@@MUX_OUTPUT[i]}"
					 elsif
					   RPi::GPIO.set_low @@MUX_OUTPUT[i] #puts" set Low  on RPi pin no: #{@@MUX_OUTPUT[i]}"
					 end
	i+=1
				end
				return "Ustawienie wyjsc GPIO RPI dla pinu:#{pin}"
	end
 #---------------------------------------------------------
 	def SetInput(pin)
	i=0
	puts "Input For pin: #{pin}"
					mux(pin).each do |p|
						if p == 1
					  			RPi::GPIO.set_high @@MUX_INPUT[i] #puts" set High on RPi pin no: #{@@MUX_INPUT[i]}"
					 	elsif
					   			RPi::GPIO.set_low @@MUX_INPUT[i] #puts" set Low  on RPi pin no: #{@@MUX_INPUT[i]}"
					 	end
							i+=1
				end
				return  "Ustawienie wejsc GPIO RPI dla pinu:#{pin}"
	end
 #---------------------------------------------------------

	def CheckError(pins, pin)
	correct_pin = pin.pin_setup
	pin_setup_to_check=[]
		pins.each do |pins|
						#p "pin's out to check -> #{pins.pin_dut}"
						pin_setup_to_check<< pins.pin_setup
				  end
		 pin_setup_to_check.each do |p|
		 			MainTest(correct_pin, p)
		 				if CheckTest()
		 					return(p "#{correct_pin} in place on #{pin.pin_dut}")
		 				else
		 					return (p "checking")
		 				end
		 end

	#p "pin -> #{pin.pin_dut}"
	#p " pins to check : #{pin_setup_to_check}"
		#return(p "#{correct_pin} in place on #{pin.pin_dut}")
	end
 #---------------------------------------------------------
	def SetTest(log_state)

	if log_state =="High"

		RPi::GPIO.set_high @@TEST_OUTPUT
		#RPi::GPIO.set_high @@TEST_INPUT
		puts "HIGH on test pin #{@@TEST_OUTPUT}"

	elsif log_state =="Low"
		RPi::GPIO.set_low @@TEST_OUTPUT
		#RPi::GPIO.set_low @@TEST_INPUT
		puts "LOW on test pin #{@@TEST_OUTPUT}"

	else
		puts"Wrong method agrument"
	end
end
 #---------------------------------------------------------

 def CheckTest()
 sleep @@SLEEPTIME
  RPi::GPIO.set_high @@TEST_OUTPUT
 sleep @@SLEEPTIME
 test = RPi::GPIO.high? @@TEST_INPUT
  RPi::GPIO.set_low @@TEST_OUTPUT

  return(test)

  end

  # ---------------------------------------------------------
 def MainTest(pin_out, pin_in)

			 SetOutput(pin_out)
			 SetInput(pin_in)

			 test = CheckTest()
			if test == false
			p "correct"
			@CorrectPin = 1000
			else
			p "false"
			@CorrectPin = 2000
			end

			return(test)
 end

 def shutdown

#system ("ls")
#system("^c")
#system ("sudo shutdown -h now")

 end


end

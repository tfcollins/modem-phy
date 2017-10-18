% Start receiver and transmitters on hardware
load_system('combinedTxRx_Chat');
set_param('combinedTxRx_Chat','SimulationCommand','start');
pause(3);
disp('Starting');
% Send packet
u = udp('127.0.0.1',25000);
fopen(u);
while 1
   s = input('Send Message[q to quit]: ','s');
   if strcmp(s,'q')
       disp('Quitting');
       break
   end
    fwrite(u,s);
    disp('Sent');
end
fclose(u);
delete(u);
pause(1);
set_param('combinedTxRx_Chat','SimulationCommand','stop');
set_param('combinedTxRx_Chat','SimulationCommand','stop');
set_param('combinedTxRx_Chat','SimulationCommand','stop');
% Check packet received



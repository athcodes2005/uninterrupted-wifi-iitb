# uninterrupted-wifi-iitb
Wi-Fi Router with Automated IIT Bombay Internet Login

Have you ever been annoyed after coming back to your room after lectures and finding that your phone won't use the your room's wifi because the internet connection has become inactive and you have to follow again the cumbersome process of waiting for the "internet.iitb.ac.in" website to load and login,here is an one time fix that will solve your problem forever.
![image](https://github.com/user-attachments/assets/95d7ebba-6eae-40eb-a813-25ac4b848304)
# Materials Needed
1. Raspberry Pi (Raspberry Pi Zero in this case)
2. SD Card
3. Case and Heatsink Raspberrypi(recommended)

# Steps
1. Flash your SD card with the Raspbian-lite(debian)  using Raspberry Pi Imager 
2. Also add credential for your Wifi router and your user by editing Raspberry Pi Imager settings
3. Enable SSH authetication and complete writing to SD card
4. Remove SD card after the write is complete , plug it in Raspberry Pi and allow it to boot
5. open terminal on your laptop connected to same Wifi as the Pi and SSH into the Pi
   find Pi's ip address by going to router page which is generally(192.168.1.1 or 192.168.0.1)
   ![image](https://github.com/user-attachments/assets/f4d41d9c-5fd3-4828-89fc-f730b111fe98)
   ![image](https://github.com/user-attachments/assets/57bf5e8f-161c-44fc-b05e-c8732f6a63e2)
6. Then type the following commands
```console
mypi@roompi:~$ sudo raspi-config
```
use arrow keys to navigate, enter key to go into an section, space key to select an option ,in the console based gui that appears
set your timezone, keyboard, WLAN country, expand your filesystem after doing all this select 'Finish' , you will be then prompted to reboot your system click 'yes'

7. After your system reboots again ssh into your pi and type the following commands
```console
mypi@roompi:~$ sudo apt update && sudo apt upgrade
mypi@roompi:~$ sudo apt install git
```
this will update the reposiory and fetch the latest packages for your device and also install git on your device

8. Now you need to generate internet access tokens for your ldap account
head over to your [sso settings](https://sso.iitb.ac.in/settings)
click on configure button under Access token
![image](https://github.com/user-attachments/assets/7b5dc70b-a36f-4078-9905-d9bd2513c8f0)
click on generate new then tick the CC's internet access portal and hit generate button
![image](https://github.com/user-attachments/assets/7247f733-07e0-4dfd-afcd-f4314c760819)
copy the newly generated token and paste it in some notepad temporarily

9. then proceed to clone this repository && edit the script,replace (internetaccesstoken) with internet access token obtained earlier and (ldapid) with your roll no  
```console
mypi@roompi:~$ git clone https://github.com/athcodes2005/uninterrupted-wifi-iitb.git
mypi@roompi:~$ cd uninterrupted-wifi-iitb
mypi@roompi:~/uninterrupted-wifi-iitb $ nano script.sh
```
10. here's how a sample script might look
![image](https://github.com/user-attachments/assets/4c0d4205-6d2a-4c5c-a5d2-7b4712e1f4b9)
*this not an actual roll no and internet access token replace it with your own credentials
press ctrl+x to exit then press y to save changes and press enter to keep file name same as before
then proceed to give execute permission to the script
```console
mypi@roompi:~/uninterrupted-wifi-iitb $ chmod +x script.sh
```
check whether the script runs by executing following command 
```console
mypi@roompi:~/uninterrupted-wifi-iitb $ ./script.sh
```
11. setup cronjob to run script automatically every time the system boots as well as after every 10 minutes
```console
mypi@roompi:~/uninterrupted-wifi-iitb $ crontab -e
```
it will then prompt you to select a text editor , proceed with 'nano' as your text editor it will then open the crontab file in the editor that you selected
add the following lines at the bottom of the file
```console
@reboot sleep 30 && /home/mypi/uninterrupted-wifi-iitb/script.sh 
*/10 * * * * /home/mypi/uninterrupted-wifi-iitb/script.sh
```
![image](https://github.com/user-attachments/assets/d23e3d2e-1f58-45a4-85da-27a3702cdba6)
press ctrl+x to exit then press y to save changes and press enter to keep file name same as before

this will basically run the script every 30 seconds after the system boots as well as after every 10 minutes pass.
thus ensuring we have an uninterrupted internet connection



    



    




   



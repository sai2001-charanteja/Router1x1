# From this project i learned :

    1. Flow of Verification environmnent
    2. How to setup Verification environent componenents.
    3. Usage of Mailboxes
    4. Constraints
    5. Functional Coverage
    6. Inheritance for adding extra code with out disturbing the environment
    7. Usage of mod_ports

# Virification Environment Flow:

<img width="1316" height="706" alt="image" src="https://github.com/user-attachments/assets/da7e62cd-113f-4040-9436-ce98fe1cc0d1" />


# Wave Diagram :

<img width="1919" height="1133" alt="image" src="https://github.com/user-attachments/assets/30a5c571-de3a-4929-bafd-8b55af860872" />


# Functional Coverage :

<img width="1915" height="967" alt="image" src="https://github.com/user-attachments/assets/2fa80aec-9438-40e0-8172-5b9968c76e45" />
    For this i have slightly modified the coverage group
    
# My Output:

    # [New Testcase] run started at time :0
    # [Test case] Build started at time : 0
    # [Environment] Build started at time : 0
    # [Test case] Build completed at time : 0
    # [Environmnet] run started at time : 0
    # [Generator] Reset Packet generated at time : 0
    # [Driver] The reset is started on DUT at time : 0
    # [Generator] Packet '1' is generated at time : (0)
    # [Driver] The reset is completed on DUT at time : 15
    # [Driver] The driving of packet (1) started at time : 15
    # [Generator] Packet '2' is generated at time : (15)
    # [Driver] The driving of packet (1) Completed at time : 485
    # [iMonitor] Captured packet 1 at time : 495
    # [Coverage] Coverage Score : 2.454020
    # [Generator] Packet '3' is generated at time : (535)
    # [Driver] The driving of packet (2) started at time : 975
    # [OMonitor] Captured packet 1 at time : 985
    # [Scoreboard] Packet 1 is captured at time :985
    # [Driver] The driving of packet (2) Completed at time : 1135
    # [iMonitor] Captured packet 2 at time : 1145
    # [Coverage] Coverage Score : 2.718506
    # [Generator] Packet '4' is generated at time : (1185)
    # [Driver] The driving of packet (3) started at time : 1315
    # [OMonitor] Captured packet 2 at time : 1325
    # [Scoreboard] Packet 2 is captured at time :1325
    # [Driver] The driving of packet (3) Completed at time : 1745
    # [iMonitor] Captured packet 3 at time : 1755
    # [Coverage] Coverage Score : 2.982992
    # [Generator] Packet '5' is generated at time : (1795)
    # [Driver] The driving of packet (4) started at time : 2195
    # [OMonitor] Captured packet 3 at time : 2205
    # [Scoreboard] Packet 3 is captured at time :2205
    # [Driver] The driving of packet (4) Completed at time : 3285
    # [iMonitor] Captured packet 4 at time : 3295
    # [Coverage] Coverage Score : 5.176595
    # [Driver] The driving of packet (5) started at time : 4395
    # [OMonitor] Captured packet 4 at time : 4405
    # [Scoreboard] Packet 4 is captured at time :4405
    # [Driver] The driving of packet (5) Completed at time : 4925
    # [iMonitor] Captured packet 5 at time : 4935
    # [Coverage] Coverage Score : 7.107747
    # [OMonitor] Captured packet 5 at time : 5485
    # [Scoreboard] Packet 5 is captured at time :5485
    # [Generator] The total no. generated packets are 5
    # [Driver] The total no. drived packets are 5
    # [iMonitor] The total captured packets are : 5
    # [oMonitor] The total captured packets are : 5
    # [ScoreBoard] Matched : 5 , MisMatched : 0
    # 
    # ******************************************
    # [ScoreBoard] Matched : 5 , MisMatched : 0
    # **************TEST PASSED*****************
    # ******************************************
    # 
    # ******************************************
    # ***[Coverage] COverage Score : 7.107747***
    # ******************************************
    # [Environmnet] run Completed at time : 5735

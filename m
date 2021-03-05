Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF42532EBAA
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 13:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCEMyd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 07:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCEMyW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 07:54:22 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F2C061756
        for <linux-ext4@vger.kernel.org>; Fri,  5 Mar 2021 04:54:21 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u20so1841763iot.9
        for <linux-ext4@vger.kernel.org>; Fri, 05 Mar 2021 04:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=v15NS91ae8iH/d9ynrpvVj+OmNQpA1PFEJreF6mCFjE=;
        b=I8nrj4eOsEopEtxlNUz3KALRQJI6Ajj4P4fkkcR/VUsBtkG0005ujXo2JRmeHAe9D3
         /QnXBccMxzA5o4nAG6Yf+DqedEPqqlWMFjsBKZftwojrLcKzTbUwrJ8Maoo21vqDoLWa
         Oans86HZPovCZCn55AseFiMusPVpXBVGvuPAL+7SLV0TQuDb4QY8rHn9XJqSsZqgPCy+
         DUCdTJ620hsARNcE3ibCPUyU2iT7cgwsGQW26G7XL9cKU4sDqsKzZeJJr7eYjJ8NiA1M
         T0id5f79AHTXPqNP4NLrDmqkxZZZOlKfym9Q6ouZGomRrQJt5OBFPl5ytg7W5RXQfwpk
         19eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=v15NS91ae8iH/d9ynrpvVj+OmNQpA1PFEJreF6mCFjE=;
        b=lTtODr/bEd6oRqIDq0ha012n/PfO5Q9sB88D+IdXCDp/v6gxm0ee8drFhOEtdgLJok
         +hEeHSbzEC/Fq7KHQsK7d7kB9HNqgXqdGHxwU324FEgzAydk50P6dlXUTGZpbEBJiz4o
         uyCOqEQAJu5pDaYUWa8/NZRv5fpop7l2Y1sgzV5As9/ZZb4ZZcQo9b2aZ56rzuQaOin0
         7pU+r2GC/G4orSFbx/AuHZllrYl7DztorMEuLoswrCtSVoBrJdGAUMDXQNuXCg5qsGEW
         uCmU8dcTqYQSYS4i/5tOy/CMG9db09ITjO/qK5Kvfzfw3YtRFmHeU0EV4TxXUCxmpsJB
         KHNw==
X-Gm-Message-State: AOAM531BMhm9ikyng5wJsNV4X8ant5ZZaOfxo92/Wvv7JYQvtmHLThWG
        3KMpqkcb7tZANkNG+J4uwrIjvD8nkiNILqT4C+f3eqr2hv2D0Q==
X-Google-Smtp-Source: ABdhPJwKfX1PWtvbs6fk4pb5AzFrY8HloPAkbTAkCp6pEoNwS+yyv8JVSJJMYMCLWZosLYTfxhHX0ziE2DDaQJKnRTY=
X-Received: by 2002:a05:6638:635:: with SMTP id h21mr9425093jar.97.1614948861018;
 Fri, 05 Mar 2021 04:54:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu> <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
 <YD0JfjnMtXzGguZ6@mit.edu> <CA+icZUUruS8h=CiUwuSsbL9NmCXCvdfV-XFfV=Z=qOpR9b83XA@mail.gmail.com>
 <20210305115957.x4gbppxpzxuvn2kd@work> <CA+icZUWZ8-005hOOaapW=0EnySD7jcL6RaFsiMXV6EPfvmG1Vg@mail.gmail.com>
 <20210305124800.254qikr22kxafpae@work>
In-Reply-To: <20210305124800.254qikr22kxafpae@work>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 13:53:43 +0100
Message-ID: <CA+icZUXwZFVwF_sZZzmfnf0sr9hYof8T9KpRZ42xhaOvwUSr3w@mail.gmail.com>
Subject: Re: badblocks from e2fsprogs
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 5, 2021 at 1:48 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Fri, Mar 05, 2021 at 01:21:51PM +0100, Sedat Dilek wrote:
> > On Fri, Mar 5, 2021 at 1:00 PM Lukas Czerner <lczerner@redhat.com> wrote:
> > >
> > > On Mon, Mar 01, 2021 at 04:42:26PM +0100, Sedat Dilek wrote:
> > > > On Mon, Mar 1, 2021 at 4:34 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > > > >
> > > > > On Mon, Mar 01, 2021 at 04:12:03PM +0100, Sedat Dilek wrote:
> > > > > >
> > > > > > OK, I see.
> > > > > > So I misunderstood the -o option.
> > > > >
> > > > > It was clearly documented in the man page:
> > > > >
> > > > >        -o output_file
> > > > >               Write the list of bad blocks to the specified file.
> > > > >               Without this option, badblocks displays the list on
> > > > >               its standard output.  The format of this file is
> > > > >               suitable for use by the -l option in e2fsck(8) or
> > > > >               mke2fs(8).
> > > > >
> > > >
> > > > RTFM.
> > > >
> > > > > I will say that for modern disks, the usefulness of badblocks has
> > > > > decreased significantly over time.  That's because for modern-sized
> > > > > disks, it can often take more than 24 hours to do a full read on the
> > > > > entire disk surface --- and the factory testing done by HDD
> > > > > manufacturers is far more comprehensive.
> > > > >
> > > > > In addition, SMART (see the smartctl package) is a much more reliable
> > > > > and efficient way of judging disk health.
> > > > >
> > > > > The badblocks program was written over two decades ago, before the
> > > > > days of SATA, and even IDE disks, when disk controlls and HDD's were
> > > > > far more primitive.  These days, modern HDD and SSD will do their own
> > > > > bad block redirection from a built-in bad block sparing pool, and the
> > > > > usefulness of using badblocks has been significantly decreased.
> > > > >
> > > >
> > > > Thanks for the clarification on badblocks usage and usefulness.
> > > >
> > > > OK, I ran before badblocks:
> > > >
> > > > 1. smartctl -a /dev/sdc (shell)
> > > > 2. gsmartcontrol (GUI)
> > > >
> > > > The results showed me "this disk is healthy".
> > > > As you said: Both gave a very quick overview.
> > > >
> > > > - Sedat -
> > >
> > > Just note that not even the device firmware can't really know whether the
> > > block is good/bad unless it tries to read/write it. In that way I still
> > > find the badblocks useful because it can "force" the device to notice
> > > that there is something wrong and try to fix it (perhaps by remapping
> > > the bad block to spare one). Of course you could use dd for that, but
> > > there are several reasons why badblocks is still more convenient tool to
> > > do that.
> > >
> > > That said you should also check the SMART data _after_ you run the
> > > badblocks to see if it encountered any read errors and/or remapped some
> > > blocks.
> > >
> >
> > Thanks Lukas.
> >
> > With gsmartcontrol I archived two logs.
> >
> > The diff says:
> >
> > cd ~/DISK-HEALTH/gsmartcontrol
> >
> > git diff ST1000LM024_HN-M101MBB_S2U5J9CCB68827_2020-05-28.txt
> > ST1000LM024_HN-M101MBB_S2U5J9CCB68827_2021-03-05.txt | egrep -i '
> > read|remap' | grep -i error
> > -  1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    0
> > +  1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    2
> >
> > There are no "remap" keywords in the gsmartcontrol log-files.
>
> Hi,
>
> yes, sorry I was not sure what the exact term the SMART is using so I
> remapping "remapping" in a descriptive sense. Looking at your output the
> field you're looking is "Reallocated_Event_Count" which is 0 in both
> cases.
>

Again thank you!

Now, I now know which keywords are relevant and needed to be inspected
in case of a disk-health-check:

# git diff ST1000LM024_HN-M101MBB_S2U5J9CCB68827_2020-05-28.txt
ST1000LM024_HN-M101MBB_S2U5J9CCB68827_2021-03-05.txt | egrep 'Raw
_Read_Error_Rate|Reallocated_Event_Count'
-  1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    0
+  1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    2
196 Reallocated_Event_Count -O--CK   252   252   000    -    0

- Sedat -

> -Lukas
>
> >
> > I have attached both log-files.
> > ( Hope there is no sensitive data included. )
> >
> > - Sedat -
> >
> > >
> > > >
> > > > [1] https://superuser.com/questions/171195/how-to-check-the-health-of-a-hard-drive
> > > >
> > >
>
> > smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.7.0-rc7-4-amd64-clang] (local build)
> > Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Model Family:     Seagate Samsung SpinPoint M8 (AF)
> > Device Model:     ST1000LM024 HN-M101MBB
> > Serial Number:    S2U5J9CCB68827
> > LU WWN Device Id: 5 0004cf 208db3445
> > Firmware Version: 2AR10001
> > User Capacity:    1,000,204,886,016 bytes [1.00 TB]
> > Sector Sizes:     512 bytes logical, 4096 bytes physical
> > Rotation Rate:    5400 rpm
> > Form Factor:      2.5 inches
> > Device is:        In smartctl database [for details use: -P show]
> > ATA Version is:   ATA8-ACS T13/1699-D revision 6
> > SATA Version is:  SATA 3.0, 3.0 Gb/s (current: 3.0 Gb/s)
> > Local Time is:    Thu May 28 22:09:29 2020 CEST
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Unavailable
> > APM level is:     254 (maximum performance)
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > DSN feature is:   Unavailable
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> >
> > General SMART Values:
> > Offline data collection status:  (0x00)       Offline data collection activity
> >                                       was never started.
> >                                       Auto Offline Data Collection: Disabled.
> > Self-test execution status:      (   0)       The previous self-test routine completed
> >                                       without error or no self-test has ever
> >                                       been run.
> > Total time to complete Offline
> > data collection:              (13380) seconds.
> > Offline data collection
> > capabilities:                          (0x5b) SMART execute Offline immediate.
> >                                       Auto Offline data collection on/off support.
> >                                       Suspend Offline collection upon new
> >                                       command.
> >                                       Offline surface scan supported.
> >                                       Self-test supported.
> >                                       No Conveyance Self-test supported.
> >                                       Selective Self-test supported.
> > SMART capabilities:            (0x0003)       Saves SMART data before entering
> >                                       power-saving mode.
> >                                       Supports SMART auto save timer.
> > Error logging capability:        (0x01)       Error logging supported.
> >                                       General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:      (   2) minutes.
> > Extended self-test routine
> > recommended polling time:      ( 223) minutes.
> > SCT capabilities:            (0x003f) SCT Status supported.
> >                                       SCT Error Recovery Control supported.
> >                                       SCT Feature Control supported.
> >                                       SCT Data Table supported.
> >
> > SMART Attributes Data Structure revision number: 16
> > Vendor Specific SMART Attributes with Thresholds:
> > ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
> >   1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    0
> >   2 Throughput_Performance  -OS--K   252   252   000    -    0
> >   3 Spin_Up_Time            PO---K   089   089   025    -    3463
> >   4 Start_Stop_Count        -O--CK   098   098   000    -    2129
> >   5 Reallocated_Sector_Ct   PO--CK   252   252   010    -    0
> >   7 Seek_Error_Rate         -OSR-K   252   252   051    -    0
> >   8 Seek_Time_Performance   --S--K   252   252   015    -    0
> >   9 Power_On_Hours          -O--CK   100   100   000    -    1289
> >  10 Spin_Retry_Count        -O--CK   252   252   051    -    0
> >  11 Calibration_Retry_Count -O--CK   100   100   000    -    38
> >  12 Power_Cycle_Count       -O--CK   099   099   000    -    1421
> > 191 G-Sense_Error_Rate      -O---K   252   252   000    -    0
> > 192 Power-Off_Retract_Count -O---K   252   252   000    -    0
> > 194 Temperature_Celsius     -O----   061   052   000    -    39 (Min/Max 13/49)
> > 195 Hardware_ECC_Recovered  -O-RCK   100   100   000    -    0
> > 196 Reallocated_Event_Count -O--CK   252   252   000    -    0
> > 197 Current_Pending_Sector  -O--CK   252   252   000    -    0
> > 198 Offline_Uncorrectable   ----CK   252   252   000    -    0
> > 199 UDMA_CRC_Error_Count    -OS-CK   200   200   000    -    0
> > 200 Multi_Zone_Error_Rate   -O-R-K   100   100   000    -    2970
> > 223 Load_Retry_Count        -O--CK   100   100   000    -    38
> > 225 Load_Cycle_Count        -O--CK   098   098   000    -    22549
> >                             ||||||_ K auto-keep
> >                             |||||__ C event count
> >                             ||||___ R error rate
> >                             |||____ S speed/performance
> >                             ||_____ O updated online
> >                             |______ P prefailure warning
> >
> > General Purpose Log Directory Version 1
> > SMART           Log Directory Version 1 [multi-sector log support]
> > Address    Access  R/W   Size  Description
> > 0x00       GPL,SL  R/O      1  Log Directory
> > 0x01           SL  R/O      1  Summary SMART error log
> > 0x02           SL  R/O      2  Comprehensive SMART error log
> > 0x03       GPL     R/O      2  Ext. Comprehensive SMART error log
> > 0x06           SL  R/O      1  SMART self-test log
> > 0x07       GPL     R/O      2  Extended self-test log
> > 0x08       GPL     R/O      2  Power Conditions log
> > 0x09           SL  R/W      1  Selective self-test log
> > 0x10       GPL     R/O      1  NCQ Command Error log
> > 0x11       GPL     R/O      1  SATA Phy Event Counters log
> > 0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
> > 0xc0-0xdf  GPL,SL  VS      16  Device vendor specific log
> > 0xe0       GPL,SL  R/W      1  SCT Command/Status
> > 0xe1       GPL,SL  R/W      1  SCT Data Transfer
> >
> > SMART Extended Comprehensive Error Log Version: 1 (2 sectors)
> > No Errors Logged
> >
> > SMART Extended Self-test Log Version: 1 (2 sectors)
> > Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> > # 1  Short offline       Completed without error       00%      1289         -
> >
> > SMART Selective self-test log data structure revision number 0
> > Note: revision number not 1 implies that no selective self-test has ever been run
> >  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
> >     1        0        0  Completed [00% left] (0-65535)
> >     2        0        0  Not_testing
> >     3        0        0  Not_testing
> >     4        0        0  Not_testing
> >     5        0        0  Not_testing
> > Selective self-test flags (0x0):
> >   After scanning selected spans, do NOT read-scan remainder of disk.
> > If Selective self-test is pending on power-up, resume after 0 minute delay.
> >
> > SCT Status Version:                  2
> > SCT Version (vendor specific):       256 (0x0100)
> > Device State:                        Active (0)
> > Current Temperature:                    39 Celsius
> > Power Cycle Min/Max Temperature:     37/41 Celsius
> > Lifetime    Min/Max Temperature:     13/49 Celsius
> > Specified Max Operating Temperature:    80 Celsius
> > Under/Over Temperature Limit Count:   0/0
> >
> > SCT Temperature History Version:     2
> > Temperature Sampling Period:         5 minutes
> > Temperature Logging Interval:        5 minutes
> > Min/Max recommended Temperature:     -5/80 Celsius
> > Min/Max Temperature Limit:           -10/85 Celsius
> > Temperature History Size (Index):    128 (71)
> >
> > Index    Estimated Time   Temperature Celsius
> >   72    2020-05-28 11:30    39  ********************
> >   73    2020-05-28 11:35    33  **************
> >   74    2020-05-28 11:40    34  ***************
> >  ...    ..(  2 skipped).    ..  ***************
> >   77    2020-05-28 11:55    34  ***************
> >   78    2020-05-28 12:00    35  ****************
> >  ...    ..(  2 skipped).    ..  ****************
> >   81    2020-05-28 12:15    35  ****************
> >   82    2020-05-28 12:20    36  *****************
> >   83    2020-05-28 12:25    37  ******************
> >  ...    ..(  5 skipped).    ..  ******************
> >   89    2020-05-28 12:55    37  ******************
> >   90    2020-05-28 13:00    38  *******************
> >  ...    ..( 10 skipped).    ..  *******************
> >  101    2020-05-28 13:55    38  *******************
> >  102    2020-05-28 14:00    39  ********************
> >  103    2020-05-28 14:05    38  *******************
> >  ...    ..(  2 skipped).    ..  *******************
> >  106    2020-05-28 14:20    38  *******************
> >  107    2020-05-28 14:25    39  ********************
> >  ...    ..( 20 skipped).    ..  ********************
> >    0    2020-05-28 16:10    39  ********************
> >    1    2020-05-28 16:15    40  *********************
> >  ...    ..( 11 skipped).    ..  *********************
> >   13    2020-05-28 17:15    40  *********************
> >   14    2020-05-28 17:20    41  **********************
> >   15    2020-05-28 17:25    41  **********************
> >   16    2020-05-28 17:30    41  **********************
> >   17    2020-05-28 17:35    40  *********************
> >   18    2020-05-28 17:40    40  *********************
> >   19    2020-05-28 17:45    40  *********************
> >   20    2020-05-28 17:50    42  ***********************
> >   21    2020-05-28 17:55    43  ************************
> >   22    2020-05-28 18:00    42  ***********************
> >   23    2020-05-28 18:05    41  **********************
> >   24    2020-05-28 18:10    40  *********************
> >   25    2020-05-28 18:15    40  *********************
> >   26    2020-05-28 18:20    40  *********************
> >   27    2020-05-28 18:25    42  ***********************
> >   28    2020-05-28 18:30    43  ************************
> >   29    2020-05-28 18:35    42  ***********************
> >   30    2020-05-28 18:40    41  **********************
> >   31    2020-05-28 18:45    40  *********************
> >   32    2020-05-28 18:50    39  ********************
> >   33    2020-05-28 18:55    39  ********************
> >   34    2020-05-28 19:00    39  ********************
> >   35    2020-05-28 19:05    38  *******************
> >  ...    ..(  5 skipped).    ..  *******************
> >   41    2020-05-28 19:35    38  *******************
> >   42    2020-05-28 19:40    39  ********************
> >   43    2020-05-28 19:45    39  ********************
> >   44    2020-05-28 19:50    40  *********************
> >   45    2020-05-28 19:55    42  ***********************
> >   46    2020-05-28 20:00    41  **********************
> >   47    2020-05-28 20:05    40  *********************
> >   48    2020-05-28 20:10    39  ********************
> >   49    2020-05-28 20:15    39  ********************
> >   50    2020-05-28 20:20    38  *******************
> >   51    2020-05-28 20:25    38  *******************
> >   52    2020-05-28 20:30    38  *******************
> >   53    2020-05-28 20:35    37  ******************
> >  ...    ..(  2 skipped).    ..  ******************
> >   56    2020-05-28 20:50    37  ******************
> >   57    2020-05-28 20:55    38  *******************
> >   58    2020-05-28 21:00    37  ******************
> >  ...    ..(  2 skipped).    ..  ******************
> >   61    2020-05-28 21:15    37  ******************
> >   62    2020-05-28 21:20    39  ********************
> >   63    2020-05-28 21:25    39  ********************
> >   64    2020-05-28 21:30    40  *********************
> >   65    2020-05-28 21:35    41  **********************
> >   66    2020-05-28 21:40    41  **********************
> >   67    2020-05-28 21:45    40  *********************
> >   68    2020-05-28 21:50    40  *********************
> >   69    2020-05-28 21:55    40  *********************
> >   70    2020-05-28 22:00    39  ********************
> >   71    2020-05-28 22:05    39  ********************
> >
> > SCT Error Recovery Control:
> >            Read: Disabled
> >           Write: Disabled
> >
> > Device Statistics (GP/SMART Log 0x04) not supported
> >
> > SATA Phy Event Counters (GP Log 0x11)
> > ID      Size     Value  Description
> > 0x0001  4            0  Command failed due to ICRC error
> > 0x0002  4            0  R_ERR response for data FIS
> > 0x0003  4            0  R_ERR response for device-to-host data FIS
> > 0x0004  4            0  R_ERR response for host-to-device data FIS
> > 0x0005  4            0  R_ERR response for non-data FIS
> > 0x0006  4            0  R_ERR response for device-to-host non-data FIS
> > 0x0007  4            0  R_ERR response for host-to-device non-data FIS
> > 0x0008  4            0  Device-to-host non-data FIS retries
> > 0x0009  4            0  Transition from drive PhyRdy to drive PhyNRdy
> > 0x000a  4            0  Device-to-host register FISes sent due to a COMRESET
> > 0x000b  4            0  CRC errors within host-to-device FIS
> > 0x000d  4            0  Non-CRC errors within host-to-device FIS
> > 0x000f  4            0  R_ERR response for host-to-device data FIS, CRC
> > 0x0010  4            0  R_ERR response for host-to-device data FIS, non-CRC
> > 0x0012  4            0  R_ERR response for host-to-device non-data FIS, CRC
> > 0x0013  4            0  R_ERR response for host-to-device non-data FIS, non-CRC
> > 0x8e00  4            0  Vendor specific
> > 0x8e01  4            0  Vendor specific
> > 0x8e02  4            0  Vendor specific
> > 0x8e03  4            0  Vendor specific
> > 0x8e04  4            0  Vendor specific
> > 0x8e05  4            0  Vendor specific
> > 0x8e06  4            0  Vendor specific
> > 0x8e07  4            0  Vendor specific
> > 0x8e08  4            0  Vendor specific
> > 0x8e09  4            0  Vendor specific
> > 0x8e0a  4            0  Vendor specific
> > 0x8e0b  4            0  Vendor specific
> > 0x8e0c  4            0  Vendor specific
> > 0x8e0d  4            0  Vendor specific
> > 0x8e0e  4            0  Vendor specific
> > 0x8e0f  4            0  Vendor specific
> > 0x8e10  4            0  Vendor specific
> > 0x8e11  4            0  Vendor specific
>
> > smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.12.0-rc1-11-amd64-clang13-cfi] (local build)
> > Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > === START OF INFORMATION SECTION ===
> > Model Family:     Seagate Samsung SpinPoint M8 (AF)
> > Device Model:     ST1000LM024 HN-M101MBB
> > Serial Number:    S2U5J9CCB68827
> > LU WWN Device Id: 5 0004cf 208db3445
> > Firmware Version: 2AR10001
> > User Capacity:    1,000,204,886,016 bytes [1.00 TB]
> > Sector Sizes:     512 bytes logical, 4096 bytes physical
> > Rotation Rate:    5400 rpm
> > Form Factor:      2.5 inches
> > Device is:        In smartctl database [for details use: -P show]
> > ATA Version is:   ATA8-ACS T13/1699-D revision 6
> > SATA Version is:  SATA 3.0, 3.0 Gb/s (current: 3.0 Gb/s)
> > Local Time is:    Fri Mar  5 13:16:48 2021 CET
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> > AAM feature is:   Unavailable
> > APM level is:     254 (maximum performance)
> > Rd look-ahead is: Enabled
> > Write cache is:   Enabled
> > DSN feature is:   Unavailable
> > ATA Security is:  Disabled, NOT FROZEN [SEC1]
> >
> > === START OF READ SMART DATA SECTION ===
> > SMART overall-health self-assessment test result: PASSED
> >
> > General SMART Values:
> > Offline data collection status:  (0x00)       Offline data collection activity
> >                                       was never started.
> >                                       Auto Offline Data Collection: Disabled.
> > Self-test execution status:      (   0)       The previous self-test routine completed
> >                                       without error or no self-test has ever
> >                                       been run.
> > Total time to complete Offline
> > data collection:              (13380) seconds.
> > Offline data collection
> > capabilities:                          (0x5b) SMART execute Offline immediate.
> >                                       Auto Offline data collection on/off support.
> >                                       Suspend Offline collection upon new
> >                                       command.
> >                                       Offline surface scan supported.
> >                                       Self-test supported.
> >                                       No Conveyance Self-test supported.
> >                                       Selective Self-test supported.
> > SMART capabilities:            (0x0003)       Saves SMART data before entering
> >                                       power-saving mode.
> >                                       Supports SMART auto save timer.
> > Error logging capability:        (0x01)       Error logging supported.
> >                                       General Purpose Logging supported.
> > Short self-test routine
> > recommended polling time:      (   2) minutes.
> > Extended self-test routine
> > recommended polling time:      ( 223) minutes.
> > SCT capabilities:            (0x003f) SCT Status supported.
> >                                       SCT Error Recovery Control supported.
> >                                       SCT Feature Control supported.
> >                                       SCT Data Table supported.
> >
> > SMART Attributes Data Structure revision number: 16
> > Vendor Specific SMART Attributes with Thresholds:
> > ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
> >   1 Raw_Read_Error_Rate     POSR-K   100   100   051    -    2
> >   2 Throughput_Performance  -OS--K   252   252   000    -    0
> >   3 Spin_Up_Time            PO---K   089   089   025    -    3456
> >   4 Start_Stop_Count        -O--CK   098   098   000    -    2543
> >   5 Reallocated_Sector_Ct   PO--CK   252   252   010    -    0
> >   7 Seek_Error_Rate         -OSR-K   252   252   051    -    0
> >   8 Seek_Time_Performance   --S--K   252   252   015    -    0
> >   9 Power_On_Hours          -O--CK   100   100   000    -    4201
> >  10 Spin_Retry_Count        -O--CK   252   252   051    -    0
> >  11 Calibration_Retry_Count -O--CK   100   100   000    -    244
> >  12 Power_Cycle_Count       -O--CK   099   099   000    -    1864
> > 191 G-Sense_Error_Rate      -O---K   252   252   000    -    0
> > 192 Power-Off_Retract_Count -O---K   252   252   000    -    0
> > 194 Temperature_Celsius     -O----   064   049   000    -    35 (Min/Max 13/52)
> > 195 Hardware_ECC_Recovered  -O-RCK   100   100   000    -    0
> > 196 Reallocated_Event_Count -O--CK   252   252   000    -    0
> > 197 Current_Pending_Sector  -O--CK   252   252   000    -    0
> > 198 Offline_Uncorrectable   ----CK   252   252   000    -    0
> > 199 UDMA_CRC_Error_Count    -OS-CK   200   200   000    -    0
> > 200 Multi_Zone_Error_Rate   -O-R-K   100   100   000    -    15982
> > 223 Load_Retry_Count        -O--CK   100   100   000    -    244
> > 225 Load_Cycle_Count        -O--CK   098   098   000    -    23647
> >                             ||||||_ K auto-keep
> >                             |||||__ C event count
> >                             ||||___ R error rate
> >                             |||____ S speed/performance
> >                             ||_____ O updated online
> >                             |______ P prefailure warning
> >
> > General Purpose Log Directory Version 1
> > SMART           Log Directory Version 1 [multi-sector log support]
> > Address    Access  R/W   Size  Description
> > 0x00       GPL,SL  R/O      1  Log Directory
> > 0x01           SL  R/O      1  Summary SMART error log
> > 0x02           SL  R/O      2  Comprehensive SMART error log
> > 0x03       GPL     R/O      2  Ext. Comprehensive SMART error log
> > 0x06           SL  R/O      1  SMART self-test log
> > 0x07       GPL     R/O      2  Extended self-test log
> > 0x08       GPL     R/O      2  Power Conditions log
> > 0x09           SL  R/W      1  Selective self-test log
> > 0x10       GPL     R/O      1  NCQ Command Error log
> > 0x11       GPL     R/O      1  SATA Phy Event Counters log
> > 0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
> > 0xc0-0xdf  GPL,SL  VS      16  Device vendor specific log
> > 0xe0       GPL,SL  R/W      1  SCT Command/Status
> > 0xe1       GPL,SL  R/W      1  SCT Data Transfer
> >
> > SMART Extended Comprehensive Error Log Version: 1 (2 sectors)
> > No Errors Logged
> >
> > SMART Extended Self-test Log Version: 1 (2 sectors)
> > Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
> > # 1  Short offline       Completed without error       00%      1289         -
> >
> > SMART Selective self-test log data structure revision number 0
> > Note: revision number not 1 implies that no selective self-test has ever been run
> >  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
> >     1        0        0  Completed [00% left] (0-65535)
> >     2        0        0  Not_testing
> >     3        0        0  Not_testing
> >     4        0        0  Not_testing
> >     5        0        0  Not_testing
> > Selective self-test flags (0x0):
> >   After scanning selected spans, do NOT read-scan remainder of disk.
> > If Selective self-test is pending on power-up, resume after 0 minute delay.
> >
> > SCT Status Version:                  2
> > SCT Version (vendor specific):       256 (0x0100)
> > Device State:                        Active (0)
> > Current Temperature:                    35 Celsius
> > Power Cycle Min/Max Temperature:     26/42 Celsius
> > Lifetime    Min/Max Temperature:     13/51 Celsius
> > Specified Max Operating Temperature:    80 Celsius
> > Under/Over Temperature Limit Count:   0/0
> >
> > SCT Temperature History Version:     2
> > Temperature Sampling Period:         5 minutes
> > Temperature Logging Interval:        5 minutes
> > Min/Max recommended Temperature:     -5/80 Celsius
> > Min/Max Temperature Limit:           -10/85 Celsius
> > Temperature History Size (Index):    128 (121)
> >
> > Index    Estimated Time   Temperature Celsius
> >  122    2021-03-05 02:40    35  ****************
> >  ...    ..(  2 skipped).    ..  ****************
> >  125    2021-03-05 02:55    35  ****************
> >  126    2021-03-05 03:00    34  ***************
> >  ...    ..(  3 skipped).    ..  ***************
> >    2    2021-03-05 03:20    34  ***************
> >    3    2021-03-05 03:25    35  ****************
> >    4    2021-03-05 03:30    35  ****************
> >    5    2021-03-05 03:35    34  ***************
> >  ...    ..( 17 skipped).    ..  ***************
> >   23    2021-03-05 05:05    34  ***************
> >   24    2021-03-05 05:10    33  **************
> >   25    2021-03-05 05:15    33  **************
> >   26    2021-03-05 05:20    34  ***************
> >   27    2021-03-05 05:25    33  **************
> >   28    2021-03-05 05:30    34  ***************
> >  ...    ..(  4 skipped).    ..  ***************
> >   33    2021-03-05 05:55    34  ***************
> >   34    2021-03-05 06:00    33  **************
> >  ...    ..(  2 skipped).    ..  **************
> >   37    2021-03-05 06:15    33  **************
> >   38    2021-03-05 06:20    34  ***************
> >   39    2021-03-05 06:25    35  ****************
> >   40    2021-03-05 06:30    35  ****************
> >   41    2021-03-05 06:35    35  ****************
> >   42    2021-03-05 06:40    34  ***************
> >   43    2021-03-05 06:45    34  ***************
> >   44    2021-03-05 06:50    34  ***************
> >   45    2021-03-05 06:55    33  **************
> >   46    2021-03-05 07:00    33  **************
> >   47    2021-03-05 07:05    33  **************
> >   48    2021-03-05 07:10    34  ***************
> >  ...    ..(  3 skipped).    ..  ***************
> >   52    2021-03-05 07:30    34  ***************
> >   53    2021-03-05 07:35    35  ****************
> >   54    2021-03-05 07:40    35  ****************
> >   55    2021-03-05 07:45    35  ****************
> >   56    2021-03-05 07:50    36  *****************
> >   57    2021-03-05 07:55    35  ****************
> >  ...    ..( 13 skipped).    ..  ****************
> >   71    2021-03-05 09:05    35  ****************
> >   72    2021-03-05 09:10    36  *****************
> >  ...    ..( 13 skipped).    ..  *****************
> >   86    2021-03-05 10:20    36  *****************
> >   87    2021-03-05 10:25    37  ******************
> >   88    2021-03-05 10:30    38  *******************
> >   89    2021-03-05 10:35    38  *******************
> >   90    2021-03-05 10:40    39  ********************
> >   91    2021-03-05 10:45    39  ********************
> >   92    2021-03-05 10:50    39  ********************
> >   93    2021-03-05 10:55    38  *******************
> >   94    2021-03-05 11:00    37  ******************
> >   95    2021-03-05 11:05    37  ******************
> >   96    2021-03-05 11:10    39  ********************
> >   97    2021-03-05 11:15    41  **********************
> >   98    2021-03-05 11:20    42  ***********************
> >   99    2021-03-05 11:25    42  ***********************
> >  100    2021-03-05 11:30    40  *********************
> >  101    2021-03-05 11:35    39  ********************
> >  102    2021-03-05 11:40    38  *******************
> >  103    2021-03-05 11:45    37  ******************
> >  ...    ..(  3 skipped).    ..  ******************
> >  107    2021-03-05 12:05    37  ******************
> >  108    2021-03-05 12:10    39  ********************
> >  109    2021-03-05 12:15    39  ********************
> >  110    2021-03-05 12:20    37  ******************
> >  ...    ..(  2 skipped).    ..  ******************
> >  113    2021-03-05 12:35    37  ******************
> >  114    2021-03-05 12:40    38  *******************
> >  115    2021-03-05 12:45    37  ******************
> >  116    2021-03-05 12:50    37  ******************
> >  117    2021-03-05 12:55    36  *****************
> >  ...    ..(  2 skipped).    ..  *****************
> >  120    2021-03-05 13:10    36  *****************
> >  121    2021-03-05 13:15    35  ****************
> >
> > SCT Error Recovery Control:
> >            Read: Disabled
> >           Write: Disabled
> >
> > Device Statistics (GP/SMART Log 0x04) not supported
> >
> > SATA Phy Event Counters (GP Log 0x11)
> > ID      Size     Value  Description
> > 0x0001  4            0  Command failed due to ICRC error
> > 0x0002  4            0  R_ERR response for data FIS
> > 0x0003  4            0  R_ERR response for device-to-host data FIS
> > 0x0004  4            0  R_ERR response for host-to-device data FIS
> > 0x0005  4            0  R_ERR response for non-data FIS
> > 0x0006  4            0  R_ERR response for device-to-host non-data FIS
> > 0x0007  4            0  R_ERR response for host-to-device non-data FIS
> > 0x0008  4            0  Device-to-host non-data FIS retries
> > 0x0009  4            0  Transition from drive PhyRdy to drive PhyNRdy
> > 0x000a  4            0  Device-to-host register FISes sent due to a COMRESET
> > 0x000b  4            0  CRC errors within host-to-device FIS
> > 0x000d  4            0  Non-CRC errors within host-to-device FIS
> > 0x000f  4            0  R_ERR response for host-to-device data FIS, CRC
> > 0x0010  4            0  R_ERR response for host-to-device data FIS, non-CRC
> > 0x0012  4            0  R_ERR response for host-to-device non-data FIS, CRC
> > 0x0013  4            0  R_ERR response for host-to-device non-data FIS, non-CRC
> > 0x8e00  4            0  Vendor specific
> > 0x8e01  4            0  Vendor specific
> > 0x8e02  4            0  Vendor specific
> > 0x8e03  4            0  Vendor specific
> > 0x8e04  4            0  Vendor specific
> > 0x8e05  4            0  Vendor specific
> > 0x8e06  4            0  Vendor specific
> > 0x8e07  4            0  Vendor specific
> > 0x8e08  4            0  Vendor specific
> > 0x8e09  4            0  Vendor specific
> > 0x8e0a  4            0  Vendor specific
> > 0x8e0b  4            0  Vendor specific
> > 0x8e0c  4            0  Vendor specific
> > 0x8e0d  4            0  Vendor specific
> > 0x8e0e  4            0  Vendor specific
> > 0x8e0f  4            0  Vendor specific
> > 0x8e10  4            0  Vendor specific
> > 0x8e11  4            0  Vendor specific
>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532524FBA5
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHXKkK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 06:40:10 -0400
Received: from mx-relay80-hz2.antispameurope.com ([94.100.136.180]:51899 "EHLO
        mx-relay80-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgHXKkH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 06:40:07 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 06:40:05 EDT
Received: from b2b-92-50-72-125.unitymedia.biz ([92.50.72.125]) by mx-relay80-hz2.antispameurope.com;
 Mon, 24 Aug 2020 12:34:21 +0200
Received: from [192.168.101.55] (192.168.101.55) by eks-ex.eks-engel.local
 (192.168.100.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1034.26; Mon, 24 Aug
 2020 12:34:18 +0200
To:     <linux-ext4@vger.kernel.org>
From:   Benjamin Beckmeyer <beb@eks-engel.de>
Subject: eMMC read problems with i.mx6ul
Message-ID: <21f7a90a-d288-60d6-c009-2c9d9ddc5a21@eks-engel.de>
Date:   Mon, 24 Aug 2020 12:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [192.168.101.55]
X-ClientProxiedBy: eks-ex.eks-engel.local (192.168.100.30) To
 eks-ex.eks-engel.local (192.168.100.30)
X-C2ProcessedOrg: 290e847d-2dbf-4126-92e5-262e4c411ebf
X-cloud-security-sender: beb@eks-engel.de
X-cloud-security-recipient: linux-ext4@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay80-hz2.antispameurope.com with 9E3BD10A99D
X-cloud-security-connect: b2b-92-50-72-125.unitymedia.biz[92.50.72.125], TLS=1, IP=92.50.72.125
X-cloud-security: scantime:1.301
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,
we have some strange problem with an embedded device and emmc.
The emmc has 3 partitions, two rootfs(ro) and a data partition.

The systemd log is written to the data partition to and some user
space tools are writting its small data to this partition too. 

The strange part is, it just occurs in our test environment with 
profinet. We can not reproduce the error if we want. It could be 
running 10-30 time just fine and then it occurs again. 
At the moment I think, it occurs more often when I flash our whole 
hd.img what we get from ptxdist, and after the first boot of the 
system I start the test and the error occurs.

Sometimes, after a reset the emmc won't be recognized in barebox 
as well and the we can't even boot anymore. After a power cut the 
emmc will be recognized again and we can boot again from it, but 
the read error will be still present. Then I have to boot up via 
SD card and make e2fsck to the data partition and the system will 
be booting normally.

I already wrote a message to the systemd developers because the 
systemd-fsck won't check the data partition because it is 
mounted already, I wrote a systemd service myself to do a fsck 
after the systemd-fsck but the error occurs again but this time 
it took longer to occur.

Hopefully somebody can help me with this problem. Let me know if 
you need more information. 

Here is the log from where the mmc driver is loaded: 
/** snip
[    2.127510] 000: sdhci: Secure Digital Host Controller Interface driver
[    2.127528] 000: sdhci: Copyright(c) Pierre Ossman
[    2.127538] 000: sdhci-pltfm: SDHCI platform and OF driver helper
[    2.176672] 000: mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
[    2.228087] 000: mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
[    2.250412] 000: NET: Registered protocol family 10
[    2.266873] 000: Segment Routing with IPv6
[    2.267609] 000: sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.282911] 000: bpfilter: Loaded bpfilter_umh pid 150
[    2.288936] 000: NET: Registered protocol family 17
[    2.289323] 000: Bridge firewalling registered
[    2.289631] 000: 8021q: 802.1Q VLAN Support v1.8
[    2.289828] 000: Key type dns_resolver registered
[    2.298940] 000: Registering SWP/SWPB emulation handler
[    2.337829] 000: mmc1: new DDR MMC card at address 0001
[    2.356365] 000: mmcblk1: mmc1:0001 Q2J55L 7.09 GiB
[    2.358096] 000: mmcblk1boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    2.359513] 000: mmcblk1boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    2.374895] 000: mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB, chardev (247:0)
[    2.388153] 000:  mmcblk1: p1 p2 p3
[    2.460761] 000: imx_thermal tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
[    2.470878] 000: snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    2.497610] 000: mmc0: host does not support reading read-only switch, assuming write-enable
[    2.508639] 000: mmc0: new high speed SDHC card at address 59b4
[    2.526394] 000: mmcblk0: mmc0:59b4 USD   3.75 GiB
[    2.528188] 000: EXT4-fs (mmcblk1p1): mounted filesystem with ordered data mode. Opts: (null)
[    2.528352] 000: VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    2.534657] 000:  mmcblk0: p1 p2 p3 p4
[    2.538719] 000: devtmpfs: mounted
[    2.541648] 000: Freeing unused kernel memory: 1024K
[    2.552044] 000: Run /sbin/init as init process
[    2.558430] 000: random: fast init done
[    2.902075] 000: systemd[1]: System time before build time, advancing clock.
[    2.953223] 000: systemd[1]: systemd 239 running in system mode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK -SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=hybrid)
[  OK  ] Listening on Journal Socket.
[  OK  ] Started Dispa[    2.954390] 000: systemd[1]: Detected architecture arm.
tch Password Requests to Console Directory Watch.
[  OK  ] Created slice system-systemd[    2.964564] 000: systemd[1]: Set hostname to <em-switch>.
\x2dfsck.slice.
[  OK  ] Listening on Journal Socket (/dev/log).
         Mounting /sys/kernel/debug...
[    2.971953] 000: systemd[1]: Hardware watchdog 'imx2+ watchdog', version 0
[    2.972037] 000: systemd[1]: Set hardware watchdog to 10s.
[    4.203054] 000: random: systemd: uninitialized urandom read (16 bytes read)
[    4.205036] 000: systemd[1]: Listening on Journal Socket.
[    4.206831] 000: random: systemd: uninitialized urandom read (16 bytes read)
[    4.208104] 000: systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.208642] 000: random: systemd: uninitialized urandom read (16 bytes read)
[    4.220086] 000: systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    4.222244] 000: systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Process Core Dump Socket.
[  OK  ] Crea[    4.237927] 000: systemd[1]: Mounting /sys/kernel/debug...
ted slice system-serial\x2dgetty.slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Reached target Remote File Systems.
         Starting Journal Service...
         Mounting Kernel Configuration File System...
         Starting Apply Kernel Variables...
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Reached target Paths.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[  OK  ] Reached target Swap.
[  OK  ] Listening on udev Kernel Socket.
         Starting udev Coldplug all Devices...
         Starting Remount Root and Kernel File Systems...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Mounted /sys/kernel/debug.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
         Mounting /var/lib/private...
         Mounting /tmp...
         Mounting /var/tmp...
         Mounting /var/lock...
[  OK  ] Started Journal Service.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Mounted /var/lib/private.
[  OK  ] Mounted /tmp.
[  OK  ] Mounted /var/tmp.
[  OK  ] Mounted /var/lock.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Found device /dev/ttymxc0.
[  OK  ] Found device /dev/disk/by-uuid/1073706a-a8c1-4d59-b701-73b07f603c4c.
         Starting File System Check on /dev/06a-a8c1-4d59-b701-73b07f603c4c...
[     *] A start job is running for File Sysb701-73b07f603c4c (15s / no limit)[   21.024014] 000: random: crng init done
[   21.024030] 000: random: 7 urandom warning(s) missed due to ratelimiting
[    **] A s[   21.317229] 000: mmc1: Card stuck in wrong state! mmcblk1 card_busy_detect status: 0xe00
tart job is running for File Sys¦[   21.317374] 000: mmc1: cache flush error -110
[  *** ] A start job is running for File Sysb701-73b07f603c4c (18s / no limit)[   22.884916] 000: mmc1: tried to HW reset card, got error -110
[   22.884980] 000: mmcblk1: recovery failed!
[   22.885355] 000: print_req_error: I/O error, dev mmcblk1, sector 823296 flags 801
[   22.885415] 000: Buffer I/O error on dev mmcblk1p3, logical block 0, lost async page write
[   22.885729] 000: Buffer I/O error on dev mmcblk1p3, logical block 1, lost async page write
[   22.907845] 000: mmcblk1: error -110 requesting status
[   22.907956] 000: mmcblk1: recovery failed!
[   22.909672] 000: print_req_error: I/O error, dev mmcblk1, sector 824256 flags 801
[   22.909813] 000: Buffer I/O error on dev mmcblk1p3, logical block 120, lost async page write
[   22.919844] 000: mmcblk1: error -110 requesting status
[   22.919886] 000: mmcblk1: recovery failed!
[   22.920054] 000: print_req_error: I/O error, dev mmcblk1, sector 2887696 flags 801
[   22.920080] 000: Buffer I/O error on dev mmcblk1p3, logical block 258050, lost async page write
[   22.920133] 000: Buffer I/O error on dev mmcblk1p3, logical block 258051, lost async page write
[   22.927495] 000: mmcblk1: error -110 requesting status
[   22.927519] 000: mmcblk1: recovery failed!
[   22.928290] 000: print_req_error: I/O error, dev mmcblk1, sector 3018776 flags 801
[   22.928317] 000: Buffer I/O error on dev mmcblk1p3, logical block 274435, lost async page write
[   22.928378] 000: Buffer I/O error on dev mmcblk1p3, logical block 274436, lost async page write
[   22.928400] 000: Buffer I/O error on dev mmcblk1p3, logical block 274437, lost async page write
[   22.936711] 000: mmcblk1: error -110 requesting status
[   22.936738] 000: mmcblk1: recovery failed!
[ ***[   22.936818] 000: print_req_error: I/O error, dev mmcblk1, sector 824256 flags 801
  ] A start job is running fo[   22.936840] 000: Buffer I/O error on dev mmcblk1p3, logical block 120, lost async page write
r File Sysb701-73b07f603c4c (1[   22.946089] 000: mmcblk1: error -110 requesting status
8s / no limit)[   22.946645] 000: mmc1: cache flush error -110
[**    ] A start job is running for File Sysb701-73b07f603c4c (20s / no limit)[   24.499510] 000: mmc1: tried to HW reset card, got error -110
[   24.499570] 000: mmcblk1: recovery failed!
[   24.499987] 000: print_req_error: I/O error, dev mmcblk1, sector 823296 flags 80700
[   24.521212] 000: mmcblk1: error -110 requesting status
[   24.521272] 000: mmcblk1: recovery failed!
[   24.525634] 000: print_req_error: I/O error, dev mmcblk1, sector 5017472 flags 80700
[   24.536275] 000: mmcblk1: error -110 requesting status
[*     ] A start [   24.536304] 000: mmcblk1: recovery failed!
job is running for File Sysb701-73b07f603c4c (20s / no limit)[   24.536440] 000: print_req_error: I/O error, dev mmcblk1, sector 823296 flags 0
[   24.536465] 000: Buffer I/O error on dev mmcblk1p3, logical block 0, async page read
[FAILED] Failed to start File System Check o3706a[   24.543988] 000: mmcblk1: error -110 requesting status
-a8c1-4d59-b701-73b07f603c4c.
See 'systemctl status "systemd-fsck@dev\x2d73b07f603c4c.service"[   24.544009] 000: mmcblk1: recovery failed!
' for details.
[DEPEND] Dependency failed for /data.
[DEPEND] Dependen[   24.544109] 000: print_req_error: I/O error, dev mmcblk1, sector 5017472 flags 0
cy failed for Local File Systems.
[DEPEND] Dependency failed for /var/log.
[DEPEND] Dependency failed for Flush Journal to Persistent [   24.552036] 000: mmcblk1: error -110 requesting status
Storage.
[  OK  ] Reached target Login Prompts.
[  OK  ] Reached target Timers.
[  OK  ] Reached target Sockets.
         [   24.552064] 000: mmcblk1: recovery failed!
Starting Create Volatile Files and Directories...
[   24.552159] 000: print_req_error: I/O error, dev mmcblk1, sector 823296 flags 0
[  OK  ] Started Emergency Shell.
[  OK  ] Reached targe[   24.553234] 000: mmc1: cache flush error -110
t Emergency Mode.
[  OK  ] Reached target Network.
[   24.844915] 000: mmcblk1: error -110 requesting status
[   24.844949] 000: mmcblk1: recovery failed!
[   24.845120] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #5643: comm systemd-tmpfile: reading directory lblock 0
[   24.854949] 000: mmcblk1: error -110 requesting status
[   24.854977] 000: mmcblk1: recovery failed!
[   24.855149] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.863734] 000: mmcblk1: error -110 requesting status
[   24.863767] 000: mmcblk1: recovery failed!
[   24.863937] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #5643: comm systemd-tmpfile: reading directory lblock 0
[   24.872321] 000: mmcblk1: error -110 requesting status
[   24.872349] 000: mmcblk1: recovery failed!
[   24.872521] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.883483] 000: mmcblk1: error -110 requesting status
[   24.883510] 000: mmcblk1: recovery failed!
[   24.883652] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
[   24.891536] 000: mmcblk1: error -110 requesting status
[   24.891563] 000: mmcblk1: recovery failed!
[   24.891707] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.899509] 000: mmcblk1: error -110 requesting status
[   24.899532] 000: mmcblk1: recovery failed!
[   24.899669] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
[   24.906789] 000: mmcblk1: error -110 requesting status
[   24.906807] 000: mmcblk1: recovery failed!
[   24.906918] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.916057] 000: mmcblk1: error -110 requesting status
[   24.916083] 000: mmcblk1: recovery failed!
[   24.916229] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #8740: comm systemd-tmpfile: reading directory lblock 0
[   24.923766] 000: mmcblk1: error -110 requesting status
[   24.923789] 000: mmcblk1: recovery failed!
[   24.923928] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.931803] 000: mmcblk1: error -110 requesting status
[   24.931827] 000: mmcblk1: recovery failed!
[   24.931966] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #8740: comm systemd-tmpfile: reading directory lblock 0
[   24.939625] 000: mmcblk1: error -110 requesting status
[   24.939651] 000: mmcblk1: recovery failed!
[   24.939797] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.952762] 000: mmcblk1: error -110 requesting status
[   24.952784] 000: mmcblk1: recovery failed!
[   24.952913] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
[   24.960744] 000: mmcblk1: error -110 requesting status
[   24.960772] 000: mmcblk1: recovery failed!
[   24.960913] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[  OK  ] Started Create Volatile Files a[   24.968590] 000: mmcblk1: error -110 requesting status
nd Directories.
[   24.968613] 000: mmcblk1: recovery failed!
[   24.968754] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
         Starting Network Time Synchroniz[   24.976226] 000: mmcblk1: error -110 requesting status
ation...
[   24.976245] 000: mmcblk1: recovery failed!
[   24.976383] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   24.984441] 000: mmcblk1: error -110 requesting status
[   24.984465] 000: mmcblk1: recovery failed!
[   24.984608] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
[   24.992264] 000: mmcblk1: error -110 requesting status
[   24.992288] 000: mmcblk1: recovery failed!
[   24.992429] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
[   25.000331] 000: mmcblk1: error -110 requesting status
[   25.000358] 000: mmcblk1: recovery failed!
[   25.000495] 000: EXT4-fs error (device mmcblk1p1): __ext4_find_entry:1492: inode #2561: comm systemd-tmpfile: reading directory lblock 0
[   25.007947] 000: mmcblk1: error -110 requesting status
[   25.007974] 000: mmcblk1: recovery failed!
[FAILED] Failed to start Network Time Synchronization.
See 'systemctl st[   25.008107] 000: EXT4-fs (mmcblk1p1): I/O error while writing superblock
atus systemd-timesyncd.service' for details.
[  OK  ] Stopped Network Time Synchronization.
[   25.016063] 000: mmcblk1: error -110 requesting status
         Starting Network Time Synchroniza[   25.016083] 000: mmcblk1: recovery failed!
tion...
[   25.023743] 000: mmcblk1: error -110 requesting status
[   25.023770] 000: mmcblk1: recovery failed!
[   25.031711] 000: mmcblk1: error -110 requesting status
[   25.031733] 000: mmcblk1: recovery failed!
[   25.039494] 000: mmcblk1: error -110 requesting status
[   25.039522] 000: mmcblk1: recovery failed!
[   25.047338] 000: mmcblk1: error -110 requesting status
[   25.047362] 000: mmcblk1: recovery failed!
[   25.055902] 000: mmcblk1: error -110 requesting status
[   25.055921] 000: mmcblk1: recovery failed!
[   25.063768] 000: mmcblk1: error -110 requesting status
[   25.063789] 000: mmcblk1: recovery failed!
[   25.071356] 000: mmcblk1: error -110 requesting status
[   25.071379] 000: mmcblk1: recovery failed!
[   25.079520] 000: mmcblk1: error -110 requesting status
[   25.079549] 000: mmcblk1: recovery failed!
[FAILED] Failed to start Network Time Sy[   25.086803] 000: mmcblk1: error -110 requesting status
nchronization.
See 'systemctl status systemd-timesyncd.service' for details.
[  OK  ] Stopped Network Time Synchronization.
[   25.086821] 000: mmcblk1: recovery failed!
         Starting Network Time Synchroniza[   25.094766] 000: mmcblk1: error -110 requesting status
tion...
[   25.094789] 000: mmcblk1: recovery failed!
[   25.102440] 000: mmcblk1: error -110 requesting status
[   25.102465] 000: mmcblk1: recovery failed!
[   25.112327] 000: mmcblk1: error -110 requesting status
[   25.112349] 000: mmcblk1: recovery failed!
[   25.120195] 000: mmcblk1: error -110 requesting status
[   25.120223] 000: mmcblk1: recovery failed!
[   25.128028] 000: mmcblk1: error -110 requesting status
[   25.128053] 000: mmcblk1: recovery failed!
[   25.135584] 000: mmcblk1: error -110 requesting status
[   25.135605] 000: mmcblk1: recovery failed!
[   25.214423] 000: mmcblk1: error -110 requesting status
[   25.214445] 000: mmcblk1: recovery failed!
[   25.222312] 000: mmcblk1: error -110 requesting status
[FAILED] Failed to start Network Time Synchronization.
See 'systemctl st[   25.222336] 000: mmcblk1: recovery failed!
atus systemd-timesyncd.service' for details.
[  OK  ] Stopped Network Time Synchronization.
[   25.231191] 000: mmcblk1: error -110 requesting status
         [   25.231215] 000: mmcblk1: recovery failed!
[   25.259659] 000: mmcblk1: error -110 requesting status
Starting Network Time Synchronization...
[   25.259685] 000: mmcblk1: recovery failed!
[   25.266869] 000: mmcblk1: error -110 requesting status
[   25.266887] 000: mmcblk1: recovery failed!
[   25.274889] 000: mmcblk1: error -110 requesting status
[   25.274911] 000: mmcblk1: recovery failed!
[   25.282615] 000: mmcblk1: error -110 requesting status
[   25.282641] 000: mmcblk1: recovery failed!
[   25.381711] 000: mmcblk1: error -110 requesting status
[   25.381733] 000: mmcblk1: recovery failed!
[   25.390506] 000: mmcblk1: error -110 requesting status
[   25.390531] 000: mmcblk1: recovery failed!
[   25.415301] 000: mmcblk1: error -110 requesting status
[FAILED] Failed to start Network Time Sy[   25.415324] 000: mmcblk1: recovery failed!
nchronization.
See 'systemctl status systemd-timesyncd.service' for details.
[  OK  ] Stopped Network Time Synchroniz[   25.422982] 000: mmcblk1: error -110 requesting status
ation.
         Starting Network Time Synchroniz[   25.423006] 000: mmcblk1: recovery failed!
ation...
[   25.430951] 000: mmcblk1: error -110 requesting status
[   25.430973] 000: mmcblk1: recovery failed!
[   25.438547] 000: mmcblk1: error -110 requesting status
[   25.438570] 000: mmcblk1: recovery failed!
[   25.533452] 000: mmcblk1: error -110 requesting status
[   25.533475] 000: mmcblk1: recovery failed!
[   25.542210] 000: mmcblk1: error -110 requesting status
[   25.542232] 000: mmcblk1: recovery failed!
[   25.557311] 000: mmcblk1: error -110 requesting status
[   25.557334] 000: mmcblk1: recovery failed!
[   25.564633] 000: mmcblk1: error -110 requesting status
[   25.564651] 000: mmcblk1: recovery failed!
[   25.572755] 000: mmcblk1: error -110 requesting status
[FAILED] Failed to start Network Time Synchronization.
See 'systemctl stat[   25.572780] 000: mmcblk1: recovery failed!
us systemd-timesyncd.service' for details.
[  OK  ] Stopped Network Time Synchroni[   25.580456] 000: mmcblk1: error -110 requesting status
zation.
[FAILED] Failed to start Network Time Synchronization.
See 'systemctl status[   25.580479] 000: mmcblk1: recovery failed!
 systemd-timesyncd.service' for d[   25.667384] 000: mmcblk1: error -110 requesting status
etails.
[  OK  ] Reac[   25.667408] 000: mmcblk1: recovery failed!
[   25.675702] 000: mmcblk1: error -110 requesting status
[   25.675722] 000: mmcblk1: recovery failed!
[   25.690315] 000: mmcblk1: error -110 requesting status
[   25.690344] 000: mmcblk1: recovery failed!
[   25.698009] 000: mmcblk1: error -110 requesting status
[   25.698036] 000: mmcblk1: recovery failed!
[   25.705846] 000: mmcblk1: error -110 requesting status
[   25.705866] 000: mmcblk1: recovery failed!
[   25.713623] 000: mmcblk1: error -110 requesting status
[   25.713645] 000: mmcblk1: recovery failed!
[   25.801037] 000: mmcblk1: error -110 requesting status
[   25.801060] 000: mmcblk1: recovery failed!
[   25.809880] 000: mmcblk1: error -110 requesting status
[   25.809904] 000: mmcblk1: recovery failed!
[   25.824101] 000: mmcblk1: error -110 requesting status
[   25.824122] 000: mmcblk1: recovery failed!
[   25.831884] 000: mmcblk1: error -110 requesting status
[   25.831908] 000: mmcblk1: recovery failed!
[   25.839946] 000: mmcblk1: error -110 requesting status
[   25.839971] 000: mmcblk1: recovery failed!
[   25.847336] 000: mmcblk1: error -110 requesting status
[   25.847358] 000: mmcblk1: recovery failed!
[   25.912384] 000: mmcblk1: error -110 requesting status
[   25.912407] 000: mmcblk1: recovery failed!
[   25.912534] 000: EXT4-fs warning (device mmcblk1p1): ext4_dx_find_entry:1602: inode #5668: lblock 1: comm (plymouth): error -5 reading directory block
[   25.992057] 000: mmcblk1: error -110 requesting status
[   25.992078] 000: mmcblk1: recovery failed!
[   25.999776] 000: mmcblk1: error -110 requesting status
[   25.999798] 000: mmcblk1: recovery failed!

-- 
Best regards
Benjamin Beckmeyer


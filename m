Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF5D76AC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2019 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfJOMi4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 15 Oct 2019 08:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfJOMi4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 08:38:56 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205197] New: kernel BUG at fs/ext4/extents_status.c:884
Date:   Tue, 15 Oct 2019 12:38:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arnaud@btmx.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205197-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205197

            Bug ID: 205197
           Summary: kernel BUG at fs/ext4/extents_status.c:884
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.5
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: arnaud@btmx.fr
        Regression: No

I get this in dmesg when trying to mount an encrypted volume that is on an SD
card.

[ 196.382120] kernel BUG at fs/ext4/extents_status.c:884!
[ 196.382126] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[ 196.382131] CPU: 1 PID: 3053 Comm: mount Tainted: G OE 5.3.5-arch1-1-ARCH #1
[ 196.382133] Hardware name: LENOVO 20BUS0991P/20BUS0991P, BIOS JBET54WW (1.19
) 11/06/2015
[ 196.382152] RIP: 0010:ext4_es_cache_extent+0x130/0x140 [ext4]
[ 196.382155] Code: 48 89 e2 4c 89 e6 e8 3f 13 24 c6 48 8b 03 48 85 c0 75 e5 65
ff 0d 68 72 a5 3f 0f 85 43 ff ff ff e8 15 3f 64 c5 e9 39 ff ff ff <0f> 0b e8 49
da 6c c5 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
[ 196.382157] RSP: 0018:ffffb357c2087a08 EFLAGS: 00010a13
[ 196.382159] RAX: 07ffffffffffffff RBX: ffff89fa3622c468 RCX: 07ffffffffffffff
[ 196.382161] RDX: 00000000d7fee2a7 RSI: 000000008597e24b RDI: ffff89fa3622c468
[ 196.382163] RBP: 000000005d96c4f1 R08: 47ffffffffffffff R09: 0000000000000008
[ 196.382165] R10: ffffd3ac501f1000 R11: 0000000000000c84 R12: ffff89fa3622c468
[ 196.382166] R13: 000000008597e24b R14: ffff89fa5b642de8 R15: 000000005d96c4f2
[ 196.382169] FS: 00007fa998e67500(0000) GS:ffff89fa6de40000(0000)
knlGS:0000000000000000
[ 196.382171] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 196.382173] CR2: 00007f4d6727a100 CR3: 00000004256f0003 CR4: 00000000003606e0
[ 196.382175] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 196.382176] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 196.382178] Call Trace:
[ 196.382194] __read_extent_tree_block+0x19d/0x240 [ext4]
[ 196.382207] ext4_find_extent+0x140/0x310 [ext4]
[ 196.382220] ext4_ext_map_blocks+0x96/0x1260 [ext4]
[ 196.382237] ext4_map_blocks+0x361/0x610 [ext4]
[ 196.382252] _ext4_get_block+0xaa/0x120 [ext4]
[ 196.382257] generic_block_bmap+0x4b/0x70
[ 196.382266] jbd2_journal_init_inode+0x13/0xb0 [jbd2]
[ 196.382283] ext4_fill_super+0x261e/0x36f0 [ext4]
[ 196.382289] ? snprintf+0x51/0x70
[ 196.382293] ? mount_bdev+0x176/0x1a0
[ 196.382308] ? ext4_calculate_overhead+0x480/0x480 [ext4]
[ 196.382310] mount_bdev+0x176/0x1a0
[ 196.382325] ? ext4_calculate_overhead+0x480/0x480 [ext4]
[ 196.382330] legacy_get_tree+0x27/0x40
[ 196.382334] vfs_get_tree+0x25/0xd0
[ 196.382337] do_mount+0x78c/0x9f0
[ 196.382341] ? memdup_user+0x45/0x80
[ 196.382343] ksys_mount+0x7e/0xc0
[ 196.382346] __x64_sys_mount+0x21/0x30
[ 196.382350] do_syscall_64+0x5f/0x1c0
[ 196.382355] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 196.382358] RIP: 0033:0x7fa998feae4e
[ 196.382361] Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 89 01 48
[ 196.382363] RSP: 002b:00007fff1c861838 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[ 196.382366] RAX: ffffffffffffffda RBX: 00007fa999111204 RCX: 00007fa998feae4e
[ 196.382367] RDX: 00005623e65ba650 RSI: 00005623e65ba6d0 RDI: 00005623e65ba6b0
[ 196.382369] RBP: 00005623e65ba440 R08: 0000000000000000 R09: 00005623e65bb750
[ 196.382370] R10: 0000000000000400 R11: 0000000000000246 R12: 0000000000000000
[ 196.382372] R13: 00005623e65ba6b0 R14: 00005623e65ba650 R15: 00005623e65ba440
[ 196.382375] Modules linked in: bnep fuse dm_crypt snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc
joydev mousedev btusb intel_rapl_msr intel_rapl_common btrtl btbcm btintel
bluetooth x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm ecdh_generic ecc
irqbypass i915 iwlmvm crct10dif_pclmul mac80211 crc32_pclmul ofpart
ghash_clmulni_intel cmdlinepart libarc4 intel_spi_platform intel_spi
snd_hda_codec_realtek i2c_algo_bit iTCO_wdt spi_nor iTCO_vendor_support
snd_hda_codec_generic iwlwifi aesni_intel mei_wdt mtd mei_hdcp wmi_bmof
snd_hda_intel aes_x86_64 drm_kms_helper crypto_simd snd_hda_codec cryptd drm
glue_helper intel_cstate intel_uncore cfg80211 psmouse snd_hda_core
intel_rapl_perf input_leds thinkpad_acpi i2c_i801 intel_pch_thermal intel_gtt
tpm_tis snd_hwdep mei_me tpm_tis_core snd_pcm rtsx_pci_ms agpgart nvram
ledtrig_audio lpc_ich memstick mei snd_timer syscopyarea rfkill e1000e tpm
sysfillrect evdev snd sysimgblt mac_hid
[ 196.382407] rng_core fb_sys_fops battery ac wmi soundcore mmc_block
vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vboxdrv(OE) coretemp msr loop sg
crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 dm_mod
sd_mod rtsx_pci_sdmmc serio_raw mmc_core atkbd libps2 ahci libahci libata
crc32c_intel ehci_pci xhci_pci scsi_mod ehci_hcd xhci_hcd rtsx_pci i8042 serio
[ 196.382428] ---[ end trace 175bffb9fd52421d ]---
[ 196.382447] RIP: 0010:ext4_es_cache_extent+0x130/0x140 [ext4]
[ 196.382471] Code: 48 89 e2 4c 89 e6 e8 3f 13 24 c6 48 8b 03 48 85 c0 75 e5 65
ff 0d 68 72 a5 3f 0f 85 43 ff ff ff e8 15 3f 64 c5 e9 39 ff ff ff <0f> 0b e8 49
da 6c c5 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
[ 196.382473] RSP: 0018:ffffb357c2087a08 EFLAGS: 00010a13
[ 196.382476] RAX: 07ffffffffffffff RBX: ffff89fa3622c468 RCX: 07ffffffffffffff
[ 196.382477] RDX: 00000000d7fee2a7 RSI: 000000008597e24b RDI: ffff89fa3622c468
[ 196.382479] RBP: 000000005d96c4f1 R08: 47ffffffffffffff R09: 0000000000000008
[ 196.382481] R10: ffffd3ac501f1000 R11: 0000000000000c84 R12: ffff89fa3622c468
[ 196.382483] R13: 000000008597e24b R14: ffff89fa5b642de8 R15: 000000005d96c4f2
[ 196.382485] FS: 00007fa998e67500(0000) GS:ffff89fa6de40000(0000)
knlGS:0000000000000000
[ 196.382487] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 196.382488] CR2: 00007f4d6727a100 CR3: 00000004256f0003 CR4: 00000000003606e0
[ 196.382494] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 196.382495] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

--------------------------------------------------------------------------------------------------

LUKS header information
Version: 2
Epoch: 3
Metadata area: 16384 [bytes]
Keyslots area: 16744448 [bytes]
UUID: 02d64dc9-075e-462f-bfb3-d68e86ec55cc
Label: (no label)
Subsystem: (no subsystem)
Flags: (no flags)

Data segments:
0: crypt
offset: 16777216 [bytes]
length: (whole device)
cipher: aes-xts-plain64
sector: 512 [bytes]

Keyslots:
0: luks2
Key: 512 bits
Priority: normal
Cipher: aes-xts-plain64
Cipher key: 512 bits
PBKDF: argon2i
Time cost: 4
Memory: 894034
Threads: 4
Salt: ca dc d6 fd d0 a5 48 b0 2e 0b f4 bd 0b cc ae 31
c9 96 9d a6 b2 cb e3 24 b5 be 76 55 89 e5 1d dc
AF stripes: 4000
AF hash: sha256
Area offset:32768 [bytes]
Area length:258048 [bytes]
Digest ID: 0
Tokens:
Digests:
0: pbkdf2
Hash: sha256
Iterations: 110516
Salt: 21 53 93 92 14 12 d9 1b 33 d5 8c 03 e0 8b 89 b4
b7 00 9d 4b 3b be 68 ab d3 f5 b7 42 d9 31 f5 61
Digest: 66 28 58 07 3f 71 99 5c 63 99 49 b6 53 a9 d7 9d
38 aa 84 9e 7e 8c 42 62 99 d8 8b 35 7d 12 99 3c

----------------------------------------------------------------------------------------------------------------

★ sudo fdisk -l /dev/mmcblk0
Disk /dev/mmcblk0: 976.58 GiB, 1048577048576 bytes, 2048002048 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device Boot Start End Sectors Size Id Type
/dev/mmcblk0p1 32 2048001823 2048001792 976.6G b W95 FAT32

------------------------------------------------------------------------------------------------------------------

★ sudo fdisk -l /dev/mapper/sd
Disk /dev/mapper/sd: 976.56 GiB, 1048560140288 bytes, 2047969024 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

------------------------------------------------------------------------------------------------------------------

★ sudo cat /etc/crypttab
sd /dev/mmcblk0p1 /home/arno/.sd.keyfile luks,nofail

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

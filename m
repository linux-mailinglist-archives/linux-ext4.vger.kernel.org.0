Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D440269F9E
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIOHY7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 15 Sep 2020 03:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgIOHYr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 03:24:47 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 209275] New: Graphics freeze after WARNING: CPU: 2 PID: 156207
 at fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
Date:   Tue, 15 Sep 2020 07:24:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dwagelaar@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-209275-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209275

            Bug ID: 209275
           Summary: Graphics freeze after WARNING: CPU: 2 PID: 156207 at
                    fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
           Product: File System
           Version: 2.5
    Kernel Version: 5.8.6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: dwagelaar@gmail.com
        Regression: No

Since updating from kernel 5.7.15 to 5.6.8, I get system freezes (graphics and
input only, sound continues to work) about once every day.

Sep 15 08:51:36 styx kernel: ------------[ cut here ]------------
Sep 15 08:51:36 styx kernel: WARNING: CPU: 2 PID: 156207 at
fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
Sep 15 08:51:36 styx kernel: Modules linked in: hid_steam uinput vfat fat
xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJE
CT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable
_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter it87(OE)
hwmon_vid snd_hda_codec_realtek uvcvideo snd_hda_codec_generic vid
eobuf2_vmalloc videobuf2_memops ledtrig_audio snd_hda_codec_hdmi videobuf2_v4l2
snd_hda_intel videobuf2_common snd_intel_dspcfg snd_usb_audio snd_usbmidi_lib
videodev snd_hda_codec snd_rawmidi edac_mce_amd joyde
v mc kvm_amd snd_hda_core snd_hwdep kvm snd_seq snd_seq_device irqbypass
eeepc_wmi asus_wmi snd_pcm rapl sparse_keymap rfkill snd_timer video sp5100_tco
wmi_bmof pcspkr snd
Sep 15 08:51:36 styx kernel: i2c_piix4 k10temp soundcore gpio_amdpt
gpio_generic acpi_cpufreq binfmt_misc ip_tables dm_crypt hid_logitech_hidpp
amdgpu iommu_v2 gpu_sched i2c_algo_bit ttm crct10dif_pclmul drm_kms
_helper crc32_pclmul crc32c_intel cec ghash_clmulni_intel drm ccp r8169 nvme
uas usb_storage nvme_core hid_logitech_dj wmi pinctrl_amd fuse
Sep 15 08:51:36 styx kernel: CPU: 2 PID: 156207 Comm: gnome-shell Tainted: G   
       OE     5.8.6-101.fc31.x86_64 #1
Sep 15 08:51:36 styx kernel: Hardware name: System manufacturer System Product
Name/PRIME B350M-A, BIOS 5603 07/28/2020
Sep 15 08:51:36 styx kernel: RIP: 0010:ext4_set_page_dirty+0x3e/0x50
Sep 15 08:51:36 styx kernel: Code: 48 8b 00 a8 01 75 16 48 8b 57 08 48 8d 42 ff
83 e2 01 48 0f 44 c7 48 8b 00 a8 08 74 0d 48 8b 07 f6 c4 20 74 0f e9 92 ec f6
ff <0f> 0b 48 8b 07 f6 c4 20 75 f1 0f 0b e9 81 ec f6 
ff 90 0f 1f 44 00
Sep 15 08:51:36 styx kernel: RSP: 0018:ffffb0660e0b7b58 EFLAGS: 00010246
Sep 15 08:51:36 styx kernel: RAX: 0017ffffc0020016 RBX: ffffdf579f8b8240 RCX:
0000000000000000
Sep 15 08:51:36 styx kernel: RDX: 0000000000000000 RSI: 000055a8b037a000 RDI:
ffffdf579f8b8240
Sep 15 08:51:36 styx kernel: RBP: ffff9c81a54a5bd0 R08: ffff9c8192920960 R09:
0000000000000000
Sep 15 08:51:36 styx kernel: R10: 0000000000000000 R11: 0000000000000000 R12:
ffffb0660e0b7ca8
Sep 15 08:51:36 styx kernel: R13: 000055a8b037b000 R14: 80000007e2e09845 R15:
000055a8b037a000
Sep 15 08:51:36 styx kernel: FS:  00007fbaa607f200(0000)
GS:ffff9c81be880000(0000) knlGS:0000000000000000
Sep 15 08:51:36 styx kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 15 08:51:36 styx kernel: CR2: 00007fbaa9c69430 CR3: 000000025ccc4000 CR4:
00000000003406e0
Sep 15 08:51:36 styx kernel: Call Trace:
Sep 15 08:51:36 styx kernel: unmap_page_range+0xa8d/0xee0
Sep 15 08:51:36 styx kernel: unmap_vmas+0x6a/0xd0
Sep 15 08:51:36 styx kernel: exit_mmap+0x97/0x170
Sep 15 08:51:36 styx kernel: mmput+0x61/0x140
Sep 15 08:51:36 styx kernel: begin_new_exec+0x377/0x98c
Sep 15 08:51:36 styx kernel: load_elf_binary+0x13e/0x16f0
Sep 15 08:51:36 styx kernel: __do_execve_file.isra.0+0x5d7/0xb90
Sep 15 08:51:36 styx kernel: __x64_sys_execve+0x35/0x40
Sep 15 08:51:36 styx kernel: do_syscall_64+0x52/0x90
Sep 15 08:51:36 styx kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Sep 15 08:51:36 styx kernel: RIP: 0033:0x7fbaa9d104db
Sep 15 08:51:36 styx kernel: Code: Bad RIP value.
Sep 15 08:51:36 styx kernel: RSP: 002b:00007ffe62149158 EFLAGS: 00000246
ORIG_RAX: 000000000000003b
Sep 15 08:51:36 styx kernel: RAX: ffffffffffffffda RBX: 00007fbaa607f180 RCX:
00007fbaa9d104db
Sep 15 08:51:36 styx kernel: RDX: 000055a8ad07acf0 RSI: 000055a8b25f8160 RDI:
000055a8ada2b9e0
Sep 15 08:51:36 styx kernel: RBP: 000000000000007b R08: 0000000000000000 R09:
00007fbaa6e984e0
Sep 15 08:51:36 styx kernel: R10: 000055a8b25f8160 R11: 0000000000000246 R12:
000055a8ada2b9e0
Sep 15 08:51:36 styx kernel: R13: 000055a8b25f8160 R14: 0000000000000016 R15:
0000000000000000
Sep 15 08:51:36 styx kernel: ---[ end trace 17be478a5fbbe377 ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

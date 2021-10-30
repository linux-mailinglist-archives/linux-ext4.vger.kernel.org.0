Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06644407DE
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Oct 2021 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhJ3Heq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Oct 2021 03:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhJ3Heq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 30 Oct 2021 03:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E7D760296
        for <linux-ext4@vger.kernel.org>; Sat, 30 Oct 2021 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635579136;
        bh=oqcstX9wJUg0F66xUYK1FjTg1Bb+w7oPQXFZYOk6mAQ=;
        h=From:To:Subject:Date:From;
        b=cTfZXnKm63LbnixSSI/Og23Kuj+iP4p/MSoO7zyHDUGhBu5x/1No7PDpg9Otr7Ujo
         GXt/DsGSpIbHjx5xn8bF1tGE38QvjNkhrm4KaSE90YCylTCgGlirJP2855DKHxVAww
         fPCJIzGLEYnB4X4RdCE4TcMvoETUPdmfzbiVklbM/Lk4AwqSqfpFR71E861b63WOx0
         cTRsFg7FNofCOh06PXCuXsszSd0/rf2e2cqBF/alSrM6JVbE7TGe8KL30b3rxV1tBI
         H/8dIB78Jiy6aoyj2JgwW86Z6OlmfOZOCcD53c9GcmDpd7vXh/rfm7J60M6/+oCRzs
         wXHhJtSnM+Xyw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7BCAC60F35; Sat, 30 Oct 2021 07:32:16 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214881] New: whole file system down, dmesg say kernel BUG
Date:   Sat, 30 Oct 2021 07:32:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jre200080@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214881-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214881

            Bug ID: 214881
           Summary: whole file system down, dmesg say kernel BUG
           Product: File System
           Version: 2.5
    Kernel Version: 5.4.0-89-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: jre200080@gmail.com
        Regression: No

[86468.462456] ------------[ cut here ]------------
[86468.462486] WARNING: CPU: 1 PID: 12821 at fs/ext4/inode.c:3936
ext4_set_page_dirty+0x4e/0x60
[86468.462487] Modules linked in: bluetooth ecdh_generic ecc vmnet(OE)
parport_pc vmmon(OE) xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetl=
ink
xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntr=
ack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter br_netfilter bridge stp llc
vmw_vsock_vmci_transport vsock vmw_vmci vboxnetadp(OE) vboxnetflt(OE) aufs
vboxdrv(OE) overlay binfmt_misc nls_iso8859_1 snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr
snd_hda_intel snd_intel_dspcfg mei_hdcp snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event intel_rapl_common x86_pkg_temp_ther=
mal
intel_powerclamp coretemp snd_rawmidi kvm_intel dell_smm_hwmon kvm
crct10dif_pclmul ghash_clmulni_intel snd_seq aesni_intel input_leds crypto_=
simd
joydev dell_wmi cryptd glue_helper dell_smbios i915 snd_seq_device rapl dcd=
bas
intel_cstate snd_timer snd sparse_keymap dell_wmi_descriptor
intel_wmi_thunderbolt wmi_bmof serio_raw
[86468.462513]  drm_kms_helper mei_me mei i2c_algo_bit fb_sys_fops syscopya=
rea
sysfillrect intel_pch_thermal soundcore sysimgblt mac_hid acpi_pad sch_fq_c=
odel
msr ppdev lp parport drm ip_tables x_tables autofs4 hid_generic usbhid hid
crc32_pclmul e1000e psmouse ahci i2c_i801 libahci wmi video [last unloaded:
parport_pc]
[86468.462525] CPU: 1 PID: 12821 Comm: vmx-vcpu-0 Tainted: G           OE=
=20=20=20=20
5.4.0-89-generic #100-Ubuntu
[86468.462526] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS
2.13.1 06/14/2019
[86468.462528] RIP: 0010:ext4_set_page_dirty+0x4e/0x60
[86468.462529] Code: 8d 42 ff 83 e2 01 48 0f 44 c7 48 8b 00 a8 08 74 0f 48 =
8b
07 f6 c4 20 74 11 e8 8e 8a f7 ff 5d c3 0f 0b 48 8b 07 f6 c4 20 75 ef <0f> 0=
b e8
7b 8a f7 ff 5d c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00
[86468.462530] RSP: 0018:ffff9951813c7ce8 EFLAGS: 00010246
[86468.462531] RAX: 0017ffffc0000055 RBX: ffff889f85e41860 RCX:
0000000000000000
[86468.462531] RDX: 0000000000000000 RSI: 0000000000000041 RDI:
ffffd6a84cf7d4c0
[86468.462532] RBP: ffff9951813c7ce8 R08: 0000000000000000 R09:
ffffffffab668700
[86468.462532] R10: ffff889f3884f540 R11: 0000000000000001 R12:
ffffd6a84cf7d4c0
[86468.462533] R13: 0000000000000041 R14: ffff889f85e41860 R15:
0000000000000001
[86468.462534] FS:  00007f1df1b2c700(0000) GS:ffff889f95a40000(0000)
knlGS:0000000000000000
[86468.462534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86468.462535] CR2: 00007f20015e83f1 CR3: 00000003fee1e005 CR4:
00000000003606e0
[86468.462536] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[86468.462536] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[86468.462536] Call Trace:
[86468.462540]  set_page_dirty+0x61/0xc0
[86468.462541]  set_page_dirty_lock+0x35/0x60
[86468.462546]  qp_release_pages+0x68/0xb0 [vmw_vmci]
[86468.462549]  qp_host_unregister_user_memory.isra.0+0x27/0x80 [vmw_vmci]
[86468.462551]  vmci_qp_broker_detach+0x2b3/0x3f0 [vmw_vmci]
[86468.462553]  vmci_host_unlocked_ioctl+0x9c/0xb20 [vmw_vmci]
[86468.462556]  do_vfs_ioctl+0x407/0x670
[86468.462558]  ? do_user_addr_fault+0x216/0x450
[86468.462559]  ksys_ioctl+0x67/0x90
[86468.462561]  __x64_sys_ioctl+0x1a/0x20
[86468.462563]  do_syscall_64+0x57/0x190
[86468.462565]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[86468.462566] RIP: 0033:0x7f2004e5550b
[86468.462567] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 =
c7
c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[86468.462568] RSP: 002b:00007f1df1b206a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[86468.462569] RAX: ffffffffffffffda RBX: 00007f1df1b206c0 RCX:
00007f2004e5550b
[86468.462569] RDX: 00007f1df1b206c0 RSI: 00000000000007aa RDI:
0000000000000076
[86468.462570] RBP: 0000000000000000 R08: 0000000000000000 R09:
00007f1df1b20810
[86468.462570] R10: 000055eaf4e17900 R11: 0000000000000246 R12:
00000000fffffffe
[86468.462571] R13: 0000000000000020 R14: 0000000000000020 R15:
00007f20035f5280
[86468.462572] ---[ end trace 4a54b902aa5ff059 ]---
[86511.589168] ------------[ cut here ]------------
[86511.589170] kernel BUG at fs/ext4/inode.c:2714!
[86511.589174] invalid opcode: 0000 [#1] SMP PTI
[86511.589175] CPU: 7 PID: 68798 Comm: kworker/u16:3 Tainted: G        W  O=
E=20=20=20
 5.4.0-89-generic #100-Ubuntu
[86511.589176] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS
2.13.1 06/14/2019
[86511.589179] Workqueue: writeback wb_workfn (flush-8:16)
[86511.589182] RIP: 0010:mpage_prepare_extent_to_map+0x294/0x2d0
[86511.589184] Code: 6e 74 00 48 8b 85 30 ff ff ff 48 39 85 48 ff ff ff 0f =
86
21 fe ff ff 31 c0 eb a4 4c 89 ef e8 b3 a4 e7 ff e9 a4 fe ff ff 0f 0b <0f> 0=
b 48
8d bd 50 ff ff ff 89 85 40 ff ff ff e8 48 af e8 ff 8b 85
[86511.589184] RSP: 0018:ffff995183797930 EFLAGS: 00010246
[86511.589186] RAX: 0017ffffc000005d RBX: ffff995183797968 RCX:
00000000001214f5
[86511.589187] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffd6a84cf7d4c0
[86511.589188] RBP: ffff995183797a00 R08: 00000000ffffefff R09:
ffff8899d32ca000
[86511.589189] R10: 0000000000092800 R11: 0000000000000000 R12:
000000000000024f
[86511.589190] R13: ffffd6a84cf7d4c0 R14: ffff889e8ab92058 R15:
ffff995183797a90
[86511.589191] FS:  0000000000000000(0000) GS:ffff889f95bc0000(0000)
knlGS:0000000000000000
[86511.589192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86511.589193] CR2: 00007f1ed6015000 CR3: 00000001f460a003 CR4:
00000000003606e0
[86511.589193] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[86511.589194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[86511.589194] Call Trace:
[86511.589198]  ext4_writepages+0x5ab/0x950
[86511.589201]  do_writepages+0x43/0xd0
[86511.589202]  ? mpage_map_and_submit_extent+0x4b0/0x4b0
[86511.589203]  ? do_writepages+0x43/0xd0
[86511.589205]  ? find_busiest_group+0x49/0x520
[86511.589206]  __writeback_single_inode+0x40/0x300
[86511.589208]  writeback_sb_inodes+0x22d/0x4b0
[86511.589209]  __writeback_inodes_wb+0x56/0xf0
[86511.589210]  wb_writeback+0x20c/0x2f0
[86511.589212]  ? cpumask_next+0x1b/0x20
[86511.589214]  wb_workfn+0x3a5/0x4f0
[86511.589215]  ? __switch_to_asm+0x40/0x70
[86511.589216]  ? __switch_to_asm+0x34/0x70
[86511.589217]  ? __switch_to_asm+0x40/0x70
[86511.589217]  ? __switch_to_asm+0x34/0x70
[86511.589218]  ? __switch_to_asm+0x40/0x70
[86511.589220]  ? __switch_to+0x7f/0x480
[86511.589220]  ? __switch_to_asm+0x40/0x70
[86511.589221]  ? __switch_to_asm+0x34/0x70
[86511.589223]  process_one_work+0x1eb/0x3b0
[86511.589225]  worker_thread+0x4d/0x400
[86511.589226]  kthread+0x104/0x140
[86511.589227]  ? process_one_work+0x3b0/0x3b0
[86511.589228]  ? kthread_park+0x90/0x90
[86511.589229]  ret_from_fork+0x35/0x40
[86511.589230] Modules linked in: bluetooth ecdh_generic ecc vmnet(OE)
parport_pc vmmon(OE) xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetl=
ink
xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntr=
ack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter br_netfilter bridge stp llc
vmw_vsock_vmci_transport vsock vmw_vmci vboxnetadp(OE) vboxnetflt(OE) aufs
vboxdrv(OE) overlay binfmt_misc nls_iso8859_1 snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr
snd_hda_intel snd_intel_dspcfg mei_hdcp snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event intel_rapl_common x86_pkg_temp_ther=
mal
intel_powerclamp coretemp snd_rawmidi kvm_intel dell_smm_hwmon kvm
crct10dif_pclmul ghash_clmulni_intel snd_seq aesni_intel input_leds crypto_=
simd
joydev dell_wmi cryptd glue_helper dell_smbios i915 snd_seq_device rapl dcd=
bas
intel_cstate snd_timer snd sparse_keymap dell_wmi_descriptor
intel_wmi_thunderbolt wmi_bmof serio_raw
[86511.589249]  drm_kms_helper mei_me mei i2c_algo_bit fb_sys_fops syscopya=
rea
sysfillrect intel_pch_thermal soundcore sysimgblt mac_hid acpi_pad sch_fq_c=
odel
msr ppdev lp parport drm ip_tables x_tables autofs4 hid_generic usbhid hid
crc32_pclmul e1000e psmouse ahci i2c_i801 libahci wmi video [last unloaded:
parport_pc]
[86511.589259] ---[ end trace 4a54b902aa5ff05a ]---
[86511.646812] RIP: 0010:mpage_prepare_extent_to_map+0x294/0x2d0
[86511.646818] Code: 6e 74 00 48 8b 85 30 ff ff ff 48 39 85 48 ff ff ff 0f =
86
21 fe ff ff 31 c0 eb a4 4c 89 ef e8 b3 a4 e7 ff e9 a4 fe ff ff 0f 0b <0f> 0=
b 48
8d bd 50 ff ff ff 89 85 40 ff ff ff e8 48 af e8 ff 8b 85
[86511.646819] RSP: 0018:ffff995183797930 EFLAGS: 00010246
[86511.646821] RAX: 0017ffffc000005d RBX: ffff995183797968 RCX:
00000000001214f5
[86511.646821] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffd6a84cf7d4c0
[86511.646822] RBP: ffff995183797a00 R08: 00000000ffffefff R09:
ffff8899d32ca000
[86511.646823] R10: 0000000000092800 R11: 0000000000000000 R12:
000000000000024f
[86511.646824] R13: ffffd6a84cf7d4c0 R14: ffff889e8ab92058 R15:
ffff995183797a90
[86511.646825] FS:  0000000000000000(0000) GS:ffff889f95bc0000(0000)
knlGS:0000000000000000
[86511.646826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86511.646827] CR2: 00007f1ed6015000 CR3: 00000001f460a003 CR4:
00000000003606e0
[86511.646828] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[86511.646829] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[86511.646853] ------------[ cut here ]------------
[86511.646859] WARNING: CPU: 7 PID: 68798 at kernel/exit.c:726
do_exit+0x49/0xaf0
[86511.646860] Modules linked in: bluetooth ecdh_generic ecc vmnet(OE)
parport_pc vmmon(OE) xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetl=
ink
xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntr=
ack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter br_netfilter bridge stp llc
vmw_vsock_vmci_transport vsock vmw_vmci vboxnetadp(OE) vboxnetflt(OE) aufs
vboxdrv(OE) overlay binfmt_misc nls_iso8859_1 snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio intel_rapl_msr
snd_hda_intel snd_intel_dspcfg mei_hdcp snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event intel_rapl_common x86_pkg_temp_ther=
mal
intel_powerclamp coretemp snd_rawmidi kvm_intel dell_smm_hwmon kvm
crct10dif_pclmul ghash_clmulni_intel snd_seq aesni_intel input_leds crypto_=
simd
joydev dell_wmi cryptd glue_helper dell_smbios i915 snd_seq_device rapl dcd=
bas
intel_cstate snd_timer snd sparse_keymap dell_wmi_descriptor
intel_wmi_thunderbolt wmi_bmof serio_raw
[86511.646904]  drm_kms_helper mei_me mei i2c_algo_bit fb_sys_fops syscopya=
rea
sysfillrect intel_pch_thermal soundcore sysimgblt mac_hid acpi_pad sch_fq_c=
odel
msr ppdev lp parport drm ip_tables x_tables autofs4 hid_generic usbhid hid
crc32_pclmul e1000e psmouse ahci i2c_i801 libahci wmi video [last unloaded:
parport_pc]
[86511.646923] CPU: 7 PID: 68798 Comm: kworker/u16:3 Tainted: G      D W  O=
E=20=20=20
 5.4.0-89-generic #100-Ubuntu
[86511.646924] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS
2.13.1 06/14/2019
[86511.646929] Workqueue: writeback wb_workfn (flush-8:16)
[86511.646932] RIP: 0010:do_exit+0x49/0xaf0
[86511.646933] Code: 83 ec 40 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 =
48
8b 83 a0 0b 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 b7 04 00 00 <0f> 0=
b 65
44 8b 2d 65 8b b7 54 41 81 e5 00 ff 1f 00 44 89 6d 9c 0f
[86511.646934] RSP: 0018:ffff995183797ee0 EFLAGS: 00010216
[86511.646935] RAX: ffff995183797d30 RBX: ffff889f6f5597c0 RCX:
0000000000000006
[86511.646936] RDX: ffff889f857e0048 RSI: 0000000000000086 RDI:
000000000000000b
[86511.646936] RBP: ffff995183797f48 R08: 0000000000000566 R09:
ffffffffacfb3084
[86511.646937] R10: ffffffffacf991a8 R11: ffff995183797580 R12:
000000000000000b
[86511.646938] R13: 000000000000000b R14: ffffffffac74a718 R15:
0000000000000000
[86511.646939] FS:  0000000000000000(0000) GS:ffff889f95bc0000(0000)
knlGS:0000000000000000
[86511.646940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86511.646940] CR2: 00007f1ed6015000 CR3: 00000001f460a003 CR4:
00000000003606e0
[86511.646941] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[86511.646942] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[86511.646943] Call Trace:
[86511.646948]  ? kthread+0x104/0x140
[86511.646951]  ? process_one_work+0x3b0/0x3b0
[86511.646955]  rewind_stack_do_exit+0x17/0x20
[86511.646957] ---[ end trace 4a54b902aa5ff05b ]---
[86652.894611] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[86652.894626] Bluetooth: BNEP filters: protocol multicast
[86652.894629] Bluetooth: BNEP socket layer initialized

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

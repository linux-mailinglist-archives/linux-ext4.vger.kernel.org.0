Return-Path: <linux-ext4+bounces-3348-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1CE938624
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69AD1C20A78
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BE168492;
	Sun, 21 Jul 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6gqNQnP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00D1DA53
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721595947; cv=none; b=a4nI1vqZqZXgT7MolpGA1tzsSYEx50EO2Z5rAP1yRzXbTndM2BpBYSndrfGNYuq2afgnN0yLcZhRJt5YynJdmcSe82wgEQ3Nw6EG8wnFsVBRFyAtiSHNtOdbZ+PYXLMhYsGppeSa8p8OCRz63gCAUEx5LgU1WbKKD4yNlG2vh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721595947; c=relaxed/simple;
	bh=yQkVJr7hR32nRi7bK8CMYIP+oobRmr0+t5v5SVaOL5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdjSMIbrb1+3h3UggGRtYZ6f3S/HHl74Xr7z6WPOS5P26vhxG6/n0Ox/3lQA00yLm+Yuc6KIuX8KLigpYNNc/QqCPXizKEUDLU1qkhIY69uR1JtmjI83rzlP7W++gnncY+u5F3Apn9Rzq7A9yhNLnmEpfIcemJzndH2giK5tt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6gqNQnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 425E6C4AF0E
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721595947;
	bh=yQkVJr7hR32nRi7bK8CMYIP+oobRmr0+t5v5SVaOL5w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l6gqNQnProiaM2BUmxEB44Y0n7jXhfpCs9A+nnZPu+vLoOM00eOErfTYRhfOW3CUg
	 iKAujz1BERQaSqO5uThgSimhiNi4LUVBStdCZV+fk9QJTllX82bI9YKUNAkllcY5hR
	 /gtb0WTA1mD/h+zNPoJJhSY+gWvd/1FkfRZKQiYrPRoIfzp5/xowduibPX1EcA6Jpm
	 xzhgBM3buurEyhQhtBfZgb59HNLW7xlZQQ1Tk8s0oDu7ZMUAawriXiGt5kia5YBGgJ
	 3Tu0FAJ/N+0XsKxOq4X80pV21j8r05P2PDHGk3yFgkVtTpDE3bQWGYw8jwSdnfRDQI
	 CbeKNaq6JVNpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 32A3FC53BBF; Sun, 21 Jul 2024 21:05:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Sun, 21 Jul 2024 21:05:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: priority cf_regression bug_severity
Message-ID: <bug-219072-13602-0Aom1GCe3r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Priority|P3                          |P1
         Regression|No                          |Yes
           Severity|normal                      |blocking

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
We now have two bug reports containing very similar if not exactly the same
backtraces.

Theodore, please take a look.

------------[ cut here ]------------
strnlen: detected buffer overflow: 17 byte read of buffer size 16
WARNING: CPU: 3 PID: 1622 at lib/string_helpers.c:1029
__fortify_report+0x43/0x50
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic kvm
ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi nf_reject_ipv6
crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio polyval_clmulni snd_hda_i=
ntel
ip6t_rt polyval_generic snd_intel_dspcfg gf128mul snd_usbmidi_lib
snd_intel_sdw_acpi ghash_clmulni_intel sha512_ssse3 snd_ump snd_hda_codec
sha256_ssse3 snd_rawmidi sha1_ssse3 btusb snd_hda_core snd_seq_device
aesni_intel btrtl mc snd_hwdep btintel crypto_simd btbcm snd_pcm cryptd r81=
69
btmtk realtek snd_timer mdio_devres rapl bluetooth snd wmi_bmof k10temp pcs=
pkr
ipt_REJECT ccp i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill
nf_log_syslog joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
 winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop nfnetlink zr=
am
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid
amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper drm_buddy nvme drm_display_helper nvme_core crc32c_intel
cec xhci_pci xhci_pci_renesas nvme_auth wmi
CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G           OE=20=20=20=20=
=20
6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK MAX
(MS-7C02), BIOS 3.I0 10/14/2023
RIP: 0010:__fortify_report+0x43/0x50
Code: c1 83 e7 01 48 c7 c1 82 1a 45 8f 48 c7 c7 e8 49 4b 8f 48 8b 34 c5 e0 =
55
ed 8e 48 c7 c0 3d f7 44 8f 48 0f 44 c8 e8 7d 4b a3 ff <0f> 0b c3 cc cc cc c=
c 66
0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffb4b09f7b3b68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __fortify_report+0x43/0x50
 ? __warn.cold+0x8e/0xe8
 ? __fortify_report+0x43/0x50
 ? report_bug+0xff/0x140
 ? console_unlock+0x84/0x130
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __fortify_report+0x43/0x50
 ? __fortify_report+0x43/0x50
 __fortify_panic+0xd/0xf
 __ext4_ioctl.cold+0x13/0x59 [ext4 2a94c00997ffaf4059189da5c3ba69455dc04edb]
 ? do_filp_open+0xc4/0x170
 ? __fdget_raw+0xa5/0xc0
 ? terminate_walk+0x61/0x100
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x82/0x190
 ? from_kgid_munged+0x12/0x30
 ? cp_statx+0x19f/0x1e0
 ? do_statx+0x72/0xa0
 ? syscall_exit_to_user_mode+0x72/0x200
 ? do_syscall_64+0x8e/0x190
 ? do_user_addr_fault+0x36c/0x620
 ? exc_page_fault+0x81/0x190
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x760ade31f13f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24
08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff f=
f 77
18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
 </TASK>
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1037!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G        W  OE=20=20=20=20=
=20
6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK MAX
(MS-7C02), BIOS 3.I0 10/14/2023
RIP: 0010:__fortify_panic+0xd/0xf
Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90 90 =
90
90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48 8b 54 24 1=
0 48
8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x27
 ? die+0x2e/0x50
 ? do_trap+0xca/0x110
 ? do_error_trap+0x6a/0x90
 ? __fortify_panic+0xd/0xf
 ? exc_invalid_op+0x50/0x70
 ? __fortify_panic+0xd/0xf
 ? asm_exc_invalid_op+0x1a/0x20
 ? __fortify_panic+0xd/0xf
 __ext4_ioctl.cold+0x13/0x59 [ext4 2a94c00997ffaf4059189da5c3ba69455dc04edb]
 ? do_filp_open+0xc4/0x170
 ? __fdget_raw+0xa5/0xc0
 ? terminate_walk+0x61/0x100
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x82/0x190
 ? from_kgid_munged+0x12/0x30
 ? cp_statx+0x19f/0x1e0
 ? do_statx+0x72/0xa0
 ? syscall_exit_to_user_mode+0x72/0x200
 ? do_syscall_64+0x8e/0x190
 ? do_user_addr_fault+0x36c/0x620
 ? exc_page_fault+0x81/0x190
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x760ade31f13f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24
08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff f=
f 77
18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
 </TASK>
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic kvm
ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi nf_reject_ipv6
crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio polyval_clmulni snd_hda_i=
ntel
ip6t_rt polyval_generic snd_intel_dspcfg gf128mul snd_usbmidi_lib
snd_intel_sdw_acpi ghash_clmulni_intel sha512_ssse3 snd_ump snd_hda_codec
sha256_ssse3 snd_rawmidi sha1_ssse3 btusb snd_hda_core snd_seq_device
aesni_intel btrtl mc snd_hwdep btintel crypto_simd btbcm snd_pcm cryptd r81=
69
btmtk realtek snd_timer mdio_devres rapl bluetooth snd wmi_bmof k10temp pcs=
pkr
ipt_REJECT ccp i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill
nf_log_syslog joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
 winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop nfnetlink zr=
am
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid
amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper drm_buddy nvme drm_display_helper nvme_core crc32c_intel
cec xhci_pci xhci_pci_renesas nvme_auth wmi
---[ end trace 0000000000000000 ]---
RIP: 0010:__fortify_panic+0xd/0xf
Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90 90 =
90
90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48 8b 54 24 1=
0 48
8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
PKRU: 55555554

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=


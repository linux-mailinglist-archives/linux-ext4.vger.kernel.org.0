Return-Path: <linux-ext4+bounces-3349-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A1938625
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 23:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF71C208E4
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398B16A920;
	Sun, 21 Jul 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="H98LFE7i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769A161321;
	Sun, 21 Jul 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721596270; cv=none; b=m/yY3nUu6keZCDAz8mBu28BVwdgpAm4fTmkdVUE3BF82VoJD9+Z8VeMxcQJJKfDqZxzlFC+z6VnOLehmnGG4OmtjOeSJWBYYakg2ago5u8c6K1beFQ15n2N9RTymCtynCczPA317rWt8DC3wWrytLCYcd5xUY36lu0cdFSiKmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721596270; c=relaxed/simple;
	bh=aOER0KavdduMrSh6sKKrzQF4xuuB9KflIoXEwakApc4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RqEovTjR9jRqE8bRrwsKuTIHMuCLhyKQC4ZBMetk2wGcW+MXNc3QBhEXlfAd9qSDTldT6xj4aOuJnlv+0y/zxsmTeDY81Erab+fYx6+56sToGZWog0Mj41Lxm5PE8YIGr2q/sVEPr3yQaGZ7+l/yiE6DQmGx8SIEghQhy2JvPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=H98LFE7i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721596261; x=1722201061; i=aros@gmx.com;
	bh=xNOyNgAjPPDbf5c6cgjYWAGnKCgXeLcbMtiYlXvkj5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H98LFE7iXPLfKBy4d9lLvT/7RmxziiwDTcy/JtO5LzbgRDY8MAaCL5zm/COAqC0f
	 DKn8dgFA0SdbI/xxc6X69at+q/u1SOhl2lMFFGzssTpY6QBztZzPmfViAob7P80Dz
	 MWasvfn/UIdmde/SZokmqs5mOud7ic3HH4Z8fDX1PDjckFZe/wLDVQzk2NfLy8AuP
	 9LwgFsXj2YB9OANz2C6xWo8yDZdRbA/YYIWGrBN1R55O4mBFKpXVW5QG3S3bb1xCS
	 I++Hpw8e5bSLLMJ9n3rA3/ipfoIulTKsQWVYdUjgf4yvZZVqsFg3ZT71astmddGok
	 i7P1+8axDKt2JWSA9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.110.76] ([194.110.13.8]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1sSKyn1XR6-00HEXP; Sun, 21
 Jul 2024 23:11:01 +0200
Message-ID: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>
Date: Sun, 21 Jul 2024 21:10:59 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Linux 6.10 regression resulting in a crash when using an ext4
 filesystem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yKOWLUBiagvL1PezUlr62IolUBXm2HQUsu7TsRumoYKLDl7GnCn
 Uc/v80jg97cJT2jm1AzVeFbCuDd8yBLre/2hNDupk+7zl/fLZLEWFfMLEeSXfSEe2vq7kin
 CNLEWboPyDeRV/+FhuzNGco3UEk7NGBXuP5BcrYGHJ7tJH3H58xtEhz5wLv/YexYSn8dl+2
 fRK+rWY8NjdFxf3bh9Jug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0YzS8RxRvac=;sxGlQlpWUWZQvcgsTNQwMgxV4YP
 47Pf6EYf1v/TUEe8XPVMeE4dt/ivt/mNQamiMuHeo6TEACUiCaL4qEeHr8WqyLUOYRwm5yDv8
 rD6XuGM0FD32/RiDVoUbY8gAuYc+f4HbY+8LaQ88PZJssesYzf2m+hiPeGxH7Qgo9mpkvokzs
 A+8LExqdMSU7d9bBTm7FYhvLVwx6bvnZKXZplBS6O3wsai5Bgp2f6up7CyRZR8Og1mgjmTKwq
 zJozwvzlIZkeA609skyEbqK4qZtWiUM3LKq4tG52CrT/ocG6nch2ChiO27NO1Z5umNepabg95
 ZvYB2eu1f0r8RwYuJtDXRpQgDrTTuQGSLszV1EAEvkZBXtVHJBvcdmzc2wsr+/btEWcJzfIP/
 YVE/k0Qhj3hijka1Ydl1RCK8eojY7qpTgOf1IoEN9kkEzJYFw6nEhJ/keeVQT74mubY9PxdbX
 TqN3coqQbPlPl5RXRC/h1wivVsnxMesCO46AsxZD+UI8D4JmUe+DCGHHENF/TQzRP94MT2v71
 Iimsq25DjVU7KNMGIdtHQEYy5o/vJ9wAbJr58L7zEkrv32xeBpbFDci/YE5Drh2CrTofubNss
 sBLtOpWIi+Jfy01ocLI5t9QN3vnnaZ4n796erMDIPR6XJEsddHc5nHRcozU62vHo13n+2kW/n
 xXmDre5VlK1EEK7iZMgteeZqCS7Fdg5v+xM/U7tO08iPjR5NX66wjCjShcytvT6Th22ZFB/lO
 i88jxAvXMdQiPZA8TarxonZcM2vVb8+RCHR9WMt1lpmevjV0TrLnxG+cLsMVFti/Iu1mSNNLW
 pLXbBaVAcGv36Fv63KYibcZ6NsZMTfNX5hfB3STtoQ3S0=

Hello,

There are now two bug reports containing very similar if not exactly the
same backtraces.

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072
https://bugzilla.kernel.org/show_bug.cgi?id=3D219078

Theodore, please take a look.

Might not be necesserily ext4 related but I cannot tell.

=2D-----------[ cut here ]------------
strnlen: detected buffer overflow: 17 byte read of buffer size 16
WARNING: CPU: 3 PID: 1622 at lib/string_helpers.c:1029
__fortify_report+0x43/0x50
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic
kvm ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi
nf_reject_ipv6 crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio
polyval_clmulni snd_hda_intel ip6t_rt polyval_generic snd_intel_dspcfg
gf128mul snd_usbmidi_lib snd_intel_sdw_acpi ghash_clmulni_intel
sha512_ssse3 snd_ump snd_hda_codec sha256_ssse3 snd_rawmidi sha1_ssse3
btusb snd_hda_core snd_seq_device aesni_intel btrtl mc snd_hwdep btintel
crypto_simd btbcm snd_pcm cryptd r8169 btmtk realtek snd_timer
mdio_devres rapl bluetooth snd wmi_bmof k10temp pcspkr ipt_REJECT ccp
i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill nf_log_syslog
joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
  winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop
nfnetlink zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
hid_generic usbhid amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm
drm_exec gpu_sched drm_suballoc_helper drm_buddy nvme drm_display_helper
nvme_core crc32c_intel cec xhci_pci xhci_pci_renesas nvme_auth wmi
CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G           OE
6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK
MAX (MS-7C02), BIOS 3.I0 10/14/2023
RIP: 0010:__fortify_report+0x43/0x50
Code: c1 83 e7 01 48 c7 c1 82 1a 45 8f 48 c7 c7 e8 49 4b 8f 48 8b 34 c5
e0 55 ed 8e 48 c7 c0 3d f7 44 8f 48 0f 44 c8 e8 7d 4b a3 ff <0f> 0b c3
cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffb4b09f7b3b68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:00000000000000=
00
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
  __ext4_ioctl.cold+0x13/0x59 [ext4
2a94c00997ffaf4059189da5c3ba69455dc04edb]
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
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89
44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d
00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
  </TASK>
=2D--[ end trace 0000000000000000 ]---
=2D-----------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1037!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G        W  OE
6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK
MAX (MS-7C02), BIOS 3.I0 10/14/2023
RIP: 0010:__fortify_panic+0xd/0xf
Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48
8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:00000000000000=
00
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
  __ext4_ioctl.cold+0x13/0x59 [ext4
2a94c00997ffaf4059189da5c3ba69455dc04edb]
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
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89
44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d
00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
  </TASK>
Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic
kvm ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi
nf_reject_ipv6 crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio
polyval_clmulni snd_hda_intel ip6t_rt polyval_generic snd_intel_dspcfg
gf128mul snd_usbmidi_lib snd_intel_sdw_acpi ghash_clmulni_intel
sha512_ssse3 snd_ump snd_hda_codec sha256_ssse3 snd_rawmidi sha1_ssse3
btusb snd_hda_core snd_seq_device aesni_intel btrtl mc snd_hwdep btintel
crypto_simd btbcm snd_pcm cryptd r8169 btmtk realtek snd_timer
mdio_devres rapl bluetooth snd wmi_bmof k10temp pcspkr ipt_REJECT ccp
i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill nf_log_syslog
joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
  winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop
nfnetlink zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
hid_generic usbhid amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm
drm_exec gpu_sched drm_suballoc_helper drm_buddy nvme drm_display_helper
nvme_core crc32c_intel cec xhci_pci xhci_pci_renesas nvme_auth wmi
=2D--[ end trace 0000000000000000 ]---
RIP: 0010:__fortify_panic+0xd/0xf
Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48
8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
PKRU: 55555554



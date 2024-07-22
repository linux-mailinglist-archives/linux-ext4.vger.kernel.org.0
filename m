Return-Path: <linux-ext4+bounces-3350-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA9938808
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 06:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE65F1F213DF
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 04:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFE16419;
	Mon, 22 Jul 2024 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHQbuFrt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782812B63;
	Mon, 22 Jul 2024 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621965; cv=none; b=VlxRGm6MaQNRT0ytwWVdSWUIHvbFJfJHnRqWmMbW43NYM+xDbsrs/R6PWIjv6+am35F0CyX5gLc+zkqCflm21yfVbQSeq9V+Mn4dxTQZd9Tj7RcBLqX+WxUoCWKk2z7sE9y6vG6OP8Bonf62y2+QFFxcW2O07Z80gk7s3wZg+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621965; c=relaxed/simple;
	bh=muonCMzrB0AixKWg4qxRoZ/sNzBc5ShBmZrCqfBeeWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWuLvagxl8UpwfqPk8HpFWBP/Jz0fPz6zZcFBcHbw5YDIw+fBZEF//rzYzs37htn9hoktLDCs5GuaZtn4aHJ2eBOeLzMzlUo0FGwfZOp/6YIz/btb8k0gpXLQdU4E+w0Sl0VunIMbf5UBReAXk1n5cU3wqmBhqXGmoUIjZZFju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHQbuFrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47556C116B1;
	Mon, 22 Jul 2024 04:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721621965;
	bh=muonCMzrB0AixKWg4qxRoZ/sNzBc5ShBmZrCqfBeeWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHQbuFrtHDOtfSo8OWSdzaH2KfMT2a4KDbFHNt1oZNtITrxGTBKzg4HL99QjZBDUP
	 3DZm8g9hsx8Y3RJ4f0WLgNR/12X+stk/AHEzebLPWILY26YkAogJBOYviqL+4XpYwT
	 F0ZUYOr17ixUhSPQHLJPj/Nes57mC6fNrpzquQZLQO5HTqWaHm5AfPaH8QAD7JrUJH
	 VwLcHhfvZThCJgQ2a4KNHkD45+laSoMSmyKDezo0lS4SpOMsgk0gAORTOw9JNzNi4C
	 tflseL8a5FJ7Jr74OODXzedKr+/aCi/dkz0G+I1l5QWjRvrPssCoUZ61x2P0HjI7FW
	 Ng0MJEgSBEwdA==
Date: Sun, 21 Jul 2024 21:19:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de,
	justinstitt@google.com, keescook@chromium.org,
	linux-hardening@vger.kernel.org
Subject: Re: Linux 6.10 regression resulting in a crash when using an ext4
 filesystem
Message-ID: <20240722041924.GB103010@frogsfrogsfrogs>
References: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>

On Sun, Jul 21, 2024 at 09:10:59PM +0000, Artem S. Tashkinov wrote:
> Hello,
> 
> There are now two bug reports containing very similar if not exactly the
> same backtraces.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219072
> https://bugzilla.kernel.org/show_bug.cgi?id=219078
> 
> Theodore, please take a look.

[adding everyone involved in 744a56389f739 ("ext4: replace deprecated
strncpy with alternatives") to cc]

Is strscpy_pad appropriate if the @src parameter itself is a fixed
length char[16] which isn't null terminated when the label itself is 16
chars long?

--D

> Might not be necesserily ext4 related but I cannot tell.
> 
> ------------[ cut here ]------------
> strnlen: detected buffer overflow: 17 byte read of buffer size 16
> WARNING: CPU: 3 PID: 1622 at lib/string_helpers.c:1029
> __fortify_report+0x43/0x50
> Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
> algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
> intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic
> kvm ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi
> nf_reject_ipv6 crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio
> polyval_clmulni snd_hda_intel ip6t_rt polyval_generic snd_intel_dspcfg
> gf128mul snd_usbmidi_lib snd_intel_sdw_acpi ghash_clmulni_intel
> sha512_ssse3 snd_ump snd_hda_codec sha256_ssse3 snd_rawmidi sha1_ssse3
> btusb snd_hda_core snd_seq_device aesni_intel btrtl mc snd_hwdep btintel
> crypto_simd btbcm snd_pcm cryptd r8169 btmtk realtek snd_timer
> mdio_devres rapl bluetooth snd wmi_bmof k10temp pcspkr ipt_REJECT ccp
> i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill nf_log_syslog
> joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
> lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
>  winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop
> nfnetlink zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
> hid_generic usbhid amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm
> drm_exec gpu_sched drm_suballoc_helper drm_buddy nvme drm_display_helper
> nvme_core crc32c_intel cec xhci_pci xhci_pci_renesas nvme_auth wmi
> CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G           OE
> 6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
> Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK
> MAX (MS-7C02), BIOS 3.I0 10/14/2023
> RIP: 0010:__fortify_report+0x43/0x50
> Code: c1 83 e7 01 48 c7 c1 82 1a 45 8f 48 c7 c7 e8 49 4b 8f 48 8b 34 c5
> e0 55 ed 8e 48 c7 c0 3d f7 44 8f 48 0f 44 c8 e8 7d 4b a3 ff <0f> 0b c3
> cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffb4b09f7b3b68 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
> RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
> RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
> R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
> R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
> FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __fortify_report+0x43/0x50
>  ? __warn.cold+0x8e/0xe8
>  ? __fortify_report+0x43/0x50
>  ? report_bug+0xff/0x140
>  ? console_unlock+0x84/0x130
>  ? handle_bug+0x3c/0x80
>  ? exc_invalid_op+0x17/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __fortify_report+0x43/0x50
>  ? __fortify_report+0x43/0x50
>  __fortify_panic+0xd/0xf
>  __ext4_ioctl.cold+0x13/0x59 [ext4
> 2a94c00997ffaf4059189da5c3ba69455dc04edb]
>  ? do_filp_open+0xc4/0x170
>  ? __fdget_raw+0xa5/0xc0
>  ? terminate_walk+0x61/0x100
>  __x64_sys_ioctl+0x94/0xd0
>  do_syscall_64+0x82/0x190
>  ? from_kgid_munged+0x12/0x30
>  ? cp_statx+0x19f/0x1e0
>  ? do_statx+0x72/0xa0
>  ? syscall_exit_to_user_mode+0x72/0x200
>  ? do_syscall_64+0x8e/0x190
>  ? do_user_addr_fault+0x36c/0x620
>  ? exc_page_fault+0x81/0x190
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x760ade31f13f
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89
> 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d
> 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
> RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
> RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
> R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
> R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> kernel BUG at lib/string_helpers.c:1037!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 1622 Comm: KIO::WorkerThre Tainted: G        W  OE
> 6.10.0-arch1-1 #1 3f70a25b32dbfb369f64430c352117d965bafd6c
> Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK
> MAX (MS-7C02), BIOS 3.I0 10/14/2023
> RIP: 0010:__fortify_panic+0xd/0xf
> Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48
> 8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
> RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
> RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
> RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
> R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
> R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
> FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die_body.cold+0x19/0x27
>  ? die+0x2e/0x50
>  ? do_trap+0xca/0x110
>  ? do_error_trap+0x6a/0x90
>  ? __fortify_panic+0xd/0xf
>  ? exc_invalid_op+0x50/0x70
>  ? __fortify_panic+0xd/0xf
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __fortify_panic+0xd/0xf
>  __ext4_ioctl.cold+0x13/0x59 [ext4
> 2a94c00997ffaf4059189da5c3ba69455dc04edb]
>  ? do_filp_open+0xc4/0x170
>  ? __fdget_raw+0xa5/0xc0
>  ? terminate_walk+0x61/0x100
>  __x64_sys_ioctl+0x94/0xd0
>  do_syscall_64+0x82/0x190
>  ? from_kgid_munged+0x12/0x30
>  ? cp_statx+0x19f/0x1e0
>  ? do_statx+0x72/0xa0
>  ? syscall_exit_to_user_mode+0x72/0x200
>  ? do_syscall_64+0x8e/0x190
>  ? do_user_addr_fault+0x36c/0x620
>  ? exc_page_fault+0x81/0x190
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x760ade31f13f
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89
> 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d
> 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:0000760a5dfff310 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000760a5dfff560 RCX: 0000760ade31f13f
> RDX: 0000760a5dfff390 RSI: 0000000081009431 RDI: 000000000000003e
> RBP: 0000760a5dfff4b0 R08: 0000760a5dfff580 R09: 00007609e0007ae0
> R10: 0000000000001000 R11: 0000000000000246 R12: 0000760a5dfff390
> R13: 00007609e00135e0 R14: 0000760a5dfff540 R15: 0000000000010308
>  </TASK>
> Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq uhid cmac
> algif_hash algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr
> intel_rapl_common kvm_amd snd_hda_codec_realtek snd_hda_codec_generic
> kvm ip6t_REJECT snd_hda_scodec_component snd_hda_codec_hdmi
> nf_reject_ipv6 crct10dif_pclmul crc32_pclmul xt_hl snd_usb_audio
> polyval_clmulni snd_hda_intel ip6t_rt polyval_generic snd_intel_dspcfg
> gf128mul snd_usbmidi_lib snd_intel_sdw_acpi ghash_clmulni_intel
> sha512_ssse3 snd_ump snd_hda_codec sha256_ssse3 snd_rawmidi sha1_ssse3
> btusb snd_hda_core snd_seq_device aesni_intel btrtl mc snd_hwdep btintel
> crypto_simd btbcm snd_pcm cryptd r8169 btmtk realtek snd_timer
> mdio_devres rapl bluetooth snd wmi_bmof k10temp pcspkr ipt_REJECT ccp
> i2c_piix4 libphy soundcore nf_reject_ipv4 xt_LOG rfkill nf_log_syslog
> joydev mousedev nft_limit gpio_amdpt gpio_generic mac_hid lz4
> lz4_compress xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c tcp_bbr
>  winesync(OE) pkcs8_key_parser i2c_dev crypto_user dm_mod loop
> nfnetlink zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
> hid_generic usbhid amdgpu video amdxcp i2c_algo_bit drm_ttm_helper ttm
> drm_exec gpu_sched drm_suballoc_helper drm_buddy nvme drm_display_helper
> nvme_core crc32c_intel cec xhci_pci xhci_pci_renesas nvme_auth wmi
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__fortify_panic+0xd/0xf
> Code: ff e8 87 03 00 00 e9 08 b8 89 ff 66 90 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 b3 e2 89 ff <0f> 0b 48
> 8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 99 27 42 8f
> RSP: 0018:ffffb4b09f7b3b70 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff991a934c6000 RCX: 0000000000000027
> RDX: ffff99219eba19c8 RSI: 0000000000000001 RDI: ffff99219eba19c0
> RBP: ffffb4b09f7b3c38 R08: 0000000000000000 R09: ffffb4b09f7b39e8
> R10: ffffffff8fcb21e8 R11: 0000000000000003 R12: 0000760a5dfff390
> R13: ffff991a8a724af8 R14: ffff991aa4a3d478 R15: ffffffff8fd2a5a0
> FS:  0000760a5e0006c0(0000) GS:ffff99219eb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007609e0013810 CR3: 000000012cb70000 CR4: 0000000000f50ef0
> PKRU: 55555554
> 
> 


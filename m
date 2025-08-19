Return-Path: <linux-ext4+bounces-9398-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D3B2CF70
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920E7625C4A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC1225A5B;
	Tue, 19 Aug 2025 22:38:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8335334A;
	Tue, 19 Aug 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643107; cv=none; b=eQJcW/LXmaokBv3VlY+PD1TYhli/6CfsnzPb+bWR63ivlYNLzAUuY+2emgAQHh3HK0Qty6APM2xRBSmPUzhPsWaUH6wXB184NdZrK8quUCMxz1sYZtLNetWR/sKB6qQRTt6nlyVvwmSTHQ4vBMAG6/yroReJR+PgqvoagqpDOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643107; c=relaxed/simple;
	bh=+kkh3eYgbY5UnO3LKRHwP6Z/T6fPAMN+QWdEvbhWqNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US/b1dYiF5IrpiiWcmmYdD8eu+hVvfX5WcCdk4PYM87+1PpYlt9PYPCtukkdHv9PWxX3hu7YLTP27vQ2Du+TtUZguYDogqEYH4uWaN2Lxpsq+Hqr2brshp5w6JF0sGh+b/jONe4kMTUKB6DjqU0FumJ9EpEuFjkBczYQ2RINOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e94ee2f1fe2so827668276.1;
        Tue, 19 Aug 2025 15:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755643104; x=1756247904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XHF4UeHmi11VhvbU3Wg/v0UFOjsp660xlXcr5v+DGM=;
        b=aZYV08jQQGnuPHcPtUdKeCPAk0te6C1AbZOmg1zR7PIHpciiBKBqVq4NrD9UkQWw/K
         kVIKoIwWcvN//gwzOecdOKqN89owmB0u5JNYxO6x0GFHwfdwxwptVSwEhG+4UYl6LB/6
         Kj/4cVK6Zg82y4lICAbCpz/kAcr34RXzhwjj+fxV7oTB84cf9onvFSDwKDBBlm3HJmbr
         gMjNmx5qcmWpyRrTMuxqkyZXQMNbZv05FyQQ4nJ+W2Z3CFxzASK/8j4gtPvWgl781BGW
         Hv4pIPiNRy4Bzlxdj4HZuKshKzXbsx5ejKWYAlHeQqKWvEkBRcBHAuwsykC3MZc5wUxt
         HNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUwksaGr5yGn1cT84Ju3mnAuy6ZHjc8zfqi4FyZey/ov4u1CCM/q1m72m9vSlS5pQDwFjVG1cacn+XA@vger.kernel.org, AJvYcCV1plmB+uXrIL6Px+Z+LgrZ66uJNd2boej2VBpqQvOdwNZZFkzhOAe3cVrAOGhA2VkxBbl4gn2dogz9RFvz@vger.kernel.org, AJvYcCX/PMfg06GajBMrmnExmzmfBq5YkegYMp4hTYjQqWAOz112vJeGszClt4Ys9oCzZZ4B/TvRWJiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8jlrksnI/A4BIfxyFTHSoyPlfI7HlW8pzT0IbYDANDKsqlUO
	PdwaTSNOQU8Fgqz3S7esJbXAQpTJHcRo1HNYhAMWgiu1b/0AYp9ZfMfLQYvQQKUS
X-Gm-Gg: ASbGncubXog0RuopU19vN3dIm+Onqxk8iDSxAabBngdoqspb32bxlP3BFuU79EXG+Ya
	PutiNDsCyOt9oOXjZGeSCOvTXjKjHAHI7PJTkXTiou/ilAQsgxnohh+vhCiBG8wl4epy26ek6e3
	ftQrFddkafOEQM4H8vXgnNsir/ClJZDBHX220uQLjbaTHX22yznCfS6rh7pPvLqkQW0LcXgZIgH
	0WLT3/ljBbA7UlkLllqQChnnZ1yV0AR+Pk/df4pbi1PfIgk11MTkg0zBdD/AlS3bWDssjRqD2QZ
	3H6WUYtGWWuaydcesQnG+YpHCwmUcKUb9KynR+5ht9np3LuuXO3+26LKDZH4b4/EbvV0hXb0kf/
	PFoZVmjAfEHnsWh1nIgcycbeqrOavheF2okZEcY13+aCeRlur57mfbitwTpZYbbugJohiTw==
X-Google-Smtp-Source: AGHT+IHLRJIyMzxUgIXIc6OQo3uoMXWwKSoz1zB4Wxd3gi1hK1vk5HrunsBLxY40CxSc8UidoNazSQ==
X-Received: by 2002:a05:690c:b1e:b0:71f:9805:af8e with SMTP id 00721157ae682-71fb30fe739mr11233457b3.13.1755643104281;
        Tue, 19 Aug 2025 15:38:24 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6de98f4esm32676697b3.9.2025.08.19.15.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 15:38:23 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e94ee2f1fe2so827647276.1;
        Tue, 19 Aug 2025 15:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhnE4vpLqVuQX25CXprVDEcnDF0YZft3hCJQ0k+0cmYmFVJpkIUJaSsezNXtLbCYXQqrWDfNPr++Dg@vger.kernel.org, AJvYcCVuglP62m7HctpDwuKrnAJCrfp/cLGgM3Rab3pGy4UpV+Y2JTymv6jcP+8x96tTE7YBxvk00LhS@vger.kernel.org, AJvYcCWY4gVP2LxHiDO4t8BePglePWvUMe4KGqqGjUjLiL4gVPFjQyS2+fXrSLJrPYLx4RQPj3AHl2f170Jqrjoo@vger.kernel.org
X-Received: by 2002:a05:6902:4183:b0:e93:2a04:5ca8 with SMTP id
 3f1490d57ef6-e94f659e4camr982642276.20.1755643102696; Tue, 19 Aug 2025
 15:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d7f77d2-b1f8-4d49-b36a-927a943efc2f@heusel.eu>
In-Reply-To: <3d7f77d2-b1f8-4d49-b36a-927a943efc2f@heusel.eu>
From: Luca Boccassi <bluca@debian.org>
Date: Tue, 19 Aug 2025 23:38:11 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRtmhi8aaO+xsT=kgXYhB8u3sgBdtevrxDWctTLteWYoA@mail.gmail.com>
X-Gm-Features: Ac12FXxJcrP4RNQVP9ojUhzeV6UKisJc8960k_IZzRXNwRTNujVL_1Qj0nmzju4
Message-ID: <CAMw=ZnRtmhi8aaO+xsT=kgXYhB8u3sgBdtevrxDWctTLteWYoA@mail.gmail.com>
Subject: Re: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
To: Christian Heusel <christian@heusel.eu>
Cc: Zhang Yi <yi.zhang@huawei.com>, Sasha Levin <sashal@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, heftig@archlinux.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 21:53, Christian Heusel <christian@heusel.eu> wrote:
>
> Hello everyone,
>
> the systemd CI has [recently noticed][0] an issue within the ext4 file
> system after the Arch Linux kernel was upgraded to 6.16.1. The issue is
> exclusive to the stable tree and does not occur on 6.16 and not on
> 6.17-rc2. I have also tested 6.16.2-rc1 and it still contains the bug.
>
> I was able to bisect the issue between 6.16 and 6.16.1 to the following
> commit:
>
>     b9c561f3f29c2 ("ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()")
>
> The issue can be reproduced by running the tests from
> [TEST-58-REPART.sh][1] by running the [systemd integration tests][2].
> But if there are any suggestions I can also test myself as the initial
> setup for the integration tests is a bit involved.
>
> It is not yet clear to me whether this has real-world impact besides the
> test, but the systemd devs said that it's not a particularily demanding
> workflow, so I guess it is expected to work and could cause issues on
> other systems too.
>
> Also does anybody have an idea which backport could be missing?
>
> Cheers,
> Chris
>
> [0]: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233
> [1]: https://github.com/systemd/systemd/blob/main/test/units/TEST-58-REPART.sh
> [2]: https://github.com/systemd/systemd/blob/main/test/integration-tests/README.md
>
> ---
>
> #regzbot introduced: b9c561f3f29c2
> #regzbot title: [STABLE] ext4: too many credits wanted / file system issue in v6.16.1
> #regzbot link: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233
>
> ---
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
> git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
> # status: waiting for bad commit, 1 good commit known
> # bad: [3e0969c9a8c57ff3c6139c084673ebedfc1cf14f] Linux 6.16.1
> git bisect bad 3e0969c9a8c57ff3c6139c084673ebedfc1cf14f
> # good: [288f1562e3f6af6d9b461eba49e75c84afa1b92c] media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check
> git bisect good 288f1562e3f6af6d9b461eba49e75c84afa1b92c
> # bad: [f427460a1586c2e0865f9326b71ed6e5a0f404f2] f2fs: turn off one_time when forcibly set to foreground GC
> git bisect bad f427460a1586c2e0865f9326b71ed6e5a0f404f2
> # bad: [5f57327f41a5bbb85ea382bc389126dd7b8f2d7b] scsi: elx: efct: Fix dma_unmap_sg() nents value
> git bisect bad 5f57327f41a5bbb85ea382bc389126dd7b8f2d7b
> # good: [9143c604415328d5dcd4d37b8adab8417afcdd21] leds: pca955x: Avoid potential overflow when filling default_label (take 2)
> git bisect good 9143c604415328d5dcd4d37b8adab8417afcdd21
> # good: [9c4f20b7ac700e4b4377f85e36165a4f6ca85995] RDMA/hns: Fix accessing uninitialized resources
> git bisect good 9c4f20b7ac700e4b4377f85e36165a4f6ca85995
> # good: [0b21d1962bec2e660c22c4c4231430f97163dcf8] perf tests bp_account: Fix leaked file descriptor
> git bisect good 0b21d1962bec2e660c22c4c4231430f97163dcf8
> # good: [3dbe96d5481acd40d6090f174d2be8433d88716d] clk: thead: th1520-ap: Correctly refer the parent of osc_12m
> git bisect good 3dbe96d5481acd40d6090f174d2be8433d88716d
> # bad: [c6714f30ef88096a8da9fcafb6034dc4e9aa467d] clk: sunxi-ng: v3s: Fix de clock definition
> git bisect bad c6714f30ef88096a8da9fcafb6034dc4e9aa467d
> # bad: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
> git bisect bad b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8
> # first bad commit: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()

The full kernel warning (immediately after the ext4 fs stops working):

[ 156.796652] JBD2: (sd-copy) wants too many credits credits:554
rsv_credits:0 max:338
[ 156.802468] ------------[ cut here ]------------
[ 156.802929] WARNING: CPU: 1 PID: 2904 at fs/jbd2/transaction.c:334
start_this_handle.cold+0x21/0x2e
[ 156.803222] Modules linked in: dm_crypt encrypted_keys trusted
asn1_encoder tee joydev mousedev iTCO_wdt intel_pmc_bxt
iTCO_vendor_support kvm_amd i2c_i801 psmouse pcspkr vfat fat intel_agp
mac_hid serio_raw lpc_ich intel_rapl_msr cfg80211 rfkill tun nfnetlink
ip_tables intel_rapl_common ccp kvm irqbypass polyval_clmulni
ghash_clmulni_intel sha512_ssse3 sha1_ssse3 aesni_intel virtio_balloon
virtio_scsi i2c_smbus i2c_mux intel_gtt loop dm_mod qemu_fw_cfg
vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock
virtio_rng x_tables
[ 156.804702] CPU: 1 UID: 0 PID: 2904 Comm: (sd-copy) Not tainted
6.16.1-arch1-1 #1 PREEMPT(full)
83823f140bb4fc8c507f38d1610ad9b642cd4b9a
[ 156.805292] H[ 156.792161] TEST-70-TPM2.sh[2894]: Successfully
forked off '(sd-copy)' as PID 2904.ardware name: QEMU Standard PC (Q35
+ ICH9, 2009), BIOS unknown 02/02/2022
[ 156.806972] RIP: 0010:start_this_handle.cold+0x21/0x2e
[ 156.807210] Code: 4c 8b 14 24 e9 46 d7 64 00 65 48 8b 05 63 40 0d 03
44 89 f1 44 89 fa 48 c7 c7 30 84 3e a2 48 8d b0 f0 0c 00 00 e8 32 8b
fe ff <0f> 0b 41 b9 e4 ff ff ff e9 dc d9 64 00 49 8b 54 24 18 49 8b 74
24
[ 156.807896] RSP: 0018:ffffd110c351f990 EFLAGS: 00010246
[ 156.808182] RAX: 0000000000000048 RBX: ffff8a8ed19b3000 RCX: 0000000000000000
[ 156.808367] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8a8f3bd1cfc0
[ 156.808483] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fffff35f
[ 156.808591] R10: ffffffffa2e60de0 R11: ffffd110c351f830 R12: ffff8a8ec0775508
[ 156.808761] R13: 0000000000000005 R14: 0000000000000000 R15: 000000000000022a
[ 156.808977] FS: 00007fa54aec3440(0000) GS:ffff8a8f9821b000(0000)
knlGS:0000000000000000
[ 156.810623] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 156.811062] CR2: 00005624ae24ce30 CR3: 00000001071d4002 CR4: 0000000000370ef0
[ 156.811288] Call Trace:
[ 156.811402] <TASK>
[ 156.811460] ? kmem_cache_alloc_noprof+0x12d/0x410
[ 156.811989] ? jbd2__journal_start+0x82/0x210
[ 156.812501] jbd2__journal_start+0xfc/0x210
[ 156.812507] ext4_truncate+0x168/0x440
[ 156.812512] ? unmap_mapping_range+0x80/0x130
[ 156.812517] ext4_setattr+0x706/0xa90
[ 156.812521] notify_change+0x340/0x4e0
[ 156.812526] ? do_truncate+0xc2/0xf0
[ 156.812529] do_truncate+0xc2/0xf0
[ 156.812533] [ 156.803411] TEST-70-TPM2.sh[2904]: Mounting
/dev/mapper/luks-repart-2d18cd9c567b253b (ext4) on
/run/systemd/mount-root (MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_NOATIME
"")...do_ftruncate+0x12d/0x1f0
[ 156.812536]
do_sys_ftruncate+0x40/0x80
[ 156.812539] __x64_sys_ftruncate+0x1a/0x30
[ 156.812541] do_syscall_64+0x81/0x970
[ 156.812546] ? shmem_file_llseek+0x6b/0xc0
[ 156.812551] ? syscall_exit_work+0x143/0x1b0
[ 156.812555] ? do_syscall_64+0x22f/0x970
[ 156.812557] ? syscall_exit_work+0x143/0x1b0
[ 156.812559] ? do_syscall_64+0x22f/0x970
[ 156.812563] ? syscall_exit_work+0x143/0x1b0
[ 156.812566] ? do_syscall_64+0x22f/0x970
[ 156.812568] ? shmem_file_llseek+0x6b/0xc0
[ 156.812571] ? syscall_exit_work+0x143/0x1b0
[ 156.812573] ? do_syscall_64+0x22f/0x970
[ 156.812575] ? do_syscall_64+0x22f/0x970
[ 156.812578] ? syscall_exit_work+0x143/0x1b0
[ 156.812580] ? do_syscall_64+0x22f/0x970
[ 156.812582] ? exc_page_fault+0x7e/0x1a0
[ 156.812585] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 156.812588] RIP: 0033:0x7fa54a110ceb
[ 156.812595] Code: d2 31 f6 48 89 e5 48 83 ec 08 6a 4a e8 0e 25 f8 ff
c9 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa b8 4d 00 00 00
0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 f1 7f 0f 00 f7
d8
[ 156.812597] RSP: 002b:00007ffd70e12d48 EFLAGS: 00000206 ORIG_RAX:
000000000000004d
[ 156.812599] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007fa54a110ceb
[ 156.812601] RDX: 0000000000000001 RSI: 0000000000000048 RDI: 0000000000000012
[ 156.812602] RBP: 00007ffd70e12e00 R08: 0000000000000000 R09: 00007fa54aec32d0
[ 156.812603] R10: 0000000000000008 R11: 0000000000000206 R12: 0000000000000013
[ 156.812604] R13: 7fffffffffffffb7 R14: 0000000000000048 R15: 0000000000010000
[ 156.812609] </TASK>
[ 156.819965] ---[ end trace 0000000000000000 ]---
[ 156.819988] EXT4-fs error (device dm-0) in ext4_setattr:5987: error 28


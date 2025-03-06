Return-Path: <linux-ext4+bounces-6677-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC8A5410A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C39B3A8910
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE2192D77;
	Thu,  6 Mar 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esxJ6yO+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3318DB3C;
	Thu,  6 Mar 2025 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230520; cv=none; b=OW0Lb0su28OHrs2iCaNkQLdF27qRtJBbsrCsA4+v67f1xnNf8S0YJOyd9gSW0RlWTtwwyvgijq+KHuCVcVn0EKAECDkYuiZAaVrL433iHogKhJ93xNaB2cR6ew7fxi8GL5afJeMzvxQOJT3nMNDrCRq2SpNorsxHoNhDzUi2Apg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230520; c=relaxed/simple;
	bh=bBe+RM1k95uuNOzM+TDkwClBV5lMfOy4r22+SuIYfOU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=laiY+hqjwFllNze19QwGgFvSNZYZhe2zg0umG2qNXqHM2AbrISmc6yDP5jCiRCY7TH4T6KvFPraVeYhwKo35cO3eLEXQ/aFiyZQ0lRBvRzBzwVp97waBkmnf3lYFSsi9Van1FchX64hOC0IL9Z4tvou51v0eO1Uqxbazq+OHaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esxJ6yO+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8ec399427so1618816d6.2;
        Wed, 05 Mar 2025 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230517; x=1741835317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBe+RM1k95uuNOzM+TDkwClBV5lMfOy4r22+SuIYfOU=;
        b=esxJ6yO+QRXu9AIvCjlZQ0mQa3TKAYW8RKvyIBC2RQnGu6hfGdRCgZ6BKecDo9qoQb
         W2+Wr5Yfn3Ejg0Rh95DLkalC6I4pJnEpjau4+A3NWZePH0T4SOOdrcfJ/qI9515pdGmD
         78U8j4ZohZR0MCwv9T9kpPlMTOIA7VtWTKw8SFpYA0yoTRaIs3GpzTgQd6oBmLwFcDFc
         DDUuKSx4gUZX5NM8chrkWlyrPuiWt1lFK2hf+30B3X9lU7JG8jJ7MSz9DEKuoatBFR9V
         mt9UXGX2qHGbT/2fC3mljI9TKsDjmg3EWTIY+R2ZuTPo+awBiLNXSk07cWRWUu2xMqP3
         GtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230517; x=1741835317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBe+RM1k95uuNOzM+TDkwClBV5lMfOy4r22+SuIYfOU=;
        b=lEBO3QwodoKCyIG/2oDkHn9PZIg/7O1iiS/OQQFcTVfKo4+GQG4KRJb+uvsa/kAe2h
         DEjKC4/Qoyajyod2Fe1lIb48BMprzH9p1duD1IGkVrkY0G8/zYVmDaFFkCULEGJKr3JP
         +VH+7lxMS8Fq5j1n6HpXexnevihBylYoOgtq9/6/KSW1OlXoWpYdcL7+SW5apAEgYdNa
         mGWGpZj6+XXGW8/JakLRvD+nT3NgEQyR/HeIkCkcoDIKoFiAyxs5YsI0+svOd37TqIZ7
         2p71biaU25t5v+bmqKtanpF2q80tOVWYmV/es3xdIXjOr+1PGck69qTgLUDgWHakNbgs
         WeTg==
X-Forwarded-Encrypted: i=1; AJvYcCX85cyqUrLKQDi5pzucZyb0A8DDsAEe2kYi3Yn1ZE03jApWkDJpnFzBDo8QNzqL71JLhZeXK4HLUWvqpiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgBYd4P2ZpI5aRxS9fFQHlvzYZx1rnUhqiBnTXm4/bh3xwZa7
	aTfWIG93Pa5E1hf+Gb7nSgjV2QzhcAS6qa6U8+2sya6x9EzFrcdOfXIOK6AR5H96DqtFEdQA5Wl
	WnukDD4aBIwXrMe+7tdwX750fZow=
X-Gm-Gg: ASbGncsmCLXWNsX+3ViiZvZ60wa/a4c4qAsewqAE2hkTJump+1/AHNwOIPscX9Q1x3z
	4tvDNJP74ZDW1YKDY6Sya19d5FwvWwUoDGych5MzL29aDBJdXqUd5AC4C/aemoESyGQF/DOC94p
	Xu6Hz+WUufIjSx4vyTWsipvyLAH+g=
X-Google-Smtp-Source: AGHT+IFLk1IMmcOgJtopx0qs+LokEPNxhFxMc6XGDAtFjIwiBAdNnGv+C57GeBSnczPcgxkD6BrILp9qCbFPlaUvUgc=
X-Received: by 2002:a05:6214:451a:b0:6e8:f2bf:7262 with SMTP id
 6a1803df08f44-6e8f2bf7543mr35958856d6.41.1741230517375; Wed, 05 Mar 2025
 19:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 11:08:26 +0800
X-Gm-Features: AQ5f1Jq57WdMBU9iMXZJ145aUnx3mItMDkvH4DL5N-4kVjg8N30H9KQNgnFdOgc
Message-ID: <CALm_T+3Tup+nmgA_CEw1RGGq=Ur-R0HyVdLX5xFzhF7nnK8g1g@mail.gmail.com>
Subject: Potential Linux Crash: KASAN slab-out-of-bounds Read in
 ext4_find_extent in Linux kernel v6.13-rc5
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Experts,

Hello!

I am a security researcher focused on testing Linux kernel
vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
we encountered a crash related to the fs/ext4 kernel module. We have
successfully captured the call trace information for this crash.

Unfortunately, we have not been able to reproduce the issue in our
local environment, so we are unable to provide a PoC (Proof of
Concept) at this time.

We fully understand the complexity and importance of Linux kernel
maintenance, and we would like to share this finding with you for
further analysis and confirmation of the root cause. Below is a
summary of the relevant information:

Kernel Version: v6.13-rc5

Kernel Module: fs/ext4/extents.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

BUG: KASAN: slab-out-of-bounds in ext4_ext_binsearch
fs/ext4/extents.c:840 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0x9b8/0xa00
fs/ext4/extents.c:955
Read of size 4 at addr ffff888107037aa0 by task kworker/u16:3/50
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: writeback wb_workfn (flush-7:6)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xce/0x660 mm/kasan/report.c:489
 kasan_report+0xc6/0x100 mm/kasan/report.c:602
 ext4_ext_binsearch fs/ext4/extents.c:840 [inline]
 ext4_find_extent+0x9b8/0xa00 fs/ext4/extents.c:955
 ext4_ext_map_blocks+0x1bc/0x4e70 fs/ext4/extents.c:4205
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x3c8/0x11c0 fs/ext4/inode.c:702
 mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
 ext4_do_writepages+0x15b1/0x3040 fs/ext4/inode.c:2735
 ext4_writepages+0x275/0x510 fs/ext4/inode.c:2824
 do_writepages+0x197/0x7b0 mm/page-writeback.c:2702
 __writeback_single_inode+0xe5/0x950 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x593/0xd00 fs/fs-writeback.c:1976
 wb_writeback+0x188/0x790 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x1d2/0xa50 fs/fs-writeback.c:2343
 process_one_work+0x61a/0x1050 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x8cc/0x1160 kernel/workqueue.c:3391
 kthread+0x25a/0x330 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5054:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0xf5/0x360 mm/slub.c:4175
 getname_flags.part.0+0x48/0x4e0 fs/namei.c:139
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x84/0xd0 fs/namei.c:223
 getname_maybe_null include/linux/fs.h:2796 [inline]
 vfs_fstatat fs/stat.c:361 [inline]
 vfs_stat include/linux/fs.h:3392 [inline]
 __do_sys_newstat+0x93/0x130 fs/stat.c:503
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5054:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0xec/0x380 mm/slub.c:4715
 putname+0x111/0x150 fs/namei.c:296
 vfs_fstatat fs/stat.c:367 [inline]
 vfs_stat include/linux/fs.h:3392 [inline]
 __do_sys_newstat+0xbc/0x130 fs/stat.c:503
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f



=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

If you need more details or additional test results, please feel free
to let us know. Thank you so much for your attention! Please don't
hesitate to reach out if you have any suggestions or need further
communication.

Best regards,
Luka


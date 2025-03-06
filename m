Return-Path: <linux-ext4+bounces-6676-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD0A540F1
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 04:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B51B1892EFA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 03:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5F18CC1C;
	Thu,  6 Mar 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW8/h/eM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E4199230;
	Thu,  6 Mar 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230007; cv=none; b=dyaNfM3+r8sUg0sAJ39r6ybVpq3yNUy0NsLoWlLazG2PWqR0PBekTSGSwPQcUdz8YVgqn/CZe+XD2sCMBOjtrn0yHvC1Z1CiowUew8lxUT1s86+1j+JZ9QrR2qy/7ZCZ/Y1CcTuJL2ZvdNuclF2t4VguD0f48GRHNqxX2XWThUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230007; c=relaxed/simple;
	bh=pphNzZjoskzWzkOM/yq4hlV4xR2iKnYzcrrbGIr4huY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X8vGOTF/ye8Q5Zt1dy8BKAbNMTqat6iCdZZF6J5nIR6PpyLh9UKUQHsz2QWbKVX5SotFscC+3cBFgs68b7nJpZMJX0c3K8bTkPTW4WGm08O2UunLdK8ZqsFmTOcyQU6tJmS61WtK5JM4y6lR8dqDhaoy6tzdMaWCmxatQG/4SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW8/h/eM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6df83fd01cbso923556d6.2;
        Wed, 05 Mar 2025 19:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230004; x=1741834804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pphNzZjoskzWzkOM/yq4hlV4xR2iKnYzcrrbGIr4huY=;
        b=jW8/h/eMdJp9ulSmcc7Fd3hiyKYpA0if7m6IvZhZYrEzXN8wxNqo+uPOsyctGyuI+e
         r3L6KsvUIOD2ywfx3t2s3GYCwDYmeTCzJofWTF+2SfGb+UfVaWlnv1MSG4eQNJBahLQ3
         3K0IH/A9zWLZZnI6IyJK3iyo3b98GcbHKTRHx6BX5ftzqSV9aWnq1AVBUyWPuN1sQAuE
         D60ApsJpOFrreGaNws3mVKvsGhGwtonBpSAgfCHP0mZ/MjXthwBkBasHxprHmEl3BdNb
         JPeAHv5O135Bf2iPZ78Em2ziogzxbp2+NXPrFkgQftskXjwBpCCJ+dgJSde+mXWlALmO
         AFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230004; x=1741834804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pphNzZjoskzWzkOM/yq4hlV4xR2iKnYzcrrbGIr4huY=;
        b=EOC957QHDzQh/sq1kGNJwhPe2qKyBgwMK3snzMTq+5yRaCs3vtoloFCcFrNgYn819o
         hn7DYGMwjtfxwnImwF0je3nvHcJaX5O5Q6ZWwa+Vl30oBUJN4KdjB9JBeugpggYsoy9E
         pDK9O7jcRyBgEElVaZgOAkiwC51WHP5D3nlPtaWFaHdUeAT+QNAcOJNYk7BKJ+1oS997
         d+PLo2Ecl+YmwwYvgvUNJS0hT0mznRjdG1KIk5W96fyusdiDncvlAsLG315hh67PK6uY
         qgd4+IxKl3fmZdycDRyLjmjJkiTDW2n+JXNQC6sR+3UnyTvgQj5IiY7xLsC4Z58H6UoC
         wiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTO8MJwFMlG5vvRC6Wa2L9phDkR7Sl3SBVO9yj4wKOsPh439rD8YYNcqgk23StSjscIPQ8k52950oSAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFbxRorjbp0/zgNMHSG2+LRIuu+IacIxILR5ckPOtZgVlHlUC
	ZscmWUP5lP14FF9+enJD7bWH7k01mgjIe8MXHJBejWm/LrPgDdK266eT9STbhiSIelzi7ok6A07
	4JjDmENJwVhfcCwefud1KBK3weRDU7RlXzOg=
X-Gm-Gg: ASbGncvV9z6nYFIu7EL70VGMJe8bS8OL4gMJNb4EmRQRVw9Gk13f2GJYaOOSiyYMDhr
	i3vkZp41b+kxKHQwh3iBfS9cyyzuZNfBwmML8S/EWwk0DHa1a1nVN9orQJRP3heaC4SQ50NfWnE
	K8J6aQOWW69Z1AoCWntnNie9rrtlI=
X-Google-Smtp-Source: AGHT+IEoAOZWQbjqyEMft7Py0/fTn4Im38vvO39WGbHXfXyWQ4vYD36tcpn1tsE8Z4E6vO/crmdq4W5leyJ3CQsf8D8=
X-Received: by 2002:ad4:5ec9:0:b0:6e8:90eb:e5a1 with SMTP id
 6a1803df08f44-6e8e6d442d1mr85550936d6.35.1741230004116; Wed, 05 Mar 2025
 19:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 10:59:52 +0800
X-Gm-Features: AQ5f1JpCOetcZL7QWyaomQkqZP8byiUPAUhT018USnerMvbneS1dBPELx-rgzKw
Message-ID: <CALm_T+3qoQAChNSzULwKOvYDmvkxC8U5moKM5JEVRocR62s3yQ@mail.gmail.com>
Subject: Potential Linux Crash: KASAN slab-use-after-free Read in
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

Kernel Version: v6.13.0-rc5

Kernel Module: fs/ext4/extents.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

BUG: KASAN: slab-use-after-free in ext4_ext_binsearch
fs/ext4/extents.c:840 [inline]
BUG: KASAN: slab-use-after-free in ext4_find_extent+0x9b8/0xa00
fs/ext4/extents.c:955
I/O error, dev sr0, sector 1 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Read of size 4 at addr ffff888104c720ac by task kworker/u16:4/218
Buffer I/O error on dev sr0, logical block 1, async page read

CPU: 3 UID: 0 PID: 218 Comm: kworker/u16:4 Not tainted
6.13.0-rc5-00012-g0bc21e701a6f #2
EXT4-fs (loop5): unmounting filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09=
.
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: writeback wb_workfn (flush-7:2)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xce/0x660 mm/kasan/report.c:489
I/O error, dev sr0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 2, async page read
 kasan_report+0xc6/0x100 mm/kasan/report.c:602
 ext4_ext_binsearch fs/ext4/extents.c:840 [inline]
 ext4_find_extent+0x9b8/0xa00 fs/ext4/extents.c:955
 ext4_ext_map_blocks+0x1bc/0x4e70 fs/ext4/extents.c:4205
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 3 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 3, async page read
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x3c8/0x11c0 fs/ext4/inode.c:702
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 4, async page read
 mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
 ext4_do_writepages+0x15b1/0x3040 fs/ext4/inode.c:2735
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 5 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 5, async page read
 ext4_writepages+0x275/0x510 fs/ext4/inode.c:2824
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
 do_writepages+0x197/0x7b0 mm/page-writeback.c:2702
Buffer I/O error on dev sr0, logical block 6, async page read
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 7 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 7, async page read
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
I/O error, dev sr0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
0
Buffer I/O error on dev sr0, logical block 0, async page read
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
Buffer I/O error on dev sr0, logical block 1, async page read
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 __writeback_single_inode+0xe5/0x950 fs/fs-writeback.c:1680
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 writeback_sb_inodes+0x593/0xd00 fs/fs-writeback.c:1976
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 wb_writeback+0x188/0x790 fs/fs-writeback.c:2156
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x1d2/0xa50 fs/fs-writeback.c:2343
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 process_one_work+0x61a/0x1050 kernel/workqueue.c:3229
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x8cc/0x1160 kernel/workqueue.c:3391
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 kthread+0x25a/0x330 kernel/kthread.c:389
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 </TASK>

Allocated by task 119:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0xf5/0x360 mm/slub.c:4175
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 getname_flags.part.0+0x48/0x4e0 fs/namei.c:139
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x84/0xd0 fs/namei.c:223
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 do_sys_openat2+0xfb/0x1a0 fs/open.c:1396
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x16b/0x210 fs/open.c:1428
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


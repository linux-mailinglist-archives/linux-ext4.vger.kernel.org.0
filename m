Return-Path: <linux-ext4+bounces-3237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB392FF2A
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3D91F23021
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAB178398;
	Fri, 12 Jul 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLZPSm/a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC317624C
	for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804180; cv=none; b=ALZPy98vsajZnD/bVrPQiypOWyAISuCLGxQ58Poe7iz0UIf9gmVUHL7UIxuivtU/jhPikOokBtsodl38If5RNYJJEPI1+zjDZYtWk2hcoi21X7cdWSBX8feDMU8jq6Kk/zRgpdkx/00dNaGLZejeT++DDWh0XaI1WNxUpAIhZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804180; c=relaxed/simple;
	bh=Wo/v5UwG/09CD73ONxK7imOHJdQall48xHyQGXTgfwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riBWi+7+XC3yZB5mVNFlHpn/EBTGaNoQNha8/EL0m6JkTRxHTTVxyomUo2wnCJqrzeMVMh+9IX6yCxlfrAmfW+9rrruvW7Z6F+GlVgfv+oiOZRl5c7wU6zosEy4lRxQl0I+nAdtN3bkvxCrM65aduGF0I82dJCAT2bjZIXb00Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLZPSm/a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c965efab0fso1757827a91.3
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720804178; x=1721408978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrj2IHZDU2vmhGKB/cK/omhwPnigu08hmqFJnt5GI3M=;
        b=PLZPSm/aH4+1fK3EQgYLF9PMy8Qo2c79l6u6PIl5bT2EehCG/u0gEqiqQyNzMtfL+s
         onP4bcAXHQAos0aJBiQlvg2zxkLdy2CQoSUQh99YFfU51Z63IMomx8ZWesRPSvAn2s0n
         /9aZ7ARmKtdveuqECe2fhXmnQ5InKEBzv4nbRmr2vXCTbBFwrH2oEnpRtPMhB+HaPJm+
         Fvn3tUs3F0vI64Rg23uJP9XarwQVYt/ibLT6wUY1Ie0KLLNtkxGOaTvKyEhVjdHoWnFO
         5Dp1mog/jdM0sjiFzZmafOG7ke1uc2UzVaumS4EsvUqo2e33ayqrn+MWJ56JLOjuhBCg
         XtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804178; x=1721408978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrj2IHZDU2vmhGKB/cK/omhwPnigu08hmqFJnt5GI3M=;
        b=jPwnReDIirwavnJ4+sfIaKNvgS8g4YJrEBEJJeayXM3N+fflZ88l65/CVubi5DMTmi
         Vp8ghNDRj8txa5d8siSad1PowYbibDH/WOUkoNR69dNFarymKma5ze+zZ+zaykS/M2ML
         YYF8Nr7Wn/h8GmtY96A1CN4BZtYPXtcPQjO6DUBntDWlZQ4G8mK/mdRbxSLA6ooi4J5k
         EfN0/weRvdNdgrJxq2p34moINADbW3APvXaTBDySZ440/GuNzxpJyf8lgPoisGh284Cx
         m1z5TVnF6dcP/99TgIE3evuF5w1Q3JGFa/5Ah08jHmpawcFCWYINNcZr+H4wiJFvO7Ng
         cRmg==
X-Gm-Message-State: AOJu0YyYqNYJeDBjIJaRfl/VXf6qqUiNER244ddrqSDIfmhzzbstNISO
	VeK3bDf5OdVOCvOIjbHusT1gzMe5aYVV70d0pxJvn1Mws4czDzrugbCgV6qbVo7kWESKc4qcnOb
	ouGWSjSMFuvflGHXE3+NJDKoWNHM7l1P2
X-Google-Smtp-Source: AGHT+IFjCE2F1AV1BQa9Z2ftNsKvp7zs0sJbNriOnExPDcvezmbY1d2dmGhIV4hLzqIdHU3f4saJsP0uE9EMJnTPORY=
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id
 98e67ed59e1d1-2ca35d43887mr9447762a91.39.1720804177939; Fri, 12 Jul 2024
 10:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-3-harshadshirwadkar@gmail.com> <20240701220837.GD419129@mit.edu>
In-Reply-To: <20240701220837.GD419129@mit.edu>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Fri, 12 Jul 2024 10:09:26 -0700
Message-ID: <CAD+ocbwg1Uh9aLZAZFHaPMBAimkXVUsUeQM=jEHvnJ1WmfXKFA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] ext4: for committing inode, make
 ext4_fc_track_inode wait
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, saukad@google.com, harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the review, Jan and the bug report Ted. I think I have
found the issue here.

In fast commit code, we are using s_fc_lock to protect additions and
deletions to lists s_fc_q and s_fc_dentry_q. However, since s_fc_lock
is a spin_lock, we have to give it up in many places where we do
things like memory allocations / deletions, since those cannot be
performed in an atomic context. I am realizing that unlocking that
lock in the middle of the list traversal to allow it to perform these
non-atomic tasks is opening a door to a lot of subtle concurrency
bugs. Unlocking this lock in the middle of the traversal leaves the
door open to ext4_fc_del, which may just remove an entry from the
list, and leave the initial traversal in a broken state. So as an
immediate remedy, I am thinking that we can convert s_fc_lock to mutex
so that the commit code doesn't have to leave the lock in the middle
of the loop.

In the long run, we need to revisit the whole staging queue / main
queue design. I think we can just simplify that such that there is
really only one queue. Commit code just copies the queue in a local
variable and initializes sbi->s_fc_q to empty. That would get rid of
all the messy "if commit ongoing insert in staging otherwise insert in
main" conditions and also simplify the overall code.

I'll make the change to convert to mutex and handle all other Jan's
comments (thanks Jan for the detailed feedback on other patches) to
submit V7 of this patch series.

Thank you,
Harshad



On Mon, Jul 1, 2024 at 3:08=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, May 29, 2024 at 01:19:55AM +0000, Harshad Shirwadkar wrote:
> > If the inode that's being requested to track using ext4_fc_track_inode
> > is being committed, then wait until the inode finishes the
> > commit. Also, add calls to ext4_fc_track_inode at the right places.
> >
> > With this patch, now calling ext4_reserve_inode_write() results in
> > inode being tracked for next fast commit. A subtle lock ordering
> > requirement with i_data_sem (which is documented in the code) requires
> > that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> > this patch also adds explicit ext4_fc_track_inode() calls in places
> > where i_data_sem grabbed.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> I tried applying this patchset to both the current ext4/dev branch as
> well as on to 6.10-rc5, and generic/241 is triggering large series of
> WARNINGS followed by a BUG (or in some cases, a soft lockup).  A
> bisection leads me to this patch.
>
> The WARN stack trace:
>
> [    4.061189] ------------[ cut here ]------------
> [    4.061848] WARNING: CPU: 1 PID: 2627 at fs/ext4/fast_commit.c:259 ext=
4_fc_del+0x7d/0x190
> [    4.062919] CPU: 1 PID: 2627 Comm: dbench Not tainted 6.10.0-rc5-xfste=
sts-00033-gb6f5b0076b56 #350
> [    4.064070] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> [    4.065077] RIP: 0010:ext4_fc_del+0x7d/0x190
> [    4.065404] Code: 0f 84 f0 00 00 00 48 8b 83 48 ff ff ff 48 0f ba e0 2=
a 73 18 48 8b 43 28 48 8b 80 90 03 00 00 48 8b 80 80 00 00 00 a8 02 75 02 <=
0f> 0b 48 89 ef e8 09 ad 68 00 84 c0 74 0f 48 8b 53 98 48 8b 43 a0
> [    4.066190] RSP: 0018:ffffc90003707d98 EFLAGS: 00010246
> [    4.066415] RAX: 0000000000000001 RBX: ffff888013de5c08 RCX: 000000000=
0000000
> [    4.066718] RDX: 0000000000000001 RSI: 00000000ffffffff RDI: ffff88800=
a22c7f0
> [    4.067019] RBP: ffff888013de5ba0 R08: ffffffff827fc6fe R09: ffff88800=
8bed000
> [    4.067323] R10: 0000000000000008 R11: 000000000000001e R12: ffff88800=
a22c7f0
> [    4.067629] R13: ffff88800a22c000 R14: ffff888013de5b90 R15: ffff88800=
ac0c000
> [    4.067935] FS:  00007fec79a4e740(0000) GS:ffff88807dd00000(0000) knlG=
S:0000000000000000
> [    4.068281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.068530] CR2: 000055d2f34b87e8 CR3: 000000000f492003 CR4: 000000000=
0770ef0
> [    4.068834] PKRU: 55555554
> [    4.068952] Call Trace:
> [    4.069061]  <TASK>
> [    4.069158]  ? __warn+0x7b/0x120
> [    4.069338]  ? ext4_fc_del+0x7d/0x190
> [    4.069497]  ? report_bug+0x174/0x1c0
> [    4.069655]  ? handle_bug+0x3a/0x70
> [    4.069809]  ? exc_invalid_op+0x17/0x70
> [    4.069975]  ? asm_exc_invalid_op+0x1a/0x20
> [    4.070156]  ? ext4_fc_del+0x7d/0x190
> [    4.070309]  ? ext4_fc_del+0x44/0x190
> [    4.070468]  ext4_clear_inode+0x12/0xb0
> [    4.070636]  ext4_free_inode+0x86/0x5a0
> [    4.070802]  ext4_evict_inode+0x457/0x6b0
> [    4.070976]  evict+0xcd/0x1d0
> [    4.071114]  do_unlinkat+0x2de/0x330
> [    4.071271]  __x64_sys_unlink+0x23/0x30
> [    4.071436]  do_syscall_64+0x4b/0x110
> [    4.071596]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    4.071812] RIP: 0033:0x7fec79b4aa07
> [    4.071969] Code: f0 ff ff 73 01 c3 48 8b 0d f6 83 0d 00 f7 d8 64 89 0=
1 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 83 0d 00 f7 d8 64 89 01 48
> [    4.072760] RSP: 002b:00007ffed55de918 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000057
> [    4.073081] RAX: ffffffffffffffda RBX: 00007ffed55dedb0 RCX: 00007fec7=
9b4aa07
> [    4.073429] RDX: 0000000000000000 RSI: 00007ffed55dedb0 RDI: 00007ffed=
55dedb0
> [    4.073733] RBP: 000055d2f34a37f0 R08: 0fffffffffffffff R09: 000000000=
0000000
> [    4.074033] R10: 0000000000000000 R11: 0000000000000206 R12: 000055d2f=
34a35d0
> [    4.074338] R13: 00007fec79c35000 R14: 0000000000000004 R15: 00007fec7=
9c35050
> [    4.074650]  </TASK>
> [    4.074747] ---[ end trace 0000000000000000 ]---
>
> And here's the BUG:
>
> [    5.121989] BUG: kernel NULL pointer dereference, address: 00000000000=
000b8
> [    5.122281] #PF: supervisor read access in kernel mode
> [    5.122500] #PF: error_code(0x0000) - not-present page
> [    5.122717] PGD 0 P4D 0
> [    5.122828] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    5.123036] CPU: 0 PID: 2629 Comm: dbench Tainted: G        W         =
 6.10.0-rc5-xfstests-00033-gb6f5b0076b56 #350
> [    5.123470] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> [    5.123857] RIP: 0010:ext4_fc_perform_commit+0x303/0x4b0
> [    5.124082] Code: fd 48 2d a0 00 00 00 48 39 d3 75 af e9 ac fe ff ff 4=
9 8b 4d 58 49 8d 45 58 48 39 c1 0f 84 9f 01 00 00 49 8b 45 58 49 63 4d 08 <=
48> 39 88 b8 00 00 00 4c 8d 78 78 0f 85 7f 01 00 00 48 89 ef e8 c4
> [    5.124855] RSP: 0018:ffffc90003727df8 EFLAGS: 00010246
> [    5.125072] RAX: 0000000000000000 RBX: ffff8880089e5f08 RCX: 000000000=
89e5f08
> [    5.125416] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff88800=
a22c7f0
> [    5.125712] RBP: ffff88800a22c7f0 R08: ffff88807dc2fbc0 R09: 000000000=
0000000
> [    5.126009] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800=
a22c7c8
> [    5.126310] R13: ffff8880089e5f08 R14: ffff88800a22c7a8 R15: ffff88800=
a22c708
> [    5.126609] FS:  00007fec79a4e740(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [    5.126943] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.127188] CR2: 00000000000000b8 CR3: 000000000f48e002 CR4: 000000000=
0770ef0
> [    5.127483] PKRU: 55555554
> [    5.127598] Call Trace:
> [    5.127705]  <TASK>
> [    5.127838]  ? __die+0x23/0x60
> [    5.127973]  ? page_fault_oops+0xa3/0x160
> [    5.128143]  ? exc_page_fault+0x6a/0x160
> [    5.128351]  ? asm_exc_page_fault+0x26/0x30
> [    5.128530]  ? ext4_fc_perform_commit+0x303/0x4b0
> [    5.128728]  ? ext4_fc_perform_commit+0x36b/0x4b0
> [    5.128948]  ext4_fc_commit+0x17f/0x300
> [    5.129116]  ext4_sync_file+0x1ce/0x380
> [    5.129310]  __x64_sys_fsync+0x3b/0x70
> [    5.129470]  do_syscall_64+0x4b/0x110
> [    5.129627]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.129840] RIP: 0033:0x7fec79b4fb10
> [    5.129995] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 0f 1f 44 00 00 80 3d d1 ba 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> [    5.130764] RSP: 002b:00007ffed55de948 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000004a
> [    5.131079] RAX: ffffffffffffffda RBX: 00007fec79c35450 RCX: 00007fec7=
9b4fb10
> [    5.131381] RDX: 0000000000002b6f RSI: 0000000000002b6f RDI: 000000000=
0000005
> [    5.131681] RBP: 000055d2f34a3660 R08: 1999999999999999 R09: 000000000=
0000000
> [    5.131981] R10: 00007fec79bcdac0 R11: 0000000000000202 R12: 000055d2f=
34a35d0
> [    5.132280] R13: 00007fec79c35450 R14: 0000000000000003 R15: 00007fec7=
9c354a0
> [    5.132575]  </TASK>
> [    5.132670] CR2: 00000000000000b8
> [    5.132812] ---[ end trace 0000000000000000 ]---
>
> Harshad, can you take a look?   Thanks!
>
>                                                 - Ted
>


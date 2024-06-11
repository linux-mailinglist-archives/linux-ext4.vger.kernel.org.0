Return-Path: <linux-ext4+bounces-2845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A760B90379C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7101C23792
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC59176ABA;
	Tue, 11 Jun 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuVbkQEP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B287346F
	for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097262; cv=none; b=MyIXo7bHMDw2oLV1fUx9IhqghxBCppSRzlEMV28wFc/L9zNznK3v+ANwH7Z6mdU7931vjldhrvMEfhuP6B0SXSxyDczpNC1n8OPhG+7NOeuOonJ05FFy2+93AUlDeXBESOFdXHSYv4cGChJaEO1dZvQbWVGYwVpyceDrflGO7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097262; c=relaxed/simple;
	bh=HfgAS0KSFZ7V+nAXdxzcCjVbvqyqtkxFmdMkxpbCKXo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hZLCACCEMMt/RzWNBCNtEd2aoUhOPMxSZ0CV+eAw1pQwaLdrfgGtzVo2UR0EjfIJ2Lr2sfwyDRzCri/0zOVz6Ects6dViHW5cgx6gdefNJCAn4ibmUsX9+J7APYTnQBig2Sl/kMkThezlkV4pLqxB+QNacnhbreTG7zRSVqbSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuVbkQEP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a08091c2bso11186817b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718097260; x=1718702060; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqcTAILBWMoM2RnR2kpmmEiseDcW1gScP97iUYXzTvE=;
        b=HuVbkQEPEiVMw2WJR46uiv1oiAZ+UDMBrtIYTz61egHfDn87WurtkJHTYPdovXtcTe
         BWi973lUGaCCpjEP3bEVE1pR2oWhP3dhApMzSD2Sc6z7IaFlLi9Mr9ae1pVbewwiambb
         dgroOmp1GU0+nzmv/bcDtmmR1SXvs6f3dcN7ym67yNDvGTqo6ZH+pUK5rngbGnxPeyb3
         lGxNccFAunk8Cr04yz8QpGl9zkuv38b8FRYHsxHr3MteytXuT9PWZVgsIOy9BuzasxJ1
         8xhW4yryWZDVTGrNLXrevkRKDC45ksp2v5oMraNquAAD8EbqiCsAFUZyy/Xg6jE68gGg
         ED9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097260; x=1718702060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqcTAILBWMoM2RnR2kpmmEiseDcW1gScP97iUYXzTvE=;
        b=HWEQGky3pkihg+vYBMVCyjIyKTUFQfCpv27vdiky1MLO/dNwfA8pK4kdpVAoElgjvr
         SUF5rjxIhZOPL+G3tQ3AsLbuD93IIVg2TDl6TcP8KJ5bKJuaDmyM98X8dvyASwXZzExu
         FgZmjYPyk2JhfZiKzXJgwvArKRnyHy4uaQ9qWv8x+7Rt/VBau3E0zMdI/p/kfKfSGRiD
         XZX0DaICcxULmsAJZcY3Y//b7I126zZBwTuzDijA/sB1U3zY8Jk/79QcRLoJRQrKRiYv
         mW++wjaH3JDW+h9ku2ByROS36w2D+pNlRRMoyNlcxana0Y9VwP7OZ3g21GKdByXKq9Dw
         Cgbg==
X-Forwarded-Encrypted: i=1; AJvYcCXW0hOCPwHxa4osTK9MoCrCt10hiH8nTZ+rHcpLKu5NdJzIQKIOIWAj1yvKA75OakFfXXqu4J9XjtqT0n9vvuSrlJPowLqglTeKrQ==
X-Gm-Message-State: AOJu0YyZvdxN5IizJ+NY+HohTtLo80hO6HJHBr9fJJaWXyLe9jHivpX/
	p0f/RI9GVNYTchHbdBjOo/31LWBm5ms062OkuILp/keakP4WHnS/ArXns4h38w==
X-Google-Smtp-Source: AGHT+IFsGRjvigUxgTTtTqGgMnNIg8YFES6i9HDNADq5rjt43maW5TChLkUemeXXADRcsznTywdH0A==
X-Received: by 2002:a0d:c782:0:b0:62d:a29:5384 with SMTP id 00721157ae682-62d0a2954a3mr52702187b3.43.1718097258846;
        Tue, 11 Jun 2024 02:14:18 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccacade03sm19192037b3.27.2024.06.11.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:14:18 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:13:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
cc: syzbot <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com>, 
    akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
    syzkaller-bugs@googlegroups.com, Hugh Dickins <hughd@google.com>, 
    Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_store
In-Reply-To: <CAJD7tkaTQU1Kxt935fmq+_BJd-VT6vKFj58o7Aq+QhoyrOtCmw@mail.gmail.com>
Message-ID: <02a21a55-8fe3-a9eb-f54b-051d75ae8335@google.com>
References: <000000000000d0f165061a6754c3@google.com> <CAJD7tkaTQU1Kxt935fmq+_BJd-VT6vKFj58o7Aq+QhoyrOtCmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1445972292-1718097257=:2984"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1445972292-1718097257=:2984
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Jun 2024, Yosry Ahmed wrote:
> On Sat, Jun 8, 2024 at 2:09=E2=80=AFPM syzbot
> <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of gi=
t:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D113f3fd6980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5d2cbf3363=
3f507
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9c1fe13fcb515=
74b249b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/d=
isk-614da38e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmli=
nux-614da38e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115=
/bzImage-614da38e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com
>=20
> This doesn't look like a zswap bug, and perhaps not a bug at all but I
> am not sure. Zswap is reading the data in a folio to check if it is
> filled with a repeated pattern, and it is encountering uninitialized
> data. I am not sure if this is expected behavior or not.

I agree, it doesn't look like a zswap bug: zswap is just following orders.

>=20
> Could it just be that the size of the data written by syzbot is not
> divisible by PAGE_SIZE, so part of the final page is left
> uninitialized? Do we keep the unwritten parts of a shmem page
> uninitialized by any chance?

Shmem can keep uninitialized data pages around, but should be zeroing
what's still uninitialized before it can reach the outside world -
in this case being written to swap.  I don't know of a shmem bug here.

>=20
> Hugh, do you mind taking a quick look at whether this is a real bug?
>=20
> If this is expected behavior, perhaps there is some annotation we can
> use in zswap that it is fine to encounter uninitialized data when
> reading the folio.

I've not been faced with a KMSAN report before, so I might well be
misunderstanding its language: but this looks like an ext4 "bug" to me.

I think the story that the three KMSAN stacks are telling is this:
syzbot has an ext4 filesystem on a loop device on a tmpfs file (I do
exactly that too); ext4 is doing some ext4_xattr_inode_write() business,
in the course of which it writes back a not-fully-initialized block to
the loop device; shmem faithfully copies that data into its pagecache,
then later when under memory pressure that page gets "written" out to
zswap: where zswap_is_page_same_filled() takes an interest in the data,
and KMSAN objects because some of it was not originally initialized.

If that's a correct interpretation, then it's probably not a big deal:
it's probably the uninitialized end of a buffer that's written out,
not any part of the "disk" which ext4 would ever show to a user; but
I do agree with KMSAN that ext4 would do better to clear that area,
rather than accidentally storing someone else's super-secret info.

Hugh

>=20
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in zswap_is_page_same_filled mm/zswap.c:1481 [=
inline]
> > BUG: KMSAN: uninit-value in zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
> >  zswap_is_page_same_filled mm/zswap.c:1481 [inline]
> >  zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
> >  swap_writepage+0x126/0x4c0 mm/page_io.c:198
> >  shmem_writepage+0x1826/0x1f70 mm/shmem.c:1518
> >  pageout mm/vmscan.c:660 [inline]
> >  shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
> >  evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
> >  try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
> >  shrink_one+0x66f/0xd40 mm/vmscan.c:4772
> >  shrink_many mm/vmscan.c:4835 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:4935 [inline]
> >  shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
> >  kswapd_shrink_node mm/vmscan.c:6704 [inline]
> >  balance_pgdat mm/vmscan.c:6895 [inline]
> >  kswapd+0x1eba/0x4460 mm/vmscan.c:7164
> >  kthread+0x3e2/0x540 kernel/kthread.c:389
> >  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Uninit was stored to memory at:
> >  memcpy_from_iter lib/iov_iter.c:73 [inline]
> >  iterate_bvec include/linux/iov_iter.h:122 [inline]
> >  iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
> >  iterate_and_advance include/linux/iov_iter.h:271 [inline]
> >  __copy_from_iter lib/iov_iter.c:249 [inline]
> >  copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
> >  generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
> >  shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:2920
> >  do_iter_readv_writev+0x7e6/0x960
> >  vfs_iter_write+0x459/0xd00 fs/read_write.c:895
> >  lo_write_bvec drivers/block/loop.c:246 [inline]
> >  lo_write_simple drivers/block/loop.c:267 [inline]
> >  do_req_filebacked drivers/block/loop.c:491 [inline]
> >  loop_handle_cmd drivers/block/loop.c:1907 [inline]
> >  loop_process_work+0x1502/0x3440 drivers/block/loop.c:1942
> >  loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1973
> >  process_one_work kernel/workqueue.c:3267 [inline]
> >  process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
> >  worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
> >  kthread+0x3e2/0x540 kernel/kthread.c:389
> >  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Uninit was created at:
> >  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
> >  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
> >  alloc_pages mm/mempolicy.c:2335 [inline]
> >  folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
> >  filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
> >  __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
> >  grow_dev_folio fs/buffer.c:1042 [inline]
> >  grow_buffers fs/buffer.c:1108 [inline]
> >  __getblk_slow fs/buffer.c:1134 [inline]
> >  bdev_getblk+0x39b/0xc80 fs/buffer.c:1429
> >  __getblk include/linux/buffer_head.h:355 [inline]
> >  sb_getblk include/linux/buffer_head.h:361 [inline]
> >  ext4_getblk+0x3da/0xe00 fs/ext4/inode.c:843
> >  ext4_xattr_inode_write fs/ext4/xattr.c:1421 [inline]
> >  ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1596 [inline]
> >  ext4_xattr_set_entry+0x574d/0x6880 fs/ext4/xattr.c:1718
> >  ext4_xattr_block_set+0xb94/0x4fb0 fs/ext4/xattr.c:2037
> >  ext4_xattr_move_to_block fs/ext4/xattr.c:2654 [inline]
> >  ext4_xattr_make_inode_space fs/ext4/xattr.c:2729 [inline]
> >  ext4_expand_extra_isize_ea+0x20bd/0x3560 fs/ext4/xattr.c:2821
> >  __ext4_expand_extra_isize+0x5dc/0x680 fs/ext4/inode.c:5789
> >  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
> >  __ext4_mark_inode_dirty+0x70d/0xa10 fs/ext4/inode.c:5910
> >  ext4_delete_inline_entry+0x650/0x7d0 fs/ext4/inline.c:1753
> >  ext4_delete_entry+0x13f/0x7d0 fs/ext4/namei.c:2719
> >  __ext4_unlink+0x9b8/0x11b0 fs/ext4/namei.c:3273
> >  ext4_unlink+0x226/0x630 fs/ext4/namei.c:3321
> >  vfs_unlink+0x676/0xa30 fs/namei.c:4343
> >  do_unlinkat+0x823/0xe10 fs/namei.c:4407
> >  __do_sys_unlinkat fs/namei.c:4450 [inline]
> >  __se_sys_unlinkat fs/namei.c:4443 [inline]
> >  __x64_sys_unlinkat+0x17c/0x230 fs/namei.c:4443
> >  x64_sys_call+0x846/0x3b50 arch/x86/include/generated/asm/syscalls_64.h=
:264
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > CPU: 1 PID: 88 Comm: kswapd1 Not tainted 6.9.0-syzkaller-02707-g614da38=
e2f7a #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/02/2024
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20
---1463770367-1445972292-1718097257=:2984--


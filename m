Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B89429AF6
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 03:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhJLBWu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhJLBWr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Oct 2021 21:22:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA40C06161C;
        Mon, 11 Oct 2021 18:20:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w6so4664638pfd.11;
        Mon, 11 Oct 2021 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vKo6dHBGZGRZ+QVhKsHKS/1oEEF3K0Wf4gbpvEJ/Pxo=;
        b=jePH8u6HWYzIhDz6pM03+izScQaod7BzUWSZVd1Rep9FnYAfCRc3bmvMhRSjZ2uzwX
         DnAlF99qOK80sBUV6WtKRPpaUILp6ZKPf0Z/3Lh4id+3iS3c7Qr4L3lvcaOymV21GDpk
         7CttodWKv1DSfSj51ay5jQ98HYe5gMn7PfAqCi132xlqWYMnQ89JNZtz5eKb4afGNg9V
         mXJYN1iNArxv/oKDPaV/5fACAmvBbEmFY2x24ZpwKd6fmpklYcBHSgdzN4yxfxswC7gZ
         RVBzQ2Ursconyme/8KNY2v0aaqYhU2Iqwt7CwtY6lV7iUpxMvm+kev8Phn/8+7H1bImw
         mYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vKo6dHBGZGRZ+QVhKsHKS/1oEEF3K0Wf4gbpvEJ/Pxo=;
        b=wPd+G1J76bH9N/cPncF9Qu3gXhUSs8Oh1ieg+zgSdEZvSw1PBeDlbEIyRGTgECuL6h
         JX8RmtT4EkZsvL88FoxrJvLPj3tQykhZkLnGjKzwj55nYfytM6pzWDHkbCjhi1CcsfQi
         TjYOUQK8cJKpsqtXm4HF5iLUjG6zWBPCmOYTNikMfePDqaprDlNeUGaVtXNb0SzB6T/+
         Cy2vYsBBaIj83D/mRiqQLX4wWCwJcibwV8ESdWwkD40IDuuv9Hf3oWcqkpGDvJJTVz73
         U5X4jEzdsf5/mGqVEmh3vna0NKY1LjnY9EUFaXPD8M0UmTZLNvb3kEKFPdEM2vE9PZ5H
         CU0Q==
X-Gm-Message-State: AOAM53055G6xPQ6Kv0xFfbFIywR/a46I+RGcTeyXA+meaADFw5uXPWvv
        YtBHJkCishKQ1PhXX6OpoNm5K4apB3uqQmh4Hg==
X-Google-Smtp-Source: ABdhPJzcw0AzrmP92HLJlycv/fFNJ6Y7IghaAFuMZHgD0Zx577rdajuQqdPPLbMh8BHQXtjRL9x1MwACukeBvqlWEpw=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr20294748pgd.381.1634001645144;
 Mon, 11 Oct 2021 18:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsb1dE7A_v_=yYfMOO0HSGT9a0Zc7=cC6cmYREWepHhxpw@mail.gmail.com>
 <20211011222135.GA17897@localhost.localdomain>
In-Reply-To: <20211011222135.GA17897@localhost.localdomain>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 12 Oct 2021 09:20:34 +0800
Message-ID: <CACkBjsY3VOvyAF1mrmyM1Fsx9QGSsOamjq944d5+X+zkH9rFEw@mail.gmail.com>
Subject: Re: kernel BUG in ext4_da_get_block_prep
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Whitney <enwlinux@gmail.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:21=E5=86=99=E9=81=93=EF=BC=9A
>
> * Hao Sun <sunhao.th@gmail.com>:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> >
> > HEAD commit: 60a9483534ed Merge tag 'warning-fixes-20211005'
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1zMa_o4PaMiO_nYcQ4giUjNhFszYjFae-/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1u-ncYGLkq3xqdlNQYJz8-G6=
Fhf3H-moP/view?usp=3Dsharing
> > Syzlang reproducer:
> > https://drive.google.com/file/d/1LWQjzVVjjI8q6sO1f4AYlq5NlcN-shBP/view?=
usp=3Dsharing
> >
> > Sorry, I don't have a C reproducer for this crash, hope the symbolized
> > report and Syzlang reproducer can help.
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> >
> > ------------[ cut here ]------------
> > kernel BUG at fs/ext4/inode.c:1721!
> > invalid opcode: 0000 [#1] PREEMPT SMP
> > CPU: 1 PID: 19701 Comm: syz-executor Not tainted 5.15.0-rc4+ #22
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
> > RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
> > Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
> > 01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
> > e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
> > RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
> > RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
> > RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
> > R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
> > R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
> > FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  ext4_block_write_begin+0x208/0x980 fs/ext4/inode.c:1078
> >  ext4_da_write_begin+0x1d4/0x490 fs/ext4/inode.c:2969
> >  generic_perform_write+0xce/0x220 mm/filemap.c:3770
> >  ext4_buffered_write_iter+0xd6/0x190 fs/ext4/file.c:269
> >  ext4_file_write_iter+0x80/0x940 fs/ext4/file.c:680
> >  call_write_iter include/linux/fs.h:2163 [inline]
> >  do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
> >  do_iter_write+0xaf/0x250 fs/read_write.c:855
> >  vfs_iter_write+0x38/0x60 fs/read_write.c:896
> >  iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
> >  do_splice_from fs/splice.c:767 [inline]
> >  direct_splice_actor+0x4a/0x80 fs/splice.c:936
> >  splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
> >  do_splice_direct+0xc3/0x110 fs/splice.c:979
> >  do_sendfile+0x338/0x740 fs/read_write.c:1249
> >  __do_sys_sendfile64 fs/read_write.c:1314 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1300 [inline]
> >  __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x46ae99
> > Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f773e1d5c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> > RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> > RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> > RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00008400fffffffb R11: 0000000000000246 R12: 000000000078c0a0
> > R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007fffca657850
> > Modules linked in:
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 46bee01b7f620b60 ]---
> > RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
> > RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
> > Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
> > 01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
> > e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
> > RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
> > RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
> > RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
> > R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
> > R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
> > FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
>
> Hi:
>
> Thanks for the report.
>
> Violation of the assertion enforced on line 1721 in fs/ext4/inode.c has
> already been reported separately in a recent upstream kernel.
>
> It's not clear what can be done with the information reported here.  A
> reproducer would be most useful but it's not obvious how to generate that
> from this information.  The supplied log suggests that 1) the test
> file system was encountering ENOMEM at least from time to time in ext4_se=
tattr
> and that 2) some sort of fault was being injected to force a failure prio=
r to
> the crash.
>
> What sort of fault was being injected?
>

console output:
https://drive.google.com/file/d/1zMa_o4PaMiO_nYcQ4giUjNhFszYjFae-/view?usp=
=3Dsharing
As can be seen in the full console log, the following faults were
injected during execution.

[  618.499431][T19702] FAULT_INJECTION: forcing a failure.
[  618.499431][T19702] name failslab, interval 1, probability 0, space
0, times 0
[  618.502116][T19702] CPU: 1 PID: 19702 Comm: syz-executor Not
tainted 5.15.0-rc4+ #22
[  618.503904][T19702] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[  618.506049][T19702] Call Trace:
[  618.506656][T19702]  dump_stack_lvl+0x8d/0xcf
[  618.507496][T19702]  should_fail+0x13c/0x160
[  618.508277][T19702]  should_failslab+0x5/0x10
[  618.509259][T19702]  slab_pre_alloc_hook.constprop.99+0x4e/0xc0
[  618.510334][T19702]  ? jbd2__journal_start+0xa0/0x350
[  618.511835][T19702]  kmem_cache_alloc+0x44/0x280
[  618.513404][T19702]  jbd2__journal_start+0xa0/0x350
[  618.514364][T19702]  __ext4_journal_start_sb+0x1ea/0x270
[  618.515499][T19702]  ext4_truncate+0x136/0x7e0
[  618.516881][T19702]  ? unmap_mapping_pages+0x95/0x180
[  618.518105][T19702]  ext4_setattr+0x9bf/0xdc0
[  618.519125][T19702]  ? ext4_journalled_write_end+0x7a0/0x7a0
[  618.520331][T19702]  notify_change+0x476/0x670
[  618.521343][T19702]  do_truncate+0xa3/0x100
[  618.522411][T19702]  path_openat+0xc81/0xe20
[  618.523197][T19702]  ? __lock_acquire+0x4a8/0x1d60
[  618.524155][T19702]  ? __lock_acquire+0x4a8/0x1d60
[  618.525235][T19702]  do_filp_open+0xe3/0x170
[  618.526191][T19702]  ? alloc_fd+0x1a1/0x290
[  618.527059][T19702]  ? _find_next_bit+0x10a/0x130
[  618.528074][T19702]  ? do_sys_openat2+0x357/0x4a0
[  618.529063][T19702]  do_sys_openat2+0x357/0x4a0
[  618.529997][T19702]  do_sys_open+0x87/0xd0
[  618.530860][T19702]  do_syscall_64+0x34/0xb0
[  618.531748][T19702]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  618.532529][T19702] RIP: 0033:0x46ae99
[  618.533061][T19702] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8
64 89 01 48
[  618.536000][T19702] RSP: 002b:00007f773e1abc48 EFLAGS: 00000246
ORIG_RAX: 0000000000000055
[  618.537368][T19702] RAX: ffffffffffffffda RBX: 000000000078c158
RCX: 000000000046ae99
[  618.538530][T19702] RDX: 0000000000000000 RSI: 00000000000000a1
RDI: 00000000200002c0
[  618.539773][T19702] RBP: 00007f773e1abc80 R08: 0000000000000000
R09: 0000000000000000
[  618.540912][T19702] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000013
[  618.542395][T19702] R13: 0000000000000000 R14: 000000000078c158
R15: 00007fffca657850
[  618.544389][T19702] EXT4-fs error (device sda) in
ext4_setattr:5488: Out of memory

> The fact that the test system was running out of memory is a potentially
> useful hint.
>
> Thanks,
> Eric
>
> P.S.  The supplied kernel configuration produces a kernel that runs so sl=
owly
> that a trial run of the ext4 test appliance has made almost no forward
> progress on my test system in three hours of running time on ext4/032 alo=
ne
> (4K test scenario).  So, that's not particularly useful.
>

Expanding the VM resource, e.g., memory size, may resolve this.

Regards
Hao

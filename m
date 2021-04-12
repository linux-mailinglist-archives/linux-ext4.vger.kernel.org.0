Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20D35C440
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhDLKnT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhDLKnS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 06:43:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC81C061574;
        Mon, 12 Apr 2021 03:43:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d10so9024995pgf.12;
        Mon, 12 Apr 2021 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEK0nhztsH9mu96d1FzhM0ZDZsnUHURdhQ+XaFjk794=;
        b=vUKK3xVtZ1ns6QVpic8QwSyGa7ukh7Fdo7RdRRVAv3O44CN7gzae0xnjcIWkF5OpVN
         AfttBwqPteUWgFDa38DKZ86DNX1kR3EAmfs+u3lBVJZy0LyTIjFTjsmPzHSCmftVJ27m
         YRAYWKJpPTbw2qQJGpm4YhFAnJlw5ONMtHe5mmxDkdj4RYQkWYCLUcmZFrCc1ZyXj+jP
         xEH9IYaxVERMaKjYcc+q/PHK/tHdfjqgyYnVgIMio+x3M4hOGtItMpEvu+EVS36TWb5i
         yL2UTH+fToXM6P9bav6qRcs8vvKU4rdyKmX4urhtKYgJVuFNCMNrs2qtXft4V099NfL9
         ya0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEK0nhztsH9mu96d1FzhM0ZDZsnUHURdhQ+XaFjk794=;
        b=AcwsgbsGxIr5qy4flq7HSzCkQn+LsED/5F5H9sTlIrE1raOrAwCnahw4su1MsqCAWH
         b3kQx0d48QCfapcuWufRK1HNQWSoTaH0FqozPONXaX6bRfdSq/WdtHLohp/CoSRWz9Y6
         d69eaoeqBnwBxs4M0IYShV8/UGjGu4dAG1WIP1DhxfloMgfeQKlmLHS94rRlV6k2JmxK
         l9eOnyfAOrs6TuITdIeu5H3fgYo3BEJJF/DDEWXT1LlCQyCaMxoI68NMqEiXj0tVqhpx
         M1dA6WhwtgBSs77a+YlC4giTQxG8MDjoo2jgMqw5TADzbb2QBIKn23czNvm0OFPkncAu
         XzHw==
X-Gm-Message-State: AOAM5327DSGf+KdrQSDC3NFj8WgiKWuMrAfhpuuXKYFkq2aerpSgVpYa
        smGF6XXFCEv8RY+stsbeKv51znxgvsuxYim7eQ==
X-Google-Smtp-Source: ABdhPJw0ds5EmL0VZYpokhc0XW2/tJ9E24q0a9iTdeHgTcuD82YHOWlrs+LPS65NMsiyjRoqhPvVmYxD6nH1Bxtl56w=
X-Received: by 2002:aa7:818e:0:b029:215:2466:3994 with SMTP id
 g14-20020aa7818e0000b029021524663994mr25117151pfi.48.1618224180432; Mon, 12
 Apr 2021 03:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYrsp5LekZciBjSbnJLHvBwQF3YM5TiKEMPeUX-D_DaSA@mail.gmail.com>
 <20210412090212.GA31090@quack2.suse.cz>
In-Reply-To: <20210412090212.GA31090@quack2.suse.cz>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 12 Apr 2021 18:42:58 +0800
Message-ID: <CACkBjsYuWeJNYTGUhBVszgiUVOrMdEZ=qcmDtEk97BEtm4ggSA@mail.gmail.com>
Subject: Re: More KCSAN data-race Reports
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jack@suse.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> =E4=BA=8E2021=E5=B9=B44=E6=9C=8812=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Sun 11-04-21 11:42:05, Hao Sun wrote:
> > Since the last KCSAN report[1], I found two more KCSAN reports that
> > Syzbot had not reported.
> > Not sure if they are valid bugs, I hope the stack information in
> > reports can help you locate the problem.
> > Kernel config can be found in the attachment.
>
> Do we have symbolic decoding of the traces below? Because involved
> functions are really big so it's difficult to guess what KCSAN is
> complaining about... At least I wasn't able to guess it after looking int=
o
> the stacktraces for a while.
>
Sorry, the log processing module of Fuzzer still has some logic bugs,
only some of the symbolized reports are stored in the disk.
Interestingly, however, the read-write end that causes data racing in
both reports are in the same location (fs/jbd2/commit.c:443), and this
information should help locate the problem.

Partial symbolized report 1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KCSAN: data-race in ext4_mark_iloc_dirty / jbd2_journal_commit_transac=
tion
read-write to 0xffff88804451d800 of 8 bytes by task 4821 on cpu 1:
 jbd2_journal_commit_transaction+0x222/0x3200 fs/jbd2/commit.c:443
 kjournald2+0x253/0x470 fs/jbd2/journal.c:213
 kthread+0x1f0/0x220 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Partial symbolized report 2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KCSAN: data-race in __ext4_handle_dirty_metadata /
jbd2_journal_commit_transaction
read-write to 0xffff88800e142800 of 8 bytes by task 4823 on cpu 0:
 jbd2_journal_commit_transaction+0x222/0x3200 fs/jbd2/commit.c:443
 kjournald2+0x253/0x470 fs/jbd2/journal.c:213
 kthread+0x1f0/0x220 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

>
> >
> > Here is the detailed information:
> > commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
> > version:   linux 5.11
> > git tree:    upstream
> >
> > Report-1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in ext4_mark_iloc_dirty / jbd2_journal_commit_tra=
nsaction
> >
> > read-write to 0xffff88804451d800 of 8 bytes by task 4821 on cpu 1:
> >  jbd2_journal_commit_transaction+0x222/0x3200
> >  kjournald2+0x253/0x470
> >  kthread+0x1f0/0x220
> >  ret_from_fork+0x1f/0x30
> >
> > read to 0xffff88804451d800 of 8 bytes by task 8418 on cpu 0:
> >  ext4_mark_iloc_dirty+0x14ec/0x16e0
> >  __ext4_mark_inode_dirty+0x4d2/0x5d0
> >  ext4_evict_inode+0xb9f/0xed0
> >  evict+0x1a6/0x410
> >  iput+0x3fc/0x510
> >  do_unlinkat+0x2c9/0x4d0
> >  __x64_sys_unlink+0x2c/0x30
> >  do_syscall_64+0x39/0x80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Report-2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in __ext4_handle_dirty_metadata /
> > jbd2_journal_commit_transaction
> >
> > read-write to 0xffff88800e142800 of 8 bytes by task 4823 on cpu 0:
> >  jbd2_journal_commit_transaction+0x222/0x3200
> >  kjournald2+0x253/0x470
> >  kthread+0x1f0/0x220
> >  ret_from_fork+0x1f/0x30
> >
> > read to 0xffff88800e142800 of 8 bytes by task 7925 on cpu 1:
> >  __ext4_handle_dirty_metadata+0x11a/0x590
> >  ext4_mark_iloc_dirty+0x12dd/0x16e0
> >  __ext4_mark_inode_dirty+0x4d2/0x5d0
> >  ext4_dirty_inode+0x86/0xa0
> >  __mark_inode_dirty+0x70/0x6b0
> >  file_update_time+0x3ab/0x3f0
> >  file_modified+0x62/0x80
> >  ext4_buffered_write_iter+0x1f9/0x3d0
> >  ext4_file_write_iter+0x45e/0x10d0
> >  vfs_write+0x6db/0x7c0
> >  ksys_write+0xce/0x180
> >  __x64_sys_write+0x3e/0x50
> >  do_syscall_64+0x39/0x80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> >
> > [1] https://lore.kernel.org/lkml/CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV=
6CTXVvtVa7KPQ@mail.gmail.com/
>
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

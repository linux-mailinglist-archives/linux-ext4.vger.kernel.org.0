Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3035550D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbhDFN2D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbhDFN2C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Apr 2021 09:28:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D9C06174A;
        Tue,  6 Apr 2021 06:27:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b10so15539003iot.4;
        Tue, 06 Apr 2021 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXjsPBr0qX/pSOJq0XHrLuh8funEyjUuOd/nR4meJJI=;
        b=fuL3qBLf0jFhr6qwSVz/eh93yoVvaHXCBkLyIzsejTjO5ncEASIHYSJnREfyqpxHkp
         /h8WgyCXeE0O9CuEd2RCnH+PgoA9krqnXyN1mleaTzT8xXMDRstaxKwzdfBDxphMmVnu
         4xLJGty3imSjacAOOw1wa0rTjNv2FcmXph6POAabsxpuvbP7dJFZVYDyw2OK/UclJ9qS
         iwRObqAEU5W1vW9QTNfU7hsASBHbZC1bVbK4tfdBGXm2sH8U/wKhclcZIT+n3Rvh23Om
         Z/F3CGUJLCF7iJrnq+OzbuDlMa79DlGoP+meIDEkjc4WcujFJfVIOZWbHkz8PX03Ca18
         Jm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXjsPBr0qX/pSOJq0XHrLuh8funEyjUuOd/nR4meJJI=;
        b=VL90O2BKhqY2wNV/5bv+XcMmPy/2lOBz9DJElNBLhBckC3j9WIwtrCUvY7Md09Ta4f
         ZfsopPT7lRsSnBcau0hOIyx/wfMdD7NG72M4gj5Af3rgwq1OhE9zd2RabXmuib8e80q8
         1KOORQgu0C9OgTBUSfPY1AQIGRk18+4AZLHigAGyTrc7dQqWMZyPOcnMRhg+gcTaT/0Q
         eJ5AONWQFDiq5qEk+MHOus0LJRn/FlNoyuT3uEPLrlZD9sKUoAD5GL+NMfJYIfcV8YRf
         hVe7ES+Y31N+CtYmxITpNK915wuNam+l0Q/cbjCkmNak6tWe50Q2FNSMaK894WNQvGnU
         PS5Q==
X-Gm-Message-State: AOAM533UJ/92Jqx2icHnr5+JsrgdUz28dt4+aTBvbhns5D8dq5UEL2Y/
        Q/jlItkYDzTfef4hu2Qkk8qlOygwlsRjyYlt0Q==
X-Google-Smtp-Source: ABdhPJzQPzkhvdBjCOUpNphQ/hqTE5QA+ozLmJP1bIMAl4Rm2pkdhOWuHf6AuWU/8nXmGHXHgubc26bSrYtaxIf7IK8=
X-Received: by 2002:a5e:a508:: with SMTP id 8mr24251361iog.135.1617715674703;
 Tue, 06 Apr 2021 06:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
 <20210406123232.GD19407@quack2.suse.cz>
In-Reply-To: <20210406123232.GD19407@quack2.suse.cz>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 6 Apr 2021 21:27:48 +0800
Message-ID: <CACkBjsZgEi5peFFn0vx34F8A1wROjNgpERXigOtznB7ox9mWVQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __jbd2_journal_file_buffer / jbd2_journal_dirty_metadata
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Thanks for report but I'm not sure what KCSAN is complaining about - isn'=
t the report truncated?

Yes, the full KCSAN report is available in the attached log file.
Here is the report :
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KCSAN: data-race in __jbd2_journal_file_buffer /
jbd2_journal_dirty_metadata

write to 0xffff88800af6da38 of 8 bytes by task 4822 on cpu 1:
 __jbd2_journal_file_buffer+0x18d/0x370
 __jbd2_journal_refile_buffer+0x155/0x230
 jbd2_journal_commit_transaction+0x24c6/0x3200
 kjournald2+0x253/0x470
 kthread+0x1f0/0x220
 ret_from_fork+0x1f/0x30

read to 0xffff88800af6da38 of 8 bytes by task 1955 on cpu 0:
 jbd2_journal_dirty_metadata+0x17f/0x670
 __ext4_handle_dirty_metadata+0xc6/0x590
 ext4_mark_iloc_dirty+0x12dd/0x16e0
 __ext4_mark_inode_dirty+0x4d2/0x5d0
 ext4_writepages+0x1262/0x1e50
 do_writepages+0x7b/0x150
 __writeback_single_inode+0x84/0x4e0
 writeback_sb_inodes+0x69f/0x1020
 __writeback_inodes_wb+0xb0/0x2a0
 wb_writeback+0x290/0x650
 wb_do_writeback+0x582/0x5d0
 wb_workfn+0xb8/0x410
 process_one_work+0x3e1/0x940
 worker_thread+0x64a/0xaa0
 kthread+0x1f0/0x220
 ret_from_fork+0x1f/0x30

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1955 Comm: kworker/u5:2 Not tainted 5.11.0+ #5


Sorry, I couldn't symbolize it because the original Linux binary was lost.
Do you think this is an actual bug?

Hao

Jan Kara <jack@suse.cz> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=97=A5=E5=91=A8=
=E4=BA=8C =E4=B8=8B=E5=8D=888:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello!
>
> On Sun 04-04-21 17:40:44, Hao Sun wrote:
> > When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> > the Linux kernel, I found a data-race vulnerability in
> > __jbd2_journal_file_buffer / jbd2_journal_dirty_metadata.
> > Sorry, data-race is usually difficult to reproduce. I cannot provide
> > you with a reproducing program.
> > I hope that the call stack information in the crash log can help you
> > locate the problem.
> > Kernel config and full log can be found in the attachment.
> >
> > Here is the detailed information:
> > commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
> > version:   linux 5.11
> > git tree:    upstream
> > report:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in __jbd2_journal_file_buffer /
> > jbd2_journal_dirty_metadata
> > write to 0xffff88800af6da38 of 8 bytes by task 4822 on cpu 1:
> >  __jbd2_journal_file_buffer+0x18d/0x370 linux/fs/jbd2/transaction.c:251=
8
> >  __jbd2_journal_refile_buffer+0x155/0x230 linux/fs/jbd2/transaction.c:2=
612
> >  jbd2_journal_commit_transaction+0x24c6/0x3200 linux/fs/jbd2/commit.c:1=
084
> >  kjournald2+0x253/0x470 linux/fs/jbd2/journal.c:213
> >  kthread+0x1f0/0x220 linux/kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 linux/arch/x86/entry/entry_64.S:294
>
> Thanks for report but I'm not sure what KCSAN is complaining about - isn'=
t
> the report truncated? I'm missing 'read' part of the report... The compla=
int
> is on line:
>
> jh->b_transaction =3D transaction;
>
> I would guess the complaint is because of the check:
>
>         /*
>          * This and the following assertions are unreliable since we may =
see jh
>          * in inconsistent state unless we grab bh_state lock. But this i=
s
>          * crucial to catch bugs so let's do a reliable check until the
>          * lockless handling is fully proven.
>          */
>         if (jh->b_transaction !=3D transaction &&
>             jh->b_next_transaction !=3D transaction) {
>
> And the comment explains, why we do this unreliable check. Again, if we
> wanted to silence KCSAN, we could use data_race() macro but AFAIU Ted isn=
't
> very fond of that annotation.
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

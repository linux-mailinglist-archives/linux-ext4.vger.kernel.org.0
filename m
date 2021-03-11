Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922B4337633
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhCKOxT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 09:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhCKOxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 09:53:16 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C75C061760
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 06:53:16 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l4so20842377qkl.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHPIkhTb0LE1ggEW55e8PVY6uRKVEwz5gqVz2vI9SzE=;
        b=Bhi8px5GrHj7K2OkZ2Wd5DLPfqYMZL+TS/bR9cALnTN0U4D3gdvsgXMevrbSUujiso
         LGYW2QvD+RG1lpMw/i8N8mA7U3by86mAbbQvWZJEthBBeShXXuKlXuhWSAst+92Cyanl
         DBrt9CIENu18/doC/lTokLfTU1zDe4rveMjrKh6x6CAtSoSOmn8ls+MonlmNteWEVcTw
         Hg0aNN/YBZnR8u6774JfaGPnUz4GV12glMT5BXOmXfUswF2mwlsZkwipHPL8mMUHMR7J
         W9piEVQTJpc3+z3niHKUjYzpJ32dO1kLNpnxweCS9K+PXLR72/Xgb6aY9yScmtSQEs3H
         QPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHPIkhTb0LE1ggEW55e8PVY6uRKVEwz5gqVz2vI9SzE=;
        b=H5hWjtMa8Ss5cNZJJbzL+NH58aALrKNzKDpUwZDnj6Er1VBefayqGFcUg2fVOIZaoq
         Vct49DK5v0HBlSgh6+tQ1UOE9L7ciLas1s1zIgOb6kd/kqzzjgH7BpJjZH153o9QELp8
         Ktiy/OB/dHxFLUuP/Etaf9pagt39T4LAJoFsjnPsmErV7pIgdpWWT5M46dZ4Q6ziDSxw
         QPY4Tiez6mlAejCUEuhmxBb6OR9YojOEpz2fRrWqQ+IkM5ZujW0XZx51kLY7pOhZU2ss
         K4RHKJRS1TEsLgkfjmPfdlZ9R9W8pLTI8zTMtYk9aVMSnTI5IlYwYwJA7NZF/QSLmdlA
         TdWg==
X-Gm-Message-State: AOAM532Ubf/jVNPNDBk6zKnbHB83rSFrhuriTRJQJ5TGmxmn5MUh+X77
        8fzM6nbLtR0/EJ3okugn1xmblcTiwLhnar6y4ieeHQ==
X-Google-Smtp-Source: ABdhPJzQ3NUbCY3lw1wcdCgBzBoejG7qGizVUeuwvRYWcaZ7RpliAYL96CzGCXNPc6j5EpotIrRQTj08SX8qAheY+cY=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr7970362qko.424.1615474394860;
 Thu, 11 Mar 2021 06:53:14 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008de88005bd40ac36@google.com> <20210311142503.GA31816@quack2.suse.cz>
In-Reply-To: <20210311142503.GA31816@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 15:53:03 +0100
Message-ID: <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle / start_this_handle
To:     Jan Kara <jack@suse.cz>, Marco Elver <elver@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 11, 2021 at 3:25 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-03-21 02:59:14, syzbot wrote:
> > HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=159f69ecd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=de394bbaade74fb7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=30774a6acf6a2cf6d535
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in start_this_handle / start_this_handle
> >
> > write to 0xffff888103880870 of 8 bytes by task 29956 on cpu 1:
> >  jbd2_get_transaction fs/jbd2/transaction.c:125 [inline]
> >  start_this_handle+0xceb/0x1010 fs/jbd2/transaction.c:400
> >  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
> >  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
> >  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
> >  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
> >  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
> >  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
> >  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
> >  call_write_iter include/linux/fs.h:1977 [inline]
> >  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
> >  do_iter_write+0x112/0x4c0 fs/read_write.c:866
> >  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
> >  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
> >  do_splice_from fs/splice.c:767 [inline]
> >  direct_splice_actor+0x80/0xa0 fs/splice.c:936
> >  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
> >  do_splice_direct+0xf5/0x170 fs/splice.c:979
> >  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
> >  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
> >  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
> >  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > read to 0xffff888103880870 of 8 bytes by task 29936 on cpu 0:
> >  start_this_handle+0x1c1/0x1010 fs/jbd2/transaction.c:352
> >  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
> >  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
> >  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
> >  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
> >  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
> >  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
> >  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
> >  call_write_iter include/linux/fs.h:1977 [inline]
> >  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
> >  do_iter_write+0x112/0x4c0 fs/read_write.c:866
> >  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
> >  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
> >  do_splice_from fs/splice.c:767 [inline]
> >  direct_splice_actor+0x80/0xa0 fs/splice.c:936
> >  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
> >  do_splice_direct+0xf5/0x170 fs/splice.c:979
> >  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
> >  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
> >  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
> >  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 29936 Comm: syz-executor.5 Not tainted 5.12.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > ==================================================================
>
> So this case is harmless. start_this_handle() does indeed check
> journal->j_running_transaction without any protection and this is only a
> racy check to opportunistically preallocate a transaction if we are likely
> to need it. There was some macro to instruct KCSAN that the read is
> actually fine, wasn't there?

+Marco
+Tetsuo, did you want to fix it?

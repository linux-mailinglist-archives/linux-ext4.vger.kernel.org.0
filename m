Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA8337685
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhCKPIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 10:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhCKPIj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 10:08:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC5DC061574
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 07:08:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u16so2254544wrt.1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4x0v+FphobiCPZoiCteRtnz8+1VQaGdmjfd5nyd/Wdc=;
        b=vki9vs0wB3CnH6j3W0LYqwe/IocTQQSldUjacBRapGaCYaRe1XkE8tbQuHAHQMYBsz
         cnOpMGqlwhbeHRGrOlbI1lHdYxig9gugbDrmExal7cR5tZ007B9OtCMb5fBSAC0iMSpJ
         IRDQp34EqT+wunufBDyW1+QpOUkpEdaAHrpvfkOg0+funVcsui3TBRN8TseWIg4wDAws
         3ViJWAf1hwzJnRjU8LjgIUSA6Xq47Nj28uQ5EpYiRoklZegRu8iyFu8W0YQ0ztzJcFkp
         yDJ0vy5Qb+9y0NhK4ZtlIBJhFb4tOcN0+2RjQca0KtP6EQJycYLGCBfKZabdBNZVdeQi
         zGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4x0v+FphobiCPZoiCteRtnz8+1VQaGdmjfd5nyd/Wdc=;
        b=khf3crGuKAFrTQUC/lu6gMveIwlkPMshKlzj3KbWrLmAzUNMDkEwGMw7LSQyHuK77G
         Eup7xx48YQbawBj0H1OUqimYp804fN/jLcEA7zSsJgr/xKyQWYuazeXNJloQdrOGF4iD
         FU3/gPPZe4j0x212vvmKC1s4yRl1U/Txjxf9TAxN/vr7Qxf+89xDyx/zOdS/ACEUpFYU
         rXGypbmBg3pXmAyPXdRybnLwfcRJ9mZH4ebyYi4bRETGgfAFREzseLKcYL4qLMx0ZpRb
         96oJIxZUwOZKTExNXEiiy1uZFpYFNwTQ/dXnps8ElCCQ0Za0ugbqtyOuhcKHuDUxzCHU
         KdhQ==
X-Gm-Message-State: AOAM532yowLmWPs3zcnWyo9MAYstXLKL01wt9A+gExwKkgWeiCYb7rtw
        MGDFg6fyVGPBY/hadpRXxa3lTg==
X-Google-Smtp-Source: ABdhPJzuCixPGSspzv4RHN0XotKQY8WuFdaBRW218yk5D90ZwY41tzGbTsLADKf/ZOzww58n55lU+Q==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr9141391wrc.385.1615475316943;
        Thu, 11 Mar 2021 07:08:36 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:c064:a43:182e:6e2f])
        by smtp.gmail.com with ESMTPSA id q25sm3958848wmq.15.2021.03.11.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:08:35 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:08:30 +0100
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle /
 start_this_handle
Message-ID: <YEoybjJpCQzNx15r@elver.google.com>
References: <0000000000008de88005bd40ac36@google.com>
 <20210311142503.GA31816@quack2.suse.cz>
 <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 11, 2021 at 03:53PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 11, 2021 at 3:25 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 11-03-21 02:59:14, syzbot wrote:
> > > HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=159f69ecd00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=de394bbaade74fb7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=30774a6acf6a2cf6d535
> > > compiler:       Debian clang version 11.0.1-2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in start_this_handle / start_this_handle
> > >
> > > write to 0xffff888103880870 of 8 bytes by task 29956 on cpu 1:
> > >  jbd2_get_transaction fs/jbd2/transaction.c:125 [inline]
> > >  start_this_handle+0xceb/0x1010 fs/jbd2/transaction.c:400
> > >  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
> > >  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
> > >  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
> > >  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
> > >  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
> > >  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
> > >  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
> > >  call_write_iter include/linux/fs.h:1977 [inline]
> > >  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
> > >  do_iter_write+0x112/0x4c0 fs/read_write.c:866
> > >  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
> > >  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
> > >  do_splice_from fs/splice.c:767 [inline]
> > >  direct_splice_actor+0x80/0xa0 fs/splice.c:936
> > >  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
> > >  do_splice_direct+0xf5/0x170 fs/splice.c:979
> > >  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
> > >  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
> > >  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
> > >  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > read to 0xffff888103880870 of 8 bytes by task 29936 on cpu 0:
> > >  start_this_handle+0x1c1/0x1010 fs/jbd2/transaction.c:352
> > >  jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
> > >  __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
> > >  __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
> > >  ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
> > >  generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
> > >  ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
> > >  ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
> > >  call_write_iter include/linux/fs.h:1977 [inline]
> > >  do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
> > >  do_iter_write+0x112/0x4c0 fs/read_write.c:866
> > >  vfs_iter_write+0x4c/0x70 fs/read_write.c:907
> > >  iter_file_splice_write+0x40a/0x750 fs/splice.c:689
> > >  do_splice_from fs/splice.c:767 [inline]
> > >  direct_splice_actor+0x80/0xa0 fs/splice.c:936
> > >  splice_direct_to_actor+0x345/0x650 fs/splice.c:891
> > >  do_splice_direct+0xf5/0x170 fs/splice.c:979
> > >  do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
> > >  __do_sys_sendfile64 fs/read_write.c:1319 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1311 [inline]
> > >  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
> > >  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 29936 Comm: syz-executor.5 Not tainted 5.12.0-rc2-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > ==================================================================
> >
> > So this case is harmless. start_this_handle() does indeed check
> > journal->j_running_transaction without any protection and this is only a
> > racy check to opportunistically preallocate a transaction if we are likely
> > to need it. There was some macro to instruct KCSAN that the read is
> > actually fine, wasn't there?

If the outcome of the check does not affect correctness and the code is
entirely fault tolerant to the precise value being read, then a
data_race(!journal->j_running_transaction) marking here would be fine.

If in doubt, this is the latest summary for concurrent access markings:
https://lkml.kernel.org/r/20210220051000.GA457@paulmck-ThinkPad-P72

> +Marco
> +Tetsuo, did you want to fix it?

Thanks,
-- Marco

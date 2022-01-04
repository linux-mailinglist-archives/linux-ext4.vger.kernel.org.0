Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56234866F8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiAFPpz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 10:45:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47262 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240602AbiAFPpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 10:45:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A41F21F3A3;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWPrwj05ixeuJKYFYuqtZ9JmRiHgMfpX+u/e4iItUFY=;
        b=bRAEWcB2eJasuBXVNBrCbY+kGN3dgE+cxVVqP5cJTPu5uyOchEpEqxB0f761IbmVGTflOY
        ZPc/XptVo2yGycSRe+IFdi0rwRH0PjutEAhsKpNSZZY5rNFHU4iYvJnxgE/7MZYDvKd8/l
        04JYQtjADdZjv9p8yy/Q4SEJzwSSOac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWPrwj05ixeuJKYFYuqtZ9JmRiHgMfpX+u/e4iItUFY=;
        b=t0h90VH8gtsoPQBKbtAde6oYnrH4FzelCbEaSe0t4irX/MlVd+x5SC2rggJvTqUii2J7lo
        5Fo09MGcfNayv9BQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88F3CA3B83;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id 46728A05D7; Tue,  4 Jan 2022 15:33:16 +0100 (CET)
Date:   Tue, 4 Jan 2022 15:33:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     kvartet <xyru1999@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, sunhao.th@gmail.com
Subject: Re: INFO: task hung in add_transaction_credits
Message-ID: <20220104143316.caxoubywrppk6qb7@quack3.lan>
References: <CAFkrUshr_89Kdax0bJb6BHAZhLgzkkJOxY45Cci7UwzQ6TmiRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkrUshr_89Kdax0bJb6BHAZhLgzkkJOxY45Cci7UwzQ6TmiRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 04-01-22 18:30:47, kvartet wrote:
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.
> 
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: https://paste.ubuntu.com/p/N2WMbfsc5s/plain/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yiru Xu <xyru1999@gmail.com>

Thanks for report. I had a look into the stacktraces. What is clear is that
there are several processes waiting in wait_transaction_locked() meaning
that we want to commit a transaction and wait while there are still active
handles attached to the transaction. I can also infer that the process
holding the handle for the transaction is:

4 locks held by syz-executor.1/20606:
 #0: ffff88810c7ec460 (sb_writers#5){.+.+}-{0:0}, at:
filename_create+0xf3/0x490 fs/namei.c:3649
 #1: ffff888028ff7198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff888028ff7198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
filename_create+0x158/0x490 fs/namei.c:3654
 #2: ffff88810c7f8990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0xf58/0x1360 fs/jbd2/transaction.c:466
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
i_mmap_lock_read include/linux/fs.h:513 [inline]
 #3: ffff8880287f2e28 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
rmap_walk_file+0x86d/0xc20 mm/rmap.c:2345

What is not obvious though is why this task is blocked and does not
eventually release the transaction handle. For that we would need a
stacktrace of this task...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

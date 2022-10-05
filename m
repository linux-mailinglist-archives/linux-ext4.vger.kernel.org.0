Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9A5F5725
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Oct 2022 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJEPK7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Oct 2022 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJEPK4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Oct 2022 11:10:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381F6E2C1
        for <linux-ext4@vger.kernel.org>; Wed,  5 Oct 2022 08:10:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C03221908;
        Wed,  5 Oct 2022 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664982654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJ8T0628CAm/q1s7Mr4NAQYrSudhCB97pVlh8zKySrg=;
        b=X/E60drRzi/3gdn15x9tb2pHuROgPZCWp8Xva0Vzv+65089iLj5ExD2b/Kt+OIVfy3+9zx
        L1NE4Re3iKjBq7H3jHAIFX6lAnOnWbqeF1T6d2eyjpPecWu/QVHYf+S1NBQpnOoxKj0J6q
        taQMo5YdsEf2+VYTxGnwCVGyLzs7LAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664982654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJ8T0628CAm/q1s7Mr4NAQYrSudhCB97pVlh8zKySrg=;
        b=8kQZwZLwNlDvtCeQ7ySXhfi72ECgXyZTK1HCJKWbU5nXw0DZh8oZ4D9wmX7q1BFHQ09xcP
        LBzVuYdzDdyJBJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1831A13ABD;
        Wed,  5 Oct 2022 15:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i0TfBX6ePWPfOAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Oct 2022 15:10:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8BA85A0680; Wed,  5 Oct 2022 17:10:53 +0200 (CEST)
Date:   Wed, 5 Oct 2022 17:10:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, tytso@mit.edu,
        Ye Bin <yebin10@huawei.com>, linux-ext4@vger.kernel.org,
        regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221005151053.7jjgc7uhvquo6a5n@quack3>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Thilo!

On Tue 04-10-22 16:21:12, Thilo Fromm wrote:
> On 04/10/2022 11:10, Jan Kara wrote:
> > Hello!
> > 
> > On Mon 03-10-22 23:38:07, Jeremi Piotrowski wrote:
> > > On Thu, Sep 29, 2022 at 03:18:21PM +0200, Thilo Fromm wrote:
> > > > Thank you very much for your thorough feedback. We were unaware of
> > > > the backtrace issue and will have a look at once.
> > > > 
> > > > > > > So this seems like a real issue. Essentially, the problem is that
> > > > > > > ext4_bmap() acquires inode->i_rwsem while its caller
> > > > > > > jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
> > > > > > > looks like a real deadlock possibility.
> > > > > > 
> [...]
> > > > > > The issue can be triggered on Flatcar release 3227.2.2 / kernel version
> > > > > > 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
> > > > > > 51ae846cff5 was introduced to 5.15 in 5.15.61.
> > > > > 
> > > > > Well, so far your stacktraces do not really show anything pointing to that
> > > > > particular commit. So we need to understand that hang some more.
> > > > 
> > > > This makes sense and I agree. Sorry for the garbled stack traces.
> > > > 
> > > > In other news, one of our users - who can reliably trigger the issue
> > > > in their set-up - ran tests with kernel 5.15.63 with and without
> > > > commit 51ae846cff5. Without the commit, the kernel hang did not
> > > > occur (see https://github.com/flatcar/Flatcar/issues/847#issuecomment-1261967920).
> > > > 
> [...]
> > > So our stacktraces were mangled because historically our kernel build used
> > > INSTALL_MOD_STRIP=--strip-unneeded, we've now switched it back to --strip-debug
> > > which is the default. We're still using CONFIG_UNWINDER_ORC=y.
> > > 
> > > Here's the hung task output after the change to stripping:
> > 
> > Yeah, the stacktraces now look as what I'd expect. Thanks for fixing that!
> > Sadly they don't point to the culprit of the problem. They show jbd2/sda9-8
> > is waiting for someone to drop its transaction handle. Other processes are
> > waiting for jbd2/sda9-8 to commit a transaction. And then a few processes
> > are waiting for locks held by these waiting processes. But I don't see
> > anywhere the process holding the transaction handle. Can you please
> > reproduce the problem once more and when the system hangs run:
> > 
> > echo w >/proc/sysrq-trigger
> > 
> > Unlike softlockup detector, this will dump all blocked task so hopefully
> > we'll see the offending task there. Thanks!
> 
> Thank you for the feedback! We forwarded your request to our user with the
> reliable repro case, at https://github.com/flatcar/Flatcar/issues/847;
> please find their blocked tasks output below.

Thanks for the stacktraces. 

> [ 3451.530765] sysrq: Show Blocked State
> [ 3451.534632] task:jbd2/sda9-8     state:D stack:    0 pid:  704 ppid:    2
> flags:0x00004000
> [ 3451.543107] Call Trace:
> [ 3451.545671]  <TASK>
> [ 3451.547888]  __schedule+0x2eb/0x8d0
> [ 3451.551491]  schedule+0x5b/0xd0
> [ 3451.554749]  jbd2_journal_commit_transaction+0x301/0x18e0 [jbd2]
> [ 3451.560881]  ? wait_woken+0x70/0x70
> [ 3451.564485]  ? lock_timer_base+0x61/0x80
> [ 3451.568524]  kjournald2+0xab/0x270 [jbd2]
> [ 3451.572657]  ? wait_woken+0x70/0x70
> [ 3451.576258]  ? load_superblock.part.0+0xb0/0xb0 [jbd2]
> [ 3451.581526]  kthread+0x124/0x150
> [ 3451.584874]  ? set_kthread_struct+0x50/0x50
> [ 3451.589177]  ret_from_fork+0x1f/0x30
> [ 3451.592887]  </TASK>

So again jdb2 waiting for the transaction handle to be dropped. The task
having the handle open is:

> [ 3473.580964] task:containerd      state:D stack:    0 pid:92591 ppid:
> 70946 flags:0x00004000
> [ 3473.589432] Call Trace:
> [ 3473.591997]  <TASK>
> [ 3473.594209]  ? ext4_mark_iloc_dirty+0x56a/0xaf0 [ext4]
> [ 3473.599518]  ? __schedule+0x2eb/0x8d0
> [ 3473.603301]  ? _raw_spin_lock_irqsave+0x36/0x50
> [ 3473.607947]  ? __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 3473.613393]  ? __wait_on_bit_lock+0x40/0xb0
> [ 3473.617689]  ? out_of_line_wait_on_bit_lock+0x92/0xb0
> [ 3473.622854]  ? var_wake_function+0x30/0x30
> [ 3473.627062]  ? ext4_xattr_block_set+0x865/0xf00 [ext4]
> [ 3473.632346]  ? ext4_xattr_set_handle+0x48e/0x630 [ext4]
> [ 3473.637718]  ? ext4_initxattrs+0x43/0x60 [ext4]
> [ 3473.642389]  ? security_inode_init_security+0xab/0x140
> [ 3473.647640]  ? ext4_init_acl+0x170/0x170 [ext4]
> [ 3473.652315]  ? __ext4_new_inode+0x11f7/0x1710 [ext4]
> [ 3473.657430]  ? ext4_create+0x115/0x1d0 [ext4]
> [ 3473.661935]  ? path_openat+0xf48/0x1280
> [ 3473.665888]  ? do_filp_open+0xa9/0x150
> [ 3473.669751]  ? vfs_statx+0x74/0x130
> [ 3473.673359]  ? __check_object_size+0x146/0x160
> [ 3473.677917]  ? do_sys_openat2+0x9b/0x160
> [ 3473.681953]  ? __x64_sys_openat+0x54/0xa0
> [ 3473.686076]  ? do_syscall_64+0x38/0x90
> [ 3473.689942]  ? entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 3473.695281]  </TASK>

Which seems to be waiting on something in ext4_xattr_block_set(). This
"something" is not quite clear because the stacktrace looks a bit
unreliable at the top - either it is a buffer lock or we are waiting for
xattr block reference usecount to decrease (which would kind of make sense
because there were changes to ext4 xattr block handling in the time window
where the lockup started happening).

Can you try to feed the stacktrace through addr2line utility (it will need
objects & debug symbols for the kernel)? Maybe it will show something
useful...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

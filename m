Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4A5FEE8F
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Oct 2022 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJNNZt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Oct 2022 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJNNZs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Oct 2022 09:25:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE6240A5
        for <linux-ext4@vger.kernel.org>; Fri, 14 Oct 2022 06:25:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28129219EF;
        Fri, 14 Oct 2022 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665753944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYGyYKY4kfrl3Y8WRctWhq19+xsfDBRbNo848N/HW5s=;
        b=BiZKppnM/JBw5uvuc9m+zvA04230ppl6HfaH/OSQ4WzzwuxDDWv1VhR/L2dQ9A1VGmeDFY
        dVihyOIRJp7rhmf+i1otpdKt2YE/ooCJOc5LsY/h2TYBsNyXwF5HTC5XKZmVDG7Ap8Df/g
        mOmiV3x2EnEdvg5o9UDNZFJNQo3x0lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665753944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYGyYKY4kfrl3Y8WRctWhq19+xsfDBRbNo848N/HW5s=;
        b=bxkMRQ8TXl9rWa1Z48QEhEtzxtWUrE1oGxXvlqj+4AUtPR/uEOUToP0nl0WMZIOK3JrR4+
        R6TDw9UtDd2cHCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A14F13451;
        Fri, 14 Oct 2022 13:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x2ZTBlhjSWMYKwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Oct 2022 13:25:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98FFFA06F1; Fri, 14 Oct 2022 15:25:43 +0200 (CEST)
Date:   Fri, 14 Oct 2022 15:25:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221014132543.i3aiyx4ent4qwy4i@quack3>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Fri 14-10-22 08:42:57, Thilo Fromm wrote:
> Just want to make sure this does not get lost - as mentioned earlier,
> reverting 51ae846cff5 leads to a kernel build that does not have this issue.

Yes, I'm aware of this and still cannot quite wrap my head how it could be
given the stacktraces I see :) They do not seem to come anywhere near that
code...

> > Sure, I think this worked fine. It's the buffer lock but right before it we're
> > opening a journal transaction. Symbolized it looks like this:
> > 
> >    ext4_mark_iloc_dirty (include/linux/buffer_head.h:308 fs/ext4/inode.c:5712) ext4
> >    __schedule (kernel/sched/core.c:4994 kernel/sched/core.c:6341)
> >    _raw_spin_lock_irqsave (arch/x86/include/asm/paravirt.h:585 arch/x86/include/asm/qspinlock.h:51 include/asm-generic/qspinlock.h:85 include/linux/spinlock.h:199 include/linux/spinlock_api_smp.h:119 kernel/locking/spinlock.c:162)
> >    __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:105) ext4
> >    __wait_on_bit_lock (arch/x86/include/asm/bitops.h:214 include/asm-generic/bitops/instrumented-non-atomic.h:135 kernel/sched/wait_bit.c:89)
> >    out_of_line_wait_on_bit_lock (kernel/sched/wait_bit.c:118)
> >    var_wake_function (kernel/sched/wait_bit.c:22)
> >    ext4_xattr_block_set (include/linux/buffer_head.h:391 fs/ext4/xattr.c:2019) ext4
> >    ext4_xattr_set_handle (fs/ext4/xattr.c:2395) ext4
> >    ext4_initxattrs (fs/ext4/xattr_security.c:48) ext4
> >    security_inode_init_security (security/security.c:1114)
> >    ext4_init_acl (fs/ext4/xattr_security.c:38) ext4
> >    __ext4_new_inode (fs/ext4/ialloc.c:1325) ext4
> >    ext4_create (fs/ext4/namei.c:2796) ext4
> >    path_openat (fs/namei.c:3334 fs/namei.c:3404 fs/namei.c:3612)
> >    do_filp_open (fs/namei.c:3642)
> >    vfs_statx (include/linux/namei.h:57 fs/stat.c:221)
> >    __check_object_size (mm/usercopy.c:240 mm/usercopy.c:286 mm/usercopy.c:256)
> >    do_sys_openat2 (fs/open.c:1214)
> >    __x64_sys_openat (fs/open.c:1241)
> >    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:118)
> 
> Is the symbolised stack trace Jeremi sent helpful to get to the bottom of
> this issue? Can we do anything else to help?

Yes, thanks for the symbolized stacktraces and sorry for the delay. It made
it clear we are hanging on buffer lock. So far I still don't understand the
deadlock scenario (in particular who can be holding the buffer locked)
and I'm busy with something else at SUSE to seriously dwelve into this but
I'll get back to you :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

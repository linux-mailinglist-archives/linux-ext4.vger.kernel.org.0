Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8F7286A6
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjFHRw7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFHRw6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 13:52:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77804172E;
        Thu,  8 Jun 2023 10:52:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 280AF2199E;
        Thu,  8 Jun 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686246775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+CZRWCtT+JtzNM6t0kOZY8HfGmvHn0sBUMaKydCgTQ=;
        b=wFWxHYveLEliWWFkr6GGWcetd0YL6jYsXgSKerhMUdHpx6hHwEdagI/s13g6r4IRWNR4lA
        Lui1rkX2fobb3WMlLuWnDfrDVXpjr4niQupeZCEV7K1KGIWV+LuK6Bt6WV5q3CHebm101Y
        62/FOXaB0c1NDmT3Ivc6wO1QEjT0/Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686246775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+CZRWCtT+JtzNM6t0kOZY8HfGmvHn0sBUMaKydCgTQ=;
        b=w+okyK0CT2LSpGsHIbvIxDwjzj3XLrkOuPzMw8CrbbrT+sBxG4dK2FA0pibSrRUCU4b9IT
        bld2XhEWRQZLGxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01C7613480;
        Thu,  8 Jun 2023 17:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9a1kAHcVgmSbWgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 17:52:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0DC1BA0749; Thu,  8 Jun 2023 19:52:54 +0200 (CEST)
Date:   Thu, 8 Jun 2023 19:52:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ext4 Development <linux-ext4@vger.kernel.org>,
        Nikolas Kraetzschmar <nikolas.kraetzschmar@sap.com>,
        Linux Stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Fwd: Remounting ext4 filesystem from ro to rw fails when quotas
 are enabled
Message-ID: <20230608175254.uacmrwz5i2cwrdmu@quack3>
References: <653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com>
 <20230608044056.GA1418535@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608044056.GA1418535@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-06-23 00:40:56, Theodore Ts'o wrote:
> On Wed, Jun 07, 2023 at 12:51:26PM +0700, Bagas Sanjaya wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> > > Since commit a44be64, remounting a read-only ext4 filesystem to
> > > become read-write fails when quotas are enabled. The mount syscall
> > > returns -EROFS and outputs the following in dmesg:
> 
> Yeah, and I think all we can do is revert this commit:
> 
>     ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled
> 
> I think I saw some messages go by about this getting queued for the
> stable kernel; if so, could it please be dropped?

Yeah, for now I'd revert the fix. It needs more thought and it is not like
it is fixing any serious vulnerability or so.

> > > The problem can be traced back to the changes introduced in commit
> > > a44be64. It appears that the issue arises because the SB_RDONLY
> > > bit of the s_flags field is now only cleared after executing the
> > > ext4_enable_quotas function. However, the vfs_setup_quota_inode
> > > function, called by ext4_enable_quotas, checks whether this bit is
> > > set (fs/quota/dquot.c:2331):
> 
> The problem that we're trying to solve is the malicious syzbot
> reproducer is in one thread, twiddling the file system state from r/o
> to rw and back.  In another thread, it's attempt to create files and
> directories.   And occasionally, we're tripping this warning:
> 
> 	WARN_ON_ONCE(dquot_initialize_needed(inode));
> 
> That's because we're racing with the quota getting initialized, and
> the moment we clear the SB_RDONLY bit the thread which is trying to
> create a directory or file will proceed with the operation --- even
> though the quota subsystem hasn't been initialized yet.  That's why
> the patch attempted to move the clearing the SB_RDONLY bit ahead of
> reiniitalization of the quota subsystem.
> 
> Since this is screwing up the ability to remount the file system rw,
> we need to revert this commit, at which point, we'll be able to
> trigger this warning again.
> 
> So how do we fix the warning?  Well, we could just drop the
> WARN_ON_ONCE(); the downside is that when this race gets hit, the
> quota operations to allocate the block and inode will silently become
> a no-op, which means the quota will get out of sync with reality.

Yes, the warning triggering is actually a good thing because it shows us we
have a race where quota can get out of sync with real space usage.

> Alternatively, we could add a call to the beginning to
> ext4_xattr_block_Set():
> 
> 	if (dquot_initialize_needed(inode))
> 		reutrn -EROFS;
> 
> ... on the theory that the only time we should hit this is when there
> is a quota setup racing with inode creation, and it's better that we
> just let the mkdir or open with O_CREAT fail than to succeed, and
> allocate blocks before the quota subsystem has been initialized.  I'm
> not sure how safe this would be on older quota setups (pre-ext4 quota
> feature), since I suspect the race window is a quite a bit bigger if I
> understand correctly how things worked with the legacy quota support.

No, xattr code is just a messenger here. There is a fundamental problem
that once we clear SB_RDONLY in superblock flags, anybody can come up with
any operation modifying the filesystem but until we are finished with
dquot_resume(), this operation can escape proper quota accounting.

> The final really hacky thing I could imagine is to hack
> dquot_initialize() to something like this:
> 
> int dquot_initialize(struct inode *inode)
> {
> 	ret = __dquot_initialize(inode, -1);
> 	if (ret)
> 		return ret;
> 	if (dquot_initialize_needed(inode)) {
> 		msleep(1000)
> 		return __dquot_initialize(inode, -1);
> 	}
> 	return 0;
> }
> 
> But I threw up a little in my mouth while writing it....
> 
> So I'm tempted to just remove the WARN_ON's, and just accept that if
> superuser wants to twiddle the read/only state of a file system with
> quota, at high rates, while something else is trying to create
> files/directories, most of which will fail while the file system is
> read-only, then the quota may gets out of sync, and... ¯\_(ツ)_/¯
> 
> Since this is only something that crazy people or malicious Syzbot
> reproducers would try to do, I'm really having a hard time bringing
> myself to care.  Especially since we have plenty of other places where
> we aren't doing the dquot_initialize_needed() check, so the
> opportunities for the quota to get out of sync already exist in other
> code paths.
> 
> Jan, what do you think?

Well, I think we should fix this properly. The problem is that currently
changing read-only state is just flipping the flag but we need an
intermediate state like "superblock is really RW but for userspace it is
RO" so that we can prepare the filesystem for taking the writes - in fact
we've already faced very similar problem with orphan replay but there we've
worked around it by forbidding orphan replay on remount and playing a bit
hacky games on mount.

I think I can see a way to solve this problem. I'll send patches.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

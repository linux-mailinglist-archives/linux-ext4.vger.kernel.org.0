Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004FC72763E
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 06:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjFHElX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 00:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjFHElW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 00:41:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6F1988
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 21:41:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3584euUk006748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 00:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686199259; bh=PrkgoFChjjS/t6u7nUUd0Q1FegS/n9GQDkTMlzso8ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WUEiQBUhZRUSLgSW0x2RfgsormeTtlzVD+EQpDXfT5Y/Lzc2XYFpkskpUkfDqSlJY
         7ZPipKOJ20PMDF1x8IMRURM5Rd9sjAS5v29ym1pH6IBxbWG8qJ4QEjqJG5YYaDUKR/
         ux8/P6p2b1Wo2yJblHp0SkLV4DOPxFunChWzUsjCWO7L6ZpMB5Q4HbTIMBNR9QVJtR
         xlE4Fy1yDXHIUT8h04Hm6ypp9f4f7rC1KUWVcEJHQz8kYnAtwwl0oYqbde8DzTnP6+
         tDupzFEWWFOv9c5b4zpUm+6Xmqp0XdgFXnRWcabtybrpUFDxNZsBJpjpa9ruTPQbvB
         8l6gghFuRk+hQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 73EA615C04C3; Thu,  8 Jun 2023 00:40:56 -0400 (EDT)
Date:   Thu, 8 Jun 2023 00:40:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ext4 Development <linux-ext4@vger.kernel.org>,
        Nikolas Kraetzschmar <nikolas.kraetzschmar@sap.com>,
        Linux Stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Fwd: Remounting ext4 filesystem from ro to rw fails when quotas
 are enabled
Message-ID: <20230608044056.GA1418535@mit.edu>
References: <653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 07, 2023 at 12:51:26PM +0700, Bagas Sanjaya wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > Since commit a44be64, remounting a read-only ext4 filesystem to
> > become read-write fails when quotas are enabled. The mount syscall
> > returns -EROFS and outputs the following in dmesg:

Yeah, and I think all we can do is revert this commit:

    ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled

I think I saw some messages go by about this getting queued for the
stable kernel; if so, could it please be dropped?

> > 
> > The problem can be traced back to the changes introduced in commit
> > a44be64. It appears that the issue arises because the SB_RDONLY
> > bit of the s_flags field is now only cleared after executing the
> > ext4_enable_quotas function. However, the vfs_setup_quota_inode
> > function, called by ext4_enable_quotas, checks whether this bit is
> > set (fs/quota/dquot.c:2331):

The problem that we're trying to solve is the malicious syzbot
reproducer is in one thread, twiddling the file system state from r/o
to rw and back.  In another thread, it's attempt to create files and
directories.   And occasionally, we're tripping this warning:

	WARN_ON_ONCE(dquot_initialize_needed(inode));

That's because we're racing with the quota getting initialized, and
the moment we clear the SB_RDONLY bit the thread which is trying to
create a directory or file will proceed with the operation --- even
though the quota subsystem hasn't been initialized yet.  That's why
the patch attempted to move the clearing the SB_RDONLY bit ahead of
reiniitalization of the quota subsystem.

Since this is screwing up the ability to remount the file system rw,
we need to revert this commit, at which point, we'll be able to
trigger this warning again.

So how do we fix the warning?  Well, we could just drop the
WARN_ON_ONCE(); the downside is that when this race gets hit, the
quota operations to allocate the block and inode will silently become
a no-op, which means the quota will get out of sync with reality.

Alternatively, we could add a call to the beginning to
ext4_xattr_block_Set():

	if (dquot_initialize_needed(inode))
		reutrn -EROFS;

... on the theory that the only time we should hit this is when there
is a quota setup racing with inode creation, and it's better that we
just let the mkdir or open with O_CREAT fail than to succeed, and
allocate blocks before the quota subsystem has been initialized.  I'm
not sure how safe this would be on older quota setups (pre-ext4 quota
feature), since I suspect the race window is a quite a bit bigger if I
understand correctly how things worked with the legacy quota support.

The final really hacky thing I could imagine is to hack
dquot_initialize() to something like this:

int dquot_initialize(struct inode *inode)
{
	ret = __dquot_initialize(inode, -1);
	if (ret)
		return ret;
	if (dquot_initialize_needed(inode)) {
		msleep(1000)
		return __dquot_initialize(inode, -1);
	}
	return 0;
}

But I threw up a little in my mouth while writing it....

So I'm tempted to just remove the WARN_ON's, and just accept that if
superuser wants to twiddle the read/only state of a file system with
quota, at high rates, while something else is trying to create
files/directories, most of which will fail while the file system is
read-only, then the quota may gets out of sync, and... ¯\_(ツ)_/¯

Since this is only something that crazy people or malicious Syzbot
reproducers would try to do, I'm really having a hard time bringing
myself to care.  Especially since we have plenty of other places where
we aren't doing the dquot_initialize_needed() check, so the
opportunities for the quota to get out of sync already exist in other
code paths.

Jan, what do you think?

					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761A4F810F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 15:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiDGN5x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDGN5w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 09:57:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191CFABC3
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 06:55:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF6D3212B7;
        Thu,  7 Apr 2022 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649339747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04hNhPzcq2v6Jo68rBdfbRUVG/Zw5oJmc+FDWmRJBbw=;
        b=nPTDyGtquAro1yKkLF0Am7hztjl0RWEcqFbEX8sSFf5NGh/3KNtiCYh7wRKhs9N0gvNKfW
        D9jO+NDtZY3n7sFMObWq5s/6Ozwf1gtVpftlfdoa+cPAGa9QMBYWN2gRbcY5SfYd4PGD29
        m4dApJB5Ef/kJEvxWMbI8nHlXXyTpLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649339747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04hNhPzcq2v6Jo68rBdfbRUVG/Zw5oJmc+FDWmRJBbw=;
        b=MhEeugRDL5NgdD3RB2YDMQ5pJkIUkyaAAGX4j9Nh3aSoy/pcnj1cr/g69cPVHqu6r12o7P
        AzlZpuX31B5ryuBw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8F82A3B82;
        Thu,  7 Apr 2022 13:55:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CEB3BA061A; Thu,  7 Apr 2022 15:55:41 +0200 (CEST)
Date:   Thu, 7 Apr 2022 15:55:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com, yebin10@huawei.com
Subject: Re: [RFC PATCH] ext4: convert symlink external data block mapping to
 bdev
Message-ID: <20220407135541.i765244kahb6lgqz@quack3.lan>
References: <20220406084503.1961686-1-yi.zhang@huawei.com>
 <20220406171715.35euuzocoe4ljepe@quack3.lan>
 <806b63ff-975d-123d-5925-587aa026ce94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806b63ff-975d-123d-5925-587aa026ce94@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 07-04-22 16:14:24, Zhang Yi wrote:
> 
> 
> On 2022/4/7 1:17, Jan Kara wrote:
> > On Wed 06-04-22 16:45:03, Zhang Yi wrote:
> >> Symlink's external data block is one kind of metadata block, and now
> >> that almost all ext4 metadata block's page cache (e.g. directory blocks,
> >> quota blocks...) belongs to bdev backing inode except the symlink. It
> >> is essentially worked in data=journal mode like other regular file's
> >> data block because probably in order to make it simple for generic VFS
> >> code handling symlinks or some other historical reasons, but the logic
> >> of creating external data block in ext4_symlink() is complicated. and it
> >> also make things confused if user do not want to let the filesystem
> >> worked in data=journal mode. This patch convert the final exceptional
> >> case and make things clean, move the mapping of the symlink's external
> >> data block to bdev like any other metadata block does.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >> This RFC patch follow the talking of whether if we could unify the
> >> journal mode of ext4 metadata blocks[1], it stop using the data=journal
> >> mode for the final exception case of symlink's external data block. Any
> >> comments are welcome, thanks.
> >>
> >> [1]. https://lore.kernel.org/linux-ext4/20220321151141.hypnhr6o4vng2sa6@quack3.lan/T/#m84b942a6bb838ba60ae8afd906ebbb987a577488
> >>
> >>  fs/ext4/inode.c   |   9 +---
> >>  fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
> >>  fs/ext4/symlink.c |  44 ++++++++++++++---
> >>  3 files changed, 93 insertions(+), 83 deletions(-)
> > 
> > Hum, we don't save on code but I'd say the result is somewhat more
> > standard. So I guess this makes some sense. Let's see what Ted thinks...
> > 
> > Otherwise I've found just one small bug below.
> > 
> >> @@ -3270,26 +3296,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >>  	if (err)
> >>  		return err;
> >>  
> >> -	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> >> -		/*
> >> -		 * For non-fast symlinks, we just allocate inode and put it on
> >> -		 * orphan list in the first transaction => we need bitmap,
> >> -		 * group descriptor, sb, inode block, quota blocks, and
> >> -		 * possibly selinux xattr blocks.
> >> -		 */
> >> -		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> >> -			  EXT4_XATTR_TRANS_BLOCKS;
> >> -	} else {
> >> -		/*
> >> -		 * Fast symlink. We have to add entry to directory
> >> -		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
> >> -		 * allocate new inode (bitmap, group descriptor, inode block,
> >> -		 * quota blocks, sb is already counted in previous macros).
> >> -		 */
> >> -		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> >> -			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> >> -	}
> >> -
> >> +	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> >> +		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> > 
> > This does not seem like enough credits - we may need to allocate inode, add
> > entry to directory, allocate & initialize symlink block. So I think you
> > need to add 4 for block allocation + init in case of non-fast symlink. And
> > please keep the comment explaining what is actually counted in the number
> > of credits...
> > 
> 
> Thanks for pointing this out, and ext4_mkdir() seems has the same problem
> too because we also need to allocate one more block to store '.' and '..'
> entries for a new created empty directory.

OK, I was thinking a bit more about this and the comment was actually a bit
misleading AFAICT. So we have:

EXT4_INDEX_EXTRA_TRANS_BLOCKS for addition of entry into the directory.
+3 for inode, inode bitmap, group descriptor allocation
EXT4_DATA_TRANS_BLOCKS for the data block allocation and modification.

So things actually look OK, just the comment was wrong and in the old code
the credits were overestimated (because we've allocated the data block in a
separate transaction).

> BTW, look the credits calculation in depth, the definition of
> EXT4_DATA_TRANS_BLOCKS is weird, the '-2' subtraction looks wrong.
> 
> > #define EXT4_DATA_TRANS_BLOCKS(sb)	(EXT4_SINGLEDATA_TRANS_BLOCKS(sb) + \
> > 					 EXT4_XATTR_TRANS_BLOCKS - 2 + \
> > 					 EXT4_MAXQUOTAS_TRANS_BLOCKS(sb))
> 
> I see the history log, before commit[1], the '-2' subtract the 2 more duplicate
> counted super block in '3 * EXT3_SINGLEDATA_TRANS_BLOCKS', but after this commit,
> it seems buggy because we have only count the super block once. It's a long time
> ago, I'm not sure am I missing something?

Yes, -2 looks strange but at the same time I fail to see why
EXT4_XATTR_TRANS_BLOCKS would need to be accounted for normal data
operation and why we're reserving 6 blocks there. I'll raise it on today's
ext4 call if someone remembers...

> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=2df2c24aa6d2cd56777570d96494b921568b4405

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

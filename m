Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D014FB563
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Apr 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiDKH5S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Apr 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiDKH5R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Apr 2022 03:57:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71E13D0D
        for <linux-ext4@vger.kernel.org>; Mon, 11 Apr 2022 00:55:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A03B21112;
        Mon, 11 Apr 2022 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649663702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S7Cw3jfJ9OL+oN6LILTNCbmYsPfwbupfI3IkW5Q6Beg=;
        b=fCthXnS+E73SaogPvVu4RKgb242nlkfRH3x4YlAW2He161HqsepqUMuOukVqa5SrstWbd/
        Z5fHt6SEtXAghz5VtHbP1G7mhOLTu7DHF5TzhlsxfGhazz9bxkmeUzoogelXuUvQOCg+Zv
        yM8Hzdh3JuKONhMHDEUtvHR+LmppmNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649663702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S7Cw3jfJ9OL+oN6LILTNCbmYsPfwbupfI3IkW5Q6Beg=;
        b=RS7xIC7aEDKjfY8D/LJmJtdf8sXxceq8X7k2v41OniDB/Rh2Wg6pPs0nsQZOGMslAhecFI
        76aHDriyvaKqC7Bg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2571AA3B89;
        Mon, 11 Apr 2022 07:55:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B5EF2A061B; Mon, 11 Apr 2022 09:55:00 +0200 (CEST)
Date:   Mon, 11 Apr 2022 09:55:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com, yebin10@huawei.com
Subject: Re: [RFC PATCH] ext4: convert symlink external data block mapping to
 bdev
Message-ID: <20220411075500.a3as6yp7nxjmru5i@quack3.lan>
References: <20220406084503.1961686-1-yi.zhang@huawei.com>
 <20220406171715.35euuzocoe4ljepe@quack3.lan>
 <806b63ff-975d-123d-5925-587aa026ce94@huawei.com>
 <20220407135541.i765244kahb6lgqz@quack3.lan>
 <515c6bbe-ae01-0256-1ae2-128dd0620fb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <515c6bbe-ae01-0256-1ae2-128dd0620fb3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 08-04-22 13:45:24, Zhang Yi wrote:
> On 2022/4/7 21:55, Jan Kara wrote:
> > On Thu 07-04-22 16:14:24, Zhang Yi wrote:
> >> On 2022/4/7 1:17, Jan Kara wrote:
> >>> On Wed 06-04-22 16:45:03, Zhang Yi wrote:
> >>>> Symlink's external data block is one kind of metadata block, and now
> >>>> that almost all ext4 metadata block's page cache (e.g. directory blocks,
> >>>> quota blocks...) belongs to bdev backing inode except the symlink. It
> >>>> is essentially worked in data=journal mode like other regular file's
> >>>> data block because probably in order to make it simple for generic VFS
> >>>> code handling symlinks or some other historical reasons, but the logic
> >>>> of creating external data block in ext4_symlink() is complicated. and it
> >>>> also make things confused if user do not want to let the filesystem
> >>>> worked in data=journal mode. This patch convert the final exceptional
> >>>> case and make things clean, move the mapping of the symlink's external
> >>>> data block to bdev like any other metadata block does.
> >>>>
> >>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>>> ---
> >>>> This RFC patch follow the talking of whether if we could unify the
> >>>> journal mode of ext4 metadata blocks[1], it stop using the data=journal
> >>>> mode for the final exception case of symlink's external data block. Any
> >>>> comments are welcome, thanks.
> >>>>
> >>>> [1]. https://lore.kernel.org/linux-ext4/20220321151141.hypnhr6o4vng2sa6@quack3.lan/T/#m84b942a6bb838ba60ae8afd906ebbb987a577488
> >>>>
> >>>>  fs/ext4/inode.c   |   9 +---
> >>>>  fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
> >>>>  fs/ext4/symlink.c |  44 ++++++++++++++---
> >>>>  3 files changed, 93 insertions(+), 83 deletions(-)
> >>>
> >>> Hum, we don't save on code but I'd say the result is somewhat more
> >>> standard. So I guess this makes some sense. Let's see what Ted thinks...
> >>>
> >>> Otherwise I've found just one small bug below.
> >>>
> >>>> @@ -3270,26 +3296,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >>>>  	if (err)
> >>>>  		return err;
> >>>>  
> >>>> -	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> >>>> -		/*
> >>>> -		 * For non-fast symlinks, we just allocate inode and put it on
> >>>> -		 * orphan list in the first transaction => we need bitmap,
> >>>> -		 * group descriptor, sb, inode block, quota blocks, and
> >>>> -		 * possibly selinux xattr blocks.
> >>>> -		 */
> >>>> -		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> >>>> -			  EXT4_XATTR_TRANS_BLOCKS;
> >>>> -	} else {
> >>>> -		/*
> >>>> -		 * Fast symlink. We have to add entry to directory
> >>>> -		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
> >>>> -		 * allocate new inode (bitmap, group descriptor, inode block,
> >>>> -		 * quota blocks, sb is already counted in previous macros).
> >>>> -		 */
> >>>> -		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> >>>> -			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> >>>> -	}
> >>>> -
> >>>> +	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> >>>> +		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> >>>
> >>> This does not seem like enough credits - we may need to allocate inode, add
> >>> entry to directory, allocate & initialize symlink block. So I think you
> >>> need to add 4 for block allocation + init in case of non-fast symlink. And
> >>> please keep the comment explaining what is actually counted in the number
> >>> of credits...
> >>>
> >>
> >> Thanks for pointing this out, and ext4_mkdir() seems has the same problem
> >> too because we also need to allocate one more block to store '.' and '..'
> >> entries for a new created empty directory.
> > 
> > OK, I was thinking a bit more about this and the comment was actually a bit
> > misleading AFAICT. So we have:
> > 
> > EXT4_INDEX_EXTRA_TRANS_BLOCKS for addition of entry into the directory.
> > +3 for inode, inode bitmap, group descriptor allocation
> > EXT4_DATA_TRANS_BLOCKS for the data block allocation and modification.
> > 
> > So things actually look OK, just the comment was wrong and in the old code
> > the credits were overestimated (because we've allocated the data block in a
> > separate transaction).
> > 
> 
> Yes，I will update the comments in my v2 iteration.
> 
> >> BTW, look the credits calculation in depth, the definition of
> >> EXT4_DATA_TRANS_BLOCKS is weird, the '-2' subtraction looks wrong.
> >>
> >>> #define EXT4_DATA_TRANS_BLOCKS(sb)	(EXT4_SINGLEDATA_TRANS_BLOCKS(sb) + \
> >>> 					 EXT4_XATTR_TRANS_BLOCKS - 2 + \
> >>> 					 EXT4_MAXQUOTAS_TRANS_BLOCKS(sb))
> >>
> >> I see the history log, before commit[1], the '-2' subtract the 2 more duplicate
> >> counted super block in '3 * EXT3_SINGLEDATA_TRANS_BLOCKS', but after this commit,
> >> it seems buggy because we have only count the super block once. It's a long time
> >> ago, I'm not sure am I missing something?
> > 
> > Yes, -2 looks strange but at the same time I fail to see why
> > EXT4_XATTR_TRANS_BLOCKS would need to be accounted for normal data
> > operation and why we're reserving 6 blocks there. I'll raise it on today's
> > ext4 call if someone remembers...
> > 
> 
> I guess the 6 blocks were:
> 
> 1. Ref count update on old xattr block
> 2. new xattr block
> 3. block bitmap update for new xattr block
> 4. group descriptor for new xattr block
> 5. block bitmap update for old xattr block
> 6. group descriptor for old block
> 
> The 5 and 6 looks like were overestimated in cases of 1) we just update the
> old ref count to no zero, 2) we free the old xattr block and the credits has
> already counted in the default revoke credits.

Yes, your explanation of 6 blocks in EXT4_XATTR_TRANS_BLOCKS looks good.
But I still wonder why we count with modification of xattrs for each data
block write. EXT4_XATTR_TRANS_BLOCKS was added to EXT4_DATA_TRANS_BLOCKS
back at the times when it was still ext3 and we have added xattr support to
ext3. Looking at places where EXT4_DATA_TRANS_BLOCKS is used (mostly in
fs/ext4/namei.c when adding entry into a directory), this was probably to
account for a fact that when we create new inode, we may be cloning or
otherwise modifying xattr block as well. So it seems that
EXT4_DATA_TRANS_BLOCKS has somewhat misleading name (it should rather be
called EXT4_INODE_CREATE_BLOCKS or something like that) but in principle we
indeed need to count with xattr block modifications. Anyway, that's for a
separate cleanup.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

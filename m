Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A998E3EB59F
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhHMMfV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 08:35:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhHMMfH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 08:35:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF76722334;
        Fri, 13 Aug 2021 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628858077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9bWXWAl5yk2Xe8Q6bXYgt4qOrFtisrhnycpZ5uaDNw=;
        b=ALya8jdTw23qDeFqDGEGc9e3NHVxWcjafVcjbGB6BzmpVMtuUi60LxOxpp4IUDvnnr5jb0
        UmUswnKUDgTF7wI0oOJ8P+zwPnVQj77JJArOeWTOUSW9sr/zRJaxcpu69Pu63re8hqgmVX
        JIXAPv8Oq9LY4rF1BEO7IE1bBchls/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628858077;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9bWXWAl5yk2Xe8Q6bXYgt4qOrFtisrhnycpZ5uaDNw=;
        b=3r1wi1Dxt/TfWZIiUmJCwWQarJDe73TbUIBWmWkGs7DA70MrrbzC2rzLHF6ZqzRwck/tq0
        plUQAg+b1/Q0gwBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B3C80A3B91;
        Fri, 13 Aug 2021 12:34:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8BC871E423D; Fri, 13 Aug 2021 14:34:34 +0200 (CEST)
Date:   Fri, 13 Aug 2021 14:34:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4: Speedup ext4 orphan inode handling
Message-ID: <20210813123434.GB11955@quack2.suse.cz>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-3-jack@suse.cz>
 <YRU3zjcP5hukrsyt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRU3zjcP5hukrsyt@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-08-21 11:01:34, Theodore Ts'o wrote:
> On Wed, Aug 11, 2021 at 12:19:13PM +0200, Jan Kara wrote:
> > +static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
> > +{
> > +	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
> > +	__le32 *bdata;
> > +	int blk, off;
> > +	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
> > +	int ret = 0;
> > +
> > +	if (!handle)
> > +		goto out;
> > +	blk = EXT4_I(inode)->i_orphan_idx / inodes_per_ob;
> > +	off = EXT4_I(inode)->i_orphan_idx % inodes_per_ob;
> > +	if (WARN_ON_ONCE(blk >= oi->of_blocks))
> > +		goto out;
> > +
> > +	ret = ext4_journal_get_write_access(handle, inode->i_sb,
> > +				oi->of_binfo[blk].ob_bh, EXT4_JTR_ORPHAN_FILE);
> > +	if (ret)
> > +		goto out;
> 
> If ext4_journal_get_write_access() fails, we effectively drop the
> inode from the orphan list (as far as the in-memory inode is
> concerned), although the inode will still be listed in the orphan
> file.  This can be really unfortunate since if the inode gets
> reallocated for some other purpose, since its inode number is left in
> the orphan block, on the next remount, this could lead to data loss.
> 
> In the orphan list code, we leave the inode on the linked list, which
> is not great, since that will prevent the inode from being freed, but
> at least we're keeping the in-memory and on-disk state in sync and we
> avoid the data loss scenario when the inode gets reused.

Actually, in the orphan list code, we leave the inode in the on-disk list
but remove it from the in-memory list - see how
list_del_init(&ei->i_orphan) is called very early in ext4_orphan_del(). The
reason for this unconditional deletion is that if we do not remove the
inode from the in-memory orphan list, the filesystem will complain and
corrupt memory on unmount.

Also note that leaving inode in the on-disk orphan list actually does no
serious harm. Because the orphan cleanup code just checks i_nlink and
i_disksize and truncates inode down to current i_disksize and removes inode
completely if i_nlink is 0. So even if an inode on the orphan list gets
reused, orphan cleanup will just do nothing for it. So the worst problem
that will likely happen is that on-disk orphan linked list becomes
corrupted but there's no data loss AFAICT.

Is it clearer now or am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

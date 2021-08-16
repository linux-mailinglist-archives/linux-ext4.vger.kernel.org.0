Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5243EDC2B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhHPRPf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 13:15:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhHPRPd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 13:15:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71C4C1FED2;
        Mon, 16 Aug 2021 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629134101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6v7kMILu9/BioJggTDDdUwJzViRkT9m9I5AQOB74+hM=;
        b=Qq9SjHfcLYR+FlwFK3md07Kh5PZLHoeW932o9jAqWT3mhC9oPGZPyDsa0YCUUaloRZ8D8a
        VqxmaBRvYWUsKN+AlMAfyubO7sqUsYNdNNDYv6ucUhW8ImEQl/Z9somyrfua55TvOt+Luu
        gT7J6AMh8fdd+2rvP5UCMBDlfZH/8k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629134101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6v7kMILu9/BioJggTDDdUwJzViRkT9m9I5AQOB74+hM=;
        b=3ZaESD70VurTZARiHiAuHS9w3xhoU/ZwJ6AD/YsP4n4anrh04wcu1+e8slFsLzMZHov4c3
        ZhTY5Yuw7c636vCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 34EC3A3B85;
        Mon, 16 Aug 2021 17:15:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D8DD01E0426; Mon, 16 Aug 2021 19:14:57 +0200 (CEST)
Date:   Mon, 16 Aug 2021 19:14:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH 3/3] ext4: prevent getting empty inode buffer
Message-ID: <20210816171457.GL30215@quack2.suse.cz>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-4-yi.zhang@huawei.com>
 <20210813134440.GE11955@quack2.suse.cz>
 <ab186083-8c08-2d74-dd63-673e918e6fa0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab186083-8c08-2d74-dd63-673e918e6fa0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 16-08-21 22:29:01, Zhang Yi wrote:
> On 2021/8/13 21:44, Jan Kara wrote:
> > On Tue 10-08-21 22:27:22, Zhang Yi wrote:
> >> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
> >> inode buffer when the inode monopolize an inode block for performance
> >> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
> >> buffer to make it fine, but we could miss this call if something bad
> >> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
> >> empty inode buffer and trigger ext4 error.
> >>
> >> For example, if we remove a nonexistent xattr on inode A,
> >> ext4_xattr_set_handle() will return ENODATA before invoking
> >> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
> >> will get checksum error message in ext4_iget() when getting inode again.
> >>
> >>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> >>
> >> Even worse, if we allocate another inode B at the same inode block, it
> >> will corrupt the inode A on disk when write back inode B.
> >>
> >> So this patch clear uptodate flag and mark buffer new if we get an empty
> >> buffer, clear it after we fill inode data or making read IO.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Thanks for the fix! Really good catch! The patch looks correct but
> > honestly, I'm not very happy about the special buffer_new handling. It
> > looks correct but I'm a bit uneasy that e.g. the block device code can
> > access this buffer and manipulate its state. Cannot we instead e.g. check
> > whether the buffer is uptodate in ext4_mark_iloc_dirty(), if not, lock it,
> > if still not uptodate, zero it, mark as uptodate, unlock it and then call
> > ext4_do_update_inode()? That would seem like a bit more foolproof solution
> > to me. Basically the fact that the buffer is not uptodate in
> > ext4_mark_iloc_dirty() would mean that nobody else is past
> > __ext4_get_inode_loc() for another inode in that buffer and so zeroing is
> > safe.
> > 
> 
> Thanks for your suggestion! I understand what you're concerned and your
> approach looks fine except mark buffer uptodate just behind zero buffer
> in ext4_mark_iloc_dirty(). Because I think (1) if ext4_do_update_inode()
> return error before filling the inode, it will still left an uptodate
> but zero buffer, and it's not easy to handle the error path. (2) it is
> still not conform the semantic of buffer uptodate because it it not
> contain an uptodate inode information. How about move mark as uptodate
> into ext4_do_update_inode(), something like that（not tested）？

OK, but this way could loading of buffer from the disk race with
ext4_do_update_inode() and overwrite its updates? You have to have buffer
uptodate before you start modifying it or you have to keep the buffer
locked all the time while you are updating it to avoid such races.

Luckily the only place where ext4_do_update_inode() can fail before copying
data to the buffer is due to ext4_inode_blocks_set() which should never
happen because we set s_maxsize so that i_blocks cannot overflow. So maybe
we can just get rid of that case and keep the uptodate setting with the
zeroing?

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index eae1b2d0b550..99ccba8d47c6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4368,8 +4368,6 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>                 brelse(bitmap_bh);
>                 if (i == start + inodes_per_block) {
>                         /* all other inodes are free, so skip I/O */
> -                       memset(bh->b_data, 0, bh->b_size);
> -                       set_buffer_uptodate(bh);
>                         unlock_buffer(bh);
>                         goto has_buffer;
>                 }
> @@ -5132,6 +5130,9 @@ static int ext4_do_update_inode(handle_t *handle,
>         if (err)
>                 goto out_brelse;
>         ext4_clear_inode_state(inode, EXT4_STATE_NEW);
> +       if (!buffer_uptodate(bh))
> +               set_buffer_uptodate(bh);
> +
>         if (set_large_file) {
>                 BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
>                 err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
> @@ -5712,6 +5713,13 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>         /* the do_update_inode consumes one bh->b_count */
>         get_bh(iloc->bh);
> 
> +       if (!buffer_uptodate(bh)) {
> +               lock_buffer(iloc->bh);
> +               if (!buffer_uptodate(iloc->bh))
> +                       memset(iloc->bh->b_data, 0, iloc->bh->b_size);
> +               unlock_buffer(iloc->bh);
> +       }
> +
>         /* ext4_do_update_inode() does jbd2_journal_dirty_metadata */
>         err = ext4_do_update_inode(handle, inode, iloc);
>         put_bh(iloc->bh);
> 
> 
> Thanks,
> Yi.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

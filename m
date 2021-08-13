Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0703EB62F
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhHMNq2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 09:46:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44158 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbhHMNpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 09:45:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1292F201D9;
        Fri, 13 Aug 2021 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628862282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0dFZ4wIjSqz/TWfTcmjEjeaSfVQ4Tue6gj7EO5G+Yk=;
        b=OisX1qkGTzxdJJMO0qGnjStZEx9KSlfsmiIeH9tPo1Ksxp5wdUTYWGxKtT/jbSabCvdShD
        rcgLnpjINIRHfrqa21E4JVmc0CYCXC3veEYwJSBsd/jQC4lbZ/Dd12jGkmerIVJQboOve5
        tKdBTfKXlCzt77Zyo60OicQF6UJwhNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628862282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0dFZ4wIjSqz/TWfTcmjEjeaSfVQ4Tue6gj7EO5G+Yk=;
        b=43PlRggH6IngzPpYy/O1jEsFNb5B1RYAx7lcyNWGyG9jqTiqrBb+7GiGZ1D3uReJZp9D4o
        KsgD/UtvVTFbYvBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B5CE6A3BA2;
        Fri, 13 Aug 2021 13:44:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 83A4B1E423D; Fri, 13 Aug 2021 15:44:40 +0200 (CEST)
Date:   Fri, 13 Aug 2021 15:44:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 3/3] ext4: prevent getting empty inode buffer
Message-ID: <20210813134440.GE11955@quack2.suse.cz>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810142722.923175-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-08-21 22:27:22, Zhang Yi wrote:
> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
> inode buffer when the inode monopolize an inode block for performance
> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
> buffer to make it fine, but we could miss this call if something bad
> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
> empty inode buffer and trigger ext4 error.
> 
> For example, if we remove a nonexistent xattr on inode A,
> ext4_xattr_set_handle() will return ENODATA before invoking
> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
> will get checksum error message in ext4_iget() when getting inode again.
> 
>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> 
> Even worse, if we allocate another inode B at the same inode block, it
> will corrupt the inode A on disk when write back inode B.
> 
> So this patch clear uptodate flag and mark buffer new if we get an empty
> buffer, clear it after we fill inode data or making read IO.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the fix! Really good catch! The patch looks correct but
honestly, I'm not very happy about the special buffer_new handling. It
looks correct but I'm a bit uneasy that e.g. the block device code can
access this buffer and manipulate its state. Cannot we instead e.g. check
whether the buffer is uptodate in ext4_mark_iloc_dirty(), if not, lock it,
if still not uptodate, zero it, mark as uptodate, unlock it and then call
ext4_do_update_inode()? That would seem like a bit more foolproof solution
to me. Basically the fact that the buffer is not uptodate in
ext4_mark_iloc_dirty() would mean that nobody else is past
__ext4_get_inode_loc() for another inode in that buffer and so zeroing is
safe.

								Honza

> ---
>  fs/ext4/inode.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index eae1b2d0b550..1f36289e9ef6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4292,6 +4292,18 @@ int ext4_truncate(struct inode *inode)
>  	return err;
>  }
>  
> +static void ext4_end_inode_loc_read(struct buffer_head *bh, int uptodate)
> +{
> +	if (buffer_new(bh))
> +		clear_buffer_new(bh);
> +	if (uptodate)
> +		set_buffer_uptodate(bh);
> +	else
> +		clear_buffer_uptodate(bh);
> +	unlock_buffer(bh);
> +	put_bh(bh);
> +}
> +
>  /*
>   * ext4_get_inode_loc returns with an extra refcount against the inode's
>   * underlying buffer_head on success. If 'in_mem' is true, we have all
> @@ -4367,9 +4379,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		}
>  		brelse(bitmap_bh);
>  		if (i == start + inodes_per_block) {
> -			/* all other inodes are free, so skip I/O */
> -			memset(bh->b_data, 0, bh->b_size);
> -			set_buffer_uptodate(bh);
> +			if (!buffer_new(bh)) {
> +				/* all other inodes are free, so skip I/O */
> +				memset(bh->b_data, 0, bh->b_size);
> +				set_buffer_new(bh);
> +			}
>  			unlock_buffer(bh);
>  			goto has_buffer;
>  		}
> @@ -4408,7 +4422,7 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	 * Read the block from disk.
>  	 */
>  	trace_ext4_load_inode(sb, ino);
> -	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
> +	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, ext4_end_inode_loc_read);
>  	blk_finish_plug(&plug);
>  	wait_on_buffer(bh);
>  	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
> @@ -5132,6 +5146,11 @@ static int ext4_do_update_inode(handle_t *handle,
>  	if (err)
>  		goto out_brelse;
>  	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
> +	if (buffer_new(bh)) {
> +		clear_buffer_new(bh);
> +		set_buffer_uptodate(bh);
> +	}
> +
>  	if (set_large_file) {
>  		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
>  		err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

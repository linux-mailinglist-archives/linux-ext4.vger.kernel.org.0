Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A732411632
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Sep 2021 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhITN7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Sep 2021 09:59:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52626 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhITN7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Sep 2021 09:59:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3ED6A20060;
        Mon, 20 Sep 2021 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632146296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRjQ8NXb0ndb3liRpeOC4HyiP5xOKEEvXmRW+z3ZcP0=;
        b=BzKNQyZI1wtuYfHOCXhklBOggwrgDL2HouKTkGNEekcweItHfSyzj7/H/pTdH/JNpP1/f/
        wAYpyhO02CVo9Vqi1TmjAfhACc5IChFIgJJLbToHWZiHQ92lrZVIJoi0Jsjd/sN3D03+qa
        sfRUfrytZLP3fJYxPqlsMF90HZfnIeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632146296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRjQ8NXb0ndb3liRpeOC4HyiP5xOKEEvXmRW+z3ZcP0=;
        b=1yxiG/yBWuHmNQisfavA6gdRbXn7tOhGlueAXoS+u52mGs3Wi7/rwebJpu1caEqLi8zpmH
        xR2vmmmAYWtkoFAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 31217A3B96;
        Mon, 20 Sep 2021 13:58:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 18E521E0BF7; Mon, 20 Sep 2021 15:58:16 +0200 (CEST)
Date:   Mon, 20 Sep 2021 15:58:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v5 3/3] ext4: prevent getting empty inode buffer
Message-ID: <20210920135816.GJ6607@quack2.suse.cz>
References: <20210901020955.1657340-1-yi.zhang@huawei.com>
 <20210901020955.1657340-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901020955.1657340-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-09-21 10:09:55, Zhang Yi wrote:
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
> So this patch initialize the inode buffer by filling the in-mem inode
> contents if we skip read I/O, ensure that the buffer is really uptodate.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3c36e701e30e..a8388ec91f9f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4441,12 +4441,12 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
>  
>  /*
>   * ext4_get_inode_loc returns with an extra refcount against the inode's
> - * underlying buffer_head on success. If 'in_mem' is true, we have all
> - * data in memory that is needed to recreate the on-disk version of this
> - * inode.
> + * underlying buffer_head on success. If we pass 'inode' and it does not
> + * have in-inode xattr, we have all inode data in memory that is needed
> + * to recreate the on-disk version of this inode.
>   */
>  static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
> -				struct ext4_iloc *iloc, int in_mem,
> +				struct inode *inode, struct ext4_iloc *iloc,
>  				ext4_fsblk_t *ret_block)
>  {
>  	struct ext4_group_desc	*gdp;
> @@ -4486,7 +4486,7 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	 * is the only valid inode in the block, we need not read the
>  	 * block.
>  	 */
> -	if (in_mem) {
> +	if (inode && !ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>  		struct buffer_head *bitmap_bh;
>  		int i, start;
>  
> @@ -4514,8 +4514,13 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		}
>  		brelse(bitmap_bh);
>  		if (i == start + inodes_per_block) {
> +			struct ext4_inode *raw_inode =
> +				(struct ext4_inode *) (bh->b_data + iloc->offset);
> +
>  			/* all other inodes are free, so skip I/O */
>  			memset(bh->b_data, 0, bh->b_size);
> +			if (!ext4_test_inode_state(inode, EXT4_STATE_NEW))
> +				ext4_fill_raw_inode(inode, raw_inode);
>  			set_buffer_uptodate(bh);
>  			unlock_buffer(bh);
>  			goto has_buffer;
> @@ -4576,7 +4581,7 @@ static int __ext4_get_inode_loc_noinmem(struct inode *inode,
>  	ext4_fsblk_t err_blk;
>  	int ret;
>  
> -	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc, 0,
> +	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL, iloc,
>  					&err_blk);
>  
>  	if (ret == -EIO)
> @@ -4591,9 +4596,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  	ext4_fsblk_t err_blk;
>  	int ret;
>  
> -	/* We have all inode data except xattrs in memory here. */
> -	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
> -		!ext4_test_inode_state(inode, EXT4_STATE_XATTR), &err_blk);
> +	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, inode, iloc,
> +					&err_blk);
>  
>  	if (ret == -EIO)
>  		ext4_error_inode_block(inode, err_blk, EIO,
> @@ -4606,7 +4610,7 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
>  			  struct ext4_iloc *iloc)
>  {
> -	return __ext4_get_inode_loc(sb, ino, iloc, 0, NULL);
> +	return __ext4_get_inode_loc(sb, ino, NULL, iloc, NULL);
>  }
>  
>  static bool ext4_should_enable_dax(struct inode *inode)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

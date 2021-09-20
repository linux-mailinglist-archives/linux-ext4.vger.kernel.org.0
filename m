Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F229741162D
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Sep 2021 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhITN7O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Sep 2021 09:59:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhITN7O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Sep 2021 09:59:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B171F22078;
        Mon, 20 Sep 2021 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632146266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7V/KTLDd+yjk+762+r5KIwGeaEwq0+Wir86kELCn5I=;
        b=XxY/3zPsdidK7m7tyDCH86Gu42YzNjLxtrRn3+CcrUMtoFsvxy3tqwGj0PMNA7+QBtkkNC
        FDQr+aYbzDC/USZPYlOOlk4oVQI007aOOoEIz7lNy9agusNScol1ne0c+excGG/+ghRVvZ
        iXa6OfPtu+ALQpfE0WDXTdlsS7JoX50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632146266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7V/KTLDd+yjk+762+r5KIwGeaEwq0+Wir86kELCn5I=;
        b=vIB5N16nSdDQC3CSijT883B+cnzUaiYEaRNkhXK1duSh/nMaw2iNaTsBTA0w049L1IojI7
        YC9ajSBHlj2PopDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9D2F2A3BA5;
        Mon, 20 Sep 2021 13:57:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FA5A1E0BF7; Mon, 20 Sep 2021 15:57:46 +0200 (CEST)
Date:   Mon, 20 Sep 2021 15:57:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v5 1/3] ext4: factor out ext4_fill_raw_inode()
Message-ID: <20210920135746.GH6607@quack2.suse.cz>
References: <20210901020955.1657340-1-yi.zhang@huawei.com>
 <20210901020955.1657340-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901020955.1657340-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-09-21 10:09:53, Zhang Yi wrote:
> Factor out ext4_fill_raw_inode() from ext4_do_update_inode(), which is
> use to fill the in-mem inode contents into the inode table buffer, in
> preparation for initializing the exclusive inode buffer without reading
> the block in __ext4_get_inode_loc().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 85 +++++++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 8323d3e8f393..c7186460c14d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4902,9 +4902,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	return ERR_PTR(ret);
>  }
>  
> -static int ext4_inode_blocks_set(handle_t *handle,
> -				struct ext4_inode *raw_inode,
> -				struct ext4_inode_info *ei)
> +static int ext4_inode_blocks_set(struct ext4_inode *raw_inode,
> +				 struct ext4_inode_info *ei)
>  {
>  	struct inode *inode = &(ei->vfs_inode);
>  	u64 i_blocks = READ_ONCE(inode->i_blocks);
> @@ -5007,37 +5006,16 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
>  	rcu_read_unlock();
>  }
>  
> -/*
> - * Post the struct inode info into an on-disk inode location in the
> - * buffer-cache.  This gobbles the caller's reference to the
> - * buffer_head in the inode location struct.
> - *
> - * The caller must have write access to iloc->bh.
> - */
> -static int ext4_do_update_inode(handle_t *handle,
> -				struct inode *inode,
> -				struct ext4_iloc *iloc)
> +static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode)
>  {
> -	struct ext4_inode *raw_inode = ext4_raw_inode(iloc);
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> -	struct buffer_head *bh = iloc->bh;
> -	struct super_block *sb = inode->i_sb;
> -	int err = 0, block;
> -	int need_datasync = 0, set_large_file = 0;
>  	uid_t i_uid;
>  	gid_t i_gid;
>  	projid_t i_projid;
> +	int block;
> +	int err;
>  
> -	spin_lock(&ei->i_raw_lock);
> -
> -	/*
> -	 * For fields not tracked in the in-memory inode, initialise them
> -	 * to zero for new inodes.
> -	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
> -		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
> -
> -	err = ext4_inode_blocks_set(handle, raw_inode, ei);
> +	err = ext4_inode_blocks_set(raw_inode, ei);
>  
>  	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
>  	i_uid = i_uid_read(inode);
> @@ -5079,16 +5057,8 @@ static int ext4_do_update_inode(handle_t *handle,
>  		raw_inode->i_file_acl_high =
>  			cpu_to_le16(ei->i_file_acl >> 32);
>  	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
> -	if (READ_ONCE(ei->i_disksize) != ext4_isize(inode->i_sb, raw_inode)) {
> -		ext4_isize_set(raw_inode, ei->i_disksize);
> -		need_datasync = 1;
> -	}
> -	if (ei->i_disksize > 0x7fffffffULL) {
> -		if (!ext4_has_feature_large_file(sb) ||
> -				EXT4_SB(sb)->s_es->s_rev_level ==
> -		    cpu_to_le32(EXT4_GOOD_OLD_REV))
> -			set_large_file = 1;
> -	}
> +	ext4_isize_set(raw_inode, ei->i_disksize);
> +
>  	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
>  	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
>  		if (old_valid_dev(inode->i_rdev)) {
> @@ -5128,6 +5098,45 @@ static int ext4_do_update_inode(handle_t *handle,
>  		raw_inode->i_projid = cpu_to_le32(i_projid);
>  
>  	ext4_inode_csum_set(inode, raw_inode, ei);
> +	return err;
> +}
> +
> +/*
> + * Post the struct inode info into an on-disk inode location in the
> + * buffer-cache.  This gobbles the caller's reference to the
> + * buffer_head in the inode location struct.
> + *
> + * The caller must have write access to iloc->bh.
> + */
> +static int ext4_do_update_inode(handle_t *handle,
> +				struct inode *inode,
> +				struct ext4_iloc *iloc)
> +{
> +	struct ext4_inode *raw_inode = ext4_raw_inode(iloc);
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct buffer_head *bh = iloc->bh;
> +	struct super_block *sb = inode->i_sb;
> +	int err;
> +	int need_datasync = 0, set_large_file = 0;
> +
> +	spin_lock(&ei->i_raw_lock);
> +
> +	/*
> +	 * For fields not tracked in the in-memory inode, initialise them
> +	 * to zero for new inodes.
> +	 */
> +	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
> +		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
> +
> +	if (READ_ONCE(ei->i_disksize) != ext4_isize(inode->i_sb, raw_inode))
> +		need_datasync = 1;
> +	if (ei->i_disksize > 0x7fffffffULL) {
> +		if (!ext4_has_feature_large_file(sb) ||
> +		    EXT4_SB(sb)->s_es->s_rev_level == cpu_to_le32(EXT4_GOOD_OLD_REV))
> +			set_large_file = 1;
> +	}
> +
> +	err = ext4_fill_raw_inode(inode, raw_inode);
>  	spin_unlock(&ei->i_raw_lock);
>  	if (err) {
>  		EXT4_ERROR_INODE(inode, "corrupted inode contents");
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

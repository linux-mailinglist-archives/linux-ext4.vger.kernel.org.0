Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E63C9E06
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jul 2021 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhGOLyz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 07:54:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32788 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhGOLyz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 07:54:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CFFF1FE16;
        Thu, 15 Jul 2021 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626349921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dllbM/QvdmP46017EJ86bKyufZyY6aLumShuumeX8bQ=;
        b=FadpO9gOaMZ3XjCmzvoO/FB/IQ67qGOX4zdqMFoqoduNhf8VnvCaZc11WrTdi4WmLnk1yn
        GSovns3cTYnSWfFGZYbirOFR3/LkPiWztA1fqJf+NMnJnPPSGlEC0VUWT8dq4qzByKevIP
        99LwJTC0l4qAcV7DZ/dlP6myKaxdsvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626349921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dllbM/QvdmP46017EJ86bKyufZyY6aLumShuumeX8bQ=;
        b=kz3RCiHod81zaBKwuV4f/YeYsxfcIAFocnOpdXiqQW0aeOdvsCUYGHN9uVH1jLvohkadjJ
        R99g4pV4lbR5EQCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 77389A3B99;
        Thu, 15 Jul 2021 11:52:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E7B01E0BF2; Thu, 15 Jul 2021 13:52:01 +0200 (CEST)
Date:   Thu, 15 Jul 2021 13:52:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/4] ext4: check and update i_disksize properly
Message-ID: <20210715115201.GE9457@quack2.suse.cz>
References: <20210715015452.2542505-1-yi.zhang@huawei.com>
 <20210715015452.2542505-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715015452.2542505-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-07-21 09:54:49, Zhang Yi wrote:
> After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
> isize"), i_disksize could always be updated to i_size in ext4_setattr(),
> and we could sure that i_disksize <= i_size since holding inode lock and
> if i_disksize < i_size there are delalloc writes pending in the range
> upto i_size. If the end of the current write is <= i_size, there's no
> need to touch i_disksize since writeback will push i_disksize upto
> i_size eventually. So we can switch to check i_size instead of
> i_disksize in ext4_da_write_end() when write to the end of the file.
> we also could remove ext4_mark_inode_dirty() together because we defer
> inode dirtying to generic_write_end() or ext4_da_write_inline_data_end().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d8de607849df..dca8e3810443 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3084,35 +3084,37 @@ static int ext4_da_write_end(struct file *file,
>  	end = start + copied - 1;
>  
>  	/*
> -	 * generic_write_end() will run mark_inode_dirty() if i_size
> -	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
> -	 * into that.
> +	 * Since we are holding inode lock, we are sure i_disksize <=
> +	 * i_size. We also know that if i_disksize < i_size, there are
> +	 * delalloc writes pending in the range upto i_size. If the end of
> +	 * the current write is <= i_size, there's no need to touch
> +	 * i_disksize since writeback will push i_disksize upto i_size
> +	 * eventually. If the end of the current write is > i_size and
> +	 * inside an allocated block (ext4_da_should_update_i_disksize()
> +	 * check), we need to update i_disksize here as neither
> +	 * ext4_writepage() nor certain ext4_writepages() paths not
> +	 * allocating blocks update i_disksize.
> +	 *
> +	 * Note that we defer inode dirtying to generic_write_end() /
> +	 * ext4_da_write_inline_data_end().
>  	 */
>  	new_i_size = pos + copied;
> -	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
> +	if (copied && new_i_size > inode->i_size) {
>  		if (ext4_has_inline_data(inode) ||
> -		    ext4_da_should_update_i_disksize(page, end)) {
> +		    ext4_da_should_update_i_disksize(page, end))
>  			ext4_update_i_disksize(inode, new_i_size);
> -			/* We need to mark inode dirty even if
> -			 * new_i_size is less that inode->i_size
> -			 * bu greater than i_disksize.(hint delalloc)
> -			 */
> -			ret = ext4_mark_inode_dirty(handle, inode);
> -		}
>  	}
>  
>  	if (write_mode != CONVERT_INLINE_DATA &&
>  	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
>  	    ext4_has_inline_data(inode))
> -		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
> +		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
>  						     page);
>  	else
> -		ret2 = generic_write_end(file, mapping, pos, len, copied,
> +		ret = generic_write_end(file, mapping, pos, len, copied,
>  							page, fsdata);
>  
> -	copied = ret2;
> -	if (ret2 < 0)
> -		ret = ret2;
> +	copied = ret;
>  	ret2 = ext4_journal_stop(handle);
>  	if (unlikely(ret2 && !ret))
>  		ret = ret2;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

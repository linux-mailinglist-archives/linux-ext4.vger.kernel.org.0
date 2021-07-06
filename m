Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998C33BD693
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhGFMh4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 08:37:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbhGFMbS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 08:31:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0DC1E1FF64;
        Tue,  6 Jul 2021 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625574519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7NnasxdZeTUgzqf9QL292/Oq3+QzFLsgTnmJfHyH2E=;
        b=QwBysUcUwbPs+/bbqxcWVXvZt3dWSbOoYTU713bepDJKLiov49Px5V7Mg0lMB26e8qPWKz
        MqKt1TZdqJ4al7B/kUM1ekSzam/OrBT7PSRKepXK7xcjlq1hBErfu6v86NedEoNpH2gbO3
        OHTefKyORSyZCZqUoV/LBoOjfdenIr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625574519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7NnasxdZeTUgzqf9QL292/Oq3+QzFLsgTnmJfHyH2E=;
        b=+h6MTI/R+cHN+jt3kh5FEJb3PLroKgr42c9EeUtu4Wk9g/cqkr7xHrCPOhiItfy6Uim98P
        2n5ZuvrY4dK50xDw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id ECCCFA3E54;
        Tue,  6 Jul 2021 12:28:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9FE61F2C9A; Tue,  6 Jul 2021 14:28:38 +0200 (CEST)
Date:   Tue, 6 Jul 2021 14:28:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH 2/4] ext4: correct the error path of
 ext4_write_inline_data_end()
Message-ID: <20210706122838.GC7922@quack2.suse.cz>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706024210.746788-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 10:42:08, Zhang Yi wrote:
> Current error path of ext4_write_inline_data_end() is not correct.
> 
> Firstly, it should pass out the error value if ext4_get_inode_loc()
> return fail, or else it could trigger infinite loop if we inject error
> here.
> And then it's better to add inode to orphan list if it return fail
> in ext4_journal_stop(), otherwise we could not restore inline xattr
> entry after power failure.
> Finally, we need to reset the 'ret' value if
> ext4_write_inline_data_end() return success in ext4_write_end() and
> ext4_journalled_write_end(), otherwise we could not get the error return
> value of ext4_journal_stop().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 15 +++++----------
>  fs/ext4/inode.c  |  7 +++++--
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 70cb64db33f7..28b666f25ac2 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -733,25 +733,20 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  	void *kaddr;
>  	struct ext4_iloc iloc;
>  
> -	if (unlikely(copied < len)) {
> -		if (!PageUptodate(page)) {
> -			copied = 0;
> -			goto out;
> -		}
> -	}
> +	if (unlikely(copied < len) && !PageUptodate(page))
> +		return 0;
>  
>  	ret = ext4_get_inode_loc(inode, &iloc);
>  	if (ret) {
>  		ext4_std_error(inode->i_sb, ret);
> -		copied = 0;
> -		goto out;
> +		return ret;
>  	}
>  
>  	ext4_write_lock_xattr(inode, &no_expand);
>  	BUG_ON(!ext4_has_inline_data(inode));
>  
>  	kaddr = kmap_atomic(page);
> -	ext4_write_inline_data(inode, &iloc, kaddr, pos, len);
> +	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
>  	kunmap_atomic(kaddr);
>  	SetPageUptodate(page);
>  	/* clear page dirty so that writepages wouldn't work for us. */
> @@ -760,7 +755,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  	ext4_write_unlock_xattr(inode, &no_expand);
>  	brelse(iloc.bh);
>  	mark_inode_dirty(inode);
> -out:
> +
>  	return copied;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6f6a61f3ae5f..4efd50a844b9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1295,6 +1295,7 @@ static int ext4_write_end(struct file *file,
>  			goto errout;
>  		}
>  		copied = ret;
> +		ret = 0;
>  	} else
>  		copied = block_write_end(file, mapping, pos,
>  					 len, copied, page, fsdata);
> @@ -1321,13 +1322,14 @@ static int ext4_write_end(struct file *file,
>  	if (i_size_changed || inline_data)
>  		ret = ext4_mark_inode_dirty(handle, inode);
>  
> +errout:
>  	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
>  		/* if we have allocated more blocks and copied
>  		 * less. We will have blocks allocated outside
>  		 * inode->i_size. So truncate them
>  		 */
>  		ext4_orphan_add(handle, inode);
> -errout:
> +
>  	ret2 = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = ret2;
> @@ -1410,6 +1412,7 @@ static int ext4_journalled_write_end(struct file *file,
>  			goto errout;
>  		}
>  		copied = ret;
> +		ret = 0;
>  	} else if (unlikely(copied < len) && !PageUptodate(page)) {
>  		copied = 0;
>  		ext4_journalled_zero_new_buffers(handle, page, from, to);
> @@ -1439,6 +1442,7 @@ static int ext4_journalled_write_end(struct file *file,
>  			ret = ret2;
>  	}
>  
> +errout:
>  	if (pos + len > inode->i_size && !verity && ext4_can_truncate(inode))
>  		/* if we have allocated more blocks and copied
>  		 * less. We will have blocks allocated outside
> @@ -1446,7 +1450,6 @@ static int ext4_journalled_write_end(struct file *file,
>  		 */
>  		ext4_orphan_add(handle, inode);
>  
> -errout:
>  	ret2 = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = ret2;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

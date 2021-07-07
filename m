Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1043E3BEC8B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGGQvr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 12:51:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57192 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGQvq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 12:51:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B501D21FFB;
        Wed,  7 Jul 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625676545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g082thRo0IHf7U/SrcUrCy2tOvASAkwb5QE3w7R990w=;
        b=LjzXmBBqr4kOV8uXDe173kn4+RHFasWU/Gf9iewJ4AROkgCV9H72dX0tTokVWiHcGomPuY
        uA8YR+Mq+Zp/Ku5WSCm1scJrpNFJJkH4bxaLc6JsNIVes+7LXo472Im5Lw7S32vQ6EspDJ
        rFge6ygcW+Sl35MQxG24Zn1BWod8iZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625676545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g082thRo0IHf7U/SrcUrCy2tOvASAkwb5QE3w7R990w=;
        b=pBQJWoV5t0Dok8/NCIG6gUFY8wNAYnymWMLTIrQyWlHad5j6joddifSf83JlienEtwFVU6
        bt2hcGzh4EuXEYAA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 98032A3B98;
        Wed,  7 Jul 2021 16:49:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 494BE1F2CD7; Wed,  7 Jul 2021 18:49:05 +0200 (CEST)
Date:   Wed, 7 Jul 2021 18:49:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH 3/4] ext4: factor out write end code of inline file
Message-ID: <20210707164905.GA18396@quack2.suse.cz>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706024210.746788-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 10:42:09, Zhang Yi wrote:
> Now that the inline_data file write end procedure are falled into the
> common write end functions, it is not clear. Factor them out and do
> some cleanup. This patch also drop ext4_da_write_inline_data_end()
> and switch to use ext4_write_inline_data_end() instead because we also
> need to do the same error processing if we failed to write data into
> inline entry.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just two nits below.
 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 28b666f25ac2..8fbf8ec05bd5 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -729,34 +729,80 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
>  int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  			       unsigned copied, struct page *page)
>  {
> -	int ret, no_expand;
> +	handle_t *handle = ext4_journal_current_handle();
> +	int i_size_changed = 0;
> +	int no_expand;
>  	void *kaddr;
>  	struct ext4_iloc iloc;
> +	int ret, ret2;
>  
>  	if (unlikely(copied < len) && !PageUptodate(page))
> -		return 0;
> +		copied = 0;
>  
> -	ret = ext4_get_inode_loc(inode, &iloc);
> -	if (ret) {
> -		ext4_std_error(inode->i_sb, ret);
> -		return ret;
> -	}
> +	if (likely(copied)) {
> +		ret = ext4_get_inode_loc(inode, &iloc);
> +		if (ret) {
> +			unlock_page(page);
> +			put_page(page);
> +			ext4_std_error(inode->i_sb, ret);
> +			goto out;
> +		}
> +		ext4_write_lock_xattr(inode, &no_expand);
> +		BUG_ON(!ext4_has_inline_data(inode));
>  
> -	ext4_write_lock_xattr(inode, &no_expand);
> -	BUG_ON(!ext4_has_inline_data(inode));
> +		kaddr = kmap_atomic(page);
> +		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
> +		kunmap_atomic(kaddr);
> +		SetPageUptodate(page);
> +		/* clear page dirty so that writepages wouldn't work for us. */
> +		ClearPageDirty(page);
>  
> -	kaddr = kmap_atomic(page);
> -	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
> -	kunmap_atomic(kaddr);
> -	SetPageUptodate(page);
> -	/* clear page dirty so that writepages wouldn't work for us. */
> -	ClearPageDirty(page);
> +		ext4_write_unlock_xattr(inode, &no_expand);
> +		brelse(iloc.bh);
> +	}
>  
> -	ext4_write_unlock_xattr(inode, &no_expand);
> -	brelse(iloc.bh);
> -	mark_inode_dirty(inode);
> +	/*
> +	 * It's important to update i_size while still holding page lock:
> +	 * page writeout could otherwise come in and zero beyond i_size.
> +	 */
> +	i_size_changed = ext4_update_inode_size(inode, pos + copied);
> +	if (ext4_should_journal_data(inode)) {
> +		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
> +		EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
> +	}

I think this hunk should also go into the "if (copied)" block. There's no
point in changing i_size or i_disksize when nothing was written.

> +	unlock_page(page);
> +	put_page(page);
>  
> -	return copied;
> +	/*
> +	 * Don't mark the inode dirty under page lock. First, it unnecessarily
> +	 * makes the holding time of page lock longer. Second, it forces lock
> +	 * ordering of page lock and transaction start for journaling
> +	 * filesystems.
> +	 */
> +	if (likely(copied) || i_size_changed)
> +		mark_inode_dirty(inode);

And then it is obvious here that (copied == 0) => !i_size_changed so we can
just remove the i_size_changed term from the condition.

> +out:
> +	/*
> +	 * If we have allocated more blocks and copied less. We will have
> +	 * blocks allocated outside inode->i_size, so truncate them.
> +	 */
> +	if (pos + len > inode->i_size && ext4_can_truncate(inode))
> +		ext4_orphan_add(handle, inode);
> +
> +	ret2 = ext4_journal_stop(handle);
> +	if (!ret)
> +		ret = ret2;
> +	if (pos + len > inode->i_size) {
> +		ext4_truncate_failed_write(inode);
> +		/*
> +		 * If truncate failed early the inode might still be
> +		 * on the orphan list; we need to make sure the inode
> +		 * is removed from the orphan list in that case.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}
> +	return ret ? ret : copied;
>  }

								Honza
---
Jan Kara <jack@suse.com>
SUSE Labs, CR

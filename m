Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E03BECB3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGGRC3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 13:02:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGRC3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 13:02:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D521F221BB;
        Wed,  7 Jul 2021 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625677187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACqIPBsABNdGppsH5SUdp6frmFR/MHD1RrfokrCr4zM=;
        b=rifMoVrEe+zcSSPz0rMXIlsJrK7iwBlpUj8lndH4O1qAdQBTnOgASKpXXXZpKoYOaO0Hdu
        zI5AZRXukZum0dwYpw4RJZMyHrdifohxmrvXOV9PZZZS9G0vDpkQWxhMiZOHmwxpMUGUKE
        9l1vACDPk8avIWxDehzFdt8CsEuLg/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625677187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACqIPBsABNdGppsH5SUdp6frmFR/MHD1RrfokrCr4zM=;
        b=3buicbxVPIAcokSzlI8V5xpbBR2YkolbUZRD1SLr/PKkwBVFXw93Q14vqIp0GBwia5oQTZ
        st7wY9BPUaM0u9Bg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B7D20A3B9E;
        Wed,  7 Jul 2021 16:59:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 731231F2CD7; Wed,  7 Jul 2021 18:59:47 +0200 (CEST)
Date:   Wed, 7 Jul 2021 18:59:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH 4/4] ext4: drop unnecessary journal handle in
 delalloc write
Message-ID: <20210707165947.GB18396@quack2.suse.cz>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706024210.746788-5-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 10:42:10, Zhang Yi wrote:
> After we factor out the inline data write procedure from
> ext4_da_write_end(), we don't need to start journal handle for the cases
> of both buffer overwrite and append-write. If we need to update
> i_disksize, mark_inode_dirty() do start handle and update inode buffer.
> So we could just remove all the journal handle codes in the delalloc
> write procedure.
> 
> After this patch, we could get a lot of performance improvement. Below
> is the Unixbench comparison data test on my machine with 'Intel Xeon
> Gold 5120' CPU and nvme SSD backend.
> 
> Test cmd:
> 
>   ./Run -c 56 -i 3 fstime fsbuffer fsdisk
> 
> Before this patch:
> 
>   System Benchmarks Partial Index           BASELINE       RESULT   INDEX
>   File Copy 1024 bufsize 2000 maxblocks       3960.0     422965.0   1068.1
>   File Copy 256 bufsize 500 maxblocks         1655.0     105077.0   634.9
>   File Copy 4096 bufsize 8000 maxblocks       5800.0    1429092.0   2464.0
>                                                                     ======
>   System Benchmarks Index Score (Partial Only)                      1186.6
> 
> After this patch:
> 
>   System Benchmarks Partial Index           BASELINE       RESULT   INDEX
>   File Copy 1024 bufsize 2000 maxblocks       3960.0     732716.0   1850.3
>   File Copy 256 bufsize 500 maxblocks         1655.0     184940.0   1117.5
>   File Copy 4096 bufsize 8000 maxblocks       5800.0    2427152.0   4184.7
>                                                                     ======
>   System Benchmarks Index Score (Partial Only)                      2053.0
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good and nice speedup! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 60 +++++--------------------------------------------
>  1 file changed, 5 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 650da0648eba..9c86cada9a54 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2910,19 +2910,6 @@ static int ext4_nonda_switch(struct super_block *sb)
>  	return 0;
>  }
>  
> -/* We always reserve for an inode update; the superblock could be there too */
> -static int ext4_da_write_credits(struct inode *inode, loff_t pos, unsigned len)
> -{
> -	if (likely(ext4_has_feature_large_file(inode->i_sb)))
> -		return 1;
> -
> -	if (pos + len <= 0x7fffffffULL)
> -		return 1;
> -
> -	/* We might need to update the superblock to set LARGE_FILE */
> -	return 2;
> -}
> -
>  static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  			       loff_t pos, unsigned len, unsigned flags,
>  			       struct page **pagep, void **fsdata)
> @@ -2931,7 +2918,6 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	struct page *page;
>  	pgoff_t index;
>  	struct inode *inode = mapping->host;
> -	handle_t *handle;
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
> @@ -2957,41 +2943,11 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  			return 0;
>  	}
>  
> -	/*
> -	 * grab_cache_page_write_begin() can take a long time if the
> -	 * system is thrashing due to memory pressure, or if the page
> -	 * is being written back.  So grab it first before we start
> -	 * the transaction handle.  This also allows us to allocate
> -	 * the page (if needed) without using GFP_NOFS.
> -	 */
> -retry_grab:
> +retry:
>  	page = grab_cache_page_write_begin(mapping, index, flags);
>  	if (!page)
>  		return -ENOMEM;
> -	unlock_page(page);
> -
> -	/*
> -	 * With delayed allocation, we don't log the i_disksize update
> -	 * if there is delayed block allocation. But we still need
> -	 * to journalling the i_disksize update if writes to the end
> -	 * of file which has an already mapped buffer.
> -	 */
> -retry_journal:
> -	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
> -				ext4_da_write_credits(inode, pos, len));
> -	if (IS_ERR(handle)) {
> -		put_page(page);
> -		return PTR_ERR(handle);
> -	}
>  
> -	lock_page(page);
> -	if (page->mapping != mapping) {
> -		/* The page got truncated from under us */
> -		unlock_page(page);
> -		put_page(page);
> -		ext4_journal_stop(handle);
> -		goto retry_grab;
> -	}
>  	/* In case writeback began while the page was unlocked */
>  	wait_for_stable_page(page);
>  
> @@ -3003,20 +2959,18 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  #endif
>  	if (ret < 0) {
>  		unlock_page(page);
> -		ext4_journal_stop(handle);
> +		put_page(page);
>  		/*
>  		 * block_write_begin may have instantiated a few blocks
>  		 * outside i_size.  Trim these off again. Don't need
> -		 * i_size_read because we hold i_mutex.
> +		 * i_size_read because we hold inode lock.
>  		 */
>  		if (pos + len > inode->i_size)
>  			ext4_truncate_failed_write(inode);
>  
>  		if (ret == -ENOSPC &&
>  		    ext4_should_retry_alloc(inode->i_sb, &retries))
> -			goto retry_journal;
> -
> -		put_page(page);
> +			goto retry;
>  		return ret;
>  	}
>  
> @@ -3053,8 +3007,6 @@ static int ext4_da_write_end(struct file *file,
>  			     struct page *page, void *fsdata)
>  {
>  	struct inode *inode = mapping->host;
> -	int ret;
> -	handle_t *handle = ext4_journal_current_handle();
>  	loff_t new_i_size;
>  	unsigned long start, end;
>  	int write_mode = (int)(unsigned long)fsdata;
> @@ -3086,9 +3038,7 @@ static int ext4_da_write_end(struct file *file,
>  	    ext4_da_should_update_i_disksize(page, end))
>  		ext4_update_i_disksize(inode, new_i_size);
>  
> -	copied = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
> -	ret = ext4_journal_stop(handle);
> -	return ret ? ret : copied;
> +	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

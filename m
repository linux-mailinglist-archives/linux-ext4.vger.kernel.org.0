Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04E87A4248
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjIRH0a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjIRH0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 03:26:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C03A8;
        Mon, 18 Sep 2023 00:26:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89E461F88D;
        Mon, 18 Sep 2023 07:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695021969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Py/I/FzMrkGhKFEk1Qy4ED+NcXo3BnZB0csOeT5dGY=;
        b=xI1hI3rJcSO2/N2jCikMCB0oIl8blMlnXuEoKPnq4NTCvdCUgvHjDIUsbk6VbfklnVYZiU
        mNl23GdUrIWKywB4ocKdDDyJrJ1mP2VfqjI9yiwpL4D+LMQPB5Kzc5tmsTaLC7CMFN+ZI3
        UR5vrPIexL79F29FzA/57o95LftZA0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695021969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Py/I/FzMrkGhKFEk1Qy4ED+NcXo3BnZB0csOeT5dGY=;
        b=RCIgCCRU33M4CcRAuwV3q3a4kAbEpqbeaqIRR+bLDY9zrPWwlANvr+mz2H1GfptZf2akOe
        w12BLqljj6zPsYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADA113480;
        Mon, 18 Sep 2023 07:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uQb2HZH7B2WFUwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 07:26:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 171E5A0759; Mon, 18 Sep 2023 09:26:09 +0200 (CEST)
Date:   Mon, 18 Sep 2023 09:26:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <20230918072609.teegybfhht23gzzc@quack3>
References: <cover.1694860198.git.ojaswin@linux.ibm.com>
 <2fe0c7461d7a49eec46a1c83667ae678825d8b76.1694860198.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe0c7461d7a49eec46a1c83667ae678825d8b76.1694860198.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 16-09-23 16:12:13, Ojaswin Mujoo wrote:
> ** Short Version **
> 
> In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> never zero out the range of bh that is not under write, causing whatever stale
> data is present in the folio at that time to be written out to disk. To fix this
> mark the buffer as new in ext4_get_block_unwritten(), in case it is unwritten.
> 
> -----

I'm not sure if this separator isn't going to confuse some tools processing
patches ;)

> ** Long Version **
> 
> The issue mentioned above was resulting in two different bugs:
> 
> 1. On block size < page size case in ext4, generic/269 was reliably
> failing with dioread_nolock. The state of the write was as follows:
> 
>   * The write was extending i_size.
>   * The last block of the file was fallocated and had an unwritten extent
>   * We were near ENOSPC and hence we were switching to non-delayed alloc
>     allocation.
> 
> In this case, the back trace that triggers the bug is as follows:
> 
>   ext4_da_write_begin()
>     /* switch to nodelalloc due to low space */
>     ext4_write_begin()
>       ext4_should_dioread_nolock() // true since mount flags still have delalloc
>       __block_write_begin(..., ext4_get_block_unwritten)
>         __block_write_begin_int()
>           for(each buffer head in page) {
>             /* first iteration, this is bh1 which contains i_size */
>             if (!buffer_mapped)
>               get_block() /* returns bh with only UNWRITTEN and MAPPED */
>             /* second iteration, bh2 */
>               if (!buffer_mapped)
>                 get_block() /* we fail here, could be ENOSPC */
>           }
>           if (err)
>             /*
>              * this would zero out all new buffers and mark them uptodate.
>              * Since bh1 was never marked new, we skip it here which causes
>              * the bug later.
>              */
>             folio_zero_new_buffers();
>       /* ext4_wrte_begin() error handling */
>       ext4_truncate_failed_write()
>         ext4_truncate()
>           ext4_block_truncate_page()
>             __ext4_block_zero_page_range()
>               if(!buffer_uptodate())
>                 ext4_read_bh_lock()
>                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
>                     BUG_ON(buffer_unwritten(bh)); /* !!! */
> 
> 2. The second issue is stale data exposure with page size >= blocksize
> with dioread_nolock. The conditions needed for it to happen are same as
> the previous issue ie dioread_nolock around ENOSPC condition. The issue
> is also similar where in __block_write_begin_int() when we call
> ext4_get_block_unwritten() on the buffer_head and the underlying extent
> is unwritten, we get an unwritten and mapped buffer head. Since it is
> not new, we never zero out the partial range which is not under write,
> thus writing stale data to disk. This can be easily observed with the
> following reproducer:
> 
>  fallocate -l 4k testfile
>  xfs_io -c "pwrite 2k 2k" testfile
>  # hexdump output will have stale data in from byte 0 to 2k in testfile
>  hexdump -C testfile
> 
> NOTE: To trigger this, we need dioread_nolock enabled and write
> happening via ext4_write_begin(), which is usually used when we have -o
> nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
> alternate way to call ext4_write_begin() is to make sure dellayed
> alloc switches to nodelalloc (ext4_da_write_begin() calls
> ext4_write_begin()).  This will usually happen when ext4 is almost full
> like the way generic/269 was triggering it in Issue 1 above. This might
> make this issue harder to replicate hence for reliable replicate, I used
> the below patch to temporarily allow dioread_nolock with nodelalloc and
> then mount the disk with -o nodealloc,dioread_nolock. With this you can
> hit the stale data issue 100% of times:
> 
> @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
>   if (ext4_should_journal_data(inode))
>     return 0;
>   /* temporary fix to prevent generic/422 test failures */
> - if (!test_opt(inode->i_sb, DELALLOC))
> -   return 0;
> + // if (!test_opt(inode->i_sb, DELALLOC))
> + //  return 0;
>   return 1;
>  }
> 
> After applying this patch to mark buffer as NEW, both the above issues are
> fixed.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me. Thanks for fixing this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6c490f05e2ba..8b286a800193 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -789,10 +789,22 @@ int ext4_get_block(struct inode *inode, sector_t iblock,
>  int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>  			     struct buffer_head *bh_result, int create)
>  {
> +	int ret = 0;
> +
>  	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
>  		   inode->i_ino, create);
> -	return _ext4_get_block(inode, iblock, bh_result,
> +	ret = _ext4_get_block(inode, iblock, bh_result,
>  			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> +
> +	/*
> +	 * If the buffer is marked unwritten, mark it as new to make sure it is
> +	 * zeroed out correctly in case of partial writes. Otherwise, there is
> +	 * a chance of stale data getting exposed.
> +	 */
> +	if (ret == 0 && buffer_unwritten(bh_result))
> +		set_buffer_new(bh_result);
> +
> +	return ret;
>  }
>  
>  /* Maximum number of blocks we map for direct IO at once. */
> -- 
> 2.39.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

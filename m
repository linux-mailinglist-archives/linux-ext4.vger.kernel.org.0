Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAE6DFDE1
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDLSqs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDLSqr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 14:46:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18B7ED1;
        Wed, 12 Apr 2023 11:46:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43AF11F8A6;
        Wed, 12 Apr 2023 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681325150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7KC9QUBQaRmwJIcKPRsjcOkffavLHC13KK+SVfmZhY=;
        b=r2ubmuT1bEJy/iK41oz0vJbVQz0yxxI03nokIHDEWOJM+Dz2UNGRnc8Y3LrIIG11ZfQWSY
        MKGMiM9Qqb2ocuZODVaYeqUaRCYatCxWyBIa9jB1lgmJF+yKQTUjGgL61Vl36VvB93VDdh
        OuSLsXQLol7s5RzmYy9DlxzL7ckrFtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681325150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7KC9QUBQaRmwJIcKPRsjcOkffavLHC13KK+SVfmZhY=;
        b=qFelM2v5vwaQ/GXOFO8h7gzxupTFQgRvMmEhOT4zsD/syUNmDzW/pbhgqAmRIySONFz+s/
        wSKp00/RDMe+7VDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C62D613498;
        Wed, 12 Apr 2023 18:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MhFLL138NmRECAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 18:45:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6DCBCA0732; Wed, 12 Apr 2023 20:45:45 +0200 (CEST)
Date:   Wed, 12 Apr 2023 20:45:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 1/8] ext4: only update i_reserved_data_blocks on
 successful block allocation
Message-ID: <20230412184545.golqryhkygpke4ja@quack3>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412124126.2286716-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 12-04-23 20:41:19, Baokun Li wrote:
> In our fault injection test, we create an ext4 file, migrate it to
> non-extent based file, then punch a hole and finally trigger a WARN_ON
> in the ext4_da_update_reserve_space():
> 
> EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
> ino 14, used 11 with only 10 reserved data blocks
> 
> When writing back a non-extent based file, if we enable delalloc, the
> number of reserved blocks will be subtracted from the number of blocks
> mapped by ext4_ind_map_blocks(), and the extent status tree will be
> updated. We update the extent status tree by first removing the old
> extent_status and then inserting the new extent_status. If the block range
> we remove happens to be in an extent, then we need to allocate another
> extent_status with ext4_es_alloc_extent().
> 
>        use old    to remove   to add new
>     |----------|------------|------------|
>               old extent_status
> 
> The problem is that the allocation of a new extent_status failed due to a
> fault injection, and __es_shrink() did not get free memory, resulting in
> a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
> we map to the same extent again, and the number of reserved blocks is again
> subtracted from the number of blocks in that extent. Since the blocks in
> the same extent are subtracted twice, we end up triggering WARN_ON at
> ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
> 
> For non-extent based file, we update the number of reserved blocks after
> ext4_ind_map_blocks() is executed, which causes a problem that when we call
> ext4_ind_map_blocks() to create a block, it doesn't always create a block,
> but we always reduce the number of reserved blocks. So we move the logic
> for updating reserved blocks to ext4_ind_map_blocks() to ensure that the
> number of reserved blocks is updated only after we do succeed in allocating
> some new blocks.
> 
> Fixes: 5f634d064c70 ("ext4: Fix quota accounting error with fallocate")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Modify the patch description and add the Fixes tag.
> V2->V3:
> 	Remove the redundant judgment of count.
> 
>  fs/ext4/indirect.c |  8 ++++++++
>  fs/ext4/inode.c    | 10 ----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index c68bebe7ff4b..a9f3716119d3 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	count = ar.len;
> +
> +	/*
> +	 * Update reserved blocks/metadata blocks after successful block
> +	 * allocation which had been deferred till now.
> +	 */
> +	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> +		ext4_da_update_reserve_space(inode, count, 1);
> +
>  got_it:
>  	map->m_flags |= EXT4_MAP_MAPPED;
>  	map->m_pblk = le32_to_cpu(chain[depth-1].key);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 97eb728cb958..33ae92f0ddfb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -659,16 +659,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  			 */
>  			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
>  		}
> -
> -		/*
> -		 * Update reserved blocks/metadata blocks after successful
> -		 * block allocation which had been deferred till now. We don't
> -		 * support fallocate for non extent files. So we can update
> -		 * reserve space here.
> -		 */
> -		if ((retval > 0) &&
> -			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
> -			ext4_da_update_reserve_space(inode, retval, 1);
>  	}
>  
>  	if (retval > 0) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

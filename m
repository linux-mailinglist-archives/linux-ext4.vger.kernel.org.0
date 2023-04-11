Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575A6DD646
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDKJJ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDKJJK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 05:09:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11C3C3B;
        Tue, 11 Apr 2023 02:08:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0702721A52;
        Tue, 11 Apr 2023 09:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681204081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QUbN4X1lAo8IYkLl8j1tpyI22mHXFdudshSH8d/+5U=;
        b=W0HOkI7cZ76iUjp+bgTU5dVp1WFvRIHTmBkarmTd1ttH4vHohiEjyclUAMy132UvEckq/5
        VG4NDR2YJFilWOYHmeiXQLh2C6RgwYNpDNURsUMYE5EJH6Vm651UPZQ4SsvGu5cg4gV0L0
        PxbCGjs5xJ0CMyPgB1n+NRj6KLChOmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681204081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QUbN4X1lAo8IYkLl8j1tpyI22mHXFdudshSH8d/+5U=;
        b=YoodoRY4R6PjXkhSyT+xhzLU+bpUDUDRJEyeRMv+x65zchMVnykM39HAa5VfkZxeSu2710
        D7RL7PbjLYqFxLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E361613519;
        Tue, 11 Apr 2023 09:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zel/N3AjNWRoHgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 09:08:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 69497A0732; Tue, 11 Apr 2023 11:08:00 +0200 (CEST)
Date:   Tue, 11 Apr 2023 11:08:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/2] ext4: only update i_reserved_data_blocks on
 successful block allocation
Message-ID: <20230411090800.rrsvbab3tio7rs2m@quack3>
References: <20230406132834.1669710-1-libaokun1@huawei.com>
 <20230406132834.1669710-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406132834.1669710-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-04-23 21:28:33, Baokun Li wrote:
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

Looks good, just one nit below.

> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index c68bebe7ff4b..9acab70ddf5e 100644
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
> +	if ((count > 0) && (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))

You don't need the count > 0 condition here. It should be always true.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

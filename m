Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E06F5A0E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjECObj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjECObj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:31:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164B5B84;
        Wed,  3 May 2023 07:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7916F203FE;
        Wed,  3 May 2023 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZNTFOQn8eDuWIy1dQ84N+iF0BoSPftVSCDzWv/EXj8=;
        b=sC6p1EQ+dakyztSA8Tj+PC567V4RKW5TooJj5MgHMG/FpCex4a0PBOGlKMwPqE3hljHolw
        6ilMJnuccIrOqBqKyxaFaP01n/SuBOx8JoxmrHFTS+qEeWrFQJFAoDfqNyw71TwGsRLrN4
        jsNCYYCPpNX8DQjf0KP7MNYZAJbvaOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZNTFOQn8eDuWIy1dQ84N+iF0BoSPftVSCDzWv/EXj8=;
        b=EBNUK6vf5DToZg/Q/MH2a4sZkWcCsEI4W19hmTU7phc/XVd1hecncso3HBAm//Ck6zyNOz
        RX5yxu1a5mqI6KCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 699631331F;
        Wed,  3 May 2023 14:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FPbCGUhwUmQuRgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:31:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D8D57A0744; Wed,  3 May 2023 16:31:35 +0200 (CEST)
Date:   Wed, 3 May 2023 16:31:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 07/12] ext4: using nofail preallocation in
 ext4_es_insert_delayed_block()
Message-ID: <20230503143135.qusbbl5dmlcnmnce@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-8-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-8-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:41, Baokun Li wrote:
> Similar to in ext4_es_remove_extent(), we use a no-fail preallocation
> to avoid inconsistencies, except that here we may have to preallocate
> two extent_status.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index f4d50cd501fc..f892277155fa 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -2013,7 +2013,10 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  				 bool allocated)
>  {
>  	struct extent_status newes;
> -	int err = 0;
> +	int err1 = 0;
> +	int err2 = 0;
> +	struct extent_status *es1 = NULL;
> +	struct extent_status *es2 = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return 0;
> @@ -2028,29 +2031,37 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  
>  	ext4_es_insert_extent_check(inode, &newes);
>  
> +retry:
> +	if (err1 && !es1)
> +		es1 = __es_alloc_extent(true);
> +	if ((err1 || err2) && !es2)
> +		es2 = __es_alloc_extent(true);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
> -	err = __es_remove_extent(inode, lblk, lblk, NULL, NULL);
> -	if (err != 0)
> +	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
> +	if (err1 != 0)
>  		goto error;
> -retry:
> -	err = __es_insert_extent(inode, &newes, NULL);
> -	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
> -					  128, EXT4_I(inode)))
> -		goto retry;
> -	if (err != 0)
> +
> +	err2 = __es_insert_extent(inode, &newes, es2);
> +	if (err2 != 0)
>  		goto error;
>  
>  	if (allocated)
>  		__insert_pending(inode, lblk);
>  
> +	/* es is pre-allocated but not used, free it. */
> +	if (es1 && !es1->es_len)
> +		__es_free_extent(es1);
> +	if (es2 && !es2->es_len)
> +		__es_free_extent(es2);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> +	if (err1 || err2)
> +		goto retry;
>  
>  	ext4_es_print_tree(inode);
>  	ext4_print_pending_tree(inode);
> -
> -	return err;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

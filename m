Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E66F5A28
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjECOdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjECOdl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3086E98;
        Wed,  3 May 2023 07:33:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE76722882;
        Wed,  3 May 2023 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JDZKmq6NDdubmHkP/uNsYjONpv0JeFq0IdPtlGkuEE=;
        b=2zASYWPs4ZAgH7dOk1uX7BscTjunqDjkpuVafV2ORMShEOYFc5H+ZqNU1Otzp586qtXeeT
        MihV4fCW0njxdrpkph1MEzh9UA5H5XkGkk4YcCvyZ8ZjaAShjQ5Lma6Z+YwgtxKNyTWEHO
        h6mWD5fj+4zR87Q8au/070UPG7wGak8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JDZKmq6NDdubmHkP/uNsYjONpv0JeFq0IdPtlGkuEE=;
        b=etazrKf7yQ3UmPc1F+aMte72Q40tSpHVmUiq/fPyDzlTY8tBHG1yZgsb3AOkhDgf1m1dHF
        bElfb+OlCsjZ5gDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0AE81331F;
        Wed,  3 May 2023 14:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDqwLaJwUmT9RgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:33:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 390ADA0744; Wed,  3 May 2023 16:33:06 +0200 (CEST)
Date:   Wed, 3 May 2023 16:33:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 12/12] ext4: make ext4_zeroout_es() return void
Message-ID: <20230503143306.ie557jsej4jqvu6u@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-13-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-13-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:46, Baokun Li wrote:
> After ext4_es_insert_extent() returns void, the return value in
> ext4_zeroout_es() is also unnecessary, so make it return void too.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d555ed924f37..6c3080830b00 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3123,7 +3123,7 @@ void ext4_ext_release(struct super_block *sb)
>  #endif
>  }
>  
> -static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
> +static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>  {
>  	ext4_lblk_t  ee_block;
>  	ext4_fsblk_t ee_pblock;
> @@ -3134,11 +3134,10 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>  	ee_pblock = ext4_ext_pblock(ex);
>  
>  	if (ee_len == 0)
> -		return 0;
> +		return;
>  
>  	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
>  			      EXTENT_STATUS_WRITTEN);
> -	return 0;
>  }
>  
>  /* FIXME!! we need to try to merge to left or right after zero-out  */
> @@ -3288,7 +3287,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>  			if (!err)
>  				/* update extent status tree */
> -				err = ext4_zeroout_es(inode, &zero_ex);
> +				ext4_zeroout_es(inode, &zero_ex);
>  			/* If we failed at this point, we don't know in which
>  			 * state the extent tree exactly is so don't try to fix
>  			 * length of the original extent as it may do even more
> @@ -3641,9 +3640,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  out:
>  	/* If we have gotten a failure, don't zero out status tree */
>  	if (!err) {
> -		err = ext4_zeroout_es(inode, &zero_ex1);
> -		if (!err)
> -			err = ext4_zeroout_es(inode, &zero_ex2);
> +		ext4_zeroout_es(inode, &zero_ex1);
> +		ext4_zeroout_es(inode, &zero_ex2);
>  	}
>  	return err ? err : allocated;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51115BFCFB
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIULcc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIULca (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 07:32:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5CE8B2C8;
        Wed, 21 Sep 2022 04:32:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76B0221A59;
        Wed, 21 Sep 2022 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663759948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlaKhHzIiNQlibAYkbq1JJIgnAIakxKuj8h+EiPGGVQ=;
        b=HNMUUe0MT1h6iEXUzRbRq7Dvoni4GSaWE95fG8q2F+/MI/UBxfkGPy8Zrb/5/SsvrAwpke
        23NsdQKAhgZQJBjP1Bip2qkEebaD0h3pn5X/xKUzpe776VpmoqT+4sbjScOixI7v/c0/AE
        BmwqaKegt1G2WXtFn+kUqzyoJBNIRN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663759948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlaKhHzIiNQlibAYkbq1JJIgnAIakxKuj8h+EiPGGVQ=;
        b=+cNQkVODaXgKp8W/MCEKJWWUtz5RhjfvELFBygihfWCfvufPE8JjyKtz+BaoHXKPripoIB
        pgTzlSp2FVU+0lDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69CA313A00;
        Wed, 21 Sep 2022 11:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7+LVGUz2KmPPBAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 11:32:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 057A7A0684; Wed, 21 Sep 2022 13:32:28 +0200 (CEST)
Date:   Wed, 21 Sep 2022 13:32:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 3/3] ext4: update 'state->fc_regions_size' after
 successful memory allocation
Message-ID: <20220921113227.g3zfv474tmpzfw75@quack3>
References: <20220921064040.3693255-1-yebin10@huawei.com>
 <20220921064040.3693255-4-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064040.3693255-4-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-09-22 14:40:40, Ye Bin wrote:
> To avoid to 'state->fc_regions_size' mismatch with 'state->fc_regions'
> when fail to reallocate 'fc_reqions',only update 'state->fc_regions_size'
> after 'state->fc_regions' is allocated successfully.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f5b0fc50ed47..694ab0627395 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1681,14 +1681,15 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
>  	if (state->fc_regions_used == state->fc_regions_size) {
>  		struct ext4_fc_alloc_region *fc_regions;
>  
> -		state->fc_regions_size +=
> -			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>  		fc_regions = krealloc(state->fc_regions,
> -				      state->fc_regions_size *
> -				      sizeof(struct ext4_fc_alloc_region),
> +				      sizeof(struct ext4_fc_alloc_region) *
> +				      (state->fc_regions_size +
> +				       EXT4_FC_REPLAY_REALLOC_INCREMENT),
>  				      GFP_KERNEL);
>  		if (!fc_regions)
>  			return -ENOMEM;
> +		state->fc_regions_size +=
> +			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>  		state->fc_regions = fc_regions;
>  	}
>  	region = &state->fc_regions[state->fc_regions_used++];
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

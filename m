Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEBF5BFCFD
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIULcw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 07:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIULcv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 07:32:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C018E0C4;
        Wed, 21 Sep 2022 04:32:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31C7421B2C;
        Wed, 21 Sep 2022 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663759969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ttB+8Q2hbbpW1NGadZQxX+nDsERlqx0Ofoghf1G6H4=;
        b=UD2FMWMyAu+pSD8Nl9h7RgnqJ7tKdZK6yBxuuFID9dEabYW33LNFHmQqyLMhG4TEIxBYVY
        c+rcXXsJOJGz6BnJ0ln3hlJKLH/UFP5Dw4tcebr6vqwJynYgnzClwROyDknjjFsIUGQzGE
        86Y0Ead3CTfP3vxmIIiu2+ahw1MeTFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663759969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ttB+8Q2hbbpW1NGadZQxX+nDsERlqx0Ofoghf1G6H4=;
        b=wHMCPLNvdBYnnICK4B4IXE3H8SjwFc0QjuFvgMmnJpUuM+e5Jkr1aiXJClYjWjvt4O4wXF
        L/8xsfyyWk/YR3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F43513A00;
        Wed, 21 Sep 2022 11:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKSvA2H2KmP2BAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 11:32:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1AEBEA0684; Wed, 21 Sep 2022 13:32:47 +0200 (CEST)
Date:   Wed, 21 Sep 2022 13:32:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 2/3] ext4: fix potential memory leak in
 ext4_fc_record_regions()
Message-ID: <20220921113247.fgtxzvu35qcgjpu5@quack3>
References: <20220921064040.3693255-1-yebin10@huawei.com>
 <20220921064040.3693255-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064040.3693255-3-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-09-22 14:40:39, Ye Bin wrote:
> As krealloc may return NULL, in this case 'state->fc_regions' may not be
> freed by krealloc, but 'state->fc_regions' already set NULL. Then will
> lead to 'state->fc_regions' memory leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 29a22ee0adb8..f5b0fc50ed47 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1679,15 +1679,17 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
>  	if (replay && state->fc_regions_used != state->fc_regions_valid)
>  		state->fc_regions_used = state->fc_regions_valid;
>  	if (state->fc_regions_used == state->fc_regions_size) {
> +		struct ext4_fc_alloc_region *fc_regions;
> +
>  		state->fc_regions_size +=
>  			EXT4_FC_REPLAY_REALLOC_INCREMENT;
> -		state->fc_regions = krealloc(
> -					state->fc_regions,
> -					state->fc_regions_size *
> -					sizeof(struct ext4_fc_alloc_region),
> -					GFP_KERNEL);
> -		if (!state->fc_regions)
> +		fc_regions = krealloc(state->fc_regions,
> +				      state->fc_regions_size *
> +				      sizeof(struct ext4_fc_alloc_region),
> +				      GFP_KERNEL);
> +		if (!fc_regions)
>  			return -ENOMEM;
> +		state->fc_regions = fc_regions;
>  	}
>  	region = &state->fc_regions[state->fc_regions_used++];
>  	region->ino = ino;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

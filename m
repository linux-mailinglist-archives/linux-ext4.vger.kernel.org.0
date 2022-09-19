Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784E5BD0D9
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiISP0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiISP0a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 11:26:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738696246;
        Mon, 19 Sep 2022 08:26:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64B7F22124;
        Mon, 19 Sep 2022 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663601186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mWso4401Km7Ox7DDan+Kb2HF4fLnZr56FlY67loDdk=;
        b=nROeh0jnUeKYcqGJjTi5SJbhtU7J83PSEdo28OHe0M7ws0rgRrZ0c0ws6WrYd8uq0ip1Y9
        Tdg6h7Abc1nUZvXfccZcPa/B1XQUN9gAhl0YirWfpfH+ewNyQ/2RNpRtg5NHtO5OFFGOu7
        xryhGsICCxfguvRYjbYJM4Z2Y0xK2qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663601186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mWso4401Km7Ox7DDan+Kb2HF4fLnZr56FlY67loDdk=;
        b=qBDkSNQ6ZrEDDo2zJMpT9lhWbWoOZ6V9/Dq+5nHQKJaThXKn0LiZmDsW/9a9CfTrh+hUkk
        pK3hb1N80XSD8uBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A24A13A96;
        Mon, 19 Sep 2022 15:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id STkMEiKKKGNweAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 15:26:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D1609A0682; Mon, 19 Sep 2022 17:26:25 +0200 (CEST)
Date:   Mon, 19 Sep 2022 17:26:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 1/2] ext4: fix potential memory leak in
 ext4_fc_record_regions()
Message-ID: <20220919152625.36ao6aeyoamiaaor@quack3>
References: <20220919144021.2162295-1-yebin10@huawei.com>
 <20220919144021.2162295-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919144021.2162295-2-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 19-09-22 22:40:20, Ye Bin wrote:
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
> index 9217a588afd1..cc8c8db075ba 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1677,15 +1677,17 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
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

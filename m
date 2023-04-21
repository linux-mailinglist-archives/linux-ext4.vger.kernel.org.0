Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625776EA710
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Apr 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDUJfM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Apr 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjDUJfL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Apr 2023 05:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DDAD11;
        Fri, 21 Apr 2023 02:35:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FF471FDDB;
        Fri, 21 Apr 2023 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682069703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeugHy/uBqAQ8QpbO//UGamDdqRAMjvSp/iBD9iGNUs=;
        b=mst/4ZZg266RVqOtJyK+78I+nRWON/v9YxCGJAL1swN5qwvL3jIXFtfoqsK9ypFSGGUl4a
        dUdhfZoSu+9ufkhW7oYBdnayc2e6qKK4A99zuZSLsFbNj8Ad4Pv9hCx1q4xMWETU6wh3EF
        anXKLoSHqrckALRLjWxM6QEkJfS2HkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682069703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeugHy/uBqAQ8QpbO//UGamDdqRAMjvSp/iBD9iGNUs=;
        b=okE1v9so2dAe1Etv49srTgsfA7kURy219cRFW7GR4W5YWr2YhtskDYpadrBUgaDqIof3Ip
        v6ENxLHCqLOlYVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 278E113456;
        Fri, 21 Apr 2023 09:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KHWeCcdYQmQiUgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 09:35:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8ED1BA0729; Fri, 21 Apr 2023 11:35:02 +0200 (CEST)
Date:   Fri, 21 Apr 2023 11:35:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <chao@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix wrong calculation of minlen in ext4_trim_fs()
Message-ID: <20230421093502.n4x3c773udaapksl@quack3>
References: <20230406150621.3854298-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406150621.3854298-1-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-04-23 23:06:21, Chao Yu wrote:
> As Ted pointed out as below:
> 
> "
> However the minlen variable in ext4_trim_fs is in units of *clusters*.
> And so it gets rounded up two places.  The first time is when it is
> converted into units of a cluster:
> 
> 	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
> 			      range->minlen >> sb->s_blocksize_bits);
> 
> Oh, and by the way, that first conversion is not correct as currently
> written in ext4_fs_trim().   It should be
> 
> 	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
> 		(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
> "
> 
> The reason is if range->minlen is smaller than block size of ext4,
> original calculation "range->minlen >> sb->s_blocksize_bits" may
> return zero, but since EXT4_NUM_B2C() expects a non-zero in-parameter,
> so it needs to round up range->minlen to cluster size directly as above.
> 
> Link: https://lore.kernel.org/lkml/20230311031843.GF860405@mit.edu/
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..d8b9d6a83d1e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6478,8 +6478,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  
>  	start = range->start >> sb->s_blocksize_bits;
>  	end = start + (range->len >> sb->s_blocksize_bits) - 1;
> -	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
> -			      range->minlen >> sb->s_blocksize_bits);
> +	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
> +			(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
>  
>  	if (minlen > EXT4_CLUSTERS_PER_GROUP(sb) ||
>  	    start >= max_blks ||
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

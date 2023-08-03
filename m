Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A76EC38
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjHCOTB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjHCOTA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:19:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3DF5
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:18:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F95E21985;
        Thu,  3 Aug 2023 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691072338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4aCDTtv/Ahzo1axonDQ7a0ecaLV7qzWhidw5wMPYJs=;
        b=ljc4cey46aGBBxsNwtApc1z5FEaClnwuhxRoBd0Z867cc8ocBfm77wp+7wxxu0M0Xoxm6d
        OEwbkgCWMGOdWR6v8nprqkO2LAyyMLFJylasQNjW7ipDeB1eFKWVJdegRd6hancwF7bo62
        v9ErMuNZc/W+3GDVyX+GFgwhvd/YghY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691072338;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4aCDTtv/Ahzo1axonDQ7a0ecaLV7qzWhidw5wMPYJs=;
        b=r4Q/nNg4B2sgmQXBaJLyqxLfQsTWlz2FjNADOteHVAegE/tdMriOXBkUX78i8D1RI5Wt1G
        Q3RMOcrVDTBwn2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31ADD1333C;
        Thu,  3 Aug 2023 14:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xZYYDFK3y2QGDAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:18:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AB67AA076B; Thu,  3 Aug 2023 16:18:57 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:18:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 04/12] jbd2: checking valid features early in
 journal_get_superblock()
Message-ID: <20230803141857.ec5sjy6deg7stnax@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-5-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-5-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:25, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> journal_get_superblock() is used to check validity of the jounal
> supberblock, so move the features checks from jbd2_journal_load() to
> journal_get_superblock().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index c7cdb434966f..d84f26b08315 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1398,6 +1398,21 @@ static int journal_get_superblock(journal_t *journal)
>  		goto out;
>  	}
>  
> +	/*
> +	 * If this is a V2 superblock, then we have to check the
> +	 * features flags on it.
> +	 */
> +	if (!jbd2_format_support_feature(journal))
> +		return 0;
> +
> +	if ((sb->s_feature_ro_compat &
> +			~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
> +	    (sb->s_feature_incompat &
> +			~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
> +		printk(KERN_WARNING "JBD2: Unrecognised features on journal\n");
> +		goto out;
> +	}
> +
>  	if (jbd2_has_feature_csum2(journal) &&
>  	    jbd2_has_feature_csum3(journal)) {
>  		/* Can't have checksum v2 and v3 at the same time! */
> @@ -2059,21 +2074,6 @@ int jbd2_journal_load(journal_t *journal)
>  	int err;
>  	journal_superblock_t *sb = journal->j_superblock;
>  
> -	/*
> -	 * If this is a V2 superblock, then we have to check the
> -	 * features flags on it.
> -	 */
> -	if (jbd2_format_support_feature(journal)) {
> -		if ((sb->s_feature_ro_compat &
> -		     ~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
> -		    (sb->s_feature_incompat &
> -		     ~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
> -			printk(KERN_WARNING
> -				"JBD2: Unrecognised features on journal\n");
> -			return -EINVAL;
> -		}
> -	}
> -
>  	/*
>  	 * Create a slab for this blocksize
>  	 */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1478DAAF
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Aug 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjH3Sgx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Aug 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbjH3NKg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Aug 2023 09:10:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E4124
        for <linux-ext4@vger.kernel.org>; Wed, 30 Aug 2023 06:10:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5E8821865;
        Wed, 30 Aug 2023 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693401031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OSMS43Esm5GZOYhPPBFOKfXgxG3VCMYyBXCLOZLH/A=;
        b=JYMqle8PdJ9MoNEiXK+Onfb+wTEjoJjsgnYxXLXc4Q0kblxGqPuERBQh9B/7hgau7dJ5Pm
        luXV9D5TBvLP71yyEPeIBOYlZGt1aQoP4mk2TUIAJ9b5oQhTKLqBoNqdocK73/6oaQ28Qg
        y9fXNGETxN43huO7GkjcJ6PgHbQmAuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693401031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OSMS43Esm5GZOYhPPBFOKfXgxG3VCMYyBXCLOZLH/A=;
        b=mSlCJrT1+TDkYb/aOBscAo5SlUeC9rrEfRc31m85HC0WS0xt28SdCYZQVWveWMjudtFOoB
        xo67QXmeTdMnSJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A725813441;
        Wed, 30 Aug 2023 13:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4V3EKMc/72T1XgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 13:10:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38BD3A0774; Wed, 30 Aug 2023 15:10:31 +0200 (CEST)
Date:   Wed, 30 Aug 2023 15:10:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 01/16] ext4: correct the start block of counting
 reserved clusters
Message-ID: <20230830131031.j7r266e77i5k6z2p@quack3>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
 <20230824092619.1327976-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824092619.1327976-2-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 17:26:04, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When big allocate feature is enabled, we need to count and update
> reserved clusters before removing a delayed only extent_status entry.
> {init|count|get}_rsvd() have already done this, but the start block
> number of this counting isn's correct in the following case.
> 
>   lblk            end
>    |               |
>    v               v
>           -------------------------
>           |                       | orig_es
>           -------------------------
>                    ^              ^
>       len1 is 0    |     len2     |
> 
> If the start block of the orig_es entry founded is bigger than lblk, we
> passed lblk as start block to count_rsvd(), but the length is correct,
> finally, the range to be counted is offset. This patch fix this by
> passing the start blocks to 'orig_es->lblk + len1'.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 6f7de14c0fa8..5e625ea4545d 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1405,8 +1405,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  			}
>  		}
>  		if (count_reserved)
> -			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
> -				   &orig_es, &rc);
> +			count_rsvd(inode, orig_es.es_lblk + len1,
> +				   orig_es.es_len - len1 - len2, &orig_es, &rc);
>  		goto out_get_reserved;
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

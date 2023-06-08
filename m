Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAB7284BC
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjFHQVf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHQVe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 12:21:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC611A;
        Thu,  8 Jun 2023 09:21:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AE9421A77;
        Thu,  8 Jun 2023 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686241292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Civ667UQ8fwevWftFe2wG8O2eACHxqqQ5lCSI9TWYew=;
        b=G47wYF+u6AAVM2Sk8k+YW082RJjORT0h5pE9BcdFNOzg+ItjMRdqsOy+UOGZq9ydDSEwvg
        J/gzdnHC0zzAMfYcs9fZPobRhucEpId8nGQ/HxQBgwzZGJ77nxIToOyQq53iBVGwpHUW8d
        e8YXN/RqdOcEAjDqMX0XdhBjFta9/AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686241292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Civ667UQ8fwevWftFe2wG8O2eACHxqqQ5lCSI9TWYew=;
        b=8oMJG4pqt/sf9ulFNcM63hCkr5TkAYlUe4nrtcfo4T+uyiWLYkbvJIGoMRlL+mRoxvOZz3
        Otqv2L1NCZyzScDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DB5C138E6;
        Thu,  8 Jun 2023 16:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zZsNDwwAgmTNMgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 16:21:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5895A0749; Thu,  8 Jun 2023 18:21:31 +0200 (CEST)
Date:   Thu, 8 Jun 2023 18:21:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] ext4: Fix traditional comparison using max/min method
Message-ID: <20230608162131.kduwoemmbeowmfg4@quack3>
References: <20230529070930.37949-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529070930.37949-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 29-05-23 15:09:30, Lu Hongfei wrote:
> It would be better to replace the traditional ternary conditional
> operator with max()/min()
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/balloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>  mode change 100644 => 100755 fs/ext4/balloc.c
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde817be8..82124045d187
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -111,10 +111,8 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
>  	itbl_blk_start = ext4_inode_table(sb, gdp);
>  	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
>  	if (itbl_blk_start <= end && itbl_blk_end >= start) {
> -		itbl_blk_start = itbl_blk_start >= start ?
> -			itbl_blk_start : start;
> -		itbl_blk_end = itbl_blk_end <= end ?
> -			itbl_blk_end : end;
> +		itbl_blk_start = max(itbl_blk_start, start);
> +		itbl_blk_end = min(itbl_blk_end, end);
>  
>  		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
>  		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278536ADCEC
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCGLLc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 06:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCGLKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 06:10:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F44EEB;
        Tue,  7 Mar 2023 03:08:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83E711FE17;
        Tue,  7 Mar 2023 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678187310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke0dwB/JnvVq913tkGvA2kFCWjz26aytoZuIJ1/fCDk=;
        b=htNaRrDyzDDcQeMjvq7VFJWZEs3Ii7BOn+5EDF67zM4KOh6DP3D/ntv3IHWxmxhdadUs7l
        tPq7ciRo3jVfPub4yjtijZon8j0bUCvR4ylEF+P/yJJ/LSLqE6kz7+h3TIbbMTHANlHvVk
        Ti238oLygVfOumsl7DO7Os6sf5m4fwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678187310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke0dwB/JnvVq913tkGvA2kFCWjz26aytoZuIJ1/fCDk=;
        b=gccWx0Q58D350oODKXrIPW/kr1w325oBnGKraZQmeKq9Mquv7hC2FcelhfJtpQ0isrV/fB
        og6LOthwleN0xXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75C8313440;
        Tue,  7 Mar 2023 11:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kkq6HC4bB2RjewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 11:08:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0811AA06F3; Tue,  7 Mar 2023 12:08:30 +0100 (CET)
Date:   Tue, 7 Mar 2023 12:08:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 3/4] ext4: remove unused group parameter in
 ext4_block_bitmap_csum_verify
Message-ID: <20230307110830.w7nuk3mrgjgfezig@quack3>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
 <20230221203027.2359920-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221203027.2359920-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-02-23 04:30:26, Kemeng Shi wrote:
> Remove unused group parameter in ext4_block_bitmap_csum_verify.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/balloc.c | 3 +--
>  fs/ext4/bitmap.c | 2 +-
>  fs/ext4/ext4.h   | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 689edfed231a..49fdb758b0e4 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -385,8 +385,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>  	ext4_lock_group(sb, block_group);
>  	if (buffer_verified(bh))
>  		goto verified;
> -	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
> -						    desc, bh) ||
> +	if (unlikely(!ext4_block_bitmap_csum_verify(sb, desc, bh) ||
>  		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
>  		ext4_unlock_group(sb, block_group);
>  		ext4_error(sb, "bg %u: bad block bitmap checksum", block_group);
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index 0186b894f5b3..3b83d979a650 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -54,7 +54,7 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
>  		gdp->bg_inode_bitmap_csum_hi = cpu_to_le16(csum >> 16);
>  }
>  
> -int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
> +int ext4_block_bitmap_csum_verify(struct super_block *sb,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh)
>  {
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index aa6948d12ede..04447640b4f4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2685,7 +2685,7 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>  void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh);
> -int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
> +int ext4_block_bitmap_csum_verify(struct super_block *sb,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

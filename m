Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647E6ADCE7
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCGLLU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 06:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCGLKp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 06:10:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACFE1C591;
        Tue,  7 Mar 2023 03:08:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CAB5B21A39;
        Tue,  7 Mar 2023 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678187285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIkYkZyfmRrQzHpCIUXZzrN/nyNF83tHW1n7hHdKFww=;
        b=kR/w7oBHVg0CdF18NC/42OdPTKLCFL57TSVZuPrsODI+smRzo6PSM9W01/doh/GhKBN4ZD
        /AohSzCLbvXPFtrHVYKKvsTFZnpvrdepJMLPMV/9wklHD9/k3SUnjT/yrmmcQaESrwL5Ks
        a9loZyl8CfiaBCU814DB71gifGLPWtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678187285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIkYkZyfmRrQzHpCIUXZzrN/nyNF83tHW1n7hHdKFww=;
        b=DN2NSS1PsUB467zcBCySuDmPhap2YGxcNZYo+Q0Q0KjJmbnVcIUL/Sj3JDg4oTFU71QDle
        9nFn0cUI4jdveFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC6B513440;
        Tue,  7 Mar 2023 11:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MVn8LRUbB2QMewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 11:08:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5ABF7A06F3; Tue,  7 Mar 2023 12:08:05 +0100 (CET)
Date:   Tue, 7 Mar 2023 12:08:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 2/4] ext4: remove unused group parameter in
 ext4_inode_bitmap_csum_set
Message-ID: <20230307110805.no3ww6rgrovmpire@quack3>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
 <20230221203027.2359920-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221203027.2359920-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-02-23 04:30:25, Kemeng Shi wrote:
> Remove unused group parameter in ext4_inode_bitmap_csum_set.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/bitmap.c | 2 +-
>  fs/ext4/ext4.h   | 2 +-
>  fs/ext4/ialloc.c | 6 +++---
>  fs/ext4/resize.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index 3bb28fad624f..0186b894f5b3 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -38,7 +38,7 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>  	return provided == calculated;
>  }
>  
> -void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
> +void ext4_inode_bitmap_csum_set(struct super_block *sb,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh, int sz)
>  {
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index db2476daebd2..aa6948d12ede 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2676,7 +2676,7 @@ struct mmpd_data {
>  
>  /* bitmap.c */
>  extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
> -void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
> +void ext4_inode_bitmap_csum_set(struct super_block *sb,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh, int sz);
>  int ext4_inode_bitmap_csum_verify(struct super_block *sb,
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 7e388340f588..b86756c57c0b 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -327,7 +327,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		if (percpu_counter_initialized(&sbi->s_dirs_counter))
>  			percpu_counter_dec(&sbi->s_dirs_counter);
>  	}
> -	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bitmap_bh,
> +	ext4_inode_bitmap_csum_set(sb, gdp, bitmap_bh,
>  				   EXT4_INODES_PER_GROUP(sb) / 8);
>  	ext4_group_desc_csum_set(sb, block_group, gdp);
>  	ext4_unlock_group(sb, block_group);
> @@ -852,7 +852,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
>  
>  	ext4_free_inodes_set(sb, gdp, ext4_free_inodes_count(sb, gdp) - 1);
>  	if (ext4_has_group_desc_csum(sb)) {
> -		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
> +		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
>  					   EXT4_INODES_PER_GROUP(sb) / 8);
>  		ext4_group_desc_csum_set(sb, group, gdp);
>  	}
> @@ -1222,7 +1222,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  		}
>  	}
>  	if (ext4_has_group_desc_csum(sb)) {
> -		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
> +		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
>  					   EXT4_INODES_PER_GROUP(sb) / 8);
>  		ext4_group_desc_csum_set(sb, group, gdp);
>  	}
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 6b91443d6bf3..607a1af00665 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1318,7 +1318,7 @@ static int ext4_set_bitmap_checksums(struct super_block *sb,
>  	bh = ext4_get_bitmap(sb, group_data->inode_bitmap);
>  	if (!bh)
>  		return -EIO;
> -	ext4_inode_bitmap_csum_set(sb, group, gdp, bh,
> +	ext4_inode_bitmap_csum_set(sb, gdp, bh,
>  				   EXT4_INODES_PER_GROUP(sb) / 8);
>  	brelse(bh);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

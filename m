Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA76ADCE3
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 12:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCGLK6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 06:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCGLKi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 06:10:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FE65A5;
        Tue,  7 Mar 2023 03:07:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 887651FE18;
        Tue,  7 Mar 2023 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678187249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5lYVFvLUJHOQaXldz65EVuoP5HIEFAFGY3pzs8N9dM=;
        b=l9R4WFb3i7lfT+ef+orkdhnr1fuOMn6143z5744I+GzS45ewy3IS2uht3yl9XrH6T+dN6E
        2Nw6D/HzpJnI5Kyy0v8yYwpZ1DgMlWRwb+nkv/HaX+hnc/jfv3Q83WGWMIMcw1/zMsx7yR
        w2TP1tf501DR8DksXKqNwd3VAMc8L3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678187249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5lYVFvLUJHOQaXldz65EVuoP5HIEFAFGY3pzs8N9dM=;
        b=J7t5v4TMf/duuwNdpKNG00ZYHvhz2FLMqRodgCE+JlgIugHx1jK3SsVt+9Z6A/EbEU3aDf
        jPe60YijXqX8hgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F3AF13440;
        Tue,  7 Mar 2023 11:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sEcfG/EaB2TDegAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 11:07:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A6DF6A06F3; Tue,  7 Mar 2023 12:07:28 +0100 (CET)
Date:   Tue, 7 Mar 2023 12:07:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 1/4] ext4: remove unused group parameter in
 ext4_inode_bitmap_csum_verify
Message-ID: <20230307110728.l6fdsdsrsl4k7hrz@quack3>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
 <20230221203027.2359920-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221203027.2359920-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-02-23 04:30:24, Kemeng Shi wrote:
> Remove unused group parameter in ext4_inode_bitmap_csum_verify.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/bitmap.c | 2 +-
>  fs/ext4/ext4.h   | 2 +-
>  fs/ext4/ialloc.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index f63e028c638c..3bb28fad624f 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -16,7 +16,7 @@ unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
>  	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
>  }
>  
> -int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
> +int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh, int sz)
>  {
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6479146140d2..db2476daebd2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2679,7 +2679,7 @@ extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
>  void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh, int sz);
> -int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
> +int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh, int sz);
>  void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 63f9bb6e8851..7e388340f588 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -98,7 +98,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>  	if (buffer_verified(bh))
>  		goto verified;
>  	blk = ext4_inode_bitmap(sb, desc);
> -	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
> +	if (!ext4_inode_bitmap_csum_verify(sb, desc, bh,
>  					   EXT4_INODES_PER_GROUP(sb) / 8) ||
>  	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
>  		ext4_unlock_group(sb, block_group);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

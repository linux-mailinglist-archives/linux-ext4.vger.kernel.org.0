Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B75A7C65
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiHaLq6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHaLq5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:46:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA9C04EF
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:46:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A006621B14;
        Wed, 31 Aug 2022 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoDyokEJgH+O9mAWuy8s9G7reISyYNwiVIugP7rlKXw=;
        b=bTve3zgbHTx37xKlL/7NrfhUQmhzrM6S52OQFAcrNxiQxfhvVQI8dcVwvPy3t3iwUE6Bg5
        sjaSeEkXhujroXoX3Rnf36dO5OynrTJDcfP0bM/ux++nFd5rzWYev2qCtlmt0McEY15V7B
        kdhJpSZDDJIU/l5UsaI/qGpaWk/3bAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoDyokEJgH+O9mAWuy8s9G7reISyYNwiVIugP7rlKXw=;
        b=L/PdirpSoHEYo2Hs222HkiryacsoJTgEpORBUlu8ylPlBgonFn7HJjHkHItmkDdu7PNF/R
        1txWO/7Oa/TK/YCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF9E1332D;
        Wed, 31 Aug 2022 11:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAMqIy5KD2OtBwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:46:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 857B0A067B; Wed, 31 Aug 2022 13:46:53 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:46:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 04/13] ext4: factor out ext4_handle_clustersize()
Message-ID: <20220831114653.4ipxc46unpfwwgoe@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-5-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-5-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:02, Jason Yan wrote:
> Factor out ext4_handle_clustersize(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 66a128e5a9c8..1855559be4f2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4366,6 +4366,64 @@ static void ext4_set_def_opts(struct super_block *sb,
>  		set_opt(sb, DELALLOC);
>  }
>  
> +static int ext4_handle_clustersize(struct super_block *sb, int blocksize)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_super_block *es = sbi->s_es;
> +	int clustersize;
> +
> +	/* Handle clustersize */
> +	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
> +	if (ext4_has_feature_bigalloc(sb)) {
> +		if (clustersize < blocksize) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "cluster size (%d) smaller than "
> +				 "block size (%d)", clustersize, blocksize);
> +			return -EINVAL;
> +		}
> +		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
> +			le32_to_cpu(es->s_log_block_size);
> +		sbi->s_clusters_per_group =
> +			le32_to_cpu(es->s_clusters_per_group);
> +		if (sbi->s_clusters_per_group > blocksize * 8) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "#clusters per group too big: %lu",
> +				 sbi->s_clusters_per_group);
> +			return -EINVAL;
> +		}
> +		if (sbi->s_blocks_per_group !=
> +		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
> +			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
> +				 "clusters per group (%lu) inconsistent",
> +				 sbi->s_blocks_per_group,
> +				 sbi->s_clusters_per_group);
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (clustersize != blocksize) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "fragment/cluster size (%d) != "
> +				 "block size (%d)", clustersize, blocksize);
> +			return -EINVAL;
> +		}
> +		if (sbi->s_blocks_per_group > blocksize * 8) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "#blocks per group too big: %lu",
> +				 sbi->s_blocks_per_group);
> +			return -EINVAL;
> +		}
> +		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
> +		sbi->s_cluster_bits = 0;
> +	}
> +	sbi->s_cluster_ratio = clustersize / blocksize;
> +
> +	/* Do we have standard group size of clustersize * 8 blocks ? */
> +	if (sbi->s_blocks_per_group == clustersize << 3)
> +		set_opt2(sb, STD_GROUP_SIZE);
> +
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4377,7 +4435,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	unsigned long offset = 0;
>  	struct inode *root;
>  	int ret = -ENOMEM;
> -	int blocksize, clustersize;
> +	int blocksize;
>  	unsigned int db_count;
>  	unsigned int i;
>  	int needs_recovery, has_huge_files;
> @@ -4847,54 +4905,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		}
>  	}
>  
> -	/* Handle clustersize */
> -	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
> -	if (ext4_has_feature_bigalloc(sb)) {
> -		if (clustersize < blocksize) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "cluster size (%d) smaller than "
> -				 "block size (%d)", clustersize, blocksize);
> -			goto failed_mount;
> -		}
> -		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
> -			le32_to_cpu(es->s_log_block_size);
> -		sbi->s_clusters_per_group =
> -			le32_to_cpu(es->s_clusters_per_group);
> -		if (sbi->s_clusters_per_group > blocksize * 8) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "#clusters per group too big: %lu",
> -				 sbi->s_clusters_per_group);
> -			goto failed_mount;
> -		}
> -		if (sbi->s_blocks_per_group !=
> -		    (sbi->s_clusters_per_group * (clustersize / blocksize))) {
> -			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
> -				 "clusters per group (%lu) inconsistent",
> -				 sbi->s_blocks_per_group,
> -				 sbi->s_clusters_per_group);
> -			goto failed_mount;
> -		}
> -	} else {
> -		if (clustersize != blocksize) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "fragment/cluster size (%d) != "
> -				 "block size (%d)", clustersize, blocksize);
> -			goto failed_mount;
> -		}
> -		if (sbi->s_blocks_per_group > blocksize * 8) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "#blocks per group too big: %lu",
> -				 sbi->s_blocks_per_group);
> -			goto failed_mount;
> -		}
> -		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
> -		sbi->s_cluster_bits = 0;
> -	}
> -	sbi->s_cluster_ratio = clustersize / blocksize;
> -
> -	/* Do we have standard group size of clustersize * 8 blocks ? */
> -	if (sbi->s_blocks_per_group == clustersize << 3)
> -		set_opt2(sb, STD_GROUP_SIZE);
> +	if (ext4_handle_clustersize(sb, blocksize))
> +		goto failed_mount;
>  
>  	/*
>  	 * Test whether we have more sectors than will fit in sector_t,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

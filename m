Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36F776ED73
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjHCPCc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 11:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjHCPCb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 11:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63263198A;
        Thu,  3 Aug 2023 08:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4E261DEC;
        Thu,  3 Aug 2023 15:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C6C433C8;
        Thu,  3 Aug 2023 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691074949;
        bh=eJG2y8lWiM9+Gm8twe05n+s2uPVK+OJcTkp9+x5uPx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXb/3dayOF5xVdmMG+rCWicLUQZ9tzAxLytSwZQdkPanPjKKeEA1MpLAibwOGh/GG
         t6QHQOvrTtBBBYzdubk+5pCYf0KJrAyaXhLGg/QwO/k/muIydUFJRJWiLzp6848jVG
         LCoWRGSNbGmHbmLGTBa4j+Gnz0ogfdVQfqcpE5kTMAF+ZxK6inJhdoa2Rawa48/xpA
         vrzh6+RxKL1tL8up2BLJV0P8GX4sRVnW/tvkOaIPLTd4BcQ7jD0QOY+6oJW8RV1EaP
         VYnKMCVnYeMYtz96HOf9akhzggBzBRp+JmJSkALVOzAE+QTZMWgf5MzDgnrvkEaMay
         CiWq9ivDf8bGw==
Date:   Thu, 3 Aug 2023 08:02:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v4] ext4: Fix rec_len verify error
Message-ID: <20230803150228.GC11332@frogsfrogsfrogs>
References: <20230803060938.1929759-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803060938.1929759-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 03, 2023 at 02:09:38PM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
> 
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum
> 
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
> 
> But it is not the same condition when blocksize equals to 4k.
> when enough files are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
> 
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k.
> To address this, helpers like ext4_rec_len_{from,to}_disk has already
> been introduced to complete the conversion between the encoded and the
> plain form of rec_len.
> 
> So fix this one by using the helper, and all the other in this file too.
> 
> Cc: stable@kernel.org
> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> v3->v4:
>  1,Convert all the other rec_len, litrerally.
>  2,Lift a helper output to a local variable.
>  --Suggested by Darrick.
> v2->v3:
>  1,Convert all the other rec_len if necessary, as suggested by Darrick.
>  2,Rephrase the commit message.
> v1->v2:
>  Use the existing helper to covert the rec_len, as suggested by Andreas.
> 
>  fs/ext4/namei.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..34fb2d1e66aa 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -343,17 +343,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
>  						   struct buffer_head *bh)
>  {
>  	struct ext4_dir_entry_tail *t;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
>  
>  #ifdef PARANOID
>  	struct ext4_dir_entry *d, *top;
>  
>  	d = (struct ext4_dir_entry *)bh->b_data;
>  	top = (struct ext4_dir_entry *)(bh->b_data +
> -		(EXT4_BLOCK_SIZE(inode->i_sb) -
> -		 sizeof(struct ext4_dir_entry_tail)));
> -	while (d < top && d->rec_len)
> +		(blocksize - sizeof(struct ext4_dir_entry_tail)));
> +	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
>  		d = (struct ext4_dir_entry *)(((void *)d) +
> -		    le16_to_cpu(d->rec_len));
> +		    ext4_rec_len_from_disk(d->rec_len, blocksize));
>  
>  	if (d != top)
>  		return NULL;
> @@ -364,7 +364,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
>  #endif
>  
>  	if (t->det_reserved_zero1 ||
> -	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
> +	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
> +	     sizeof(struct ext4_dir_entry_tail)) ||
>  	    t->det_reserved_zero2 ||
>  	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
>  		return NULL;
> @@ -445,13 +446,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	struct ext4_dir_entry *dp;
>  	struct dx_root_info *root;
>  	int count_offset;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
> +	unsigned int rlen = ext4_rec_len_from_disk(dirent->rec_len, blocksize);

Nit: I'd have called ^^^^ this rec_len, not rlen, but I'll let Ted
decide if he wants to change that on commit.

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
> -	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
> +	if (rlen == blocksize)
>  		count_offset = 8;
> -	else if (le16_to_cpu(dirent->rec_len) == 12) {
> +	else if (rlen == 12) {
>  		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
> -		if (le16_to_cpu(dp->rec_len) !=
> -		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
> +		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
>  			return NULL;
>  		root = (struct dx_root_info *)(((void *)dp + 12));
>  		if (root->reserved_zero ||
> @@ -1315,6 +1317,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
>  	unsigned int buflen = bh->b_size;
>  	char *base = bh->b_data;
>  	struct dx_hash_info h = *hinfo;
> +	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
>  
>  	if (ext4_has_metadata_csum(dir->i_sb))
>  		buflen -= sizeof(struct ext4_dir_entry_tail);
> @@ -1335,11 +1338,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
>  			map_tail--;
>  			map_tail->hash = h.hash;
>  			map_tail->offs = ((char *) de - base)>>2;
> -			map_tail->size = le16_to_cpu(de->rec_len);
> +			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
> +								blocksize);
>  			count++;
>  			cond_resched();
>  		}
> -		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
> +		de = ext4_next_entry(de, blocksize);
>  	}
>  	return count;
>  }
> -- 
> 2.27.0
> 

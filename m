Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85776B85E
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjHAPSf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 11:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjHAPSc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 11:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082182102;
        Tue,  1 Aug 2023 08:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A2461531;
        Tue,  1 Aug 2023 15:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED480C433C8;
        Tue,  1 Aug 2023 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690903109;
        bh=iR0vxFbHHnoGoKhRMvkLfrUpLYKG6Zy8MO5fgey7/WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R33CuhpMn3/kdUcPqTebZEgIk+MbCkDnO8EGLjqZNH4Ts1Fk4d+Dv8hTjt1nKx0ig
         NhCfBsGyTlsL7BD/334bYwz70owny1S6yOIVmEijXb5Vu5nDiMUBVMOI7bT3z5CcXt
         6Iyr7x5mF29qn00w/iHvY7PP1dSkqDPIAF2rVXg5R83zXqR2gzgLljSqTVdwr6q0eN
         GHHYfzI4ETWP5zvhtOTcPQriZDPNixmcU/jRui0X58uMMkp4dK6iIVZmascTP5I2VW
         2iqvk1SwAAb0apBIA6hMdtbLLYNlOauQBJcQ5M1yPOijaTOXSOBbzJWwI4VoQfLoP4
         lH7uP3QNUsaIw==
Date:   Tue, 1 Aug 2023 08:18:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
Message-ID: <20230801151828.GB11332@frogsfrogsfrogs>
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112337.1856215-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 01, 2023 at 07:23:37PM +0800, zhangshida wrote:
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
> been introduce to complete the conversion between the encoded and the
> plain form of rec_len.
> 
> So fix this one by using the helper, and all the other
> le16_to_cpu(ext4_dir_entry{,_2}.rec_len) accesses in this file too.
> 
> Cc: stable@kernel.org
> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> v1->v2:
>  Use the existing helper to covert the rec_len, as suggested by Andreas.
> v2->v3:
>  1,Covert all the other rec_len if necessary, as suggested by Darrick.
>  2,Rephrase the commit message.
> 
>  fs/ext4/namei.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..8cb377b8ad86 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -346,14 +346,14 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
>  
>  #ifdef PARANOID
>  	struct ext4_dir_entry *d, *top;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
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

This is sitll missing some pieces; what about this clause at line 367:

	if (t->det_reserved_zero1 ||
	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
	    t->det_reserved_zero2 ||
	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
		return NULL;

> @@ -445,13 +445,13 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	struct ext4_dir_entry *dp;
>  	struct dx_root_info *root;
>  	int count_offset;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
>  
> -	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
> +	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
>  		count_offset = 8;
> -	else if (le16_to_cpu(dirent->rec_len) == 12) {
> +	else if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == 12) {

Why not lift this ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ to a
local variable?  @dirent doesn't change, right?

>  		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
> -		if (le16_to_cpu(dp->rec_len) !=
> -		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
> +		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
>  			return NULL;
>  		root = (struct dx_root_info *)(((void *)dp + 12));
>  		if (root->reserved_zero ||

What about dx_make_map?

Here's all the opencoded access I could find:

$ git grep le16.*rec_len fs/ext4/
fs/ext4/namei.c:356:                le16_to_cpu(d->rec_len));
fs/ext4/namei.c:367:        le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
fs/ext4/namei.c:449:    if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
fs/ext4/namei.c:451:    else if (le16_to_cpu(dirent->rec_len) == 12) {
fs/ext4/namei.c:453:            if (le16_to_cpu(dp->rec_len) !=
fs/ext4/namei.c:1338:                   map_tail->size = le16_to_cpu(de->rec_len);

--D

> -- 
> 2.27.0
> 

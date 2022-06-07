Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3165400D9
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbiFGOLk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbiFGOLf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 10:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF869A5029
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654611092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoSZK5Fdg2O/rluBKwwyKA4eybAvHOSFBw/HkVVeuhM=;
        b=E9fC0hBUCBCt1yZLrY1ZPNnTMxUr+F4N3zmE6QLPbpa+60qfjezZxlYD6LRE8GFtGIrvTJ
        fZ4dBcfK758eaUjDPJv6q+62PZ0JirwQ00Co+HqxszSphXjZa1XEX+KYWuPGQ1Eg5nUv9N
        YinyO+3Z6a0qalvre+6KF+TJGC0GhAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-e0npgYDeOriiVThidcw_lQ-1; Tue, 07 Jun 2022 10:11:29 -0400
X-MC-Unique: e0npgYDeOriiVThidcw_lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F30F811E75;
        Tue,  7 Jun 2022 14:11:29 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B38F404754D;
        Tue,  7 Jun 2022 14:11:28 +0000 (UTC)
Date:   Tue, 7 Jun 2022 16:11:26 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 6/7] libext2fs: check for cyclic loops in the extent tree
Message-ID: <20220607141126.qnn6o3zkqydxyfpj@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-7-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-7-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 07, 2022 at 12:24:43AM -0400, Theodore Ts'o wrote:
> In the extent tree handling code in libext2fs, when we go move down
> the extent tree, if a cyclic loop is detected, return an error.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  lib/ext2fs/ext2_err.et.in |  3 +++
>  lib/ext2fs/extent.c       | 11 +++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ext2fs/ext2_err.et.in b/lib/ext2fs/ext2_err.et.in
> index cf0e00ea..bb1dcf14 100644
> --- a/lib/ext2fs/ext2_err.et.in
> +++ b/lib/ext2fs/ext2_err.et.in
> @@ -551,4 +551,7 @@ ec	EXT2_ET_NO_GDESC,
>  ec	EXT2_FILSYS_CORRUPTED,
>  	"The internal ext2_filsys data structure appears to be corrupted"
>  
> +ec	EXT2_ET_EXTENT_CYCLE,
> +	"Found cyclic loop in extent tree"
> +
>  	end
> diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
> index 1a206a16..82e75ccd 100644
> --- a/lib/ext2fs/extent.c
> +++ b/lib/ext2fs/extent.c
> @@ -47,6 +47,7 @@ struct extent_path {
>  	int		visit_num;
>  	int		flags;
>  	blk64_t		end_blk;
> +	blk64_t		blk;
>  	void		*curr;
>  };
>  
> @@ -286,6 +287,7 @@ errcode_t ext2fs_extent_open2(ext2_filsys fs, ext2_ino_t ino,
>  	handle->path[0].end_blk =
>  		(EXT2_I_SIZE(handle->inode) + fs->blocksize - 1) >>
>  		 EXT2_BLOCK_SIZE_BITS(fs->super);
> +	handle->path[0].blk = 0;
>  	handle->path[0].visit_num = 1;
>  	handle->level = 0;
>  	handle->magic = EXT2_ET_MAGIC_EXTENT_HANDLE;
> @@ -305,14 +307,14 @@ errout:
>  errcode_t ext2fs_extent_get(ext2_extent_handle_t handle,
>  			    int flags, struct ext2fs_extent *extent)
>  {
> -	struct extent_path	*path, *newpath;
> +	struct extent_path	*path, *newpath, *tp;
>  	struct ext3_extent_header	*eh;
>  	struct ext3_extent_idx		*ix = 0;
>  	struct ext3_extent		*ex;
>  	errcode_t			retval;
>  	blk64_t				blk;
>  	blk64_t				end_blk;
> -	int				orig_op, op;
> +	int				orig_op, op, l;
>  	int				failed_csum = 0;
>  
>  	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EXTENT_HANDLE);
> @@ -467,6 +469,11 @@ retry:
>  		}
>  		blk = ext2fs_le32_to_cpu(ix->ei_leaf) +
>  			((__u64) ext2fs_le16_to_cpu(ix->ei_leaf_hi) << 32);
> +		for (l = handle->level, tp = path; l > 0; l--, tp--) {
> +			if (blk == tp->blk)
> +				return EXT2_ET_EXTENT_CYCLE;
> +		}
> +		newpath->blk = blk;
>  		if ((handle->fs->flags & EXT2_FLAG_IMAGE_FILE) &&
>  		    (handle->fs->io != handle->fs->image_io))
>  			memset(newpath->buf, 0, handle->fs->blocksize);
> -- 
> 2.31.0
> 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE946769AF5
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGaPli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGaPli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 11:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77980171B;
        Mon, 31 Jul 2023 08:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17279611B3;
        Mon, 31 Jul 2023 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8BAC433C9;
        Mon, 31 Jul 2023 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818094;
        bh=pfPkl/XcTZd6RMGu2uh5vTemrvIMiriILRyHow4+KYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lit37bnl8taUcq0x/ZnX6IWyhn/ACxWhlqLkYm57pz06QMq+FitKMIbOvp6bahXRI
         O9nBTwtPke2LxFZahShly7hstfWFfVQeP5zVO1HB7X4wW8lmv60svVOKl06gLSbzzU
         Ooyr2l96Srw8sA1eu1JJGYhiYF6/97cHMkDO4LqUZgi96rP+phJ4yJVW3Rf4MPB55/
         FuvNH35z2wUjvrOjI4JTn/fHEVg6IZAUdb6gTIrEPM8hjqSKDtwnd8QhNohxUkez2b
         NF6GPPUbehocPDE3c0fEmEIlPzhdUlSRY1WroXgMFWkB93bQITmMxh81JiP59Xkq49
         TraiyEWY+cRsA==
Date:   Mon, 31 Jul 2023 08:41:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn
Subject: Re: [PATCH v2] ext4: Fix rec_len verify error
Message-ID: <20230731154133.GA11332@frogsfrogsfrogs>
References: <20230731010104.1781335-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731010104.1781335-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 31, 2023 at 09:01:04AM +0800, zhangshida wrote:
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
> when enough file are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
> 
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k. To address this, Modify the check so
> as to handle it properly.

urughghahrhrhr<shudder>

Sorry that I missed that rec_len is an encoded number, not a plain le16
integer...

> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> v1->v2:
>   Use a better way to check the condition, as suggested by Andreas.
> 
>  fs/ext4/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..fffed95f8531 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	struct ext4_dir_entry *dp;
>  	struct dx_root_info *root;
>  	int count_offset;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
>  
> -	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
> +	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
>  		count_offset = 8;
>  	else if (le16_to_cpu(dirent->rec_len) == 12) {

...but what about all the other le16_to_cpu(ext4_dir_entry{,_2}.rec_len)
accesses in this file?  Don't those also need to be converted to
ext4_rec_len_from_disk calls?

Also,
Fixes: dbe89444042ab ("ext4: Calculate and verify checksums for htree nodes")

--D

>  		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
> -- 
> 2.27.0
> 

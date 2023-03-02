Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA55B6A79BC
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Mar 2023 03:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCBC6u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 21:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBC6t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 21:58:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF954222CA;
        Wed,  1 Mar 2023 18:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ABD8614CD;
        Thu,  2 Mar 2023 02:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C069FC433D2;
        Thu,  2 Mar 2023 02:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677725927;
        bh=Lm55R6YOVaMYqHurjS8beoPC3BoLl7gUtCBQIKg2wk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2ToGB3938f31cpLy5gjCtQSFWv2aZRrQ+eM3WpAKF2FRMBEnN2456nZKaKGhrXR3
         OsCIhzX6yYW7/KWVkO2CuqcFgHYnre1ftgH3YTMJ2jqP1svLLKfkSuznK+ATkEjAf3
         FTVY8TVIFbwTT6i99n0xyo0Dy6VgDYriMDVDa1B2YPPJYkyqF4+iD84p+9pWk8u4Qz
         zylbZJWMC4klXXm3Befd42Uemkxb4DDcUT4Y8o423Gz1Tk99b/l0yPPjfeWIeFx+ZY
         SBCJpUUpBy9AreOifKzaN17l2ROiwikl+lmB55E+bMTMZTR67wuR/RYF5QP5ovDNVr
         de1w8q75cqfBg==
Date:   Wed, 1 Mar 2023 18:58:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix comment about the 64BIT feature
Message-ID: <ZAAQ5wxf16dBhvZl@magnolia>
References: <20230301133842.671821-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301133842.671821-1-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 01, 2023 at 01:38:42PM +0000, Tudor Ambarus wrote:
> 64BIT is part of the incompatible feature set, update the comment
> accordingly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  fs/ext4/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..85c153e120b9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1387,7 +1387,7 @@ struct ext4_super_block {
>  	__le32	s_first_meta_bg;	/* First metablock block group */
>  	__le32	s_mkfs_time;		/* When the filesystem was created */
>  	__le32	s_jnl_blocks[17];	/* Backup of the journal inode */
> -	/* 64bit support valid if EXT4_FEATURE_COMPAT_64BIT */
> +	/* 64bit support valid if EXT4_FEATURE_INCOMPAT_64BIT */

Correct.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  /*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
>  	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
>  	__le32	s_free_blocks_count_hi;	/* Free blocks count */
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

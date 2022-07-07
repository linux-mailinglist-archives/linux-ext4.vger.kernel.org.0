Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DD56AC3D
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiGGTvK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiGGTu5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 15:50:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375655C9D0
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 12:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5830B823D3
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 19:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84562C3411E;
        Thu,  7 Jul 2022 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657223454;
        bh=M7MOqJptXl2cx+QxQzLQ7EKvOtZ0hVJJfAd1HnSDPXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A88jwTPMV8rOc/3QhVrS/5FRxWxulE/J40LLKllGTq8PCaFq3PVeILWpuzlWsioYg
         7yi8iLd0ABt8agtJ2rdA71UkxGH+bNrv2kRcoosR4s2Xt6nTF+CRC+DROf0i/s05G+
         Ordgq9Ey4+PS6IaC8oChjxvdL8JL9Ob2AbaW/YiTVHFqX1Y/8dwC1Ng2XexAX8a9Aj
         fFshAhfBxw6STC+uSZEQP+LLRRhMDUNNAW+5FPUstwEdmXoTODBWlIbT+jBR4+eY8t
         ehHj8bCd8gHnwdzKhGKUv5pfqGT1UNbFB2Z9bsFQw5hH12jFrkJpAdGZsuhJ3ZeMDA
         WJLPGlO0nxmxQ==
Date:   Thu, 7 Jul 2022 19:50:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, krisman@collabora.com
Subject: Re: [PATCH v2] tune2fs: allow disabling casefold feature
Message-ID: <Ysc5HYPXUs6rW02S@gmail.com>
References: <YscmTC3Mk9OXqOgL@gmail.com>
 <20220707190456.64972-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707190456.64972-1-slava@bacher09.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 07, 2022 at 10:04:56PM +0300, Slava Bacherikov wrote:
> diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
> index 628dcdc0..8ef28860 100644
> --- a/misc/tune2fs.8.in
> +++ b/misc/tune2fs.8.in
> @@ -593,8 +593,10 @@ Enable the file system to be larger than 2^32 blocks.
>  .TP
>  .B casefold
>  Enable support for file system level casefolding.
> -.B Tune2fs
> -currently only supports setting this file system feature.
> +The option could be disabled only if filesystem has no
> +directories with
> +.B F
> +attribute.

Please use present tense: "could" => "can".  Otherwise this can be interpreted
as the opposite of what you meant.

Also, "cleared" instead of "disabled", to be consistent with the rest of the
page.

>  static errcode_t disable_uninit_bg(ext2_filsys fs, __u32 csum_feature_flag)
>  {
>  	struct ext2_group_desc *gd;
> @@ -1554,6 +1590,20 @@ mmp_error:
>  		enabling_casefold = 1;
>  	}
>  
> +	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
> +		if (mount_flags & EXT2_MF_MOUNTED) {
> +			fputs(_("The casefold feature may only be disabled when "
> +				"the filesystem is unmounted.\n"), stderr);
> +			return 1;
> +		}
> +		if (has_casefold_inode(fs)) {
> +			fputs(_("The casefold feature couldn't be disabled when "
> +					"there are inodes with +F flag.\n"), stderr);
> +			return 1;
> +		}
> +		enabling_casefold = 0;

Likewise, "couldn't" => "can't".

Also, what are the semantics of disabling casefold, exactly?  Do the encoding
and encoding flags fields in the superblock also get cleared?

- Eric

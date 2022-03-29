Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5D4EA5EA
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiC2DXi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiC2DXh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 23:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917D7B108
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 20:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FF1BB8169F
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 03:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C139C340EC;
        Tue, 29 Mar 2022 03:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648524112;
        bh=UYFdXDo3CHiWRZCZj3Wg5lmIvgMkgUoH27qe1J9Zeyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEAol/YTZlNrzkKtqIB0ejpA/zEOPElRiA4D/PQDhm6DRq+FB4dCurRiKN2mMeIUZ
         s+t1R0cvawlEUNjPZSEHXIRFE87LOWGHcYvMuUrA8hVg0PKhtHDSgA5OVqjNZ9DjlY
         rDjsYU9D4dgknO4xVsyQGatNF/CcE+eB53bu0hRZ58CglswdldDcVxyF02WBYD0w5c
         /sK3OU0nklxGIhbGJ/KyHHmJuLMXCbRKf2rhSpQtRTGW3vl+hnfvszXk4WJCeGQh4g
         flKawcdbAun5ALfvGqMKZazVGhBxta44BjCvRcaGsnLrSBKyTCvy0kr9cWwZb34fN+
         8pVIMHXZ7Slrg==
Date:   Mon, 28 Mar 2022 20:21:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/5] ext4: Log error when lookup of encoded dentry fails
Message-ID: <YkJ7TmwgW5iJswNQ@sol.localdomain>
References: <20220322030004.148560-1-krisman@collabora.com>
 <20220322030004.148560-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030004.148560-6-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 21, 2022 at 11:00:04PM -0400, Gabriel Krisman Bertazi wrote:
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 8520115cd5c2..c321c6fdb4ae 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1456,6 +1456,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +						 "Bad encoded file in directory");

Maybe have this say "Bad encoded filename" instead of "Bad encoded file"?

- Eric

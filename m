Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1049D4B0054
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 23:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiBIWb2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 17:31:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiBIWbY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 17:31:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CBE018E69;
        Wed,  9 Feb 2022 14:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E3461C9A;
        Wed,  9 Feb 2022 22:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49778C340EB;
        Wed,  9 Feb 2022 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644445885;
        bh=bR4sxUvE7t7/jpuP5YfFYF8Jl/pDn3BISpVtXoqsgls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOMKSFwEU1krwHCm9g/ZmZ+B3M5POlN1cGehoE/AXmcb842yXuchumtanaMAoT8vR
         CFz1jES8lcBRJm8RXhm7vIFKPfi3Gan9SsrVIktgzGnVjvHIfGEjqM2vvkrKcJH9Y/
         6EvFxh99sh6HS3za91w0C8wbWRHdJ8Z2tlmo16NE4uN5ZX13fq6N9diGv5cXBEli5R
         YF0u0VdhiVU+/Kl2iwam5Yv3kHdO4HO3ArnQ5mLldbezGv+B+ZYffOFOyeK73H7ZtY
         dutGeVUpJPDe09I1Zwb4oDO+JmYkLk/g4i0PW1SLKgRxfZnJuwJy6rL32bcVsDbBUl
         DdlS3C7MauxcA==
Date:   Wed, 9 Feb 2022 14:31:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 2/6] generic/204: remove unnecessary _scratch_mkfs call
Message-ID: <20220209223124.GE8313@magnolia>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209123305.253038-3-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 09:33:01PM +0900, Shin'ichiro Kawasaki wrote:
> The test case generic/204 calls _scratch_mkfs to get data block size and
> i-node size of the filesystem and obtained data block size is passed to
> the following _scratch_mfks_sized call as an option. However, the
> _scratch_mkfs call is unnecessary since the sizes can be obtained by
> _scratch_mkfs_sized call without the data block size option.
> 
> Also the _scratch_mkfs call is harmful when the _scratch_mkfs succeeds
> and the _scratch_mkfs_sized fails. In this case, the _scratch_mkfs
> leaves valid working filesystem on scratch device then following mount
> and IO operations can not detect the failure of _scratch_mkfs_sized.
> This results in the test case run with unexpected test condition.
> 
> Hence, remove the _scratch_mkfs call and the data block size option for
> _scratch_mkfs_sized call.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks ok, assuming you've verified that fstests with FSTYP=xfs doesn't
regress...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/204 | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index a3dabb71..a33a090f 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -24,10 +24,6 @@ _supported_fs generic
>  
>  _require_scratch
>  
> -# get the block size first
> -_scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
> -. $tmp.mkfs
> -
>  # For xfs, we need to handle the different default log sizes that different
>  # versions of mkfs create. All should be valid with a 16MB log, so use that.
>  # And v4/512 v5/1k xfs don't have enough free inodes, set imaxpct=50 at mkfs
> @@ -35,7 +31,7 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
>  
>  SIZE=`expr 115 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
> +_scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw
>  cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  _scratch_mount
>  
> -- 
> 2.34.1
> 

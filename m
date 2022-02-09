Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD04B0060
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 23:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiBIWcJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 17:32:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiBIWcE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 17:32:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F838E016CF5;
        Wed,  9 Feb 2022 14:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 331BB61C60;
        Wed,  9 Feb 2022 22:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B5FC340EB;
        Wed,  9 Feb 2022 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644445921;
        bh=ZDDrpjO8yswzPRQD6Q+eltA6ap/UK42AVARlNocWEYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5WrkKp79dk886m3TwJBYkfS4vcvrSyL6W6oRKksgVZt1ogc2ejVQglpieOv4WzSf
         Kp2aGhRP2p1tEBUJlL+0DzRiCxH6wIWi4k8RAohq/iN09/1e72PlM0RAqusKiOKost
         hCjvKclwysUWlyK9ClVS74wf7cLZK5VWKyjuRNJsooPzG1odKVztlfJo//8q55aPMG
         J5LRrwrXMR6m/6lIElHPhEWOftFLyiIFPwD6G4ZtbxdEUvGkgG+T5YK2DKpZFruOhD
         zol6oD8ww9h1gEgoMB1EjMdWuB8DhcrCjRpmvGua92VY0FT2UsNu4X+eAY02XzROFS
         KRWvwdKk468sg==
Date:   Wed, 9 Feb 2022 14:32:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 4/6] ext4/021: check _scratch_mkfs_sized return code
Message-ID: <20220209223201.GG8313@magnolia>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209123305.253038-5-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 09:33:03PM +0900, Shin'ichiro Kawasaki wrote:
> The test cases ext4/021 calls _scratch_mkfs before _scratch_mkfs_sized,
> and does not check return code of _scratch_mkfs_sized. Even if
> _scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
> sized mkfs failure because _scratch_mkfs already created a file system
> on the device. This results in unexpected test condition.
> 
> To avoid the unexpected test condition, check return code of
> _scratch_mkfs_sized.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/ext4/021 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/021 b/tests/ext4/021
> index 62768c60..a9277abf 100755
> --- a/tests/ext4/021
> +++ b/tests/ext4/021
> @@ -24,7 +24,7 @@ _scratch_unmount
>  
>  # With 4k block size, this amounts to 10M FS instance.
>  fssize=$((2560 * $blocksize))
> -_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
> +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _require_metadata_journaling $SCRATCH_DEV
>  
>  offset=0
> -- 
> 2.34.1
> 

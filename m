Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256A4AE619
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 01:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiBIAgJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Feb 2022 19:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiBIAgI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 19:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA4C061576;
        Tue,  8 Feb 2022 16:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF796B81DBE;
        Wed,  9 Feb 2022 00:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A82C004E1;
        Wed,  9 Feb 2022 00:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644366964;
        bh=26PhyK/CDleh+MGaZCkEtqr5m9hzAqHCQxOZcgZkTP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NogF3sfzZypnV4xvZ5e7gyCnTatVZawX4RnVMYD0beS+5g1dNICMbTWxdRAgiLtSq
         lz9T4Hcjlonht3jCCKoJYNuMz9NsWDHTOBAlyK92n5QSQp8Ds3vhr3TcUg348fKv3Y
         TQ3qow285LuHHuXbfSbMr7Ws2WR4F6qtNsr8BNMOlpxyuHnzndyX+tqgrP90nM+KLN
         jQyXCymJtaCJO2fncC0+BHREpxT1YOAA+S2Ei9lOfSoej7bPLbVsd+2dGjgVYInXmE
         7iC20o1EoFeEHg8A11BiLcmhd/HqsHuRnH2U6rIiINPqgTjMYpoKFP5bEc2P0PVjPE
         nb1xF48jiH9HQ==
Date:   Tue, 8 Feb 2022 16:36:04 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 4/7] xfs/015: check _scratch_mkfs_sized return code
Message-ID: <20220209003604.GD8288@magnolia>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
 <20220207065541.232685-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207065541.232685-5-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 07, 2022 at 03:55:38PM +0900, Shin'ichiro Kawasaki wrote:
> The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
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

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/015 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/015 b/tests/xfs/015
> index 86fa6336..2bb7b8d5 100755
> --- a/tests/xfs/015
> +++ b/tests/xfs/015
> @@ -43,7 +43,7 @@ _scratch_mount
>  _require_fs_space $SCRATCH_MNT 131072
>  _scratch_unmount
>  
> -_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw
> +_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
>  cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
>  # get original data blocks number and agcount
>  . $tmp.mkfs
> -- 
> 2.34.1
> 

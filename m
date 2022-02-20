Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E44BD006
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Feb 2022 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiBTRAx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Feb 2022 12:00:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiBTRAv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Feb 2022 12:00:51 -0500
Received: from out20-99.mail.aliyun.com (out20-99.mail.aliyun.com [115.124.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED2527E8;
        Sun, 20 Feb 2022 09:00:27 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08295915|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0260975-0.00210438-0.971798;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.MsrOLZg_1645376423;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MsrOLZg_1645376423)
          by smtp.aliyun-inc.com(33.13.245.115);
          Mon, 21 Feb 2022 01:00:24 +0800
Date:   Mon, 21 Feb 2022 01:00:23 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 1/6] common/rc: fix btrfs mixed mode usage in
 _scratch_mkfs_sized
Message-ID: <YhJzp/dnfixk/nMn@desktop>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
 <20220218073156.2179803-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218073156.2179803-2-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 18, 2022 at 04:31:51PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function _scratch_mkfs_sized needs a couple of improvements
> for btrfs. At first, the function adds --mixed option to mkfs.btrfs when
> the filesystem size is smaller then 256MiB, but this threshold is no
> longer correct and it should be 109MiB. Secondly, the --mixed option

I'm wondering if this 256M -> 109M change was made just recently or was
made on old kernel.

If it was changed just recently, say 5.14 kernel, I suspect that tests
will fail on kernels prior to that change.

But if this change was made on some acient kernels, say 4.10, then I
think we're fine with this patch.

Thanks,
Eryu

> shall not be specified to mkfs.btrfs for zoned devices, since zoned
> devices does not allow mixing metadata blocks and data blocks.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index de60fb7b..74d2d8bd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1075,10 +1075,10 @@ _scratch_mkfs_sized()
>  		;;
>  	btrfs)
>  		local mixed_opt=
> -		# minimum size that's needed without the mixed option.
> -		# Ref: btrfs-prog: btrfs_min_dev_size()
> -		# Non mixed mode is also the default option.
> -		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
> +		# Mixed option is required when the filesystem size is small and
> +		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
> +		(( fssize < $((109 * 1024 * 1024)) )) &&
> +			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
>  		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>  		;;
>  	jfs)
> -- 
> 2.34.1

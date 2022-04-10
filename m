Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87774FADEF
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Apr 2022 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiDJMvO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Apr 2022 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDJMvM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Apr 2022 08:51:12 -0400
Received: from out20-51.mail.aliyun.com (out20-51.mail.aliyun.com [115.124.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3B4A3E6;
        Sun, 10 Apr 2022 05:49:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07449171|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.183864-0.0663327-0.749803;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.NNn8Kq0_1649594937;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.NNn8Kq0_1649594937)
          by smtp.aliyun-inc.com(33.45.46.134);
          Sun, 10 Apr 2022 20:48:57 +0800
Date:   Sun, 10 Apr 2022 20:48:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4/053: Add support for testing mb_optimize_scan
Message-ID: <YlLSObvNaXxrrZkw@desktop>
References: <5b0d252484cbe973c2df0c677cb47b30012b0db1.1647253313.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0d252484cbe973c2df0c677cb47b30012b0db1.1647253313.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 14, 2022 at 04:02:07PM +0530, Ojaswin Mujoo wrote:
> Add support to test the mb_optimize_scan mount option.
> Since its value is not reflected in the "options" file in proc,
> use "mb_structs_summary" to verify its value.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

mb_optimize_scan option was added in v5.13 by commit 196e402adf2e ("ext4:
improve cr 0 / cr 1 group scanning"), and ext4/053 will run on v5.12
kernel (and newer kernels), so test will fail when testing v5.12 kernel.

> ---
>  tests/ext4/053 | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index e1e79592..bd92002f 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -100,6 +100,7 @@ test_mnt() {
>  	(
>  	ret=0
>  	IFS=','
> +	proc_path="/proc/fs/ext4/$(_short_dev $SCRATCH_DEV)"
>  	for option in $OPTS; do
>  		if echo $IGNORED | grep -w $option; then
>  			continue
> @@ -114,11 +115,16 @@ test_mnt() {
>  		fi
>  		option=${option#^}
>  
> -		if echo $CHECK_MINFO | grep -w $option; then
> +		if [[ $option =~ ^mb_optimize_scan=.*$ ]]; then
> +			# mb_optimize_scan needs special handling
> +			expected=${option#*=}
> +			ret=$(cat $proc_path/mb_structs_summary | grep "optimize_scan" \
> +				| awk '{ print $2 }')
> +		elif echo $CHECK_MINFO | grep -w $option; then
>  			findmnt -n -o OPTIONS $SCRATCH_DEV | grep $option
>  			ret=$?
>  		else
> -			grep $option /proc/fs/ext4/$(_short_dev $SCRATCH_DEV)/options
> +			grep $option $proc_path/options
>  			ret=$?
>  		fi
>  
> @@ -526,13 +532,10 @@ for fstype in ext2 ext3 ext4; do
>  
>  	mnt prefetch_block_bitmaps removed
>  	mnt no_prefetch_block_bitmaps
> -	# We don't currently have a way to know that the option has been
> -	# applied, so comment it out for now. This should be fixed in the
> -	# future.

As the comment said, we need a way to know if mb_optimize_scan option is
supported by current kernel.

Thanks,
Eryu

> -	#mnt mb_optimize_scan=0
> -	#mnt mb_optimize_scan=1
> -	#not_mnt mb_optimize_scan=9
> -	#not_mnt mb_optimize_scan=
> +	mnt mb_optimize_scan=0
> +	mnt mb_optimize_scan=1
> +	not_mnt mb_optimize_scan=9
> +	not_mnt mb_optimize_scan=
>  	mnt nombcache
>  	mnt no_mbcache nombcache
>  	mnt check=none removed
> -- 
> 2.27.0

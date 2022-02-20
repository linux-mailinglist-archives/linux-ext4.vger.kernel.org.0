Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3A84BCFD0
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Feb 2022 17:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiBTQZW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Feb 2022 11:25:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiBTQZW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Feb 2022 11:25:22 -0500
Received: from out20-97.mail.aliyun.com (out20-97.mail.aliyun.com [115.124.20.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E03466C;
        Sun, 20 Feb 2022 08:24:59 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436842|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0362374-0.00153733-0.962225;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.MsqFXXe_1645374297;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MsqFXXe_1645374297)
          by smtp.aliyun-inc.com(10.147.44.129);
          Mon, 21 Feb 2022 00:24:57 +0800
Date:   Mon, 21 Feb 2022 00:24:56 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH 2/2] ext4: Test to ensure resize with sparse_super2 is
 handled correctly
Message-ID: <YhJrWA9VaG73H5KC@desktop>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
 <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 07, 2022 at 01:55:34PM +0530, Ojaswin Mujoo wrote:
> Kernel currently doesn't support resize of EXT4 mounted
> with sparse_super2 option enabled. Earlier, it used to leave the resize
> incomplete and the fs would be left in an inconsistent state, however commit
> b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> -ENOTSUPP.
> 
> Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
> resize for multiple iterations because this leads to kernel crash due to
> fs corruption, which we want to detect.
> 
> Related commit in mainline:
> 
> [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> 
> 	ext4: add check to prevent attempting to resize an fs with sparse_super2
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/056     | 102 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  2 files changed, 104 insertions(+)
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
> diff --git a/tests/ext4/056 b/tests/ext4/056
> new file mode 100755
> index 00000000..9185621d
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,102 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM. All Rights Reserved.
> +#
> +# We don't currently support resize of EXT4 filesystems mounted
> +# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
> +# incomplete and the fs would be left into an incomplete state, however commit
> +# b1489186cc83 fixed this to avoid the fs corruption by clearly returning
> +# -ENOTSUPP.
> +#
> +# This test ensures that kernel handles resizing with sparse_super2 correctly
> +#
> +# Related commit in mainline:
> +#
> +# commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> +# ext4: add check to prevent attempting to resize an fs with sparse_super2
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto ioctl resize quick
> +
> +# real QA test starts here
> +
> +INITIAL_FS_SIZE=1G
> +RESIZED_FS_SIZE=$((2*1024*1024*1024))  # 2G
> +ONLINE_RESIZE_BLOCK_LIMIT=$((256*1024*1024))
> +
> +_supported_fs ext4
> +_require_scratch_size $(($RESIZED_FS_SIZE/1024))
> +_require_test_program "ext4_resize"
> +
> +_log()
> +{
> +	echo "$seq: $*" >> $seqres.full 2>&1
> +}

Leading under score is used for common functions, local functions don't
need it.

> +
> +do_resize()
> +{
> +
> +	$MKFS_PROG `_scratch_mkfs_options -t ext4 -E resize=$ONLINE_RESIZE_BLOCK_LIMIT \
> +		-O sparse_super2` $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
> +		|| _fail "$MKFS_PROG failed. Exiting"

I think we could use _mkfs_dev here.

> +
> +	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
> +
> +	BS=$(_get_block_size $SCRATCH_MNT)
> +	NEW_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
> +
> +	local RESIZE_RET
> +	local EOPNOTSUPP=95
> +
> +	$here/src/ext4_resize $SCRATCH_MNT $NEW_BLOCKS >> $seqres.full 2>&1
> +	RESIZE_RET=$?
> +
> +	# Use $RESIZE_RET for logging
> +	if [ $RESIZE_RET = 0 ]
> +	then
> +		_log "Resizing succeeded but FS might still be corrupt."

I don't think _log is needed here, just echo message to stdout and this
will break golden image and fail the test.

> +	elif [ $RESIZE_RET = $EOPNOTSUPP ]
> +	then
> +		_log "Resize operation not supported with sparse_super2"
> +		_log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
> +
> +	else
> +		_log "Output of resize = $RESIZE_RET. Expected $EOPNOTSUPP (EOPNOTSUPP)"
> +		_log "You might be missing kernel patch b1489186cc83"
> +	fi
> +
> +	# unount after ioctl sometimes fails with "device busy" so add a small delay
> +	sleep 0.1
> +
> +	_scratch_unmount >> $seqres.full 2>&1 || _fail "$UMOUNT_PROG failed. Exiting"
> +}
> +
> +run_test()
> +{
> +	local FSCK_RET
> +	local ITERS=8
> +
> +	for i in $(seq 1 $ITERS)
> +	do
> +		_log "----------- Iteration: $i ------------"
> +		do_resize
> +	done
> +
> +	_log "-------- Iterations Complete ---------"
> +	_log "Checking if FS is in consistent state"
> +	_check_scratch_fs
> +	FSCK_RET=$?
> +
> +	return $FSCK_RET
> +}
> +
> +run_test
> +status=$?
> +
> +if [ "$status" -eq "0" ]
> +then
> +	echo "Test Succeeded!" | tee -a $seqres.full
> +fi

This is not needed, just echo "Silence is golden" at the beginning of
the test, so any additional output will fail the test.

Thanks,
Eryu

> +
> +exit
> diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> new file mode 100644
> index 00000000..41706284
> --- /dev/null
> +++ b/tests/ext4/056.out
> @@ -0,0 +1,2 @@
> +QA output created by 056
> +Test Succeeded!
> -- 
> 2.27.0

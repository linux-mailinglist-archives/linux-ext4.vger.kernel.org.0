Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ADA4FAD47
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Apr 2022 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiDJKia (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Apr 2022 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiDJKia (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Apr 2022 06:38:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28042F00C;
        Sun, 10 Apr 2022 03:36:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r7so8183997wmq.2;
        Sun, 10 Apr 2022 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQ1asQQvmNxrwigcwF7uQQ02u1byIMM0pigUO0LuPMw=;
        b=mKj8/wnUxfiHIsLbP9BUwqf7N5oXeRNWDFO889WJNABftM3czrTP9LZ22BNCwzuG1f
         h6QZhLpXdVrCprnDJqvEbypvD/BWQBtdQ0bZ1G8oIqQWPvnMX9cV6TR4HHAuHDnqHL16
         LpaHKJ9d/TxexnSK0GW1kSRjttlYNszsem3AkJlvnho46Y8ZP24QvGRS2W23P374/crv
         qRcsIjO8a2YWiBgTyJPYUbeEfo11es9VNOk7DDGGsWP5vWwXc23usZdOYAv1akbtrChq
         JvEIUBZmuX/3nYNzIzZ4NdkcLoJsYjQ4Ki7gjPDGYKA0/mtQnxqJmHqJVpb5pV9BtxXB
         01Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQ1asQQvmNxrwigcwF7uQQ02u1byIMM0pigUO0LuPMw=;
        b=QvyHVLiPPVEdUbFq9DxTWEBRTfk65AHn1b4Cbrgq8JOLXzN1zlmPUTE0FG9gqcugx5
         OwL9YTWqj81Z/Yd9YvGvjUwnLnDPSR+4QBr4gPiGYfzNEr48F4GYtQYvmycBXoFbAVBq
         7b3oLicfW39HhybFFtDSj4VEa5ju0wupA0VeG1ELHsEaqhQM6s5ptKhREf1pt1R5ecuq
         RclZ44zBbSLQGVviBs3DfkKubNd0TYOXwqPREtJJqbz3ZRWS3rXbC35YXQsl4oyBsLkJ
         5PBh637aOhKPHg92iPCtQ1GLg0jD6seRKabtw4kwvWEiuoxlkasCYnZn5n8cU8eM608f
         xAPQ==
X-Gm-Message-State: AOAM532pi+fHPr/1NL5p5+BpnIioWrwtOZXLEBIFPbqelnLpIUHRvSg0
        URUfcjuqjpzYcf2C/+gj7Jxg02pX0nI2eg==
X-Google-Smtp-Source: ABdhPJxApIf8R0qSweTAtuzFB6o79HfICjm9s1wK8vEwxM6y0WuqIkQ7XeROxQbhDTmT4fdaLuHdzQ==
X-Received: by 2002:a05:600c:348c:b0:38c:f335:7219 with SMTP id a12-20020a05600c348c00b0038cf3357219mr24904548wmq.174.1649586978195;
        Sun, 10 Apr 2022 03:36:18 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm24860791wre.34.2022.04.10.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:36:17 -0700 (PDT)
Date:   Sun, 10 Apr 2022 18:36:14 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v2 2/2] ext4: Test to ensure resize with sparse_super2 is
 handled correctly
Message-ID: <YlKzHqkZ1GjuIcc9@desktop>
References: <cover.1645549521.git.ojaswin@linux.ibm.com>
 <30fa381cac3dcc03b6fae4b9db5bf6c9a01f7bf6.1645549521.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fa381cac3dcc03b6fae4b9db5bf6c9a01f7bf6.1645549521.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 22, 2022 at 11:20:53PM +0530, Ojaswin Mujoo wrote:
> Kernel currently doesn't support resize of EXT4 mounted
> with sparse_super2 option enabled. Earlier, it used to leave the resize
> incomplete and the fs would be left in an inconsistent state, however commit
> b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> -EOPNOTSUPP.
> 
> Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
> resize for multiple iterations because this sometimes leads to kernel crash due
> to fs corruption, which we want to detect.
> 
> Related commit in mainline:
> 
> [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> 
> 	ext4: add check to prevent attempting to resize an fs with sparse_super2
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
> 
> I would like to add a few comments on the approach followed in this
> test:
> 
> 1. So although we check the return codes of the resize operation for
> 	 proper logging, the test is only considered to be passed if fsck
> 	 passes after the resize. This is because resizing a patched kernel
> 	 always keeps the fs consistent whereas resizing on unpatched kernel
> 	 always corrupts the fs. 
> 
> 2. I've noticed that running mkfs + resize multiple times on unpatched
> 	 kernel sometimes results in KASAN reporting use-after-free. Hence, if
> 	 we detect the kernel is unpatched (doesn't return EOPNOTSUPP on
> 	 resize) we continue iterating to capture this. In this case, we don't
> 	 run fsck in each iteration but run it only after all iterations are
> 	 complete because _check_scratch_fs exits the test if it fails.
> 
> 3. In case we detect patched kernel, we stop iterating, and run fsck to
> 	 confirm success 
> 
>  tests/ext4/056     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  2 files changed, 110 insertions(+)
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
> diff --git a/tests/ext4/056 b/tests/ext4/056
> new file mode 100755
> index 00000000..0f275dea
> --- /dev/null
> +++ b/tests/ext4/056
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM. All Rights Reserved.
> +#
> +# We don't currently support resize of EXT4 filesystems mounted
> +# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
> +# incomplete and the fs would be left into an incomplete state, however commit
> +# b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> +# -ENOTSUPP.
> +#
> +# This test ensures that kernel handles resizing with sparse_super2 correctly
> +#
> +# Related commit in mainline:
> +#
> +# [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> +# 	ext4: add check to prevent attempting to resize an fs with sparse_super2
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
> +STOP_ITER=255   # Arbitrary return code
> +
> +_supported_fs ext4
> +_require_scratch_size $(($RESIZED_FS_SIZE/1024))
> +_require_test_program "ext4_resize"
> +
> +log()
> +{
> +	echo "$seq: $*" >> $seqres.full 2>&1
> +}
> +
> +do_resize()
> +{
> +	_mkfs_dev -E resize=$ONLINE_RESIZE_BLOCK_LIMIT -O sparse_super2 \
> +		$SCRATCH_DEV $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
> +		|| _fail "$MKFS_PROG failed. Exiting"
> +
> +	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
> +
> +	local BS=$(_get_block_size $SCRATCH_MNT)
> +	local REQUIRED_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
> +
> +	local RESIZE_RET
> +	local EOPNOTSUPP=95
> +
> +	log "Resizing FS"
> +	$here/src/ext4_resize $SCRATCH_MNT $REQUIRED_BLOCKS >> $seqres.full 2>&1
> +	RESIZE_RET=$?
> +
> +	# Test appears to be successful. Stop iterating and confirm if FS is
> +	# consistent.
> +	if [ $RESIZE_RET = $EOPNOTSUPP ]
> +	then
> +		log "Resize operation not supported with sparse_super2"
> +		log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
> +		return $STOP_ITER
> +	fi
> +
> +	# Test appears to be unsuccessful. Most probably, the fs is corrupt,
> +	# iterate a few more times to further stress test this.
> +	log "Something is wrong. Output of resize = $RESIZE_RET. \
> +		Expected $EOPNOTSUPP (EOPNOTSUPP)"
> +
> +	# unmount after ioctl sometimes fails with "device busy" so add a small
> +	# delay
> +	sleep 0.2
> +	_scratch_unmount >> $seqres.full 2>&1 \
> +		|| _fail "$UMOUNT_PROG failed. Exiting"
> +}
> +
> +run_test()
> +{
> +	local FSCK_RET
> +	local ITERS=8
> +	local RET=0
> +
> +	for i in $(seq 1 $ITERS)
> +	do
> +		log "----------- Iteration: $i ------------"
> +		do_resize
> +		RET=$?
> +
> +		[ "$RET" = "$STOP_ITER" ] && break
> +	done
> +
> +	log "-------- Iterations Complete ---------"
> +	log "Checking if FS is in consistent state"
> +	_check_scratch_fs

_check_scratch_fs will exit the test on failure and print error message,
which will break the golden image, so there's no need to check fsck ret.

> +	FSCK_RET=$?
> +
> +	[ "$FSCK_RET" -ne "0" ] && \
> +		echo "fs corrupt. Check $seqres.full for more details"
> +
> +	return $FSCK_RET

So I removed above hunk on commit.

Thanks for the test! And my apology to the HUGE delay on review..

Thanks,
Eryu

> +}
> +
> +echo "Silence is golden"
> +run_test
> +status=$?
> +
> +exit
> diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> new file mode 100644
> index 00000000..6142fcd2
> --- /dev/null
> +++ b/tests/ext4/056.out
> @@ -0,0 +1,2 @@
> +QA output created by 056
> +Silence is golden
> -- 
> 2.27.0

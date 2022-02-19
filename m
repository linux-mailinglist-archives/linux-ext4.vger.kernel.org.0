Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8F4BC6A6
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Feb 2022 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbiBSHWp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Feb 2022 02:22:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBSHWm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Feb 2022 02:22:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09F210;
        Fri, 18 Feb 2022 23:22:23 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21J6kcNX031374;
        Sat, 19 Feb 2022 07:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=i17v2TBaJyPAijg3EoGR7ou740fw0QYQ0vDWkvLww3s=;
 b=K/9CBarxfl4M9S9uI3BnyxEJqRwGHNW4Lv+uHFsNe41vSRz8UXQ0DFmfDQ84it310JNx
 B3O/i9n3syMIDWMcTv7WGnX05MDp8krzZTCW6SgEjb0yHO8CUK29EORySOSLZkpRnuUt
 GiJrngMe+N16vyFaQKnzUG8G3maUTxnTUBRit/7FykktvhkNRdS3ofNLtj49V3oiMVhn
 fMfVXrRDK6VWFKVpk4HBocCf/DG99OMz9eLtZsifYARwzv9HsnwbVTZ1PVJEf+RRt7sf
 tkZcqg7w+V+Sy48d2ONh56LXMmGxhDd7iq2IGakT26qFpAF6oy9MCmRCR5tis72KAF98 yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eauk00g98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 07:22:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21J7C4KB000920;
        Sat, 19 Feb 2022 07:22:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear68gt0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 07:22:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21J7MHnn33358140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 07:22:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3237FAE045;
        Sat, 19 Feb 2022 07:22:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB36AE051;
        Sat, 19 Feb 2022 07:22:14 +0000 (GMT)
Received: from localhost (unknown [9.43.86.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 19 Feb 2022 07:22:13 +0000 (GMT)
Date:   Sat, 19 Feb 2022 12:52:11 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Test to ensure resize with sparse_super2 is
 handled correctly
Message-ID: <20220219072211.lmp64ntxmrcz7sua@riteshh-domain>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
 <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NQ4iIT_KtCQwjsvVDMUCB_JIKZ70-eMB
X-Proofpoint-ORIG-GUID: NQ4iIT_KtCQwjsvVDMUCB_JIKZ70-eMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-19_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202190044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/07 01:55PM, Ojaswin Mujoo wrote:
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

Thanks for the patch. Few nits below.

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
> +
> +do_resize()
> +{
> +
> +	$MKFS_PROG `_scratch_mkfs_options -t ext4 -E resize=$ONLINE_RESIZE_BLOCK_LIMIT \
> +		-O sparse_super2` $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
> +		|| _fail "$MKFS_PROG failed. Exiting"
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

IMO, this above logs is not required. Putting iteration count is more than
enough. You could log more info if the resize fails. But above log is somewhat
confusing to me.


> +	elif [ $RESIZE_RET = $EOPNOTSUPP ]
> +	then
> +		_log "Resize operation not supported with sparse_super2"
> +		_log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"

If it fails with EOPNOTSUPP, do we still need to iterate in do_resize()
8 times?

> +
> +	else
> +		_log "Output of resize = $RESIZE_RET. Expected $EOPNOTSUPP (EOPNOTSUPP)"
> +		_log "You might be missing kernel patch b1489186cc83"

Not sure if we should pin point to a particular patch in this case.
It could be that we add some features later and then some of those doesn't again
support resize feature where it should return EOPNOTSUPP, but this test could
capture that. So, I feel above may not be required.

> +	fi
> +
> +	# unount after ioctl sometimes fails with "device busy" so add a small delay
> +	sleep 0.1

Let's not add this sleep for EOPNOTSUPP case.

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
>

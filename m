Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43F8504C60
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiDRFrw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiDRFru (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 01:47:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE2FD34;
        Sun, 17 Apr 2022 22:45:12 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23I4mrQB011852;
        Mon, 18 Apr 2022 05:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=siYszzMsP0pOV5c2PL9cf3FSnweWtrxfQV5lwWoKc7g=;
 b=eJ6Pcr39bhyAlsbaJaGlwNhjKKf7DgGEhbVxmM/jnLMq/5uK9Ear098nT8iHVisR19px
 sTm9B5QliU1V8m1/O2zzx1kYxCctM78o388gPFCMCdX8MKhlKFlkUEKLzl+sK7rzD220
 cBTsuXHkQoTCXSiNvvOC1wiRHkI3g8g1swwxiCSxBk0Y3RTVRu5BBVdNzr23C10QFx4V
 hlVttIN5Q/v6e1dWurcKGwpilGq/5R5ObO8JY/3IP1OdN4h8bX78j1ew85UhSUYsUB0V
 6S2iXlg3qv4Fu5TwtNu2IMVTm9Du1PPGe9OS7uusUTZzhp5j0Nuzb2RSVwk2/n9fvnTb jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7d6csnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 05:45:11 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23I5R7sH005843;
        Mon, 18 Apr 2022 05:45:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7d6csmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 05:45:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23I5NmsV022724;
        Mon, 18 Apr 2022 05:45:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2hta3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 05:45:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23I5j6bL29360422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 05:45:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FE942047;
        Mon, 18 Apr 2022 05:45:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12B3242042;
        Mon, 18 Apr 2022 05:45:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.71.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Apr 2022 05:45:04 +0000 (GMT)
Date:   Mon, 18 Apr 2022 11:15:01 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v2 2/2] ext4: Test to ensure resize with sparse_super2 is
 handled correctly
Message-ID: <Ylz63bzfrTwcKKDK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1645549521.git.ojaswin@linux.ibm.com>
 <30fa381cac3dcc03b6fae4b9db5bf6c9a01f7bf6.1645549521.git.ojaswin@linux.ibm.com>
 <YlKzHqkZ1GjuIcc9@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlKzHqkZ1GjuIcc9@desktop>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: taeF1MFrIUX3Wlhva-uYt0baUjNP6lRo
X-Proofpoint-GUID: fTAwdcVHZIQpfUWCfWwYzycNXj_KVe1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204180032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 10, 2022 at 06:36:14PM +0800, Eryu Guan wrote:
> On Tue, Feb 22, 2022 at 11:20:53PM +0530, Ojaswin Mujoo wrote:
> > Kernel currently doesn't support resize of EXT4 mounted
> > with sparse_super2 option enabled. Earlier, it used to leave the resize
> > incomplete and the fs would be left in an inconsistent state, however commit
> > b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> > -EOPNOTSUPP.
> > 
> > Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
> > resize for multiple iterations because this sometimes leads to kernel crash due
> > to fs corruption, which we want to detect.
> > 
> > Related commit in mainline:
> > 
> > [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> > 
> > 	ext4: add check to prevent attempting to resize an fs with sparse_super2
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> > 
> > I would like to add a few comments on the approach followed in this
> > test:
> > 
> > 1. So although we check the return codes of the resize operation for
> > 	 proper logging, the test is only considered to be passed if fsck
> > 	 passes after the resize. This is because resizing a patched kernel
> > 	 always keeps the fs consistent whereas resizing on unpatched kernel
> > 	 always corrupts the fs. 
> > 
> > 2. I've noticed that running mkfs + resize multiple times on unpatched
> > 	 kernel sometimes results in KASAN reporting use-after-free. Hence, if
> > 	 we detect the kernel is unpatched (doesn't return EOPNOTSUPP on
> > 	 resize) we continue iterating to capture this. In this case, we don't
> > 	 run fsck in each iteration but run it only after all iterations are
> > 	 complete because _check_scratch_fs exits the test if it fails.
> > 
> > 3. In case we detect patched kernel, we stop iterating, and run fsck to
> > 	 confirm success 
> > 
> >  tests/ext4/056     | 108 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/056.out |   2 +
> >  2 files changed, 110 insertions(+)
> >  create mode 100755 tests/ext4/056
> >  create mode 100644 tests/ext4/056.out
> > 
> > diff --git a/tests/ext4/056 b/tests/ext4/056
> > new file mode 100755
> > index 00000000..0f275dea
> > --- /dev/null
> > +++ b/tests/ext4/056
> > @@ -0,0 +1,108 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM. All Rights Reserved.
> > +#
> > +# We don't currently support resize of EXT4 filesystems mounted
> > +# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
> > +# incomplete and the fs would be left into an incomplete state, however commit
> > +# b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> > +# -ENOTSUPP.
> > +#
> > +# This test ensures that kernel handles resizing with sparse_super2 correctly
> > +#
> > +# Related commit in mainline:
> > +#
> > +# [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> > +# 	ext4: add check to prevent attempting to resize an fs with sparse_super2
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest auto ioctl resize quick
> > +
> > +# real QA test starts here
> > +
> > +INITIAL_FS_SIZE=1G
> > +RESIZED_FS_SIZE=$((2*1024*1024*1024))  # 2G
> > +ONLINE_RESIZE_BLOCK_LIMIT=$((256*1024*1024))
> > +
> > +STOP_ITER=255   # Arbitrary return code
> > +
> > +_supported_fs ext4
> > +_require_scratch_size $(($RESIZED_FS_SIZE/1024))
> > +_require_test_program "ext4_resize"
> > +
> > +log()
> > +{
> > +	echo "$seq: $*" >> $seqres.full 2>&1
> > +}
> > +
> > +do_resize()
> > +{
> > +	_mkfs_dev -E resize=$ONLINE_RESIZE_BLOCK_LIMIT -O sparse_super2 \
> > +		$SCRATCH_DEV $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
> > +		|| _fail "$MKFS_PROG failed. Exiting"
> > +
> > +	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
> > +
> > +	local BS=$(_get_block_size $SCRATCH_MNT)
> > +	local REQUIRED_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
> > +
> > +	local RESIZE_RET
> > +	local EOPNOTSUPP=95
> > +
> > +	log "Resizing FS"
> > +	$here/src/ext4_resize $SCRATCH_MNT $REQUIRED_BLOCKS >> $seqres.full 2>&1
> > +	RESIZE_RET=$?
> > +
> > +	# Test appears to be successful. Stop iterating and confirm if FS is
> > +	# consistent.
> > +	if [ $RESIZE_RET = $EOPNOTSUPP ]
> > +	then
> > +		log "Resize operation not supported with sparse_super2"
> > +		log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
> > +		return $STOP_ITER
> > +	fi
> > +
> > +	# Test appears to be unsuccessful. Most probably, the fs is corrupt,
> > +	# iterate a few more times to further stress test this.
> > +	log "Something is wrong. Output of resize = $RESIZE_RET. \
> > +		Expected $EOPNOTSUPP (EOPNOTSUPP)"
> > +
> > +	# unmount after ioctl sometimes fails with "device busy" so add a small
> > +	# delay
> > +	sleep 0.2
> > +	_scratch_unmount >> $seqres.full 2>&1 \
> > +		|| _fail "$UMOUNT_PROG failed. Exiting"
> > +}
> > +
> > +run_test()
> > +{
> > +	local FSCK_RET
> > +	local ITERS=8
> > +	local RET=0
> > +
> > +	for i in $(seq 1 $ITERS)
> > +	do
> > +		log "----------- Iteration: $i ------------"
> > +		do_resize
> > +		RET=$?
> > +
> > +		[ "$RET" = "$STOP_ITER" ] && break
> > +	done
> > +
> > +	log "-------- Iterations Complete ---------"
> > +	log "Checking if FS is in consistent state"
> > +	_check_scratch_fs
> 
> _check_scratch_fs will exit the test on failure and print error message,
> which will break the golden image, so there's no need to check fsck ret.
> 
> > +	FSCK_RET=$?
> > +
> > +	[ "$FSCK_RET" -ne "0" ] && \
> > +		echo "fs corrupt. Check $seqres.full for more details"
> > +
> > +	return $FSCK_RET
> 
> So I removed above hunk on commit.
> 
> Thanks for the test! And my apology to the HUGE delay on review..
No worries Eryu, thanks a lot for the review :)

Regards,
Ojaswin
> 
> Thanks,
> Eryu
> 
> > +}
> > +
> > +echo "Silence is golden"
> > +run_test
> > +status=$?
> > +
> > +exit
> > diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> > new file mode 100644
> > index 00000000..6142fcd2
> > --- /dev/null
> > +++ b/tests/ext4/056.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 056
> > +Silence is golden
> > -- 
> > 2.27.0

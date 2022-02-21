Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148D14BD609
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 07:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiBUGB3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 01:01:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbiBUGB3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 01:01:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205851334;
        Sun, 20 Feb 2022 22:01:06 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L5buEC019001;
        Mon, 21 Feb 2022 06:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AvwEuFRfNawJtRdhYGYaPMf8z/GF5fqoPS4SQbnyRbI=;
 b=WH4j7VbxY6SmJF6UBv+pR9+rPjMH9jkrWkoUCDI+lBZ3YFYNT5f2ID2ZkiFRFr70jJ0t
 ZUY/M/Po0Df5VqESnR24YM3QxMHTEZlLtOVNcUJyyRxhRlm0AjRECM6YQy04YStDp7P4
 lL6qnEAZZ6U1qmo7+WbBaqiu2c312nGImVFnlAilQ3h71AE17Dc+r0YR1PeDb4LLVDgl
 5f+WSYdFW8odg88cgf33sMz0Xw2lAcgwRv8EFHM84UUHGkigOA4591Qyg1siU+KahXiV
 v9SwWJWFqGaZzHfHwlMhNRg8XYeOSbQUms1FGJKMamJ4dwED27+bf5f+wlFwtNk5gbpj 9w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eby66nand-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 06:01:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L5imi5023672;
        Mon, 21 Feb 2022 06:01:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3eaqtj77y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 06:01:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L60wYB36045160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 06:00:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0D0D42063;
        Mon, 21 Feb 2022 06:00:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B1364205C;
        Mon, 21 Feb 2022 06:00:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.93.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Feb 2022 06:00:54 +0000 (GMT)
Date:   Mon, 21 Feb 2022 11:30:46 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH 2/2] ext4: Test to ensure resize with sparse_super2 is
 handled correctly
Message-ID: <YhMqjlb+qrgHTOVs@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
 <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
 <YhJrWA9VaG73H5KC@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhJrWA9VaG73H5KC@desktop>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iiQ0N6Y85eZ-Ikb5bpBLsLTcdG8nYyMP
X-Proofpoint-GUID: iiQ0N6Y85eZ-Ikb5bpBLsLTcdG8nYyMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210037
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eryu

Thanks for the review.

On Mon, Feb 21, 2022 at 12:24:56AM +0800, Eryu Guan wrote:
> On Mon, Feb 07, 2022 at 01:55:34PM +0530, Ojaswin Mujoo wrote:
> > Kernel currently doesn't support resize of EXT4 mounted
> > with sparse_super2 option enabled. Earlier, it used to leave the resize
> > incomplete and the fs would be left in an inconsistent state, however commit
> > b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
> > -ENOTSUPP.
> > 
> > Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
> > resize for multiple iterations because this leads to kernel crash due to
> > fs corruption, which we want to detect.
> > 
> > Related commit in mainline:
> > 
> > [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> > 
> > 	ext4: add check to prevent attempting to resize an fs with sparse_super2
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/ext4/056     | 102 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/056.out |   2 +
> >  2 files changed, 104 insertions(+)
> >  create mode 100755 tests/ext4/056
> >  create mode 100644 tests/ext4/056.out
> > 
> > diff --git a/tests/ext4/056 b/tests/ext4/056
> > new file mode 100755
> > index 00000000..9185621d
> > --- /dev/null
> > +++ b/tests/ext4/056
> > @@ -0,0 +1,102 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM. All Rights Reserved.
> > +#
> > +# We don't currently support resize of EXT4 filesystems mounted
> > +# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
> > +# incomplete and the fs would be left into an incomplete state, however commit
> > +# b1489186cc83 fixed this to avoid the fs corruption by clearly returning
> > +# -ENOTSUPP.
> > +#
> > +# This test ensures that kernel handles resizing with sparse_super2 correctly
> > +#
> > +# Related commit in mainline:
> > +#
> > +# commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> > +# ext4: add check to prevent attempting to resize an fs with sparse_super2
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
> > +_supported_fs ext4
> > +_require_scratch_size $(($RESIZED_FS_SIZE/1024))
> > +_require_test_program "ext4_resize"
> > +
> > +_log()
> > +{
> > +	echo "$seq: $*" >> $seqres.full 2>&1
> > +}
> 
> Leading under score is used for common functions, local functions don't
> need it.
> 
Got it.
> > +
> > +do_resize()
> > +{
> > +
> > +	$MKFS_PROG `_scratch_mkfs_options -t ext4 -E resize=$ONLINE_RESIZE_BLOCK_LIMIT \
> > +		-O sparse_super2` $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
> > +		|| _fail "$MKFS_PROG failed. Exiting"
> 
> I think we could use _mkfs_dev here.
> 
Oh right, I missed that. I'll fix this, thanks.
> > +
> > +	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
> > +
> > +	BS=$(_get_block_size $SCRATCH_MNT)
> > +	NEW_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
> > +
> > +	local RESIZE_RET
> > +	local EOPNOTSUPP=95
> > +
> > +	$here/src/ext4_resize $SCRATCH_MNT $NEW_BLOCKS >> $seqres.full 2>&1
> > +	RESIZE_RET=$?
> > +
> > +	# Use $RESIZE_RET for logging
> > +	if [ $RESIZE_RET = 0 ]
> > +	then
> > +		_log "Resizing succeeded but FS might still be corrupt."
> 
> I don't think _log is needed here, just echo message to stdout and this
> will break golden image and fail the test.
> 
Noted.
> > +	elif [ $RESIZE_RET = $EOPNOTSUPP ]
> > +	then
> > +		_log "Resize operation not supported with sparse_super2"
> > +		_log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
> > +
> > +	else
> > +		_log "Output of resize = $RESIZE_RET. Expected $EOPNOTSUPP (EOPNOTSUPP)"
> > +		_log "You might be missing kernel patch b1489186cc83"
> > +	fi
> > +
> > +	# unount after ioctl sometimes fails with "device busy" so add a small delay
> > +	sleep 0.1
> > +
> > +	_scratch_unmount >> $seqres.full 2>&1 || _fail "$UMOUNT_PROG failed. Exiting"
> > +}
> > +
> > +run_test()
> > +{
> > +	local FSCK_RET
> > +	local ITERS=8
> > +
> > +	for i in $(seq 1 $ITERS)
> > +	do
> > +		_log "----------- Iteration: $i ------------"
> > +		do_resize
> > +	done
> > +
> > +	_log "-------- Iterations Complete ---------"
> > +	_log "Checking if FS is in consistent state"
> > +	_check_scratch_fs
> > +	FSCK_RET=$?
> > +
> > +	return $FSCK_RET
> > +}
> > +
> > +run_test
> > +status=$?
> > +
> > +if [ "$status" -eq "0" ]
> > +then
> > +	echo "Test Succeeded!" | tee -a $seqres.full
> > +fi
> 
> This is not needed, just echo "Silence is golden" at the beginning of
> the test, so any additional output will fail the test.
> 
> Thanks,
> Eryu

Got it, thanks for the suggestions. I'll work on those and send
a v2.

Thanks and regards,
Ojaswin
> 
> > +
> > +exit
> > diff --git a/tests/ext4/056.out b/tests/ext4/056.out
> > new file mode 100644
> > index 00000000..41706284
> > --- /dev/null
> > +++ b/tests/ext4/056.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 056
> > +Test Succeeded!
> > -- 
> > 2.27.0

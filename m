Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0A2D0BE2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLGIlD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 03:41:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgLGIlD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 03:41:03 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B78cCDr073381;
        Mon, 7 Dec 2020 03:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DVmedtedZGXbUvl/8RYyTlol/VS26qHsVvPEIt+zr5Q=;
 b=pMJpf36cSpUUn/Fh7HRqouqxJijbIaB1PoJ2zsyYm2Yd9lJtshCG88rjPvTuCK5onc6L
 A1GR6LlMtZ2LUZ3oALXE4HidC8F9KW25OmxgKFKOPifJx222BJSm+u34wth6Qc0KInQS
 HYFTgWdTSNvMCM8D3vbC3o0kHe5cXNyHYOdsXp0BVxdsT05+GLE+V5UEr178+3/+mCma
 PMXcDQve2IwExvfn0mRpb8lt4vuQ8NOGNegQQ3ELQ2J8aH6TU6hfbBSr8SX3v+05QxsU
 VIujSnjoi5N52ONRAW8RYB85rGkJoDHQJ0r4wdGWxLjALLzabyCrLe/UtoOUv6yi3TYR VQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359d5nn7dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:40:18 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B78bSsP014932;
        Mon, 7 Dec 2020 08:40:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8kcp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:40:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B78bb2c55312728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 08:37:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D913AE058;
        Mon,  7 Dec 2020 08:37:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82B01AE051;
        Mon,  7 Dec 2020 08:37:36 +0000 (GMT)
Received: from [9.199.35.222] (unknown [9.199.35.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 08:37:36 +0000 (GMT)
Subject: Re: [PATCH 2/2] generic: Add test to check for mounting a huge sparse
 dm device
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        anju@linux.vnet.ibm.com
References: <cover.1607078368.git.riteshh@linux.ibm.com>
 <cc6f28972d73a50fb84a3797172ff44d396a6bef.1607078368.git.riteshh@linux.ibm.com>
 <20201206135043.GV3853@desktop> <20201206141423.GX3853@desktop>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <7c63549a-cf53-c229-5f0b-0d97f4cec20d@linux.ibm.com>
Date:   Mon, 7 Dec 2020 14:07:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201206141423.GX3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_05:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070054
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/6/20 7:44 PM, Eryu Guan wrote:
> On Sun, Dec 06, 2020 at 09:50:43PM +0800, Eryu Guan wrote:
>> On Fri, Dec 04, 2020 at 04:13:54PM +0530, Ritesh Harjani wrote:
>>> Add this test to check for regression which was reported when ext4 bmap
>>> aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
>>> from fs/inode.c which was failing since iomap_bmap() implementation earlier
>>> returned 0 for block addr > INT_MAX.
>>> This regression was fixed with following kernel commit [1]
>>> commit b75dfde1212991b24b220c3995101c60a7b8ae74
>>> ("fibmap: Warn and return an error in case of block > INT_MAX")
>>> [1]: https://patchwork.ozlabs.org/patch/1279914
>>>
>>> w/o the kernel fix we get below errors and mount fails
>>>
>>> [ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
>>> [ 1530.406645] ------------[ cut here ]------------
>>> [ 1530.407332] would truncate bmap result
>>> [ 1530.408956] WARNING: CPU: 0 PID: 6401 at fs/iomap/fiemap.c:116
>>> iomap_bmap_actor+0x43/0x50
>>> [ 1530.410607] Modules linked in:
>>> [ 1530.411024] CPU: 0 PID: 6401 Comm: mount Tainted: G        W
>>> <...>
>>>   1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
>>>   [ 1530.513310] EXT4-fs (dm-1): Could not load journal inode
>>>
>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>> ---
>>>   common/rc             | 10 +++++++
>>>   tests/generic/618     | 70 +++++++++++++++++++++++++++++++++++++++++++
>>>   tests/generic/618.out |  3 ++
>>>   tests/generic/group   |  1 +
>>>   4 files changed, 84 insertions(+)
>>>   create mode 100755 tests/generic/618
>>>   create mode 100644 tests/generic/618.out
>>>
>>> diff --git a/common/rc b/common/rc
>>> index b5a504e0dcb4..128d75226958 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -1608,6 +1608,16 @@ _require_scratch_size()
>>>   	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>>>   }
>>>   
>>> +# require a scratch dev of a minimum size (in kb) and should not be checked
>>> +# post test
>>> +_require_scratch_size_nocheck()
>>> +{
>>> +	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
>>> +
>>> +	_require_scratch_nocheck
>>> +	local devsize=`_get_device_size $SCRATCH_DEV`
>>> +	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>>> +}
>>>   
>>>   # this test needs a test partition - check we're ok & mount it
>>>   #
>>> diff --git a/tests/generic/618 b/tests/generic/618
>>> new file mode 100755
>>> index 000000000000..45c14da80c06
>>> --- /dev/null
>>> +++ b/tests/generic/618
>>> @@ -0,0 +1,70 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
>>> +# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
>>> +#
>>> +# FS QA Test generic/618
>>> +#
>>> +# Since the test is not specific to ext4, hence adding it to generic.
>>> +# Add this test to check for regression which was reported when ext4 bmap
>>> +# aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
>>> +# from fs/inode.c which was failing since iomap_bmap() implementation earlier
>>> +# returned 0 for block addr > INT_MAX.
>>> +# This regression was fixed with following kernel commit [1]
>>> +# commit b75dfde1212991b24b220c3995101c60a7b8ae74
>>> +# ("fibmap: Warn and return an error in case of block > INT_MAX")
>>> +# [1]: https://patchwork.ozlabs.org/patch/1279914
>>> +#
>>> +seq=`basename $0`
>>> +seqres=$RESULT_DIR/$seq
>>> +echo "QA output created by $seq"
>>> +
>>> +here=`pwd`
>>> +tmp=/tmp/$$
>>> +status=1	# failure is the default!
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_cleanup()
>>> +{
>>> +	_dmhugedisk_cleanup
>>> +	cd /
>>> +	rm -f $tmp.*
>>> +}
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common/rc
>>> +. ./common/filter
>>> +. ./common/dmhugedisk
>>> +
>>> +# remove previous $seqres.full before test
>>> +rm -f $seqres.full
>>> +
>>> +# Modify as appropriate.
>>> +_supported_fs generic
>>> +_require_dmhugedisk
>>> +_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
>>> +
>>> +# For 1k bs with ext4, mkfs was failing due to size limitation and also it
>>> +# becomes too slow when doing an mkfs on a huge sparse ext4 FS with 1k bs.
>>> +# Hence on ext4 run only for 4K bs.
>>> +if [ "$FSTYP" == "ext4" ]; then
>>> +	_scratch_mkfs > /dev/null 2>&1
>>> +	blksz=$(sudo debugfs -R stats $SCRATCH_DEV 2> /dev/null |grep "Block size" |cut -d ':' -f 2)
>>> +	test $blksz -lt 4096 && _notrun "This test requires ext4 with minimum 4k bs"
>>> +fi
>>
>> As this is a generic test, the same check should be done with ext2 and
>> ext3. And actually this test requires > 16T fs support. So I'd suggest
>> add a new helper, maybe called _require_16T_support, to check if $FSTYP
>> supports filesystem size > 16T. And for now, we could only check for
>> extN.
>>
>> Also, there's no need to run command with sudo in fstests, as all tests
>> are required to be run by root.
>>
>> And there's a helper to get fs block size called _get_block_size, no
>> need to parse output of debugfs. >
> Maybe something like (not tested)
> 
> _require_scratch_16T_support()
> {
> 	case $FSTYP in
> 	ext2|ext3)
> 		_notrun "$FSTYP doesn't support >16T filesystem"
> 	ext4)
> 		_scratch_mkfs >> $seqres.full 2>&1
> 		_scratch_mount
> 		local blocksize=$(_get_block_size $SCRATCH_MNT)
> 		if [ $blocksize -lt 4096 ]; then
> 			_notrun "This test requires >16T fs support"
> 		fi
> 		;;
> 	*)
> 		;;
> 	esac
> }

Sure, agreed. Let me add this in v2.
Will add f2fs along with ext2/3 as not supported (as listed below).

https://android.googlesource.com/platform/external/f2fs-tools/+/refs/heads/master/lib/libf2fs.c#1183

Thanks
-ritesh

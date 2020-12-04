Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC62CE6BF
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 04:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLDD7b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 22:59:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgLDD7b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 22:59:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B43WrKr136621;
        Thu, 3 Dec 2020 22:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jQv72CDDKW4fzHHGFMciWOnlRSCdehNGjochw6rqf+g=;
 b=oLRa+3fBO7YaJeUhsxWsHzyH20uiHeInz1Oxslv5k7oOfAvtISqH7PkcBQN+/Dw/J1we
 pYEhYZbrKu2sJN7AN/5VeahboxMMW/45E22vpme6k4nCGVilvahcktBsVKdc/c9uFXBt
 Y/s8M5na0QydVXIL88bUV9FlMWHQ62aZ1sXcGCATweSzhbqFp2ypFSf/02ZR56XfAxA7
 hsn8/tgo+2JeX5pajZ7gOCokqX7cgcIIi6jrgxDilacbsZP5ecQbN2WxpDOWRWS7ZV/l
 MJG/a8f/PgMpdWmaKPzcyenoXwqf9gU5vQhBsBE32lDLt0sasftHgovz07+JgcMz/v3C 9g== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357734rq5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 22:58:43 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B43l6AT018042;
        Fri, 4 Dec 2020 03:58:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 353e688p1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 03:58:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B43vNGC9110144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 03:57:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57C614203F;
        Fri,  4 Dec 2020 03:57:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E095E42049;
        Fri,  4 Dec 2020 03:57:21 +0000 (GMT)
Received: from [9.199.46.245] (unknown [9.199.46.245])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Dec 2020 03:57:21 +0000 (GMT)
Subject: Re: [PATCH 1/1] generic: Add test to check for mounting a huge sparse
 dm device
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
        anju@linux.vnet.ibm.com, Christian Kujau <lists@nerdbynature.de>,
        linux-ext4@vger.kernel.org
References: <daec44e9f2e3ce483b7845065db3bf148ff5cd2c.1603864280.git.riteshh@linux.ibm.com>
 <20201101162427.GF3853@desktop>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <622a8ba2-0e50-77d6-a6c5-4a91b991afb0@linux.ibm.com>
Date:   Fri, 4 Dec 2020 09:27:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201101162427.GF3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_15:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040019
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/1/20 9:54 PM, Eryu Guan wrote:
> On Wed, Oct 28, 2020 at 12:14:52PM +0530, Ritesh Harjani wrote:
>> Add this test (which Christian Kujau reported) to check for regression
>> caused due to ext4 bmap aops implementation was moved to use iomap APIs.
>> jbd2 calls bmap() kernel function from fs/inode.c which was failing since
>> iomap_bmap() implementation earlier returned 0 for block addr > INT_MAX.
>> This regression was fixed with following kernel commit [1]
>> commit b75dfde1212991b24b220c3995101c60a7b8ae74
>> ("fibmap: Warn and return an error in case of block > INT_MAX")
>> [1]: https://patchwork.ozlabs.org/patch/1279914
>>
>> w/o the kernel fix we get below error and mount fails
>>
>> [ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
>> [ 1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
>> [ 1530.513310] EXT4-fs (dm-1): Could not load journal inode
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   common/rc             | 10 +++++++
>>   tests/generic/613     | 66 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/613.out |  3 ++
>>   tests/generic/group   |  1 +
>>   4 files changed, 80 insertions(+)
>>   create mode 100755 tests/generic/613
>>   create mode 100644 tests/generic/613.out
>>
>> diff --git a/common/rc b/common/rc
>> index 27a27ea36f75..b0c353c4c107 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1607,6 +1607,16 @@ _require_scratch_size()
>>   	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>>   }
>>
>> +# require a scratch dev of a minimum size (in kb) and should not be checked
>> +# post test
>> +_require_scratch_size_nocheck()
>> +{
>> +	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
>> +
>> +	_require_scratch_nocheck
>> +	local devsize=`_get_device_size $SCRATCH_DEV`
>> +	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>> +}
> 
> Seems there's no need to introduce this new helper, just open-coded
> 
> # comments on why we use _nocheck here
> _require_scratch_nocheck
> _require_scratch_size $size

This does not work. Bcoz _require_scratch_size will create a
scratch file which I guess it will check at the end of the test.
If not there, then it reports FS as inconsistent.

I get below errors with above open coding this, as you mentioned above.
generic/618 138s ... _check_generic_filesystem: filesystem on /dev/loop3 
is inconsistent
(see 
/home/machine/src/tools-work/xfstests-dev/results//ext4_4k/generic/618.full 
for details)


> 
>>
>>   # this test needs a test partition - check we're ok & mount it
>>   #
>> diff --git a/tests/generic/613 b/tests/generic/613
>> new file mode 100755
>> index 000000000000..b426ef91cacf
>> --- /dev/null
>> +++ b/tests/generic/613
>> @@ -0,0 +1,66 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
>> +# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
>> +#
>> +# FS QA Test generic/613
>> +#
>> +# Since the test is not specific to ext4, hence adding it to generic.
>> +# Add this test to check for regression which was reported when ext4 bmap
>> +# aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
>> +# from fs/inode.c which was failing since iomap_bmap() implementation earlier
>> +# returned 0 for block addr > INT_MAX.
>> +# This regression was fixed with following kernel commit [1]
>> +# commit b75dfde1212991b24b220c3995101c60a7b8ae74
>> +# ("fibmap: Warn and return an error in case of block > INT_MAX")
>> +# [1]: https://patchwork.ozlabs.org/patch/1279914
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	_dmhugedisk_cleanup
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmhugedisk
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_require_dmhugedisk
>> +_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
>> +
>> +# For 1k bs with ext4, mkfs was failing maybe due to size limitation.
> 
> I think that's because only 4k blocksize ext4 supports filesystems
> greater than 16T.
> 
>> +if [ "$FSTYP" = "ext4" ]; then
>> +	export MKFS_OPTIONS="-F -b 4096"
>> +fi
> 
> I'd check for fs block size after mkfs and _notrun if it's ext4 and
> block_size < 4k. So we don't have to overwrite MKFS_OPTIONS and run the
> test multiple times forcely in, for example ext4-1k config & ext4-4k
> config.

Yup, I agree with this. Let me send a v2 addressing above comment.


> 
> 
>> +
>> +# 17TB dm huge-test-zer0 device
>> +# (in terms of 512 sectors)
>> +sectors=$((2*1024*1024*1024*17))
>> +chunk_size=128
>> +
>> +_dmhugedisk_init $sectors $chunk_size
>> +_mkfs_dev $DMHUGEDISK_DEV
>> +_mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
>> +testfile=$SCRATCH_MNT/testfile-$seq
>> +
>> +$XFS_IO_PROG -fc "pwrite -S 0xaa 0 1m" -c "fsync" $testfile | _filter_xfs_io
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/613.out b/tests/generic/613.out
>> new file mode 100644
>> index 000000000000..4747b7596499
>> --- /dev/null
>> +++ b/tests/generic/613.out
>> @@ -0,0 +1,3 @@
>> +QA output created by 613
>> +wrote 1048576/1048576 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 8054d874f005..360d145d2036 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -615,3 +615,4 @@
>>   610 auto quick prealloc zero
>>   611 auto quick attr
>>   612 auto quick clone
>> +613 auto mount quick
>> --
>> 2.26.2

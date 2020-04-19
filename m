Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7F1AF630
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDSB5D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Apr 2020 21:57:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50394 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgDSB5D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 18 Apr 2020 21:57:03 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03J1X3pi030253
        for <linux-ext4@vger.kernel.org>; Sat, 18 Apr 2020 21:57:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gbfma44q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Sat, 18 Apr 2020 21:57:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sun, 19 Apr 2020 02:56:38 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 19 Apr 2020 02:56:35 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03J1tnxs45809958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Apr 2020 01:55:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F49A404D;
        Sun, 19 Apr 2020 01:56:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2061A4051;
        Sun, 19 Apr 2020 01:56:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.253])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 19 Apr 2020 01:56:54 +0000 (GMT)
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sun, 19 Apr 2020 07:26:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041901-0012-0000-0000-000003A70DE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041901-0013-0000-0000-000021E454AA
Message-Id: <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-18_10:2020-04-17,2020-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004190010
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

++ mailing list.
Sorry somehow it got dropped.


On 4/19/20 7:21 AM, Ritesh Harjani wrote:
> Hello Murphy,
> 
> I guess the patch to fix this issue was recently submitted.
> Could you please test your reproducer, xfstest and ltp
> tests on below patch too. And let me know if we can add your Tested-by:
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1a2dc8f198e1225ddd40833de76b60c7ee20d22d.1587024137.git.riteshh@linux.ibm.com/ 
> 
> 
> -ritesh
> 
> On 4/19/20 5:02 AM, Murphy Zhou wrote:
>> Sometimes crazy userspace values can be here causing overflow issue.
>>
>> After moved ext4_fiemap to using the iomap framework in
>>    commit d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
>> we can hit the WARN_ON at fs/iomap/apply.c:51, then get an EIO error
>> running xfstests generic/009 (and some others) on ext4 based overlayfs.
>>
>> The minimal reproducer is:
>> -------------------------------------
>> fallocate -l 256M test.img
>> mkfs.ext4 -Fq -b 4096 -I 256 test.img
>> mkdir -p test
>> mount -o loop test.img test || exit
>> pushd test
>> rm -rf l u w m
>> mkdir -p l u w m
>> mount -t overlay -o lowerdir=l,upperdir=u,workdir=w overlay m || exit
>> xfs_io -f -c "pwrite 0 4096" -c "fiemap"  m/tf
>> umount m
>> rm -rf l u w m
>> popd
>> umount -d test
>> rm -rf test test.img
>> -------------------------------------
>>
>> Because we run fiemap command wo/ the offset and length parameters,
>> xfs_io set values based on fs blocksize etc which is got from
>> the mounted fs. These values xfs_io passed are way larger on overlayfs
>> than ext4 directly. So we can't reproduce this directly on ext4 or xfs.
>> I tried to call ioctl directly with large length value but failed to
>> reproduce this.
>>
>> I did not try to get what values xfs_io exactly passing in, but I
>> confirmed that overflowed value when it made into _ext4_fiemap.
>> It's a length of 0x7fffffffffffffff which will mess up the calculation
>> of map.m_lblk and map.m_len, make map.m_len to be 0, then hit WARN_ON
>> and get EIO in iomap_apply.
>>
>> Fixing this by ensuring the offset and length values wont exceed
>> EXT4_MAX_LOGICAL_BLOCK. Also make sure that the length would not
>> be zero because of crazy overflowed values.
>>
>> This patch has been tested with LTP/xfstests showing no new issue.
>>
>> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
>> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
>> ---
>>   fs/ext4/inode.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index e416096..3620417 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3523,6 +3523,8 @@ static int ext4_iomap_begin_report(struct inode 
>> *inode, loff_t offset,
>>       int ret;
>>       bool delalloc = false;
>>       struct ext4_map_blocks map;
>> +    ext4_lblk_t last_lblk;
>> +    ext4_lblk_t lblk;
>>       u8 blkbits = inode->i_blkbits;
>>       if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>> @@ -3540,9 +3542,18 @@ static int ext4_iomap_begin_report(struct inode 
>> *inode, loff_t offset,
>>       /*
>>        * Calculate the first and last logical block respectively.
>>        */
>> -    map.m_lblk = offset >> blkbits;
>> -    map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>> -              EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +    lblk = offset >> blkbits;
>> +    last_lblk = (offset + length - 1) >> blkbits;
>> +
>> +    if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
>> +        last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>> +    if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
>> +        lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>> +
>> +    map.m_lblk = lblk;
>> +    map.m_len = last_lblk - lblk + 1;
>> +    if (map.m_len == 0 )
>> +        map.m_len = 1;
>>       /*
>>        * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
>>


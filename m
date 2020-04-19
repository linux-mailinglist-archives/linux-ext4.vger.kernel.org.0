Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98C1AFC1D
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDSQsT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 12:48:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726615AbgDSQsT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 19 Apr 2020 12:48:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03JGVVWC103536
        for <linux-ext4@vger.kernel.org>; Sun, 19 Apr 2020 12:48:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gg25tb1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Sun, 19 Apr 2020 12:48:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sun, 19 Apr 2020 17:47:43 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 19 Apr 2020 17:47:42 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03JGl7T943319686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Apr 2020 16:47:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A98ED52051;
        Sun, 19 Apr 2020 16:48:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.253])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 909D45204F;
        Sun, 19 Apr 2020 16:48:12 +0000 (GMT)
Subject: Re: strange allocator behavior on a 2k block fs, skipping free blocks
To:     Eric Sandeen <sandeen@sandeen.net>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <24fd6030-28f4-b395-4d85-a13be6e2af06@sandeen.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Date:   Sun, 19 Apr 2020 22:18:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <24fd6030-28f4-b395-4d85-a13be6e2af06@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041916-0008-0000-0000-000003739063
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041916-0009-0000-0000-00004A954FFA
Message-Id: <20200419164812.909D45204F@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-19_04:2020-04-17,2020-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=2 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004190144
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All,

On 4/17/20 12:46 AM, Eric Sandeen wrote:
> This got picked up by xfstests generic/018 on a 2k block filesystem when it
> failed to defragment a file into 1 extent as expected.
> 
> For some reason, the allocator is skipping over free blocks when it allocates
> the donor file.  The attached image shows this behavior - if you do:
> 
> # bunzip2 ext4.img.qcow.bz2
> # qemu-img convert -O raw ext4.img.qcow ext4.img
> # mkdir -p mnt
> # mount -o loop ext4.img mnt/
> # fallocate -l 20480 mnt/newfile
> # filefrag -v mnt/newfile
> Filesystem type is: ef53
> File size of mnt/newfile is 20480 (10 blocks of 2048 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..       1:      16962..     16963:      2:             unwritten
>     1:        2..       9:      16968..     16975:      8:      16964: unwritten,eof
> mnt/newfile: 2 extents found
> 
> it allocates 2 extents, even though the blocks in between the extents are free:
> 
> # dumpe2fs test.img | grep -w 16964
> dumpe2fs 1.42.9 (28-Dec-2013)
>    Free blocks: 16964-16967, 16976-17407, 17410-17919, 17922-18431, 18434-18943, 18946-19455, 19457-19967, 19969-32767
> 

So my initial investigation on this says that below is what is
happening. Also verified by logs.
1. Initially when the fallocate blocks are requested with length of 10 
blocks. (please note in fallocate path we don't set the
EXT4_MB_HINT_TRY_GOAL).
	-> For blocks of length 10 (since length of not order of 2
multiple), we chose allocation criteria as 1. And go for
ext4_mb_scan_aligned() with stripe size as 2. So in that function
we only look for 2 blocks as needed blocks(since stripe size is 2
blocks) and we return this 2 blocks as the allocated blocks from
ext4_map_blocks.
This is where we get the blocks as (16962, 16963).

2. Now again fallocate path request for remaining length which is 8.
At this time, since 8 is equal 2^3 request. So we go with criteria
as 0. And try the allocation path via ext4_mb_simple_scan_group().

In 2nd iteration, buddy structures are scanned to find the right fit of 
the block. That's why we see two extents in above results.

I guess if we make stripe size as 0, then I don't think we will see
this problem.

> I suppose this isn't critical, as defrag is best-effort and the allocator doesn't ever guarantee contiguous allocations, but it still seems a little odd so just thought I'd highlight it.

But others can tell if this is really a problem which needs fixing in
the long run?

-ritesh


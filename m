Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44B1ACFB6
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgDPSdV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 14:33:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgDPSdU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 14:33:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GIXIUJ009831
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 14:33:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ev12hcec-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 14:33:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 16 Apr 2020 19:32:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 19:32:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GIXBRT35586092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 18:33:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E65D6A4051;
        Thu, 16 Apr 2020 18:33:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13914A404D;
        Thu, 16 Apr 2020 18:33:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.253])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 18:33:08 +0000 (GMT)
Subject: Re: [QUESTION] BUG_ON in ext4_mb_simple_scan_group
To:     yangerkun <yangerkun@huawei.com>, tytso@mit.edu, jack@suse.cz,
        dmonakhov@gmail.com, adilger@dilger.ca, bob.liu@oracle.com,
        wshilong@ddn.com, "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org
References: <9ba13e20-2946-897d-0b81-3ea7b21a4db6@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 17 Apr 2020 00:03:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9ba13e20-2946-897d-0b81-3ea7b21a4db6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041618-0012-0000-0000-000003A5B93F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041618-0013-0000-0000-000021E2FA73
Message-Id: <20200416183309.13914A404D@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_07:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160129
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Kun,

On 4/16/20 7:49 PM, yangerkun wrote:
> Nowadays, we trigger the a bug that has been reported before[1](trigger 
> the bug with read block bitmap error before). After search the patch,
> I found some related patch which has not been included in our kernel.
> 
> eb5760863fc2 ext4: mark block bitmap corrupted when found instead of BUGON
> 736dedbb1a7d ext4: mark block bitmap corrupted when found
> 206f6d552d0c ext4: mark inode bitmap corrupted when found
> db79e6d1fb1f ext4: add new ext4_mark_group_bitmap_corrupted() helper
> 0db9fdeb347c ext4: fix wrong return value in ext4_read_inode_bitmap()

I see that you anyways have figured all these patches out.

> 
> Maybe this patch can fix the problem, but I am a little confused with
> the explain from Ted described in the mail:
> 
>  > What probably happened is that the page containing actual allocation
>  > bitmap was pushed out of memory due to memory pressure.  However, the
>  > buddy bitmap was still cached in memory.  That's actually quite
>  > possible since the buddy bitmap will often be referenced more
>  > frequently than the allocation bitmap (for example, while searching
>  > for free space of a specific size, and then having that block group
>  > skipped when it's not available).
> 
>  > Since there was an I/O error reading the allocation bitmap, the buffer
>  > is not valid.  So it's not surprising that the BUG_ON(k >= max) is
>  > getting triggered.

@Others, please correct me if I am wrong here.

So just as a small summary. Ext4 maintains an inode (we call it as
buddy cache inode which is sbi->s_buddy_cache) which stores the block
bitmap and buddy information for every block group. So we require 2
blocks for every block group to store both of this info in it.

So what generally happens is whenever there is a request to block
allocation, this(buddy and block bitmap information is loaded from the
disk into the page cache.

When someone does the block allocation these pages get loaded into the
page cache. And it will be there until these pages are getting heavily
used (that's coz of page eviction algo in mm).
But in case when the memory pressure is high, these pages may get
written out and eventually getting evicted from the page cache.
Now if any of this page is not present in the page cache we go and try
to read it from the disk. (I think that's the job of
ext4_mb_load_buddy_gfp()).

So let's say while reading this page from disk we get an I/O error,
so this means, as Ted explained, that the buffer which was not properly
read and hence it is not uptodate (and so we also don't set buffer
verified bit).
And in that case we should mark that block group corrupted. So that next
time, ext4_mb_good_group() does not allow us to do allocation from that
block group. I think some of the patches which you pointed add the logic
into the mballoc. So that we don't hit that bug_on().

{...
[Addition info - not related to your issue though]
So this could also be an e.g. where the grp->bb_free may not be uptodate
for a block group of which bitmap was not properly loaded.
...}


> 
> (Our machine: x86, 4K page size, 4K block size)
> 
> After check the related code, we found that once we get a IO error from 
> ext4_wait_block_bitmap, ext4_mb_init_cache will return directly with a 
> error number, so the latter ext4_mb_simple_scan_group may never been 
> called! So any other scene will trigger this BUG_ON?

Sorry that's not what I see in latest upstream kernel.
I am not sure which kernel version you are checking this on.
Check the latest upstream kernel and compare with it.


> 
> Thanks,
> Kun.
> 
> -----
> [1] https://www.spinics.net/lists/linux-ext4/msg60329.html
> 


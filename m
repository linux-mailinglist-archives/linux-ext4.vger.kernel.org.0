Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222031AD4D8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Apr 2020 05:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgDQD0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 23:26:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbgDQD0y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 23:26:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H33onC040034
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 23:26:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30f46prg13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 23:26:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 17 Apr 2020 04:26:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Apr 2020 04:26:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H3Qk7C55705694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 03:26:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E8E1A4040;
        Fri, 17 Apr 2020 03:26:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DF3A404D;
        Fri, 17 Apr 2020 03:26:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.253])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Apr 2020 03:26:44 +0000 (GMT)
Subject: Re: [QUESTION] BUG_ON in ext4_mb_simple_scan_group
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     yangerkun <yangerkun@huawei.com>, tytso@mit.edu, jack@suse.cz,
        dmonakhov@gmail.com, adilger@dilger.ca, bob.liu@oracle.com,
        wshilong@ddn.com, linux-ext4@vger.kernel.org
References: <9ba13e20-2946-897d-0b81-3ea7b21a4db6@huawei.com>
 <20200416183309.13914A404D@d06av23.portsmouth.uk.ibm.com>
 <39040d8c-9918-d976-a25a-0ec189f1e111@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 17 Apr 2020 08:56:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <39040d8c-9918-d976-a25a-0ec189f1e111@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041703-0020-0000-0000-000003C93CDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041703-0021-0000-0000-0000222226A7
Message-Id: <20200417032644.75DF3A404D@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_10:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170020
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Yi,

On 4/17/20 7:36 AM, zhangyi (F) wrote:
> Hi, Ritesh
> 
> On 2020/4/17 2:33, Ritesh Harjani wrote:
>> Hello Kun,
>>
>> On 4/16/20 7:49 PM, yangerkun wrote:
>>> Nowadays, we trigger the a bug that has been reported before[1](trigger the bug with read block bitmap error before). After search the patch,
>>> I found some related patch which has not been included in our kernel.
>>>
>>> eb5760863fc2 ext4: mark block bitmap corrupted when found instead of BUGON
>>> 736dedbb1a7d ext4: mark block bitmap corrupted when found
>>> 206f6d552d0c ext4: mark inode bitmap corrupted when found
>>> db79e6d1fb1f ext4: add new ext4_mark_group_bitmap_corrupted() helper
>>> 0db9fdeb347c ext4: fix wrong return value in ext4_read_inode_bitmap()
>>
>> I see that you anyways have figured all these patches out.
>>
>>>
>>> Maybe this patch can fix the problem, but I am a little confused with
>>> the explain from Ted described in the mail:
>>>
>>>   > What probably happened is that the page containing actual allocation
>>>   > bitmap was pushed out of memory due to memory pressure.  However, the
>>>   > buddy bitmap was still cached in memory.  That's actually quite
>>>   > possible since the buddy bitmap will often be referenced more
>>>   > frequently than the allocation bitmap (for example, while searching
>>>   > for free space of a specific size, and then having that block group
>>>   > skipped when it's not available).
>>>
>>>   > Since there was an I/O error reading the allocation bitmap, the buffer
>>>   > is not valid.  So it's not surprising that the BUG_ON(k >= max) is
>>>   > getting triggered.
>>
>> @Others, please correct me if I am wrong here.
>>
>> So just as a small summary. Ext4 maintains an inode (we call it as
>> buddy cache inode which is sbi->s_buddy_cache) which stores the block
>> bitmap and buddy information for every block group. So we require 2
>> blocks for every block group to store both of this info in it.
>>
>> So what generally happens is whenever there is a request to block
>> allocation, this(buddy and block bitmap information is loaded from the
>> disk into the page cache.
>>
>> When someone does the block allocation these pages get loaded into the
>> page cache. And it will be there until these pages are getting heavily
>> used (that's coz of page eviction algo in mm).
>> But in case when the memory pressure is high, these pages may get
>> written out and eventually getting evicted from the page cache.
>> Now if any of this page is not present in the page cache we go and try
>> to read it from the disk. (I think that's the job of
>> ext4_mb_load_buddy_gfp()).
>>
>> So let's say while reading this page from disk we get an I/O error,
>> so this means, as Ted explained, that the buffer which was not properly
>> read and hence it is not uptodate (and so we also don't set buffer
>> verified bit).
>> And in that case we should mark that block group corrupted. So that next
>> time, ext4_mb_good_group() does not allow us to do allocation from that
>> block group. I think some of the patches which you pointed add the logic
>> into the mballoc. So that we don't hit that bug_on().
>>
>> {...
>> [Addition info - not related to your issue though]
>> So this could also be an e.g. where the grp->bb_free may not be uptodate
>> for a block group of which bitmap was not properly loaded.
>> ...}
>>
>>
>>>
>>> (Our machine: x86, 4K page size, 4K block size)
>>>
>>> After check the related code, we found that once we get a IO error from ext4_wait_block_bitmap, ext4_mb_init_cache will return directly with a error number, so the latter ext4_mb_simple_scan_group may never been called! So any other scene will trigger this BUG_ON?
>>
>> Sorry that's not what I see in latest upstream kernel.
>> I am not sure which kernel version you are checking this on.
>> Check the latest upstream kernel and compare with it.
>>
>>
> 
> Thanks for your reply.
> 
> We check the upstream kernel 5.7-rc1, on our machine which has 4K page size
> and 4K block size, if the ext4_wait_block_bitmap() invoked from
> ext4_mb_init_cache() return -EIO, the 'err' variable will be set and the
> subsequent loop will be jumped out due to '!buffer_verified[group - first_group]
> && blocks_per_page == 1', so the -EIO error number will return by
> ext4_mb_load_buddy() and there is no chance to invoke ext4_mb_simple_scan_group()
> and trigger BUG_ON().
> 
> static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
> {
> ...
>          /* wait for I/O completion */
>          for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
> ...
>                  err2 = ext4_wait_block_bitmap(sb, group, bh[i]);
>                  if (!err)
>                          err = err2;     <------ set -EIO here
>          }
> 
>          first_block = page->index * blocks_per_page;
>          for (i = 0; i < blocks_per_page; i++) {
>                  group = (first_block + i) >> 1;
> ...
>                  if (!buffer_verified(bh[group - first_group]))
>                          /* Skip faulty bitmaps */
>                          continue;<----- blocks_per_page == 1, we jump out here
>                  err = 0;  <---- never excute
> ...
> out:
> ...
>          return err;
> }
> 
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> ...
>                         err = ext4_mb_load_buddy(sb, group, &e4b);
>                         if (err)
>                                 goto out;   <--- return here
> ...
>                         if (cr == 0)
>                                 ext4_mb_simple_scan_group(ac, &e4b); <--- never invoke
> ...
> }

Yup, I guess what you mentioned is correct. But I noted one other thing.
Check if below could lead to this.

static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
{
<...>
	first_group = page->index * blocks_per_page / 2;

	/* read all groups the page covers into the cache */
	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
		if (group >= ngroups)
			break;

		grinfo = ext4_get_group_info(sb, group);
		/*
		 * If page is uptodate then we came here after online resize
		 * which added some new uninitialized group info structs, so
		 * we must skip all initialized uptodate buddies on the page,
		 * which may be currently in use by an allocating task.
		 */
		if (PageUptodate(page) && !EXT4_MB_GRP_NEED_INIT(grinfo)) {
			bh[i] = NULL;
			continue;
		}
		bh[i] = ext4_read_block_bitmap_nowait(sb, group);
		if (IS_ERR(bh[i])) {
			err = PTR_ERR(bh[i]);
			bh[i] = NULL;
			goto out;
		}
		mb_debug(1, "read bitmap for group %u\n", group);
	}

	/* wait for I/O completion */
	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
		int err2;

		if (!bh[i])
			continue;
		err2 = ext4_wait_block_bitmap(sb, group, bh[i]);
		if (!err)
			err = err2;
	}

	first_block = page->index * blocks_per_page;
	for (i = 0; i < blocks_per_page; i++) {
<...>
		if (!buffer_verified(bh[group - first_group]))
			/* Skip faulty bitmaps */
			continue;
		err = 0;            ====> yes this was not set I think.

<...>
	}
	SetPageUptodate(page);       ========> But it seems we are still 
setting uptodate bit on page.

out:
	if (bh) {
		for (i = 0; i < groups_per_page; i++)
			brelse(bh[i]);
		if (bh != &bhs)
			kfree(bh);
	}
	return err;
}


ext4_mb_load_buddy_gfp() {
<...>


	/* we could use find_or_create_page(), but it locks page
	 * what we'd like to avoid in fast path ... */
	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
	if (page == NULL || !PageUptodate(page)) {  	====> next time we won't 
go in this if condition. (since PageUptodate is already set)
<...>
		page = find_or_create_page(inode->i_mapping, pnum, gfp);
		if (page) {
			BUG_ON(page->mapping != inode->i_mapping);
			if (!PageUptodate(page)) {
				ret = ext4_mb_init_cache(page, NULL, gfp);
<...>
			}
			unlock_page(page);
		}
	}
	if (page == NULL) {
		ret = -ENOMEM;
		goto err;
	}
	if (!PageUptodate(page)) {
		ret = -EIO;
		goto err;
	}
<...>
}


So maybe since the PageUptodate bit was set on page previously as
highlighted above. Next time when there will be any allocation request,
we won't read those pages again from disk (thinking that it's uptodate.
And hence may encounter that BUG. Thoughts?

If above is true, then may be we should not call
"SetPageUptodate(page)", in case of an error reading block bitmap?
Thoughts?

One other thing from [1]. I guess it doesn't have a full kernel log.
So maybe there were some previous I/O errors as well and it failed
to update the superblock buffer_head even before. So something
may have messed up long before and it slipped through all the cracks
until it crashed in mballoc.


-ritesh


> 
> We also find that ext4_group_info:bb_counters and the corresponding buddy bit map
> are updated or initialized at the same time, so even if we encounter page miss and
> forget to mark that block group corrupted due to IO failure, it seems that it also
> could not trigger this inconsistency. Am I missing something ?
> 
> Thanks,
> Yi.
> 
>>> -----
>>> [1] https://www.spinics.net/lists/linux-ext4/msg60329.html
>>>
>>
>>
>> .
> 


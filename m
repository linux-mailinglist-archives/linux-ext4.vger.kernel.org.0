Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D54BF31B
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfIZMhB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 08:37:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfIZMhA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Sep 2019 08:37:00 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QCZwrL181680
        for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2019 08:36:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7mfs3w0r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2019 08:36:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 26 Sep 2019 13:35:02 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Sep 2019 13:35:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8QCYxwD46530846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 12:34:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130364C040;
        Thu, 26 Sep 2019 12:34:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2984C044;
        Thu, 26 Sep 2019 12:34:56 +0000 (GMT)
Received: from [9.199.159.6] (unknown [9.199.159.6])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Sep 2019 12:34:56 +0000 (GMT)
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Jan Kara <jack@suse.cz>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, tytso@mit.edu,
        linux-ext4@vger.kernel.org, david@fromorbit.com, hch@infradead.org,
        adilger@dilger.ca, mbobrowski@mbobrowski.org, rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190924151025.GD11819@quack2.suse.cz>
 <20190924194804.ED164A4040@d06av23.portsmouth.uk.ibm.com>
 <20190925092339.GB23277@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 26 Sep 2019 18:04:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190925092339.GB23277@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092612-0012-0000-0000-00000350F80C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092612-0013-0000-0000-0000218B8F8F
Message-Id: <20190926123456.9B2984C044@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260119
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan,

Thanks for answering it all and giving all the info.

On 9/25/19 2:53 PM, Jan Kara wrote:
> On Wed 25-09-19 01:18:04, Ritesh Harjani wrote:
>>> read takes i_rwsem exclusive lock instead of shared, it is a win for your
>>> workload... Argh, now checking code in fs/direct-io.c I think I can see the
>>> difference. The trick in do_blockdev_direct_IO() is:
>>>
>>>           if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
>>>                   inode_unlock(dio->inode);
>>>           if (dio->is_async && retval == 0 && dio->result &&
>>>               (iov_iter_rw(iter) == READ || dio->result == count))
>>>                   retval = -EIOCBQUEUED;
>>>           else
>>>                   dio_await_completion(dio);
>>>
>>> So actually only direct IO read submission is protected by i_rwsem with
>>> DIO_LOCKING. Actual waiting for sync DIO read happens with i_rwsem dropped.
>>>
>>> After some thought I think the best solution for this is to just finally
>>> finish the conversion of ext4 so that dioread_nolock is the only DIO path.
>>
>> Sorry, I still didn't get this completely. Could you please explain a bit
>> more?
> 
> Well, currently we have two different locking schemes for DIO - the
> "normal" case and the "dioread_nolock" case. And the "normal" case really
> only exists because buffered writeback needed to be more careful (so that
> nolock DIO cannot expose stale data) and nobody did the effort to make that
> work when blocksize < pagesize. But having two different locking schemes
> for DIO is really confusing to users and a maintenance burden so we want to
> get rid of the old scheme once the "dioread_nolock" scheme works for all
> the configurations.

Agreed.

>   
>>> With i_rwsem held in shared mode even for "unlocked" DIO, it should be
>>> actually relatively simple and most of the dances with unwritten extents
>>> shouldn't be needed anymore.
>>
>> Again, maybe it's related to above comment. Could you please give some
>> insights?
> 
> Now that we hold i_rwsem in shared mode for all of DIO, it isn't really
> "unlocked" anymore. Which actually very much limits the races with buffered
> writes and thus page writeback (because we flush page cache before doing
> DIO).

So looking at the code again based on your inputs from above, we should
be able to remove this condition <snip below> in ext4_dio_write_checks.

What I meant is, in DIO writes path we can start with shared lock
(which the current patch is doing), and only check for below conditions
<snip below> for it to continue using shared lock.
(i.e. we need not check for ext4_should_dioread_nolock(inode) anymore).

That means there should not be any race for non-extent based mode
too right?


Because for overwrites in DIO (for both extents & non-extents)-
(just reiterating)

1. Race against bufferedIO writes and DIO overwrites will be protected
via SHARED inode lock in DIO overwrites & EXCL lock in bufferedIO
writes. Plus we flush page cache before doing DIO.

2. Race against bufferedIO reads & DIO overwrites will be anyway 
protected since we don't do any block allocations during DIO overwrite.

3. Again race against DIO reads & DIO overwrites is not be a problem,
since no block allocation is done anyway. So no stale data will be
exposed.


<snip of change we should do in ext4_dio_write_checks>

         if (*iolock == EXT4_IOLOCK_SHARED &&
             (!IS_NOSEC(inode) || *unaligned_io || *extend ||
-            !ext4_should_dioread_nolock(inode) ||
              !ext4_overwrite_io(inode, offset, count))) {
                 ext4_iunlock(inode, *iolock);
                 *iolock = EXT4_IOLOCK_EXCL;
                 ext4_ilock(inode, *iolock);
                 goto restart;
         }

> 
>> Or do you mean that we should do it like this-
>> So as of now in dioread_nolock, we allocate blocks, mark the entry into
>> extents as unwritten, then do the data IO, and then finally do the
>> conversion of unwritten to written extents.
> 
> So this allocation of extents as unwritten in dioread_nolock mode is now
> mostly unnecessary. We hold i_rwsem for reading (or even for writing) while
> submitting any DIO. Because we flush page cache before starting DIO and new
> pages cannot be dirtied by buffered writes (i_rwsem), DIO cannot be racing
> with page writeback and thus cannot expose stale block contents. There is
> one exception though - which is why I wrote "mostly" above - pages can
> still be dirtied through memory mappings (there's no i_rwsem protection for
> mmap writes) and thus races with page writeback exposing stale data are still
> theoretically possible. In fact the "normal" DIO mode has this kind of race
> all the time ext4 exists.

Yes, now that you said I could see this below race even with current
code. Any other race too?

i.e.
ext4_dio_read			ext4_page_mkwrite()

     filemap_write_and_wait_range()
				     ext4_get_blocks()

     submit_bio
     // this could expose the stale data.
		
				     mark_buffer_dirty()


Ok. I guess we cannot use any exclusive inode lock in ext4_page_mkwrite,
because then we loose the parallelism that it offers right now.
Wonder how other FS protect this race (like XFS?)


> I guess we could fix this by falling back to page writeback using unwritten
> extents when we have dirty pages locked for writeback and see there's any
> DIO in flight for the inode. Sadly that means we we cannot get rid of
> writeback code using unwritten extents but at least it won't be hurting
> performance in the common case.


1. So why to check for dirty pages locked for writeback (in
ext4_page_mkwrite)? we anyway lock the page which we modify or
allocate block for. So race against bufferedRead should not happen.

2. And even if we check for inode_dio_wait(), we still can't gurantee
that the next DIO may not snoopin while we are in ext4_page_mkwrite?

I am definitely missing something here.


> 
>> So instead of that we first only reserve the disk blocks, (without
>> making any on-disk changes in extent tree), do the data IO and then
>> finally make an entry into extent tree on disk. And going
>> forward only keep this as the default path.
>>
>> The above is something I have been looking into for enabling
>> dioread_nolock for powerpc platforms where blocksize < page_size.
>> This is based upon an upstream discussion between Ted and you :)
> 
> Yes, this is even better solution to dioread_nolock "problem" but it is
> also more work 

Yes, I agree that we should do this incrementally.


> then just dropping the old DIO locking mode and
> fix writeback using unwritten extents for blocksize < pagesize.


So, I was looking into this (to support dioread_nolock for
blocksize < pagesize) but I could not find any history in git,
nor any thread which explains the problem.

I got below understanding while going over code -

1. This problem may be somehow related to bufferheads in the
extent conversion from unwritten to written in writeback path.
But I couldn't see what exactly is the issue there?

I see that the completion path happens via
ext4_end_io
    |- ext4_convert_unwritten_extents() // offset & size is properly 
taken care.
    |- ext4_release_io_end() (which is same in both DIO & writeback).


2. One thing which I noticed is the FIXME in
mpage_map_and_submit_buffers(). Where we
io->io_end->size we add the whole PAGE_SIZE.
I guess we should update the size here carefully
based on buffer_heads.


Could you please give some pointers as to what
is the limitation. Or some hint which I can go
and check by myself.



>> But even with above, in case of extending writes, we still
>> will have to zero out those extending blocks no? Which
>> will require an exclusive inode lock anyways for zeroing.
>> (same which has been done in XFS too).
> 
> Yes, extending writes are a different matter.
> 
>> So going with current discussed solution of mounting with
>> dioread_nolock to provide performance scalability in mixed read/write
>> workload should be also the right approach, no?
>> Also looking at the numbers here [3] & [4], this patch also seems
>> to improve the performance with dioread_nolock mount option.
>> Please help me understand your thoughts on this.
> 
> Yes, your patches are definitely going in the right direction. What I'm
> discussing is mostly how to make ext4 perform well for mixed read/write
> workload by default without user having to use magic mount option.

Really thanks for your support here.

So can we get these patches upstream incrementally?
i.e.
1. As a first step, we can remove this condition
ext4_should_dioread_nolock from the current patchset
(as mentioned above too) &  get this patch rebased
on top of iomap pathset. We should be good to merge
this patchset then, right? Since this should be able
to improve the performance even without dioread_nolock
mount option.


2. Meanwhile I will continue to check for blocksize < pagesize
requirement for dioread_nolock. We can follow the plan
as you mentioned above then.

Your thoughts?


-ritesh


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4204AFE9B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfIKOVH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 10:21:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbfIKOVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Sep 2019 10:21:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BEETkk067896
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 10:21:05 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uy0cawrv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 10:21:04 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 11 Sep 2019 15:21:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 15:21:00 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BEKxIM38731816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 14:20:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D934204D;
        Wed, 11 Sep 2019 14:20:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A522942049;
        Wed, 11 Sep 2019 14:20:57 +0000 (GMT)
Received: from [9.199.159.54] (unknown [9.199.159.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 14:20:57 +0000 (GMT)
Subject: Re: [PATCH 0/3] Revert parallel dio reads
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, hch@infradead.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20190827115118.GY7777@dread.disaster.area>
 <20190829105858.GA22939@quack2.suse.cz>
 <20190910141041.134674C072@d06av22.portsmouth.uk.ibm.com>
 <20190910215720.GA7561@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 11 Sep 2019 19:50:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190910215720.GA7561@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091114-0016-0000-0000-000002AA0CC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091114-0017-0000-0000-0000330A9977
Message-Id: <20190911142057.A522942049@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110133
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On 9/11/19 3:27 AM, Jan Kara wrote:
> Hello,
> 
> On Tue 10-09-19 19:40:40, Ritesh Harjani wrote:
>>>> Before doing this, you might want to have a chat and co-ordinate
>>>> with the folks that are currently trying to port the ext4 direct IO
>>>> code to use the iomap infrastructure:
>>>>
>>>> https://lore.kernel.org/linux-ext4/20190827095221.GA1568@poseidon.bobrowski.net/T/#t
>>>>
>>>> That is going to need the shared locking on read and will work just
>>>> fine with shared locking on write, too (it's the code that XFS uses
>>>> for direct IO). So it might be best here if you work towards shared
>>>> locking on the write side rather than just revert the shared locking
>>>> on the read side....
>>>
>>> Yeah, after converting ext4 DIO path to iomap infrastructure, using shared
>>> inode lock for all aligned non-extending DIO writes will be easy so I'd
>>> prefer if we didn't have to redo the iomap conversion patches due to these
>>> reverts.
>>
>> I was looking into this to see what is required to convert this into
>> shared locking for DIO write side.
>> Why do you say shared inode lock only for *aligned non-extending DIO
>> writes*?
>> non-extending means overwrite case only, which still in today's code is
>> not under any exclusive inode_lock (except the orphan handling and truncate
>> handling in case of error after IO is completed). But even with
>> current code the perf problem is reported right?
> 
> Yes, the problem is even with current code. It is that we first acquire
> inode_rwsem in exclusive mode in ext4_file_write_iter() and only later
> relax that to no lock later. And this is what is causing low performance
> for mixed read-write workload because the exclusive lock has to wait for
> all shared holders and vice versa...

Got it.


> 
>> If we see in today's code (including in iomap new code for overwrite case
>> where we downgrade the lock).
>> We call for inode_unlock in case of overwrite and then do the IO, since we
>> don't have to allocate any blocks in this case.
>>
>>
>> 	/*
>> 	 * Make all waiters for direct IO properly wait also for extent
>> 	 * conversion. This also disallows race between truncate() and
>> 	 * overwrite DIO as i_dio_count needs to be incremented under
>>   	 * i_mutex.
>> 	 */
>> 	inode_dio_begin(inode);
>> 	/* If we do a overwrite dio, i_mutex locking can be released */
>> 	overwrite = *((int *)iocb->private);
>> 	if (overwrite)
>> 		inode_unlock(inode);
>> 	
>> 	write data (via __blockdev_direct_IO)
>>
>> 	inode_dio_end(inode);
>> 	/* take i_mutex locking again if we do a ovewrite dio */
>> 	if (overwrite)
>> 		inode_lock(inode);
>>
>>
>>
>> What can we do next:-
>>
>> Earlier the DIO reads was not having any inode_locking.
>> IIUC, the inode_lock_shared() in the DIO reads case was added to
>> protect the race against reading back uninitialized/stale data for e.g.
>> in case of truncate or writeback etc.
> 
> Not quite. Places that are prone to exposing stale block content (such as
> truncate) wait for running DIO (inode_dio_wait()). Just with unlocked read
> DIO we had to have special wait mechanisms to disable unlocked DIO for a
> while so that we can actually safely drain all running DIOs without new
> ones being submitted and then perform e.g. truncate. So it was more a
> complexity of the locking mechanism.
> 
>> So as Dave suggested, shouldn't we add the complete shared locking in DIO
>> writes cases as well (except for unaligned writes, since it may required
>> zeroing of partial blocks).
>>
>>
>> Could you please help me understand how we can go about it?
>> I was thinking if we can create uninitialized blocks beyond EOF, so that
>> any parallel read should only read 0 from that area and we may not require
>> exclusive inode_lock. The block creation is anyway protected
>> with i_data_sem in ext4_map_blocks.
> 
> So doing file size changes (i.e., file expansion) without exclusive
> inode_lock would be tricky. I wouldn't really like to go there at least

Ok.

Yes, I am looking into this. I agree that the test case reported here
has the performance problem due to the fact that we take exclusive lock
first and then only when we detect it's an overwrite case we downgrade
it.

I am working over the patch to make the changes you suggested. This will
be of course on top of the new iomap patch series.


> initially. My plan would be to do it similarly to XFS like:
 >
> Do a quick check whether IO is going to grow inode size or is unaligned. If
> yes, mode = exclusive, else mode = shared. Then lock inode rwsem is
> appropriate mode, do ext4_write_checks() (which may find out exclusive lock
> is actually needed so in that case mode = exclusive and restart). Then call
> iomap code to do direct IO.

Got it.

> 
>> I do see that in case of bufferedIO writes, we use ext4_get_block_unwritten
>> for dioread_nolock case. Which should
>> be true for even writes extending beyond EOF. This will
>> create uninitialized and mapped blocks only (even beyond EOF).
>> But all of this happen under exclusive inode_lock() in ext4_file_write_iter.
> 
> I guess this is mostly because we don't bother to check in
> ext4_write_begin() whether we are extending the file or not and filling
> holes needs unwritten extents. Also before DIO reads got changed to be
> under shared inode rwsem, the following was possible:
> 
> CPU1					CPU2
> DIO read from file f offset 4096
>    flush cache
> 					grow 'f' from 4096 to 8192 by write
> 					  blocks get allocated, page cache
> 					  dirtied
>    map blocks, submit IO
>      - reads stale contents

Ok. Got it.

> 
>> Whereas in case of DIO writes extending beyond EOF, we pass
>> EXT4_GET_BLOCKS_CREATE in ext4_map_blocks which may allocate
>> initialized & mapped blocks.
>> Do you know why so?
> 
> Not using unwritten extents is faster if that is safe. So that's why DIO
> code uses them if possible.

Thanks for giving that info to me. So it must be due joining/splitting
of unwritten extents which makes it a bit slow.

> 
>> Do you think we can create uninit. blocks in dioread_nolock AIO/non-AIO DIO
>> writes cases as well with only shared inode lock mode?
>> Do you see any problems with this?
>> Or do you have any other suggestion?
> 
> Not uninit but unwritten. Yes, we can do that. After all e.g. page writeback
> creates extents like this without any inode rwsem protection.

hmm, so as I understand you would like to take this step-by-step.
First let's come up with a patch to solve above mentioned issue with 
overwrites case.
With this we can have some APIs for taking inode lock based
on the shared/exclusive mode flags.

Then as you said, we can submit IO to create unwritten extents for DIO 
writes beyond EOF as well. But that will require some careful handling 
in updating inode size. So that should be a second step we should take.


> 
>> In case of XFS -
>> I do see it promotes the demotes the shared lock (IOLOCK_XXX) in
>> xfs_file_aio_write_checks. But I don't know if after that, whether
>> it only holds the shared lock while doing the DIO IO?
>> And how does it protects against the parallel DIO reads which can
>> potentially expose any stale data?
> 
> XFS protects DIO submission with shared IOLOCK. Stale data exposure is
> solved by using unwritten extents similarly to what ext4 does.

Yes, that's what I was also thinking. But I will have to check the 
locking mechanism which XFS uses in carefully updating the inode size 
while in shared IOLOCK mode while using unwritten extents for DIO writes 
beyond EOF. I see some tricks with i_lock(ILOCK)/i_flags_lock & 
i_rwsem(IOLOCK).

Will check once the 1st step w.r.t overwrite is done.


Thanks for your comments. Appreciate it!!

-ritesh


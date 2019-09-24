Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C042DBD300
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfIXTsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 15:48:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbfIXTsP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 15:48:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OJbpIG090798
        for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2019 15:48:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7qgfmreq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2019 15:48:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 24 Sep 2019 20:48:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Sep 2019 20:48:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OJm7V540173734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 19:48:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27CC4A4053;
        Tue, 24 Sep 2019 19:48:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED164A4040;
        Tue, 24 Sep 2019 19:48:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.46.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Sep 2019 19:48:04 +0000 (GMT)
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Jan Kara <jack@suse.cz>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, adilger@dilger.ca, mbobrowski@mbobrowski.org,
        rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190924151025.GD11819@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 25 Sep 2019 01:18:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190924151025.GD11819@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092419-0020-0000-0000-000003711FA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092419-0021-0000-0000-000021C6E252
Message-Id: <20190924194804.ED164A4040@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240163
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/24/19 8:40 PM, Jan Kara wrote:
> Hi Joseph!
> 
> On Wed 18-09-19 14:35:15, Joseph Qi wrote:
>> On 19/9/17 18:32, Ritesh Harjani wrote:
>>> Hello,
>>>
>>> This patch series is based on the upstream discussion with Jan
>>> & Joseph @ [1].
>>> It is based on top of Matthew's v3 ext4 iomap patch series [2]
>>>
>>> Patch-1: Adds the ext4_ilock/unlock APIs and also replaces all
>>> inode_lock/unlock instances from fs/ext4/*
>>>
>>> For now I already accounted for trylock/lock issue symantics
>>> (which was discussed here [3]) in the same patch,
>>> since the this whole patch was around inode_lock/unlock API,
>>> so I thought it will be best to address that issue in the same patch.
>>> However, kindly let me know if otherwise.
>>>
>>> Patch-2: Commit msg of this patch describes in detail about
>>> what it is doing.
>>> In brief - we try to first take the shared lock (instead of exclusive
>>> lock), unless it is a unaligned_io or extend_io. Then in
>>> ext4_dio_write_checks(), if we start with shared lock, we see
>>> if we can really continue with shared lock or not. If not, then
>>> we release the shared lock then acquire exclusive lock
>>> and restart ext4_dio_write_checks().
>>>
>>>
>>> Tested against few xfstests (with dioread_nolock mount option),
>>> those ran fine (ext4 & generic).
>>>
>>> I tried testing performance numbers on my VM (since I could not get
>>> hold of any real h/w based test device). I could test the fact
>>> that earlier we were trying to do downgrade_write() lock, but with
>>> this patch, that path is now avoided for fio test case
>>> (as reported by Joseph in [4]).
>>> But for the actual results, I am not sure if VM machine testing could
>>> really give the reliable perf numbers which we want to take a look at.
>>> Though I do observe some form of perf improvements, but I could not
>>> get any reliable numbers (not even with the same list of with/without
>>> patches with which Joseph posted his numbers [1]).
>>>
>>>
>>> @Joseph,
>>> Would it be possible for you to give your test case a run with this
>>> patches? That will be really helpful.
>>>
>>> Branch for this is hosted at below tree.
>>>
>>> https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC
>>>
>> I've tested your branch, the result is:
>> mounting with dioread_nolock, it behaves the same like reverting
>> parallel dio reads + dioread_nolock;
>> while mounting without dioread_nolock, no improvement, or even worse.
>> Please refer the test data below.
>>
>> fio -name=parallel_dio_reads_test -filename=/mnt/nvme0n1/testfile
>> -direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=$bs
>> -size=20G -numjobs=8 -runtime=600 -group_reporting
>>
>> w/     = with parallel dio reads
>> w/o    = reverting parallel dio reads
> 
> This is with 16c54688592ce8 "ext4: Allow parallel DIO reads" reverted,
> right?

He posted the same numbers where he posted previous reverts too,
which I thought we already noticed [1].
 From [2] below, I assumed we knew this.

[2] - """
(note
that the patches actually improve performance of read-only DIO workload
when not using dioread_nolock as for that case, exclusive lock is 
replaced with a shared one)
"""


[1]  https://patchwork.ozlabs.org/patch/1153546/
[2] 
https://lore.kernel.org/linux-ext4/20190830153520.GB25069@quack2.suse.cz/

> 
>> w/o+   = reverting parallel dio reads + dioread_nolock
>> ilock  = ext4-ilock-RFC
>> ilock+ = ext4-ilock-RFC + dioread_nolock
>>
>> bs=4k:
>> --------------------------------------------------------------
>>        |            READ           |           WRITE          |
>> --------------------------------------------------------------
>> w/    | 30898KB/s,7724,555.00us   | 30875KB/s,7718,479.70us  |
>> --------------------------------------------------------------
>> w/o   | 117915KB/s,29478,248.18us | 117854KB/s,29463,21.91us |
>> --------------------------------------------------------------
> 
> I'm really surprised by the numbers here. They would mean that when DIO

While testing my patches I noticed this again, but then when I saw [2]
above, I thought we were aware of this.
My bad, I should have brought this point up maybe once before going
ahead with implementing our discussed solution.


> read takes i_rwsem exclusive lock instead of shared, it is a win for your
> workload... Argh, now checking code in fs/direct-io.c I think I can see the
> difference. The trick in do_blockdev_direct_IO() is:
> 
>          if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
>                  inode_unlock(dio->inode);
>          if (dio->is_async && retval == 0 && dio->result &&
>              (iov_iter_rw(iter) == READ || dio->result == count))
>                  retval = -EIOCBQUEUED;
>          else
>                  dio_await_completion(dio);
> 
> So actually only direct IO read submission is protected by i_rwsem with
> DIO_LOCKING. Actual waiting for sync DIO read happens with i_rwsem dropped.
> 
> After some thought I think the best solution for this is to just finally
> finish the conversion of ext4 so that dioread_nolock is the only DIO path.

Sorry, I still didn't get this completely. Could you please explain a 
bit more?


> With i_rwsem held in shared mode even for "unlocked" DIO, it should be
> actually relatively simple and most of the dances with unwritten extents
> shouldn't be needed anymore.

Again, maybe it's related to above comment. Could you please give some
insights?


Or do you mean that we should do it like this-
So as of now in dioread_nolock, we allocate blocks, mark the entry into
extents as unwritten, then do the data IO, and then finally do the
conversion of unwritten to written extents.

So instead of that we first only reserve the disk blocks, (without
making any on-disk changes in extent tree), do the data IO and then
finally make an entry into extent tree on disk. And going
forward only keep this as the default path.

The above is something I have been looking into for enabling
dioread_nolock for powerpc platforms where blocksize < page_size.
This is based upon an upstream discussion between Ted and you :)


But even with above, in case of extending writes, we still
will have to zero out those extending blocks no? Which
will require an exclusive inode lock anyways for zeroing.
(same which has been done in XFS too).

So going with current discussed solution of mounting with
dioread_nolock to provide performance scalability in mixed read/write 
workload should be also the right approach, no?
Also looking at the numbers here [3] & [4], this patch also seems
to improve the performance with dioread_nolock mount option.
Please help me understand your thoughts on this.

[3] - https://marc.info/?l=linux-ext4&m=156921748126221&w=2
[4] - 
https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fio-output/vanilla-vs-ilocknew-randrw-dioread-nolock-4K.png


-ritesh


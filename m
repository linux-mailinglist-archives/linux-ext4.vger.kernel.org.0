Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B613121B
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2020 13:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFMZF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jan 2020 07:25:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgAFMZF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jan 2020 07:25:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006CMFEw076361
        for <linux-ext4@vger.kernel.org>; Mon, 6 Jan 2020 07:25:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xar47mfk5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2020 07:25:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 6 Jan 2020 12:25:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 12:25:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006COxaE39780372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 12:24:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E654AE074;
        Mon,  6 Jan 2020 12:24:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A10F7AE053;
        Mon,  6 Jan 2020 12:24:57 +0000 (GMT)
Received: from [9.199.159.50] (unknown [9.199.159.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 12:24:57 +0000 (GMT)
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Cc:     joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 6 Jan 2020 17:54:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010612-0020-0000-0000-0000039E34B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010612-0021-0000-0000-000021F58C4F
Message-Id: <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060114
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/29/19 8:33 PM, Xiaoguang Wang wrote:
> hi,
> 
>> With inclusion of Ritesh's inode lock scalability patches[1], the
>> traditional performance reasons for dioread_nolock --- namely,
>> removing the need to take an exclusive lock for Direct I/O read
>> operations --- has been removed.
>>
>> [1] 
>> https://lore.kernel.org/r/20191212055557.11151-1-riteshh@linux.ibm.com
>>
>> So... is it time to remove the code which supports dioread_nolock?
>> Doing so would simplify the code base, and reduce the test matrix.
>> This would also make it easier to restructure the write path when
>> allocating blocks so that the extent tree is updated after writing out
>> the data blocks, by clearing away the underbrush of dioread nolock
>> first.
>>
>> If we do this, we'd leave the dioread_nolock mount option for
>> backwards compatibility, but it would be a no-op and not actually do
>> anything.
>>
>> Any objections before I look into ripping out dioread_nolock?
>>
>> The one possible concern that I considered was for Alibaba, which was
>> doing something interesting with dioread_nolock plus nodelalloc.  But
>> looking at Liu Bo's explanation[2], I believe that their workload
>> would be satisfied simply by using the standard ext4 mount options
>> (that is, the default mode has the performance benefits when doing
>> parallel DIO reads, and so the need for nodelalloc to mitigate the
>> tail latency concerns which Alibaba was seeing in their workload would
>> not be needed).  Could Liu or someone from Alibaba confirm, perhaps
>> with some benchmarks using their workload?
> Currently we don't use dioread_nolock & nodelalloc in our internal
> servers, and we use dioread_nolock & delalloc widely, it works well.
> 
> The initial reason we use dioread_nolock is that it'll also allocate
> unwritten extents for buffered write, and normally the corresponding
> inode won't be added to jbd2 transaction's t_inode_list, so while
> commiting transaction, it won't flush inodes' dirty pages, then
> transaction will commit quickly, otherwise in extream case, the time

I do notice this in ext4_map_blocks(). We add inode to t_inode_list only
in case if we allocate written blocks. I guess this was done to avoid
stale data exposure problem. So now due to ordered mode, we may end up
flushing all dirty data pages in committing transaction before the
metadata is flushed.

Do you have any benchmarks or workload where we could see this problem?
And could this actually be a problem with any real world workload too?

Actually speaking, dioread_nolock mount option was not meant to solve 
the problem you mentioned.
Atleast as per the Documentation it is meant to help with the inode lock
scalablity issue in DIO reads case, which mostly should be fixed
with recent fixes pointed by Ted in above link.



> taking to flush dirty inodes will be very big, especially cgroup writeback
> is enabled. A previous discussion: 
> https://marc.info/?l=linux-fsdevel&m=151799957104768&w=2
> I think this semantics hidden behind diread_nolock is also important,
> so if planning to remove this mount option, we should keep same semantics.


Jan/Ted, your opinion on this pls?

I do see that there was a proposal by Ted @ [1] which should
also solve this problem. I do have plans to work on Ted's proposal, but
meanwhile, should we preserve this mount option for above mentioned use
case? Or should we make it a no-op now?

Also as an update, I am working on a patch which should fix the
stale data exposure issue which we currently have with ext4_page_mkwrite
& ext4 DIO reads. With that fixed it was discussed @ [2], that we don't
need dioread_nolock, so I was also planning to make this mount option a
no-op. Will soon post the RFC version of this patch too.


[1] - https://marc.info/?l=linux-ext4&m=157244559501734&w=2

[2] - 
https://lore.kernel.org/linux-ext4/20191120143257.GE9509@quack2.suse.cz/


-ritesh


> 
> Regards,
> Xiaoguang Wang
> 
>>
>> [2] 
>> https://lore.kernel.org/linux-ext4/20181121013035.ab4xp7evjyschecy@US-160370MP2.local/ 
>>
>>
>>                                          - Ted
>>


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB1AECA9
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfIJOKu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 10:10:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfIJOKu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Sep 2019 10:10:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AEAEUC001380
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 10:10:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcwp1bwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 10:10:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 10 Sep 2019 15:10:47 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Sep 2019 15:10:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AEAhDx33554446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 14:10:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E574C050;
        Tue, 10 Sep 2019 14:10:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 134674C072;
        Tue, 10 Sep 2019 14:10:41 +0000 (GMT)
Received: from [9.199.159.63] (unknown [9.199.159.63])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 14:10:40 +0000 (GMT)
Subject: Re: [PATCH 0/3] Revert parallel dio reads
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, hch@infradead.org
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20190827115118.GY7777@dread.disaster.area>
 <20190829105858.GA22939@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 10 Sep 2019 19:40:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190829105858.GA22939@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091014-4275-0000-0000-00000363F9DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091014-4276-0000-0000-000038764E55
Message-Id: <20190910141041.134674C072@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100139
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

>> Before doing this, you might want to have a chat and co-ordinate
>> with the folks that are currently trying to port the ext4 direct IO
>> code to use the iomap infrastructure:
>>
>> https://lore.kernel.org/linux-ext4/20190827095221.GA1568@poseidon.bobrowski.net/T/#t
>>
>> That is going to need the shared locking on read and will work just
>> fine with shared locking on write, too (it's the code that XFS uses
>> for direct IO). So it might be best here if you work towards shared
>> locking on the write side rather than just revert the shared locking
>> on the read side....
> 
> Yeah, after converting ext4 DIO path to iomap infrastructure, using shared
> inode lock for all aligned non-extending DIO writes will be easy so I'd
> prefer if we didn't have to redo the iomap conversion patches due to these
> reverts.

I was looking into this to see what is required to convert this into 
shared locking for DIO write side.
Why do you say shared inode lock only for *aligned non-extending DIO 
writes*?
non-extending means overwrite case only, which still in today's code is
not under any exclusive inode_lock (except the orphan handling and 
truncate handling in case of error after IO is completed). But even with
current code the perf problem is reported right?

If we see in today's code (including in iomap new code for overwrite 
case where we downgrade the lock).
We call for inode_unlock in case of overwrite and then do the IO, since 
we don't have to allocate any blocks in this case.


	/*
	 * Make all waiters for direct IO properly wait also for extent
	 * conversion. This also disallows race between truncate() and
	 * overwrite DIO as i_dio_count needs to be incremented under
  	 * i_mutex.
	 */
	inode_dio_begin(inode);
	/* If we do a overwrite dio, i_mutex locking can be released */
	overwrite = *((int *)iocb->private);
	if (overwrite)
		inode_unlock(inode);
	
	write data (via __blockdev_direct_IO)

	inode_dio_end(inode);
	/* take i_mutex locking again if we do a ovewrite dio */
	if (overwrite)
		inode_lock(inode);



What can we do next:-

Earlier the DIO reads was not having any inode_locking.
IIUC, the inode_lock_shared() in the DIO reads case was added to
protect the race against reading back uninitialized/stale data for e.g.
in case of truncate or writeback etc.

So as Dave suggested, shouldn't we add the complete shared locking in 
DIO writes cases as well (except for unaligned writes, since it may 
required zeroing of partial blocks).


Could you please help me understand how we can go about it?
I was thinking if we can create uninitialized blocks beyond EOF, so that
any parallel read should only read 0 from that area and we may not 
require exclusive inode_lock. The block creation is anyway protected
with i_data_sem in ext4_map_blocks.


I do see that in case of bufferedIO writes, we use 
ext4_get_block_unwritten for dioread_nolock case. Which should
be true for even writes extending beyond EOF. This will
create uninitialized and mapped blocks only (even beyond EOF).
But all of this happen under exclusive inode_lock() in ext4_file_write_iter.


Whereas in case of DIO writes extending beyond EOF, we pass
EXT4_GET_BLOCKS_CREATE in ext4_map_blocks which may allocate
initialized & mapped blocks.
Do you know why so?


Do you think we can create uninit. blocks in dioread_nolock AIO/non-AIO 
DIO writes cases as well with only shared inode lock mode?
Do you see any problems with this?
Or do you have any other suggestion?


In case of XFS -
I do see it promotes the demotes the shared lock (IOLOCK_XXX) in 
xfs_file_aio_write_checks. But I don't know if after that, whether
it only holds the shared lock while doing the DIO IO?
And how does it protects against the parallel DIO reads which can 
potentially expose any stale data?


Appreciate any help & inputs from FS developers.

-ritesh


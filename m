Return-Path: <linux-ext4+bounces-303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181E805530
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Dec 2023 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31421C20CEC
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Dec 2023 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3441771;
	Tue,  5 Dec 2023 12:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A710F;
	Tue,  5 Dec 2023 04:50:33 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sl0dY3gfQzFr8S;
	Tue,  5 Dec 2023 20:46:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 20:50:30 +0800
Message-ID: <70b274c2-c19a-103b-4cf4-b106c698ddcc@huawei.com>
Date: Tue, 5 Dec 2023 20:50:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <ritesh.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231204144106.fk4yxc422gppifsz@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231204144106.fk4yxc422gppifsz@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/12/4 22:41, Jan Kara wrote:
> On Mon 04-12-23 21:50:18, Baokun Li wrote:
>> On 2023/12/4 20:11, Jan Kara wrote:
>>> On Sat 02-12-23 17:14:30, Baokun Li wrote:
>>>> Recently, while running some pressure tests on MYSQL, noticed that
>>>> occasionally a "corrupted data in log event" error would be reported.
>>>> After analyzing the error, I found that extending DIO write and buffered
>>>> read were competing, resulting in some zero-filled page end being read.
>>>> Since ext4 buffered read doesn't hold an inode lock, and there is no
>>>> field in the page to indicate the valid data size, it seems to me that
>>>> it is impossible to solve this problem perfectly without changing these
>>>> two things.
>>> Yes, combining buffered reads with direct IO writes is a recipe for
>>> problems and pretty much in the "don't do it" territory. So honestly I'd
>>> consider this a MYSQL bug. Were you able to identify why does MYSQL use
>>> buffered read in this case? It is just something specific to the test
>>> you're doing?
>> The problem is with a one-master-twoslave MYSQL database with three
>> physical machines, and using sysbench pressure testing on each of the
>> three machines, the problem occurs about once every two to three hours.
>>
>> The problem is with the relay log file, and when the problem occurs, the
>> middle dozens of bytes of the file are read as all zeros, while the data on
>> disk is not. This is a journal-like file where a write process gets the data
>> from
>> the master node and writes it locally, and another replay process reads the
>> file and performs the replay operation accordingly (some SQL statements).
>> The problem is that when replaying, it finds that the data read is
>> corrupted,
>> not valid SQL data, while the data on disk is normal.
>>
>> It's not confirmed that buffered reads vs direct IO writes is actually
>> causing this issue, but this is the only scenario that we can reproduce
>> with our local simplified scripts. Also, after merging in patch 1, the
>> MYSQL pressure test scenario has now been tested for 5 days and has not
>> been reproduced.
>>
>> I'll double-check the problem scenario, although buffered reads with
>> buffered writes doesn't seem to have this problem.
> Yeah, from what you write it seems that the replay code is using buffered
> reads on the journal file. I guess you could confirm that with a bit of
> kernel tracing but the symptoms look pretty convincing. Did you try talking
> to MYSQL guys about why they are doing this?
The operations performed on the relay log file are buffered reads and 
writes,
which I confirmed with the following bpftrace script:
```
#include <linux/fs.h>
#include <linux/path.h>
#include <linux/dcache.h>

kprobe:generic_file_buffered_read /!strncmp(str(((struct kiocb 
*)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
     printf("read path: %s\n", str(((struct kiocb 
*)arg0)->ki_filp->f_path.dentry->d_name.name));
}

kprobe:ext4_buffered_write_iter /!strncmp(str(((struct kiocb 
*)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
     printf("write path: %s\n", str(((struct kiocb 
*)arg0)->ki_filp->f_path.dentry->d_name.name));
}
```
I suspect there are DIO writes causing the problem, but I haven't caught
any DIO writes to such files via bpftrace.
>>>> In this series, the first patch reads the inode size twice, and takes the
>>>> smaller of the two values as the copyout limit to avoid copying data that
>>>> was not actually read (0-padding) into the user buffer and causing data
>>>> corruption. This greatly reduces the probability of problems under 4k
>>>> page. However, the problem is still easily triggered under 64k page.
>>>>
>>>> The second patch waits for the existing dio write to complete and
>>>> invalidate the stale page cache before performing a new buffered read
>>>> in ext4, avoiding data corruption by copying the stale page cache to
>>>> the user buffer. This makes it much less likely that the problem will
>>>> be triggered in a 64k page.
>>>>
>>>> Do we have a plan to add a lock to the ext4 buffered read or a field in
>>>> the page that indicates the size of the valid data in the page? Or does
>>>> anyone have a better idea?
>>> No, there are no plans to address this AFAIK. Because such locking will
>>> slow down all the well behaved applications to fix a corner case for
>>> application doing unsupported things. Sure we must not crash the kernel,
>>> corrupt the filesystem or leak sensitive (e.g. uninitialized) data if app
>>> combines buffered and direct IO but returning zeros instead of valid data
>>> is in my opinion fully within the range of acceptable behavior for such
>>> case.
>>>
>> I also feel that a scenario like buffered reads + DIO writes is strange.
>> But theoretically when read doesn't return an error, the data read
>> shouldn't be wrong.  And I tested that xfs guarantees data consistency in
>> this scenario, which is why I thought it might be buggy.
> Yes, XFS has inherited stronger consistency guarantees from IRIX times than
> Linux filesystems traditionally had. We generally don't even guarantee
> buffered read vs buffered write atomicity (i.e., buffered read can see a
> torn buffered write).
>
> 								Honza
I'm a bit confused here, buffered read vs buffered write uses the same 
page and
appears to be protected by a memory barrier, how does the inconsistency 
occur?


Thanks!
-- 
With Best Regards,
Baokun Li
.


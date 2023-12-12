Return-Path: <linux-ext4+bounces-386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6980E148
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 03:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6241C2169D
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 02:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BB138E;
	Tue, 12 Dec 2023 02:15:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B3B5;
	Mon, 11 Dec 2023 18:15:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sq2Jd5CNTz1Q6Zj;
	Tue, 12 Dec 2023 10:15:29 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id A4C1318002F;
	Tue, 12 Dec 2023 10:15:35 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:15:34 +0800
Message-ID: <245b1784-5c92-5d15-df33-c50de687faf9@huawei.com>
Date: Tue, 12 Dec 2023 10:15:34 +0800
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
 <70b274c2-c19a-103b-4cf4-b106c698ddcc@huawei.com>
 <20231206193757.k5cppxqew6zjmbx3@quack3>
 <63b1e234-e005-a62b-82c5-fa7acf26d53a@huawei.com>
 <20231211174952.mdwyh7fmu7rjzfn3@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231211174952.mdwyh7fmu7rjzfn3@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/12 1:49, Jan Kara wrote:
> On Thu 07-12-23 22:15:55, Baokun Li wrote:
>> On 2023/12/7 3:37, Jan Kara wrote:
>>> On Tue 05-12-23 20:50:30, Baokun Li wrote:
>>>> On 2023/12/4 22:41, Jan Kara wrote:
>>>>> On Mon 04-12-23 21:50:18, Baokun Li wrote:
>>>>>> On 2023/12/4 20:11, Jan Kara wrote:
>>>>>> The problem is with a one-master-twoslave MYSQL database with three
>>>>>> physical machines, and using sysbench pressure testing on each of the
>>>>>> three machines, the problem occurs about once every two to three hours.
>>>>>>
>>>>>> The problem is with the relay log file, and when the problem occurs, the
>>>>>> middle dozens of bytes of the file are read as all zeros, while the data on
>>>>>> disk is not. This is a journal-like file where a write process gets the data
>>>>>> from
>>>>>> the master node and writes it locally, and another replay process reads the
>>>>>> file and performs the replay operation accordingly (some SQL statements).
>>>>>> The problem is that when replaying, it finds that the data read is
>>>>>> corrupted,
>>>>>> not valid SQL data, while the data on disk is normal.
>>>>>>
>>>>>> It's not confirmed that buffered reads vs direct IO writes is actually
>>>>>> causing this issue, but this is the only scenario that we can reproduce
>>>>>> with our local simplified scripts. Also, after merging in patch 1, the
>>>>>> MYSQL pressure test scenario has now been tested for 5 days and has not
>>>>>> been reproduced.
>>>>>>
>>>>>> I'll double-check the problem scenario, although buffered reads with
>>>>>> buffered writes doesn't seem to have this problem.
>>>>> Yeah, from what you write it seems that the replay code is using buffered
>>>>> reads on the journal file. I guess you could confirm that with a bit of
>>>>> kernel tracing but the symptoms look pretty convincing. Did you try talking
>>>>> to MYSQL guys about why they are doing this?
>>>> The operations performed on the relay log file are buffered reads and
>>>> writes, which I confirmed with the following bpftrace script:
>>>> ```
>>>> #include <linux/fs.h>
>>>> #include <linux/path.h>
>>>> #include <linux/dcache.h>
>>>>
>>>> kprobe:generic_file_buffered_read /!strncmp(str(((struct kiocb
>>>> *)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
>>>>       printf("read path: %s\n", str(((struct kiocb
>>>> *)arg0)->ki_filp->f_path.dentry->d_name.name));
>>>> }
>>>>
>>>> kprobe:ext4_buffered_write_iter /!strncmp(str(((struct kiocb
>>>> *)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
>>>>       printf("write path: %s\n", str(((struct kiocb
>>>> *)arg0)->ki_filp->f_path.dentry->d_name.name));
>>>> }
>>>> ```
>>>> I suspect there are DIO writes causing the problem, but I haven't caught
>>>> any DIO writes to such files via bpftrace.
>>> Interesting. Not sure how your partially zeroed-out buffers could happen
>>> with fully buffered IO.
>>>
>> After looking at the code again and again, the following concurrency
>> seems to bypass the memory barrier:
>>
>> ext4_buffered_write_iter
>>   generic_perform_write
>>    copy_page_from_iter_atomic
>>    ext4_da_write_end
>>     ext4_da_do_write_end
>>      block_write_end
>>       __block_commit_write
>>        folio_mark_uptodate
>>         smp_wmb()
>>         set_bit(PG_uptodate, folio_flags(folio, 0))
>>      i_size_write(inode, pos + copied)
>>      // write isize 2048
>>      unlock_page(page)
>>
>> ext4_file_read_iter
>>   generic_file_read_iter
>>    filemap_read
>>     filemap_get_pages
>>      filemap_get_read_batch
>>      folio_test_uptodate(folio)
>>       ret = test_bit(PG_uptodate, folio_flags(folio, 0));
>>       if (ret)
>>        smp_rmb();
>>        // The read barrier here ensures
>>        // that data 0-2048 in the page is synchronized.
>>                             ext4_buffered_write_iter
>>                              generic_perform_write
>>                               copy_page_from_iter_atomic
>>                               ext4_da_write_end
>>                                ext4_da_do_write_end
>>                                 block_write_end
>>                                  __block_commit_write
>>                                   folio_mark_uptodate
>>                                    smp_wmb()
>>                                    set_bit(PG_uptodate, folio_flags(folio,
>> 0))
>>                                 i_size_write(inode, pos + copied)
>>                                 // write isize 4096
>>                                 unlock_page(page)
>>     // read isize 4096
>>     isize = i_size_read(inode)
>>     // But there is no read barrier here,
>>     // so the data in the 2048-4096 range
>>     // may not be synchronized yet !!!
>>     copy_page_to_iter()
>>     // copyout 4096
>>
>> In the concurrency above, we read the updated i_size, but there is
>> no read barrier to ensure that the data in the page is the same as
>> the i_size at this point. Therefore, we may copy the unsynchronized
>> page out. Is it normal for us to read zero-filled data in this case?
> Indeed, I have checked and filemap_read() (but this dates back even to old
> do_generic_file_read() code) indeed does copy data only after checking
> uptodate flag and then sampling i_size so we may be copying state in the
> middle of the racing write and indeed there is nothing which would prevent
> prefetching page data before fetching inode size. I agree this is kind of
> nasty so I think adding a read barrier between i_size_read() and
> copy_page_to_iter() makes sense. Does it fix your issue with MYSQL?
>
> 								Honza
Thank you very much for confirming this issue!

Adding a read barrier between i_size_read() and copy_page_to_iter()
does seem to have solved the problem. The environment, which was
previously reproducing once every 2-3h, has been running for 60+h
without reproducing after adding the read barrier.

This is a Load-Load reordering issue, which only occurs on some
weak mem-ordering architectures (e.g. ARM64, ALPHA), but not
on strong mem-ordering architectures (e.g. X86).  This issue was
exactly discovered when migrating MYSQL services from X86 to
ARM64.

And theoretically the problem doesn't only happen on ext4,
filesystems that call filemap_read() but don't hold inode lock
(e.g. btrfs, f2fs, ubifs ...) will have this problem, while filesystems
with inode lock (e.g. xfs, nfs) won't have this problem.

Later I will send the patch that adds the memory barrier.

Thanks!
-- 
With Best Regards,
Baokun Li
.


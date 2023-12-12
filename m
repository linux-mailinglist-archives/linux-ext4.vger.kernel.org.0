Return-Path: <linux-ext4+bounces-396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0A80ED4F
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BC01C20C9A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E86168C;
	Tue, 12 Dec 2023 13:22:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733821BB;
	Tue, 12 Dec 2023 05:22:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SqK4p4tzWzvS07;
	Tue, 12 Dec 2023 21:21:14 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9296E1800BB;
	Tue, 12 Dec 2023 21:22:00 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 21:21:59 +0800
Message-ID: <45178e80-bba4-4afe-2c74-50facd78169d@huawei.com>
Date: Tue, 12 Dec 2023 21:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] mm/filemap: avoid buffered read/write race to read
 inconsistent data
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <david@fromorbit.com>, <hch@infradead.org>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20231212093634.2464108-1-libaokun1@huawei.com>
 <20231212124157.ew6q6jp2wsezvqzd@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231212124157.ew6q6jp2wsezvqzd@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/12 20:41, Jan Kara wrote:
> On Tue 12-12-23 17:36:34, Baokun Li wrote:
>> The following concurrency may cause the data read to be inconsistent with
>> the data on disk:
>>
>>               cpu1                           cpu2
>> ------------------------------|------------------------------
>>                                 // Buffered write 2048 from 0
>>                                 ext4_buffered_write_iter
>>                                  generic_perform_write
>>                                   copy_page_from_iter_atomic
>>                                   ext4_da_write_end
>>                                    ext4_da_do_write_end
>>                                     block_write_end
>>                                      __block_commit_write
>>                                       folio_mark_uptodate
>> // Buffered read 4096 from 0          smp_wmb()
>> ext4_file_read_iter                   set_bit(PG_uptodate, folio_flags)
>>   generic_file_read_iter            i_size_write // 2048
>>    filemap_read                     unlock_page(page)
>>     filemap_get_pages
>>      filemap_get_read_batch
>>      folio_test_uptodate(folio)
>>       ret = test_bit(PG_uptodate, folio_flags)
>>       if (ret)
>>        smp_rmb();
>>        // Ensure that the data in page 0-2048 is up-to-date.
>>
>>                                 // New buffered write 2048 from 2048
>>                                 ext4_buffered_write_iter
>>                                  generic_perform_write
>>                                   copy_page_from_iter_atomic
>>                                   ext4_da_write_end
>>                                    ext4_da_do_write_end
>>                                     block_write_end
>>                                      __block_commit_write
>>                                       folio_mark_uptodate
>>                                        smp_wmb()
>>                                        set_bit(PG_uptodate, folio_flags)
>>                                     i_size_write // 4096
>>                                     unlock_page(page)
>>
>>     isize = i_size_read(inode) // 4096
>>     // Read the latest isize 4096, but without smp_rmb(), there may be
>>     // Load-Load disorder resulting in the data in the 2048-4096 range
>>     // in the page is not up-to-date.
>>     copy_page_to_iter
>>     // copyout 4096
>>
>> In the concurrency above, we read the updated i_size, but there is no read
>> barrier to ensure that the data in the page is the same as the i_size at
>> this point, so we may copy the unsynchronized page out. Hence adding the
>> missing read memory barrier to fix this.
>>
>> This is a Load-Load reordering issue, which only occurs on some weak
>> mem-ordering architectures (e.g. ARM64, ALPHA), but not on strong
>> mem-ordering architectures (e.g. X86). And theoretically the problem
> AFAIK x86 can also reorder loads vs loads so the problem can in theory
> happen on x86 as well.
According to what I read in the perfbook at the link below,
  Loads Reordered After Loads does not happen on x86.
pdf sheet 562 corresponds to page 550,
Table 15.5: Summary of Memory Ordering
https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf 

>> doesn't only happen on ext4, filesystems that call filemap_read() but
>> don't hold inode lock (e.g. btrfs, f2fs, ubifs ...) will have this
>> problem, while filesystems with inode lock (e.g. xfs, nfs) won't have
>> this problem.
>>
>> Cc: stable@kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   mm/filemap.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 71f00539ac00..6324e2ac3e74 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2607,6 +2607,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>   			goto put_folios;
>>   		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
>>   
>> +		/* Ensure that the page cache within isize is updated. */
> Barries have to be in pairs to work and it is a good practice to document
> this. So here I'd have comment like:
> 		/*
> 		 * Pairs with a barrier in
> 		 * block_write_end()->mark_buffer_dirty() or other page
> 		 * dirtying routines like iomap_write_end() to ensure
> 		 * changes to page contents are visible before we see
> 		 * increased inode size.
> 		 */
>
> 								Honza
That's a very accurate description! Thanks a lot!
I will add this comment in the next version.
>> +		smp_rmb();
>> +
>>   		/*
>>   		 * Once we start copying data, we don't want to be touching any
>>   		 * cachelines that might be contended:
>> -- 
>> 2.31.1
>>
Thanks!
-- 
With Best Regards,
Baokun Li
.


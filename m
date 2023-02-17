Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5169AD2E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBQNxR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBQNxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 08:53:16 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376014995
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 05:52:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PJCPw2CqBz4f3nxc
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 21:31:16 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLOige9jOnMwDw--.27840S3;
        Fri, 17 Feb 2023 21:31:16 +0800 (CST)
Subject: Re: [RFC PATCH v2] ext4: dio take shared inode lock when overwriting
 preallocated blocks
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yukuai3@huawei.com,
        Brian Foster <bfoster@redhat.com>
References: <87cz69ld7d.fsf@doe.com>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ed78744f-5494-a5aa-0ebb-e66c6588edb0@huaweicloud.com>
Date:   Fri, 17 Feb 2023 21:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87cz69ld7d.fsf@doe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHcLOige9jOnMwDw--.27840S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw43ZF1DWryDJF4kAFy3XFb_yoWxKF1xpF
        y3tF43CrsFgryUur1kta1xXr1Ygw1ktrWxJrW3G3WrZryDuryxtFyvqFyFka45ArZ7Cw12
        qFs0yr9rW3Z8trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello.

On 2023/2/17 1:41, Ritesh Harjani (IBM) wrote:
> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> 
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In the dio write path, we only take shared inode lock for the case of
>> aligned overwriting initialized blocks inside EOF. But for overwriting
>> preallocated blocks, it may only need to split unwritten extents, this
>> procedure has been protected under i_data_sem lock, it's safe to
>> release the exclusive inode lock and take shared inode lock.
> 
> Ok. One question though. Should we be passing IOMAP_DIO_FORCE_WAIT
> (in this case as well) which will wait for the completion of dio
> request even if the submitted IO is not synchronous. Like how it's being
> done for unaligned overwrites case [1].
> What I am mostly curious to know about is, how do we take care of
> unwritten
> to written conversion without racing which can happen in a
> seperate workqueue context and/or are there any zeroing of extents
> involved in this scenario which can race with one another?
> 
> So, I think in case of a non-aligned write it make sense [1] because it
> might involve zeroing of the partial blocks. But in this case as you
> said this already happens within i_data_sem lock context, so it won't be
> necessary. I still thought it will be worth while to confirm it's indeed
> the case or not.
> 

I'm not quite get your question, do you mean passing IOMAP_DIO_FORCE_WAIT
for the case of unaligned writing to pre-allocated(unwritten) blocks?
IIUC, That's how it's done now if you only merge my patch. And it should be
cautious to slove the conflict if you also want to merge [1] together.

After looking at [1], I think it should be:

           |  pure overwrite       |  write to pre-allocated |
-------------------------------------------------------------|
aligned    | share lock, nowait (1)| share lock, nowait  (3) |
unaligned  | share lock, nowait (2)| excl lock, wait     (4) |

In case(3), each AIO-DIO's unwritten->written conversion do not disturb each
other because of the i_data_sem lock, and the potential zeroing extents(e.g.
ext4_zero_range()) also call inode_dio_wait() to wait DIO complete. So I don't
find any race problem.

Am I missing something? or which case you want to confirm?

Thanks,
Yi.

> [1]:
> https://lore.kernel.org/linux-ext4/20230210145954.277611-1-bfoster@redhat.com/
> 
> Oh, one of the patch might run into some patch conflict depending upon
> which one gets picked first...
> 
> -ritesh
> 
> 
>>
>> This could give a significant speed up for multi-threaded writes. Test
>> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
>>
>>  direct=1
>>  ioengine=libaio
>>  iodepth=10
>>  numjobs=10
>>  runtime=60
>>  rw=randwrite
>>  size=100G
>>
>> And the test result are:
>> Before:
>>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
>>  bs=16k      IOPS=11.1k, BW=173MiB/s
>>  bs=64k      IOPS=11.2k, BW=697MiB/s
>>
>> After:
>>  bs=4k       IOPS=41.4k, BW=162MiB/s
>>  bs=16k      IOPS=41.3k, BW=646MiB/s
>>  bs=64k      IOPS=13.5k, BW=843MiB/s
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> v2->v1:
>>  - Negate the 'inited' related arguments to 'unwritten'.
>>
>>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index a7a597c727e6..21abe95a0ee7 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -202,8 +202,9 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>>  	return false;
>>  }
>>
>> -/* Is IO overwriting allocated and initialized blocks? */
>> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>> +/* Is IO overwriting allocated or initialized blocks? */
>> +static bool ext4_overwrite_io(struct inode *inode,
>> +			      loff_t pos, loff_t len, bool *unwritten)
>>  {
>>  	struct ext4_map_blocks map;
>>  	unsigned int blkbits = inode->i_blkbits;
>> @@ -217,12 +218,15 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>>  	blklen = map.m_len;
>>
>>  	err = ext4_map_blocks(NULL, inode, &map, 0);
>> +	if (err != blklen)
>> +		return false;
>>  	/*
>>  	 * 'err==len' means that all of the blocks have been preallocated,
>> -	 * regardless of whether they have been initialized or not. To exclude
>> -	 * unwritten extents, we need to check m_flags.
>> +	 * regardless of whether they have been initialized or not. We need to
>> +	 * check m_flags to distinguish the unwritten extents.
>>  	 */
>> -	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
>> +	*unwritten = !(map.m_flags & EXT4_MAP_MAPPED);
>> +	return true;
>>  }
>>
>>  static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
>> @@ -431,11 +435,16 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>   * - For extending writes case we don't take the shared lock, since it requires
>>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>>   *
>> - * - shared locking will only be true mostly with overwrites. Otherwise we will
>> - *   switch to exclusive i_rwsem lock.
>> + * - shared locking will only be true mostly with overwrites, including
>> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
>> + *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
>> + *   also release exclusive i_rwsem lock.
>> + *
>> + * - Otherwise we will switch to exclusive i_rwsem lock.
>>   */
>>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>> -				     bool *ilock_shared, bool *extend)
>> +				     bool *ilock_shared, bool *extend,
>> +				     bool *unwritten)
>>  {
>>  	struct file *file = iocb->ki_filp;
>>  	struct inode *inode = file_inode(file);
>> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>  	 * in file_modified().
>>  	 */
>>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>> -	     !ext4_overwrite_io(inode, offset, count))) {
>> +	     !ext4_overwrite_io(inode, offset, count, unwritten))) {
>>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>>  			ret = -EAGAIN;
>>  			goto out;
>> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  	loff_t offset = iocb->ki_pos;
>>  	size_t count = iov_iter_count(from);
>>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>> -	bool extend = false, unaligned_io = false;
>> +	bool extend = false, unaligned_io = false, unwritten = false;
>>  	bool ilock_shared = true;
>>
>>  	/*
>> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		return ext4_buffered_write_iter(iocb, from);
>>  	}
>>
>> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
>> +	ret = ext4_dio_write_checks(iocb, from,
>> +				    &ilock_shared, &extend, &unwritten);
>>  	if (ret <= 0)
>>  		return ret;
>>
>> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		ext4_journal_stop(handle);
>>  	}
>>
>> -	if (ilock_shared)
>> +	if (ilock_shared && !unwritten)
>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
>> --
>> 2.31.1


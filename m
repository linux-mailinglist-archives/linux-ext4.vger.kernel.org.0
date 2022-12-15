Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2441564D7B9
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 09:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLOIZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 03:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLOIZT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 03:25:19 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF29442F7
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 00:24:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NXldr1kM1z4f3mVW
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 16:24:48 +0800 (CST)
Received: from [10.174.178.134] (unknown [10.174.178.134])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNbR2ZpjjX8RCQ--.20329S3;
        Thu, 15 Dec 2022 16:24:51 +0800 (CST)
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huaweicloud.com,
        yukuai3@huawei.com
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1df360ba-35f4-18e1-5544-acb18a680a90@huaweicloud.com>
Date:   Thu, 15 Dec 2022 16:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221214170125.bixz46ybm76rtbzf@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDXSNbR2ZpjjX8RCQ--.20329S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyxGr4fGrWfZw1UXFyrZwb_yoWxKw1kpF
        y3tF43ArZFgry7uFyxta1IqFyS9ws5trWxAry3W3W5AryDuryftFy0qFyYya48XrZ7Gw42
        qFs0y34Duas0yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/12/15 1:01, Jan Kara wrote:
> On Sat 03-12-22 18:39:56, Zhang Yi wrote:
>> In the dio write path, we only take shared inode lock for the case of
>> aligned overwriting initialized blocks inside EOF. But for overwriting
>> preallocated blocks, it may only need to split unwritten extents, this
>> procedure has been protected under i_data_sem lock, it's safe to
>> release the exclusive inode lock and take shared inode lock.
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
>>  It passed xfstests auto mode with 1k and 4k blocksize.
> 
> Besides some naming nits (see below) I think this should work. But I have
> to say I'm a bit uneasy about this because we will now be changing block
> mapping from unwritten to written only with shared i_rwsem. OTOH that
> happens during writeback as well so we should be fine and the gain is very
> nice.
> 
Thanks for advice, I will change the argument name to make it more reasonable.

> Out of curiosity do you have a real usecase for this?

No, I was just analyse the performance gap in our benchmark tests, and have
some question and idea while reading the code. Maybe it could speed up the
first time write in some database. :)

Besides, I want to discuss it a bit more. I originally changed this code to
switch to take the shared inode and also use ext4_iomap_overwrite_ops for
the overwriting preallocated blocks case. It will postpone the splitting extent
procedure to endio and could give a much more gain than this patch (+~27%).

This patch:
  bs=4k       IOPS=41.4k, BW=162MiB/s
Postpone split:
  bs=4k       IOPS=52.9k, BW=207MiB/s

But I think it's maybe too radical. I looked at the history and notice in commit
0031462b5b39 ("ext4: Split uninitialized extents for direct I/O"), it introduce
the flag EXT4_GET_BLOCKS_DIO(now it had been renamed to EXT4_GET_BLOCKS_PRE_IO)
to make sure that the preallocated unwritten extent have been splitted before
submitting the I/O, which is used to prevent the ENOSPC problem if the filesystem
run out-of-space in the endio procedure. And 4 years later, commit 27dd43854227
("ext4: introduce reserved space") reserve some blocks for metedata allocation.
It looks like this commit could also slove the ENOSPC problem for most cases if
we postpone extent splitting into the endio procedure. I don't find other side
effect, so I think it may also fine if we do that. Do you have some advice or
am I missing something?

Thanks,
Yi.

> 
>>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index a7a597c727e6..7edac94025ac 100644
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
>> +			      loff_t pos, loff_t len, bool *inited)
> 
> 'inited' just sounds weird. Correct is 'initialized' which is a bit long.
> Maybe just negate the meaning and call this 'unwritten'?
> 
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
>> +	*inited = !!(map.m_flags & EXT4_MAP_MAPPED);
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
>> + * - shared locking will only be true mostly with overwrites, include
>> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
>> + *   we protects splitting extents by i_data_sem in ext4_inode_info, so we can
>> + *   also release exclusive i_rwsem lock.
>> + *
>> + * - Otherwise we will switch to exclusive i_rwsem lock.
>>   */
>>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>> -				     bool *ilock_shared, bool *extend)
>> +				     bool *ilock_shared, bool *extend,
>> +				     bool *overwrite)
> 
> And it would be good to preserve the argument name in other functions as
> well - i.e., keep using 'unwritten' here as well.
> 
>>  {
>>  	struct file *file = iocb->ki_filp;
>>  	struct inode *inode = file_inode(file);
>> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>  	 * in file_modified().
>>  	 */
>>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>> -	     !ext4_overwrite_io(inode, offset, count))) {
>> +	     !ext4_overwrite_io(inode, offset, count, overwrite))) {
>>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>>  			ret = -EAGAIN;
>>  			goto out;
>> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  	loff_t offset = iocb->ki_pos;
>>  	size_t count = iov_iter_count(from);
>>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>> -	bool extend = false, unaligned_io = false;
>> +	bool extend = false, unaligned_io = false, overwrite = false;
>>  	bool ilock_shared = true;
>>  
>>  	/*
>> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		return ext4_buffered_write_iter(iocb, from);
>>  	}
>>  
>> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
>> +	ret = ext4_dio_write_checks(iocb, from,
>> +				    &ilock_shared, &extend, &overwrite);
>>  	if (ret <= 0)
>>  		return ret;
>>  
>> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		ext4_journal_stop(handle);
>>  	}
>>  
>> -	if (ilock_shared)
>> +	if (overwrite)
>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAF63A8DA
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 14:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiK1NBS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 08:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiK1NBM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 08:01:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2812610
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 05:01:10 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLQYl1h0rzHwWL;
        Mon, 28 Nov 2022 21:00:27 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 21:01:07 +0800
Subject: Re: [PATCH] ext4: add barrier info if journal device write cache is
 not enabled
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20221124135744.1488959-1-yi.zhang@huawei.com>
 <20221128101108.nslkglhz7pmflyoa@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <02ab48e0-27d7-1a59-603a-34bd85bb2b68@huawei.com>
Date:   Mon, 28 Nov 2022 21:01:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221128101108.nslkglhz7pmflyoa@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/11/28 18:11, Jan Kara wrote:
> On Thu 24-11-22 21:57:44, Zhang Yi wrote:
>> The block layer will check and suppress flush bio if the device write
>> cache is not enabled, so the journal barrier will not go into effect
>> even if uer specify 'barrier=1' mount option. It's dangerous if the
>> write cache state is false negative, and we cannot distinguish such
>> case easily. So just give an info and an inquire interface to let
>> sysadmin know the barrier is suppressed for the case of write cache is
>> not enabled.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Hum, so have you seen a situation when write cache information is incorrect
> in the block layer? Does it happen often enough that it warrants extra
> sysfs file?
> 

Thanks for response. Yes, It often happens on some SCSI devices with RAID
card, the disks below the RAID card enabled write cache, but the RAID driver
declare the write cache was disabled when probing, and the RAID card seems
cannot guarantee data writing back to disk medium on power failure. So the
ext4 filesystem will probably be corrupted at the next startup. It's
difficult to distinguish it's a hardware or an software problem.
I am not familiar with the RAID card. So I don't know why the cache state
is incorrect (maybe incorrect configured or firmware bug).

> After all you should be able to query what the block layer thinks about the
> write cache - you definitely can for SCSI devices, I'm not sure about
> others. So you can have a look there. Providing this info in the filesystem
> seems like doing it in the wrong layer - I don't see anything jbd2/ext4
> specific here...
> 

Yes, the best way is to figure out the RAID card problem.
This patch is not to aim to fix something in ext4. The reason why I want to add
this in ext4 is just give a hint from the fs barrier's point of view, it show the
barrier's running state at mount time, could help us to delimit the cache problem
more easily when we found ext4 corruption after power failure. Before this patch,
we could do that through SCSI probing info and /sys/block/sda/queue/write_cache
(maybe some others?), it's not quite clear.

  [    2.520176] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

  [root@localhost ~]# cat /sys/block/sda/queue/write_cache
  write back

Besides, the running state info looks harmless. :)

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/super.c |  3 +++
>>  fs/ext4/sysfs.c | 19 +++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 7cdd2138c897..916f756ebbca 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5920,6 +5920,9 @@ static int ext4_load_journal(struct super_block *sb,
>>  
>>  	if (!(journal->j_flags & JBD2_BARRIER))
>>  		ext4_msg(sb, KERN_INFO, "barriers disabled");
>> +	else if (!bdev_write_cache(journal->j_dev))
>> +		ext4_msg(sb, KERN_INFO, "journal device write cache disabled, "
>> +					"barriers suppressed");
>>  
>>  	if (!ext4_has_feature_journal_needs_recovery(sb))
>>  		err = jbd2_journal_wipe(journal, !really_read_only);
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index d233c24ea342..67f619c1202e 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -37,6 +37,7 @@ typedef enum {
>>  	attr_pointer_string,
>>  	attr_pointer_atomic,
>>  	attr_journal_task,
>> +	attr_journal_barrier,
>>  } attr_id_t;
>>  
>>  typedef enum {
>> @@ -135,6 +136,20 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>>  			task_pid_vnr(sbi->s_journal->j_task));
>>  }
>>  
>> +static ssize_t journal_barrier_show(struct ext4_sb_info *sbi, char *buf)
>> +{
>> +	journal_t *journal = sbi->s_journal;
>> +
>> +	if (!journal)
>> +		return sysfs_emit(buf, "none\n");
>> +
>> +	if (!(journal->j_flags & JBD2_BARRIER))
>> +		return sysfs_emit(buf, "disabled\n");
>> +	if (!bdev_write_cache(sbi->s_journal->j_dev))
>> +		return sysfs_emit(buf, "suppressed\n");
>> +	return sysfs_emit(buf, "enabled\n");
>> +}
>> +
>>  #define EXT4_ATTR(_name,_mode,_id)					\
>>  static struct ext4_attr ext4_attr_##_name = {				\
>>  	.attr = {.name = __stringify(_name), .mode = _mode },		\
>> @@ -243,6 +258,7 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
>>  EXT4_ATTR(first_error_time, 0444, first_error_time);
>>  EXT4_ATTR(last_error_time, 0444, last_error_time);
>>  EXT4_ATTR(journal_task, 0444, journal_task);
>> +EXT4_ATTR(journal_barrier, 0444, journal_barrier);
>>  EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>>  EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>>  EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
>> @@ -291,6 +307,7 @@ static struct attribute *ext4_attrs[] = {
>>  	ATTR_LIST(first_error_time),
>>  	ATTR_LIST(last_error_time),
>>  	ATTR_LIST(journal_task),
>> +	ATTR_LIST(journal_barrier),
>>  #ifdef CONFIG_EXT4_DEBUG
>>  	ATTR_LIST(simulate_fail),
>>  #endif
>> @@ -438,6 +455,8 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>>  		return print_tstamp(buf, sbi->s_es, s_last_error_time);
>>  	case attr_journal_task:
>>  		return journal_task_show(sbi, buf);
>> +	case attr_journal_barrier:
>> +		return journal_barrier_show(sbi, buf);
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.31.1
>>

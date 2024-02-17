Return-Path: <linux-ext4+bounces-1258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF621858DC0
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 08:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36261C21102
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659D1CD28;
	Sat, 17 Feb 2024 07:41:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116A1CD18;
	Sat, 17 Feb 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155710; cv=none; b=pucy7PyxjUChEdbW577FlY212d+8U3v8p5C9GD99V26ST/mUgPuTecAzTBf0l3NOnzCQrGbzge8D85E0OfdXCYqilo7eevk1i6FFjwuWEKN/FcHluZ558e1RHtnnE3Fs5cuCrqH1ewWoHNfCzEeGoYVR/5r3VZo/f2RBmgQjhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155710; c=relaxed/simple;
	bh=nJTE1jqmCGpZ2lQwYibqNBYEZ8IaoRmC3Ai6HV4eQ1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GwFJ01WysokZZyHD5ircHdaJEaVRNAFt2MTHIeTofv2NrqqqK/wSaOiIVEsOMnk9TPlw/0szXcgnkAfZHQa1tmffTNMKa+6Yb7fAXnTnbbmbnrWMo8dby4Hzqdw2Bi5kiBXsJGCMHQ7jnAmsmvkyDvbBx3d38CIj3IQ3nih2QB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcLGd2kfGz1FKZN;
	Sat, 17 Feb 2024 15:36:57 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id A29A718001B;
	Sat, 17 Feb 2024 15:41:44 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 15:41:43 +0800
Message-ID: <83c16b1a-832d-2ffd-6100-1f2b80ca2f35@huawei.com>
Date: Sat, 17 Feb 2024 15:41:43 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/7] ext4: add positive int attr pointer to avoid sysfs
 variables overflow
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <stable@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-5-libaokun1@huawei.com>
 <20240213165810.3k4lnxaqzdwrdj35@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240213165810.3k4lnxaqzdwrdj35@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/2/14 0:58, Jan Kara wrote:
> On Fri 26-01-24 16:57:13, Baokun Li wrote:
>> We can easily trigger a BUG_ON by using the following commands:
>>
>>      mount /dev/$disk /tmp/test
>>      echo 2147483650 > /sys/fs/ext4/$disk/mb_group_prealloc
>>      echo test > /tmp/test/file && sync
>>
>> ==================================================================
>> kernel BUG at fs/ext4/mballoc.c:2029!
>> invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> CPU: 3 PID: 320 Comm: kworker/u36:1 Not tainted 6.8.0-rc1 #462
>> RIP: 0010:mb_mark_used+0x358/0x370
>> [...]
>> Call Trace:
>>   ext4_mb_use_best_found+0x56/0x140
>>   ext4_mb_complex_scan_group+0x196/0x2f0
>>   ext4_mb_regular_allocator+0xa92/0xf00
>>   ext4_mb_new_blocks+0x302/0xbc0
>>   ext4_ext_map_blocks+0x95a/0xef0
>>   ext4_map_blocks+0x2b1/0x680
>>   ext4_do_writepages+0x733/0xbd0
>> [...]
>> ==================================================================
>>
>> In ext4_mb_normalize_group_request():
>>      ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
>>
>> Here fe_len is of type int, but s_mb_group_prealloc is of type unsigned
>> int, so setting s_mb_group_prealloc to 2147483650 overflows fe_len to a
>> negative number, which ultimately triggers a BUG_ON() in mb_mark_used().
>>
>> Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
>> value range of 0-INT_MAX to avoid the above problem. In addition to the
>> mb_group_prealloc sysfs interface, the following interfaces also have uint
>> to int conversions that result in overflows, and are also fixed.
>>
>>    err_ratelimit_burst
>>    msg_ratelimit_burst
>>    warning_ratelimit_burst
>>    err_ratelimit_interval_ms
>>    msg_ratelimit_interval_ms
>>    warning_ratelimit_interval_ms
>>    mb_best_avail_max_trim_order
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I don't think you need to change s_mb_group_prealloc here and then restrict
> it even further in the next patch. I'd just leave it alone here.
Yes, we could put the next patch before this one, but using
s_mb_group_prealloc as an example makes it easier to understand
why the attr_pointer_pi case is added here.There are several other
variables that don't have more convincing examples.
>
> Also I think that limiting mb_best_avail_max_trim_order to 64 instead of
> INT_MAX will make us more resilient to surprises in the future :) But I
> don't really insist.
>
> 								Honza
I think it's enough here to make sure that mb_best_avail_max_trim_order
is a positive number, since we always make sure that min_order
is not less than 0, as follows:

          order = fls(ac->ac_g_ex.fe_len) - 1;
          min_order = order - sbi->s_mb_best_avail_max_trim_order;
          if (min_order < 0)
                  min_order = 0;

An oversized mb_best_avail_max_trim_order can be interpreted as
always being CR_ANY_FREE. 😄
>> ---
>>   fs/ext4/sysfs.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index a5d657fa05cb..6f9f96e00f2f 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -30,6 +30,7 @@ typedef enum {
>>   	attr_first_error_time,
>>   	attr_last_error_time,
>>   	attr_feature,
>> +	attr_pointer_pi,
>>   	attr_pointer_ui,
>>   	attr_pointer_ul,
>>   	attr_pointer_u64,
>> @@ -178,6 +179,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
>>   #define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
>>   	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
>>   
>> +#define EXT4_RW_ATTR_SBI_PI(_name,_elname)      \
>> +	EXT4_ATTR_OFFSET(_name, 0644, pointer_pi, ext4_sb_info, _elname)
>> +
>>   #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>>   	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>>   
>> @@ -213,17 +217,17 @@ EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>>   EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>>   EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>>   EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>> -EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>> +EXT4_RW_ATTR_SBI_PI(mb_group_prealloc, s_mb_group_prealloc);
>>   EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>>   EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>>   EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
>> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
>> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
>> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
>> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
>> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
>> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
>> -EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
>> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
>> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_burst, s_err_ratelimit_state.burst);
>> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
>> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
>> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
>> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
>> +EXT4_RW_ATTR_SBI_PI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
>>   #ifdef CONFIG_EXT4_DEBUG
>>   EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>>   #endif
>> @@ -376,6 +380,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>>   
>>   	switch (a->attr_id) {
>>   	case attr_inode_readahead:
>> +	case attr_pointer_pi:
>>   	case attr_pointer_ui:
>>   		if (a->attr_ptr == ptr_ext4_super_block_offset)
>>   			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
>> @@ -448,6 +453,10 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>>   		return ret;
>>   
>>   	switch (a->attr_id) {
>> +	case attr_pointer_pi:
>> +		if ((int)t < 0)
>> +			return -EINVAL;
>> +		fallthrough;
>>   	case attr_pointer_ui:
>>   		if (t != (unsigned int)t)
>>   			return -EINVAL;
>> -- 
>> 2.31.1
>>


Thanks!
-- 
With Best Regards,
Baokun Li
.


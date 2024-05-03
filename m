Return-Path: <linux-ext4+bounces-2270-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1BB8BA52E
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FEAB22946
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835714A85;
	Fri,  3 May 2024 02:09:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3D134A9;
	Fri,  3 May 2024 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702162; cv=none; b=U7TkN2Pfi3FfZHsQvsCq7CNgk9DAm/Ql41qElNOPO26rB51X18ylcKgzSdrFo6kRgBMwVmR7EBb4SAtO34pUgGKgFBibbp4QqSf/jpo/LDKf1LthZUd+Klih6KYTvUwIQkGr1+f4MrojO1AxkxOqdhtVkZEa6vOlapsTr8A6Nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702162; c=relaxed/simple;
	bh=npw/t6DUs7VRxXxX33ZJq9vhUD6Uee9GtuDDHixl3kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssMQLKaDaCfkex8mZqvu4UGFsCfRuzLHSNHKVnkDAqq/rIMsKBaGlY3e6OL1g8TiNvw70AjNKYDTkCN2mkIrv+LNT0hvL6ssA076VRnqorjxe3siFjWq0qDZCei0k0isKuQ8XIro70rEMu6ONXNiLg62mHTAYIKpYf9IKjJOcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VVvPB3y0lz4f3jd0;
	Fri,  3 May 2024 10:09:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 87D521A0175;
	Fri,  3 May 2024 10:09:10 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxBDRzRmnSNtLg--.12952S3;
	Fri, 03 May 2024 10:09:10 +0800 (CST)
Message-ID: <afc46ac9-e3a2-b07f-c902-a9586c420824@huaweicloud.com>
Date: Fri, 3 May 2024 10:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix uninitialized ratelimit_state->lock access in
 __ext4_fill_super()
Content-Language: en-US
To: linux-ext4@vger.kernel.org, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 Baokun Li <libaokun1@huawei.com>
References: <20240102133730.1098120-1-libaokun1@huawei.com>
 <a1874551-7e02-aa0d-9ef7-4322e920c661@huaweicloud.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <a1874551-7e02-aa0d-9ef7-4322e920c661@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxBDRzRmnSNtLg--.12952S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1ruFy5Jr4rtFykZFy5urg_yoW7tFW5pr
	n7JFyxJryUu34kJw4UJF1UJFyUJw1UG3WDJr18XF1UJrWUXr12qr4UXF10gF1UCr48Ar1U
	Jr1UJrnrZw1UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Ted,

Would you consider merging in this patch in the current merge
window? This patch has been merged in our internal branch for
a while now and so far it is safe.

Regards,
Baokun

On 2024/4/23 9:41, Baokun Li wrote:
> Gently ping again.
>
> On 2024/1/2 21:37, Baokun Li wrote:
>> In the following concurrency we will access the uninitialized rs->lock:
>>
>> ext4_fill_super
>>    ext4_register_sysfs
>>     // sysfs registered msg_ratelimit_interval_ms
>>                               // Other processes modify rs->interval to
>>                               // non-zero via msg_ratelimit_interval_ms
>>    ext4_orphan_cleanup
>>      ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
>>        __ext4_msg
>> ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
>>            if (!rs->interval)  // do nothing if interval is 0
>>              return 1;
>>            raw_spin_trylock_irqsave(&rs->lock, flags)
>>              raw_spin_trylock(lock)
>>                _raw_spin_trylock
>>                  __raw_spin_trylock
>>                    spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
>>                      lock_acquire
>>                        __lock_acquire
>>                          register_lock_class
>>                            assign_lock_key
>>                              dump_stack();
>>    ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
>>      raw_spin_lock_init(&rs->lock);
>>      // init rs->lock here
>>
>> and get the following dump_stack:
>>
>> =========================================================
>> INFO: trying to register non-static key.
>> The code is fine but needs lockdep annotation, or maybe
>> you didn't initialize this object before use?
>> turning off the locking correctness validator.
>> CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
>> [...]
>> Call Trace:
>>   dump_stack_lvl+0xc5/0x170
>>   dump_stack+0x18/0x30
>>   register_lock_class+0x740/0x7c0
>>   __lock_acquire+0x69/0x13a0
>>   lock_acquire+0x120/0x450
>>   _raw_spin_trylock+0x98/0xd0
>>   ___ratelimit+0xf6/0x220
>>   __ext4_msg+0x7f/0x160 [ext4]
>>   ext4_orphan_cleanup+0x665/0x740 [ext4]
>>   __ext4_fill_super+0x21ea/0x2b10 [ext4]
>>   ext4_fill_super+0x14d/0x360 [ext4]
>> [...]
>> =========================================================
>>
>> Normally interval is 0 until s_msg_ratelimit_state is initialized, so
>> ___ratelimit() does nothing. But registering sysfs precedes initializing
>> rs->lock, so it is possible to change rs->interval to a non-zero value
>> via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
>> uninitialized, and then a call to ext4_msg triggers the problem by
>> accessing an uninitialized rs->lock. Therefore register sysfs after all
>> initializations are complete to avoid such problems.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/super.c | 22 ++++++++++------------
>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 0980845c8b8f..1db23b0e8a4f 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5564,19 +5564,15 @@ static int __ext4_fill_super(struct 
>> fs_context *fc, struct super_block *sb)
>>       if (err)
>>           goto failed_mount6;
>>   -    err = ext4_register_sysfs(sb);
>> -    if (err)
>> -        goto failed_mount7;
>> -
>>       err = ext4_init_orphan_info(sb);
>>       if (err)
>> -        goto failed_mount8;
>> +        goto failed_mount7;
>>   #ifdef CONFIG_QUOTA
>>       /* Enable quota usage during mount. */
>>       if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
>>           err = ext4_enable_quotas(sb);
>>           if (err)
>> -            goto failed_mount9;
>> +            goto failed_mount8;
>>       }
>>   #endif  /* CONFIG_QUOTA */
>>   @@ -5602,7 +5598,7 @@ static int __ext4_fill_super(struct 
>> fs_context *fc, struct super_block *sb)
>>           ext4_msg(sb, KERN_INFO, "recovery complete");
>>           err = ext4_mark_recovery_complete(sb, es);
>>           if (err)
>> -            goto failed_mount10;
>> +            goto failed_mount9;
>>       }
>>         if (test_opt(sb, DISCARD) && 
>> !bdev_max_discard_sectors(sb->s_bdev))
>> @@ -5619,15 +5615,17 @@ static int __ext4_fill_super(struct 
>> fs_context *fc, struct super_block *sb)
>>       atomic_set(&sbi->s_warning_count, 0);
>>       atomic_set(&sbi->s_msg_count, 0);
>>   +    /* Register sysfs after all initializations are complete. */
>> +    err = ext4_register_sysfs(sb);
>> +    if (err)
>> +        goto failed_mount9;
>> +
>>       return 0;
>>   -failed_mount10:
>> +failed_mount9:
>>       ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>> -failed_mount9: __maybe_unused
>> +failed_mount8: __maybe_unused
>>       ext4_release_orphan_info(sb);
>> -failed_mount8:
>> -    ext4_unregister_sysfs(sb);
>> -    kobject_put(&sbi->s_kobj);
>>   failed_mount7:
>>       ext4_unregister_li_request(sb);
>>   failed_mount6:
>



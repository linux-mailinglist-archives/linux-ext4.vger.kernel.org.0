Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49550416E79
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Sep 2021 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbhIXJHG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Sep 2021 05:07:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9764 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbhIXJHG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Sep 2021 05:07:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HG5gk6swdzWSxh;
        Fri, 24 Sep 2021 17:04:18 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:05:30 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:05:29 +0800
Message-ID: <b936dbbc-5141-1380-8a3b-474fdc03b5de@huawei.com>
Date:   Fri, 24 Sep 2021 17:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210831120449.2910005-1-yangerkun@huawei.com>
 <20210920134627.GG6607@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
In-Reply-To: <20210920134627.GG6607@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/9/20 21:46, Jan Kara 写道:
> On Tue 31-08-21 20:04:49, yangerkun wrote:
>> The error path in ext4_fill_super forget to flush s_error_work before
>> journal destroy, and it may trigger the follow bug since
>> flush_stashed_error_work can run concurrently with journal destroy
>> without any protection for sbi->s_journal.
>>
>> [32031.740193] EXT4-fs (loop66): get root inode failed
>> [32031.740484] EXT4-fs (loop66): mount failed
>> [32031.759805] ------------[ cut here ]------------
>> [32031.759807] kernel BUG at fs/jbd2/transaction.c:373!
>> [32031.760075] invalid opcode: 0000 [#1] SMP PTI
>> [32031.760336] CPU: 5 PID: 1029268 Comm: kworker/5:1 Kdump: loaded
>> 4.18.0
>> [32031.765112] Call Trace:
>> [32031.765375]  ? __switch_to_asm+0x35/0x70
>> [32031.765635]  ? __switch_to_asm+0x41/0x70
>> [32031.765893]  ? __switch_to_asm+0x35/0x70
>> [32031.766148]  ? __switch_to_asm+0x41/0x70
>> [32031.766405]  ? _cond_resched+0x15/0x40
>> [32031.766665]  jbd2__journal_start+0xf1/0x1f0 [jbd2]
>> [32031.766934]  jbd2_journal_start+0x19/0x20 [jbd2]
>> [32031.767218]  flush_stashed_error_work+0x30/0x90 [ext4]
>> [32031.767487]  process_one_work+0x195/0x390
>> [32031.767747]  worker_thread+0x30/0x390
>> [32031.768007]  ? process_one_work+0x390/0x390
>> [32031.768265]  kthread+0x10d/0x130
>> [32031.768521]  ? kthread_flush_work_fn+0x10/0x10
>> [32031.768778]  ret_from_fork+0x35/0x40
>>
>> static int start_this_handle(...)
>>      BUG_ON(journal->j_flags & JBD2_UNMOUNT); <---- Trigger this
>>
>> Besides, after we enable fast commit, ext4_fc_replay can add work to
>> s_error_work but return success, so the latter journal destroy in
>> ext4_load_journal can trigger this problem too.
>>
>> Fix this problem with two steps:
>> 1. Call ext4_commit_super directly in ext4_handle_error for the case
>>     that called from ext4_fc_replay
>> 2. Since it's hard to pair the init and flush for s_error_work, we'd
>>     better add a extras flush_work before journal destroy in
>>     ext4_fill_super
>>
>> Fixes: c92dc856848f ("ext4: defer saving error info from atomic context")
>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/super.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index d6df62fc810c..06b5ad34d892 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -659,7 +659,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>>   		 * constraints, it may not be safe to do it right here so we
>>   		 * defer superblock flushing to a workqueue.
>>   		 */
>> -		if (continue_fs)
>> +		if (continue_fs && journal)
> 
> I'm somewhat nervous from this change because this will change the behavior
> not only for ext4_fc_replay() case but for any nojournal case as well. That
> being said we will be writing out sb directly for nojournal mode anyway and
> for errors=panic/remount-ro cases as well, so your change should be safe.
> But please explain in the changelog that you change the behavior for any
> error happening without journal. With the changelog updated feel free to
> add:

Thanks! Will do it next version!

> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 
> 								Honza
> 
>>   			schedule_work(&EXT4_SB(sb)->s_error_work);
>>   		else
>>   			ext4_commit_super(sb);
>> @@ -5172,12 +5172,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>>   	sbi->s_ea_block_cache = NULL;
>>   
>>   	if (sbi->s_journal) {
>> +		/* flush s_error_work before journal destroy. */
>> +		flush_work(&sbi->s_error_work);
>>   		jbd2_journal_destroy(sbi->s_journal);
>>   		sbi->s_journal = NULL;
>>   	}
>>   failed_mount3a:
>>   	ext4_es_unregister_shrinker(sbi);
>>   failed_mount3:
>> +	/* flush s_error_work before sbi destroy */
>>   	flush_work(&sbi->s_error_work);
>>   	del_timer_sync(&sbi->s_err_report);
>>   	ext4_stop_mmpd(sbi);
>> -- 
>> 2.31.1
>>

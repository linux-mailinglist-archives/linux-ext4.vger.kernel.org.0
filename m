Return-Path: <linux-ext4+bounces-3224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6B92F334
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 02:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C3C281A38
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D41FBA;
	Fri, 12 Jul 2024 00:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B4441D;
	Fri, 12 Jul 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745487; cv=none; b=eEtk6j2/m8TUEo8DpB0YA5mNqOBXqUHEkTP0MK6A/T0w/s8+kMOWGlJ0FemKgXsrizRJbxvqPSSCaP8kxg4uPLWbozk01y8Z5pm9FCFlTvM9jS57ynAd2rNN+maJSbIHKvJvkeeEekYvIpkkhGOltQsQsUi2dnKISOtbIlOCdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745487; c=relaxed/simple;
	bh=eIipzsjF9INeb2Be7id72lKKfgyjHErMwuec/jln4qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cuhk7iX4n+RDNGIAF4n8O1y6H5tTeC4aeJ0+uKVzc504Fcr4gSHWHxd6NwPiWc1HZ6i4I7xWYykDmeE8DS2sXxDjRe6ob/IjXr6lPz3saOIHHsbXAGt2pu5Qc+12ycanStHYqS6ZTjKQ6SkmhgwdxuxrA0wqI4lYAyr5yixgvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WKtKM4njYz1xtW6;
	Fri, 12 Jul 2024 08:49:43 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 276E61A0188;
	Fri, 12 Jul 2024 08:51:20 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jul 2024 08:51:19 +0800
Message-ID: <39c8b5c1-8c8c-40de-9b09-b28b24cc270d@huawei.com>
Date: Fri, 12 Jul 2024 08:51:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
To: Andreas Dilger <adilger@dilger.ca>, Wang Jianjian
	<wangjianjian0@foxmail.com>
CC: Luis Henriques <luis.henriques@linux.dev>, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
 <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
 <878qy8nem5.fsf@brahms.olymp>
 <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
 <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/7/12 3:28, Andreas Dilger wrote:
> On Jul 11, 2024, at 10:16 AM, Wang Jianjian <wangjianjian0@foxmail.com> wrote:
>> On 2024/7/11 23:16, Luis Henriques wrote:
>>> On Thu, Jul 11 2024, wangjianjian (C) wrote:
>>>
>>>> On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
>>>>> When a full journal commit is on-going, any fast commit has to be enqueued
>>>>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
>>>>> is done only once, i.e. if an inode is already queued in a previous fast
>>>>> commit entry it won't be enqueued again.  However, if a full commit starts
>>>>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
>>>>> be done into FC_Q_STAGING.  And this is not being done in function
>>>>> ext4_fc_track_template().
>>>>> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
>>>>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>>>>> greater than the one being handled.  The STAGING queue will then be spliced
>>>>> back into MAIN.
>>>>> This bug was found using fstest generic/047.  This test creates several 32k
>>>>> bytes files, sync'ing each of them after it's creation, and then shutting
>>>>> down the filesystem.  Some data may be loss in this operation; for example a
>>>>> file may have it's size truncated to zero.
>>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>>> ---
>>>>> Hi!
>>>>> v4 of this patch enqueues the inode into STAGING *only* if the current tid
>>>>> is non-zero.  It will be zero when doing an fc commit, and this would mean
>>>>> to always re-enqueue the inode.  This fixes the regressions caught by Ted
>>>>> in v3 with fstests generic/472 generic/496 generic/643.
>>>>> Also, since 2nd patch of v3 has already been merged, I've rebased this patch
>>>>> to be applied on top of it.
>>>>>    fs/ext4/fast_commit.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>>>> index 3926a05eceee..facbc8dbbaa2 100644
>>>>> --- a/fs/ext4/fast_commit.c
>>>>> +++ b/fs/ext4/fast_commit.c
>>>>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>>>>>    				       EXT4_STATE_FC_COMMITTING);
>>>>>    		if (tid_geq(tid, iter->i_sync_tid))
>>>>>    			ext4_fc_reset_inode(&iter->vfs_inode);
>>>>> +		} else if (tid) {
>>>>> +			/*
>>>>> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
>>>> one quick question about tid, if one disk is using long time and its tid   get
>>>> wrapped to 0, is it a valid seq? I don't find code handling this situation.
>>> Hmm... OK.  So, to answer to your question, the 'tid' is expected to wrap.
>>> That's why we use:
>>>
>>> 	if (tid_geq(tid, iter->i_sync_tid))
>> Yes, I know this.
>>>
>>> instead of:
>>>
>>> 	if (tid >= iter->i_sync_tid)
>>>
>>> (The second patch in v3 actually fixed a few places where the tid_*()
>>> helpers weren't being used.)
>>>
>>> But your question shows me that my patch is wrong as '0' may actually be a
>>> valid 'tid' value.
>>
>> Actually my question is,  there are some place use '0' to check if a transaction is valid, e.g.
>>
>> In ext4_wait_for_tail_page_commit()
>>
>> 5218         while (1) {
>> 5219                 struct folio *folio = filemap_lock_folio(inode->i_mapping,
>> 5220                                       inode->i_size >> PAGE_SHIFT);
>> 5221                 if (IS_ERR(folio))
>> 5222                         return;
>> 5223                 ret = __ext4_journalled_invalidate_folio(folio, offset,
>> 5224 folio_size(folio) - offset);
>> 5225                 folio_unlock(folio);
>> 5226                 folio_put(folio);
>> 5227                 if (ret != -EBUSY)
>> 5228                         return;
>> 5229                 commit_tid = 0;
>> 5230                 read_lock(&journal->j_state_lock);
>> 5231                 if (journal->j_committing_transaction)
>> 5232                         commit_tid = journal->j_committing_transaction->t_tid;
>> 5233                 read_unlock(&journal->j_state_lock);
>> 5234                 if (commit_tid)
>> 5235                         jbd2_log_wait_commit(journal, commit_tid);
>> 5236         }
>> 5237  We only wait commit if tid is not zero.
>>
>> And in __jbd2_log_wait_for_space()
>>
>> 79                 if (space_left < nblocks) {
>>   80                         int chkpt = journal->j_checkpoint_transactions != NULL;
>>   81                         tid_t tid = 0;
>>   82
>>   83                         if (journal->j_committing_transaction)
>>   84                                 tid = journal->j_committing_transaction->t_tid;
>>   85 spin_unlock(&journal->j_list_lock);
>>   86 write_unlock(&journal->j_state_lock);
>>   87                         if (chkpt) {
>>   88 jbd2_log_do_checkpoint(journal);
>>   89                         } else if (jbd2_cleanup_journal_tail(journal) == 0) {
>>   90                                 /* We were able to recover space; yay! */
>>   91                                 ;
>>   92                         } else if (tid) {
>>   93                                 /*
>>   94                                  * jbd2_journal_commit_transaction() may want
>>   95                                  * to take the checkpoint_mutex if JBD2_FLUSHED
>>   96                                  * is set.  So we need to temporarily drop it.
>>   97                                  */
>>   98 mutex_unlock(&journal->j_checkpoint_mutex);
>>   99                                 jbd2_log_wait_commit(journal, tid);
>> 100 write_lock(&journal->j_state_lock);
>> 101                                 continue;
>> We also only wait commit if tid is not zero.
>>
>> Does it mean all these have bugs if '0' is a valid 'tid' ?
>>
>> But on the other hand, if we don't consider sync and fsync, and default commit interval is 5s,
>>
>> time of tid wrap to 0 is nearly 680 years. However, we can run sync/fsync to make tid to increase
>>
>> more quickly in real world ?
> 
> The simple solution is that "0" is not a valid sequence.  It looks like
> this is a bug in jbd2_get_transaction() where it is incrementing the TID:
> 
>          transaction->t_tid = journal->j_transaction_sequence++;
> 
> it should add a check to handle the wrap-around:
> 
>          if (unlikely(transaction->t_tid == 0))
>                  transaction->t_tid = journal->j_transaction_sequence++;
Yes, I had ever thought about this, just curious why nobody encounter 
problems here.
> 
> Cheers, Andreas
> 
> 
> 
> 
> 
-- 
Regards



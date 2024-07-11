Return-Path: <linux-ext4+bounces-3213-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E992ECF8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF31C22161
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469316D4CB;
	Thu, 11 Jul 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hqPZB/Ol"
X-Original-To: linux-ext4@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5716D32E;
	Thu, 11 Jul 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716150; cv=none; b=EvBzZVinN9Ke6Wr0zm4yTwsjmqzwf2pa7AmOrfhL1zuP3s/Q9nyoxWC08sGSV1Gffij80sIjUR7Etri2mW5XFTq57Mmzf5KrqsJTyTiMhFyxqbX1Z3h2YTy4bKbtko0cSPdtQOQS8PBgBDfcg8YOjZQ8bph/ZmaSIV3mMpTd9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716150; c=relaxed/simple;
	bh=5XXrD3Er7tJlA0T069DV3WzFwIGiNLYlnHydNwOwoDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNE3nlovDbEH20rFmhbrLt34hcucKJPNxBGula4Vy8bKb0RdD6ebyBy+I35ERfQ+PvayisFDzgc0iTRHR951mmwNyMuHOz8QocyGr4c9ngMsD6WDNhmpsFcgQOZ+V/codULtCNJIBSJnV21J9pnAFqZ+AnHGvfNtEH83qXzgkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hqPZB/Ol; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1720716134;
	bh=s5mc+8AdniwxOMjnsOUvSDbal2IaCJcwnexgBeAnGbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hqPZB/Olgkz0rr82M3zrK0tN1hyAnUAoXEpMcSpimNjzlAaJe+2/fD0O/GX335os3
	 W4IoAP3kxZ2VrfO9lvM4iLsXx7QPrkq4fPb0NzXTfHZFw5wVRUQMw70qVemfmL25ja
	 SZKmnOfOwZJYaG+2c0tg8Em+jQcPpQ+W4nmwK2jo=
Received: from [192.168.50.235] ([120.244.20.46])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 4229AC9C; Fri, 12 Jul 2024 00:16:34 +0800
X-QQ-mid: xmsmtpt1720714594t6aplnsdx
Message-ID: <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
X-QQ-XMAILINFO: NVd9ZAvGcUb9em05hx+gRvPtwZFbK38yNemqP+tOrKR9Yly3yXTL5QIasCAEK8
	 rpDaZ6qpEvM5Fok1NrgugVqbojw8I/z88VKRL6mdwdswE7C+RxuHRIOR826LMRuH0LJ0yfL4Xrdn
	 WU18aJQQTrOg+m2SF3fWjEAQ7ptCB90QBqXM+zXmMn5XpiJ8lPDylV1ShVnn+fcWkkBQSGZTyW57
	 fF1LO9+tDq7md5vcxT+WbksW2QlA8wRbwwHjMY0cmBKUOeNX/LYwHROI+j4N7vs8XAjSFT6sKcdN
	 XKt+Z7dwiLxLRmUPlWFI6G7sNOMr7kBoNjV8syQxxJTOUNshXdRPYFtlfgNSo5Uzc7roLqhulxdS
	 Z6QlPOwOEO4JJV3aVTpb2h9j4xkRARVB0TgU6QjbG+9jATAJ+m5wsv8Xye8+vfO/zwFy6DAc177I
	 JWRn/aw07Q7vKQi117TnEbOcZosNKBZVW9fB7Ekc5Vw5T+3DpfoOhB2YeOqx7zeuMYm6qFhlbUEi
	 FXqStPW0saOSJbxsAr56iUGx7s2+epDf/NbLDQOqXft3HCK5qQj7GQR5Q3v99KRegiq3WeG7cm8L
	 PdbL320urSaf7T5wFNLJl4KI/fvImiusPUvhlUyBeCz5vOFWc1zHK6qNItWZahd57tIKSV+TPeq1
	 UsqqIOVJtI9lu1pHZbwtZS6P6sFq0CoGI2yQgGFZaV80X006yDCpyI3gaOlWpy/i9mjnYxwYzp+G
	 kBioZWhpm83rhhS9DxV1/aJFM1KV05PNW1TQvskp/cOS4w3e0VeGBjifVBF7E6+dSG+eHG1INdts
	 MxwBmmUwoEbrxgE36pZomfFvQ9rkfjD0tUUrqG+M1rIcl8efCLLboXxdzEhMh40zQ3EkFngZ6SI2
	 ABZtpk5ixQ/yXAfW97KzcXz9p6HBJzV0CnhS+c89kumgBDec9iA5VkJNnIacJv/5PFiyCcjPs/CV
	 YfyAWy0uN6zk2fxEU4CgQdnWEu00thHn5EmkCyZ2vmXNEYoHqttwTan4GPLv4ZSTyL67uohDduio
	 xZpe9ZGg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <dcf476c9-b3c5-4235-bf79-cee840895847@foxmail.com>
Date: Fri, 12 Jul 2024 00:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
To: Luis Henriques <luis.henriques@linux.dev>,
 "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 Jan Kara <jack@suse.cz>, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711083520.6751-1-luis.henriques@linux.dev>
 <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
 <878qy8nem5.fsf@brahms.olymp>
Content-Language: en-US
From: Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <878qy8nem5.fsf@brahms.olymp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/11 23:16, Luis Henriques wrote:
> On Thu, Jul 11 2024, wangjianjian (C) wrote:
>
>> On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
>>> When a full journal commit is on-going, any fast commit has to be enqueued
>>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
>>> is done only once, i.e. if an inode is already queued in a previous fast
>>> commit entry it won't be enqueued again.  However, if a full commit starts
>>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
>>> be done into FC_Q_STAGING.  And this is not being done in function
>>> ext4_fc_track_template().
>>> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
>>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>>> greater than the one being handled.  The STAGING queue will then be spliced
>>> back into MAIN.
>>> This bug was found using fstest generic/047.  This test creates several 32k
>>> bytes files, sync'ing each of them after it's creation, and then shutting
>>> down the filesystem.  Some data may be loss in this operation; for example a
>>> file may have it's size truncated to zero.
>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>> ---
>>> Hi!
>>> v4 of this patch enqueues the inode into STAGING *only* if the current tid
>>> is non-zero.  It will be zero when doing an fc commit, and this would mean
>>> to always re-enqueue the inode.  This fixes the regressions caught by Ted
>>> in v3 with fstests generic/472 generic/496 generic/643.
>>> Also, since 2nd patch of v3 has already been merged, I've rebased this patch
>>> to be applied on top of it.
>>>    fs/ext4/fast_commit.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>> index 3926a05eceee..facbc8dbbaa2 100644
>>> --- a/fs/ext4/fast_commit.c
>>> +++ b/fs/ext4/fast_commit.c
>>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>>>    				       EXT4_STATE_FC_COMMITTING);
>>>    		if (tid_geq(tid, iter->i_sync_tid))
>>>    			ext4_fc_reset_inode(&iter->vfs_inode);
>>> +		} else if (tid) {
>>> +			/*
>>> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
>> one quick question about tid, if one disk is using long time and its tid   get
>> wrapped to 0, is it a valid seq? I don't find code handling this situation.
> Hmm... OK.  So, to answer to your question, the 'tid' is expected to wrap.
> That's why we use:
>
> 	if (tid_geq(tid, iter->i_sync_tid))
Yes, I know this.
>
> instead of:
>
> 	if (tid >= iter->i_sync_tid)
>
> (The second patch in v3 actually fixed a few places where the tid_*()
> helpers weren't being used.)
>
> But your question shows me that my patch is wrong as '0' may actually be a
> valid 'tid' value.

Actually my question is,  there are some place use '0' to check if a 
transaction is valid, e.g.

In ext4_wait_for_tail_page_commit()

5218         while (1) {
5219                 struct folio *folio = 
filemap_lock_folio(inode->i_mapping,
5220                                       inode->i_size >> PAGE_SHIFT);
5221                 if (IS_ERR(folio))
5222                         return;
5223                 ret = __ext4_journalled_invalidate_folio(folio, offset,
5224 folio_size(folio) - offset);
5225                 folio_unlock(folio);
5226                 folio_put(folio);
5227                 if (ret != -EBUSY)
5228                         return;
5229                 commit_tid = 0;
5230                 read_lock(&journal->j_state_lock);
5231                 if (journal->j_committing_transaction)
5232                         commit_tid = 
journal->j_committing_transaction->t_tid;
5233                 read_unlock(&journal->j_state_lock);
5234                 if (commit_tid)
5235                         jbd2_log_wait_commit(journal, commit_tid);
5236         }
5237  We only wait commit if tid is not zero.

And in __jbd2_log_wait_for_space()

79                 if (space_left < nblocks) {
  80                         int chkpt = 
journal->j_checkpoint_transactions != NULL;
  81                         tid_t tid = 0;
  82
  83                         if (journal->j_committing_transaction)
  84                                 tid = 
journal->j_committing_transaction->t_tid;
  85 spin_unlock(&journal->j_list_lock);
  86 write_unlock(&journal->j_state_lock);
  87                         if (chkpt) {
  88 jbd2_log_do_checkpoint(journal);
  89                         } else if 
(jbd2_cleanup_journal_tail(journal) == 0) {
  90                                 /* We were able to recover space; 
yay! */
  91                                 ;
  92                         } else if (tid) {
  93                                 /*
  94                                  * 
jbd2_journal_commit_transaction() may want
  95                                  * to take the checkpoint_mutex if 
JBD2_FLUSHED
  96                                  * is set.  So we need to 
temporarily drop it.
  97                                  */
  98 mutex_unlock(&journal->j_checkpoint_mutex);
  99                                 jbd2_log_wait_commit(journal, tid);
100 write_lock(&journal->j_state_lock);
101                                 continue;
We also only wait commit if tid is not zero.

Does it mean all these have bugs if '0' is a valid 'tid' ?

But on the other hand, if we don't consider sync and fsync, and default 
commit interval is 5s,

time of tid wrap to 0 is nearly 680 years. However, we can run 
sync/fsync to make tid to increase

more quickly in real world ?


> Cheers,



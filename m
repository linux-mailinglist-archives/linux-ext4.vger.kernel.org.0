Return-Path: <linux-ext4+bounces-3231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2592F7BC
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798DB1C22D89
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED7146D7D;
	Fri, 12 Jul 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LAXDZJd9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3915B96C
	for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775718; cv=none; b=f7eYzCX6aFTlc0I5kUNNhls3Lk9RfZG7AFhmuCuRuh2vYo4OUbr8MWV3hrzH7g+kVU88gfTeURzYa4fPN137SCqZw2CL3tRZgQalJyCSXLYx1tULzQ36+cOHLGVkimcJZP0mm05pl5romZOBR0hWDGQQwMhchFiQSNR6UkOmQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775718; c=relaxed/simple;
	bh=HJqNJ9I5q2Yu3GHeutLW7BgyXuV07l/kDvIatsZJtJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmR8OxXHTGticwa4plLpQEwP1kzM3ipAJC5LRQXiz0POk7hZUtDhfrpO1cpIMCRAZLjUjH/WOYrioC04DwRaBaUFIzOfSqJT5lRvOvmk3K2BMr/WRjUEbfs1kMzte5Yjr8LmKFKDnkFL27nAeoJgRDfSMw69308kXMZX6ztf17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LAXDZJd9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720775713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cifrBLyCbpFprQnMxitY2gKUyi5y1Lw3bzjRWTC58U=;
	b=LAXDZJd9c2TeJ4CH0/wZlebryUvOOPU0S29iI69simlGhq4nUb9CAFJGCgL8Chm9AMKR5h
	Ut9tO7wk0/0hjD/+ZaZJfca62WHdsHYmXc/qHqF31S0hF+Sk0Rb8UZF2zQA8zA+72rRaeo
	cEjt8+4E5qBpE/JVIph+od4eyULEJJU=
X-Envelope-To: wangjianjian0@foxmail.com
X-Envelope-To: wangjianjian3@huawei.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Jianjian <wangjianjian0@foxmail.com>, "wangjianjian (C)"
 <wangjianjian3@huawei.com>,  Theodore Ts'o <tytso@mit.edu>,  Jan Kara
 <jack@suse.cz>,  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca> (Andreas
	Dilger's message of "Thu, 11 Jul 2024 13:28:23 -0600")
References: <20240711083520.6751-1-luis.henriques@linux.dev>
	<4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
	<878qy8nem5.fsf@brahms.olymp>
	<tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
	<A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
Date: Fri, 12 Jul 2024 10:15:04 +0100
Message-ID: <87ed7znf8n.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 11 2024, Andreas Dilger wrote:

> On Jul 11, 2024, at 10:16 AM, Wang Jianjian <wangjianjian0@foxmail.com> w=
rote:
>> On 2024/7/11 23:16, Luis Henriques wrote:
>>> On Thu, Jul 11 2024, wangjianjian (C) wrote:
>>>=20
>>>> On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
>>>>> When a full journal commit is on-going, any fast commit has to be enq=
ueued
>>>>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqu=
eueing
>>>>> is done only once, i.e. if an inode is already queued in a previous f=
ast
>>>>> commit entry it won't be enqueued again.  However, if a full commit s=
tarts
>>>>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit ne=
eds to
>>>>> be done into FC_Q_STAGING.  And this is not being done in function
>>>>> ext4_fc_track_template().
>>>>> This patch fixes the issue by re-enqueuing an inode into the STAGING =
queue
>>>>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>>>>> greater than the one being handled.  The STAGING queue will then be s=
pliced
>>>>> back into MAIN.
>>>>> This bug was found using fstest generic/047.  This test creates sever=
al 32k
>>>>> bytes files, sync'ing each of them after it's creation, and then shut=
ting
>>>>> down the filesystem.  Some data may be loss in this operation; for ex=
ample a
>>>>> file may have it's size truncated to zero.
>>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>>> ---
>>>>> Hi!
>>>>> v4 of this patch enqueues the inode into STAGING *only* if the curren=
t tid
>>>>> is non-zero.  It will be zero when doing an fc commit, and this would=
 mean
>>>>> to always re-enqueue the inode.  This fixes the regressions caught by=
 Ted
>>>>> in v3 with fstests generic/472 generic/496 generic/643.
>>>>> Also, since 2nd patch of v3 has already been merged, I've rebased thi=
s patch
>>>>> to be applied on top of it.
>>>>>   fs/ext4/fast_commit.c | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>>>> index 3926a05eceee..facbc8dbbaa2 100644
>>>>> --- a/fs/ext4/fast_commit.c
>>>>> +++ b/fs/ext4/fast_commit.c
>>>>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal=
, int full, tid_t tid)
>>>>>   				       EXT4_STATE_FC_COMMITTING);
>>>>>   		if (tid_geq(tid, iter->i_sync_tid))
>>>>>   			ext4_fc_reset_inode(&iter->vfs_inode);
>>>>> +		} else if (tid) {
>>>>> +			/*
>>>>> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
>>>> one quick question about tid, if one disk is using long time and its t=
id   get
>>>> wrapped to 0, is it a valid seq? I don't find code handling this situa=
tion.
>>> Hmm... OK.  So, to answer to your question, the 'tid' is expected to wr=
ap.
>>> That's why we use:
>>>=20
>>> 	if (tid_geq(tid, iter->i_sync_tid))
>> Yes, I know this.
>>>=20
>>> instead of:
>>>=20
>>> 	if (tid >=3D iter->i_sync_tid)
>>>=20
>>> (The second patch in v3 actually fixed a few places where the tid_*()
>>> helpers weren't being used.)
>>>=20
>>> But your question shows me that my patch is wrong as '0' may actually b=
e a
>>> valid 'tid' value.
>>=20
>> Actually my question is,  there are some place use '0' to check if a tra=
nsaction is valid, e.g.
>>=20
>> In ext4_wait_for_tail_page_commit()
>>=20
>> 5218         while (1) {
>> 5219                 struct folio *folio =3D filemap_lock_folio(inode->i=
_mapping,
>> 5220                                       inode->i_size >> PAGE_SHIFT);
>> 5221                 if (IS_ERR(folio))
>> 5222                         return;
>> 5223                 ret =3D __ext4_journalled_invalidate_folio(folio, o=
ffset,
>> 5224 folio_size(folio) - offset);
>> 5225                 folio_unlock(folio);
>> 5226                 folio_put(folio);
>> 5227                 if (ret !=3D -EBUSY)
>> 5228                         return;
>> 5229                 commit_tid =3D 0;
>> 5230                 read_lock(&journal->j_state_lock);
>> 5231                 if (journal->j_committing_transaction)
>> 5232                         commit_tid =3D journal->j_committing_transa=
ction->t_tid;
>> 5233                 read_unlock(&journal->j_state_lock);
>> 5234                 if (commit_tid)
>> 5235                         jbd2_log_wait_commit(journal, commit_tid);
>> 5236         }
>> 5237  We only wait commit if tid is not zero.
>>=20
>> And in __jbd2_log_wait_for_space()
>>=20
>> 79                 if (space_left < nblocks) {
>>  80                         int chkpt =3D journal->j_checkpoint_transact=
ions !=3D NULL;
>>  81                         tid_t tid =3D 0;
>>  82
>>  83                         if (journal->j_committing_transaction)
>>  84                                 tid =3D journal->j_committing_transa=
ction->t_tid;
>>  85 spin_unlock(&journal->j_list_lock);
>>  86 write_unlock(&journal->j_state_lock);
>>  87                         if (chkpt) {
>>  88 jbd2_log_do_checkpoint(journal);
>>  89                         } else if (jbd2_cleanup_journal_tail(journal=
) =3D=3D 0) {
>>  90                                 /* We were able to recover space; ya=
y! */
>>  91                                 ;
>>  92                         } else if (tid) {
>>  93                                 /*
>>  94                                  * jbd2_journal_commit_transaction()=
 may want
>>  95                                  * to take the checkpoint_mutex if J=
BD2_FLUSHED
>>  96                                  * is set.  So we need to temporaril=
y drop it.
>>  97                                  */
>>  98 mutex_unlock(&journal->j_checkpoint_mutex);
>>  99                                 jbd2_log_wait_commit(journal, tid);
>> 100 write_lock(&journal->j_state_lock);
>> 101                                 continue;
>> We also only wait commit if tid is not zero.
>>=20
>> Does it mean all these have bugs if '0' is a valid 'tid' ?
>>=20
>> But on the other hand, if we don't consider sync and fsync, and default =
commit interval is 5s,
>>=20
>> time of tid wrap to 0 is nearly 680 years. However, we can run sync/fsyn=
c to make tid to increase
>>=20
>> more quickly in real world ?
>
> The simple solution is that "0" is not a valid sequence.  It looks like
> this is a bug in jbd2_get_transaction() where it is incrementing the TID:
>
>         transaction->t_tid =3D journal->j_transaction_sequence++;
>
> it should add a check to handle the wrap-around:
>
>         if (unlikely(transaction->t_tid =3D=3D 0))
>                 transaction->t_tid =3D journal->j_transaction_sequence++;

Sound good to me.  I can prepare a patch with this change if no one else
sees other issues.  As far as I can see, this shouldn't be a problem even
when replaying journals that still have a '0' tid.

Thanks, Andreas.  And thanks Wang, for spotting this.

Cheers,
--=20
Lu=C3=ADs


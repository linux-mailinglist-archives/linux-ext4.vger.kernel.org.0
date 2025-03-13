Return-Path: <linux-ext4+bounces-6780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FAA5E963
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Mar 2025 02:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437487A3F40
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Mar 2025 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF1171C9;
	Thu, 13 Mar 2025 01:20:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BF2E3391;
	Thu, 13 Mar 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828848; cv=none; b=fbMxMLB8lPd+l3pTmJTOOiybjLjyek1CWB3srZ/PMLB9Kf1cW7BHBfrlUg8y+aioj+c6LCjji3v2d1s42kySzNv1VkvErVj6ThWd1x3bGjhrlJcovcFn9G4yOUIfAoTXGb+klbE0G/4ETjBTOqkipb0WsAZPdSP77n39PgQJvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828848; c=relaxed/simple;
	bh=3781Hg3C1AWPyTqnjQIlwBTcW6zEcraiVhV3ndblFCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJ8nXB1eZSIJv4iWBVp+W+pVGpLDL7mOzgrLT4DhL0ofdYNxRYToG/CMpV1imPgCQkz1W3Qb6BKLMzIo/ufVJRSHY/k8m+J1N+AiZhkcIDzmDRmvkbqlxxE3WDYTqZqcvk1KszMz3LMtT3FvERCRG6j1f1dpDpYYsospo8ph0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZCqMN6KXrz1f0bG;
	Thu, 13 Mar 2025 09:16:16 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id C83581A0188;
	Thu, 13 Mar 2025 09:20:39 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Mar 2025 09:20:38 +0800
Message-ID: <ee4156da-e199-443a-9af9-246e8d89559e@huawei.com>
Date: Thu, 13 Mar 2025 09:20:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
To: Jan Kara <jack@suse.cz>
CC: Ritesh Harjani <ritesh.list@gmail.com>, <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
	<linux-kernel@vger.kernel.org>, Mahesh Kumar <maheshkumar657g@gmail.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
 <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87ecz7hcw0.fsf@gmail.com>
 <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87cyergyb1.fsf@gmail.com>
 <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <871pv5cx6v.fsf@gmail.com>
 <bct36ajzi6sardnmc6yz4ot4fbpr654b4k2xz54mrtyje7wofq@qpwzbtctwqnf>
 <Z9GZdSiDL0J80720@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <5ygal3ht47dcpftsxxksmk4lid47al2g4xzlbennmtteeqqsed@uswr3gimu3wc>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <5ygal3ht47dcpftsxxksmk4lid47al2g4xzlbennmtteeqqsed@uswr3gimu3wc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/3/13 1:15, Jan Kara wrote:
> On Wed 12-03-25 19:56:36, Ojaswin Mujoo wrote:
>> On Wed, Mar 12, 2025 at 11:51:03AM +0100, Jan Kara wrote:
>>> On Mon 10-03-25 10:13:36, Ritesh Harjani wrote:
>>>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>>>> On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
>>>>>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>>>>>> On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
>>>>>>>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>>>>>>>> On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
>>>>>>>>>> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
>>>>>>>>>>> Presently we always BUG_ON if trying to start a transaction on a journal marked
>>>>>>>>>>> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>>>>>>>>>>> stress tests, it was observed that in case of some error handling paths, it is
>>>>>>>>>>> possible for update_super_work to start a transaction after the journal is
>>>>>>>>>>> destroyed eg:
>>>>>>>>>>>
>>>>>>>>>>> (umount)
>>>>>>>>>>> ext4_kill_sb
>>>>>>>>>>>   kill_block_super
>>>>>>>>>>>     generic_shutdown_super
>>>>>>>>>>>       sync_filesystem /* commits all txns */
>>>>>>>>>>>       evict_inodes
>>>>>>>>>>>         /* might start a new txn */
>>>>>>>>>>>       ext4_put_super
>>>>>>>>>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>>>>>>>>>>>         jbd2_journal_destroy
>>>>>>>>>>>           journal_kill_thread
>>>>>>>>>>>             journal->j_flags |= JBD2_UNMOUNT;
>>>>>>>>>>>           jbd2_journal_commit_transaction
>>>>>>>>>>>             jbd2_journal_get_descriptor_buffer
>>>>>>>>>>>               jbd2_journal_bmap
>>>>>>>>>>>                 ext4_journal_bmap
>>>>>>>>>>>                   ext4_map_blocks
>>>>>>>>>>>                     ...
>>>>>>>>>>>                     ext4_inode_error
>>>>>>>>>>>                       ext4_handle_error
>>>>>>>>>>>                         schedule_work(&sbi->s_sb_upd_work)
>>>>>>>>>>>
>>>>>>>>>>>                                                /* work queue kicks in */
>>>>>>>>>>>                                                update_super_work
>>>>>>>>>>>                                                  jbd2_journal_start
>>>>>>>>>>>                                                    start_this_handle
>>>>>>>>>>>                                                      BUG_ON(journal->j_flags &
>>>>>>>>>>>                                                             JBD2_UNMOUNT)
>>>>>>>>>>>
>>>>>>>>>>> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>>>>>>>>>>> destroying only do a journaled (and deferred) update of sb if this flag is not
>>>>>>>>>>> set. Otherwise, just fallback to an un-journaled commit.
>>>>>>>>>>>
>>>>>>>>>>> We set sbi->s_journal_destroying = true only after all the FS updates are done
>>>>>>>>>>> during ext4_put_super() (except a running transaction that will get commited
>>>>>>>>>>> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>>>>>>>>>>> outside the journal as it won't race with a journaled update (refer
>>>>>>>>>>> 2d01ddc86606).
>>>>>>>>>>>
>>>>>>>>>>> Also, we don't need a similar check in ext4_grp_locked_error since it is only
>>>>>>>>>>> called from mballoc and AFAICT it would be always valid to schedule work here.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>>>>>>>>>>> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>>>>>>>>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>>>>>>>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  fs/ext4/ext4.h      | 2 ++
>>>>>>>>>>>  fs/ext4/ext4_jbd2.h | 8 ++++++++
>>>>>>>>>>>  fs/ext4/super.c     | 4 +++-
>>>>>>>>>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>>>>>>>> index 2b7d781bfcad..d48e93bd5690 100644
>>>>>>>>>>> --- a/fs/ext4/ext4.h
>>>>>>>>>>> +++ b/fs/ext4/ext4.h
>>>>>>>>>>> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>>>>>>>>>>>  	 */
>>>>>>>>>>>  	struct work_struct s_sb_upd_work;
>>>>>>>>>>>  
>>>>>>>>>>> +	bool s_journal_destorying;
>>>>>>>>>>> +
>>>>>>>>>>>  	/* Atomic write unit values in bytes */
>>>>>>>>>>>  	unsigned int s_awu_min;
>>>>>>>>>>>  	unsigned int s_awu_max;
>>>>>>>>>>> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>>>>>>>>>>> index 9b3c9df02a39..6bd3ca84410d 100644
>>>>>>>>>>> --- a/fs/ext4/ext4_jbd2.h
>>>>>>>>>>> +++ b/fs/ext4/ext4_jbd2.h
>>>>>>>>>>> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>>>>>>>>>>>  {
>>>>>>>>>>>  	int err = 0;
>>>>>>>>>>>  
>>>>>>>>>>> +	/*
>>>>>>>>>>> +	 * At this point all pending FS updates should be done except a possible
>>>>>>>>>>> +	 * running transaction (which will commit in jbd2_journal_destroy). It
>>>>>>>>>>> +	 * is now safe for any new errors to directly commit superblock rather
>>>>>>>>>>> +	 * than going via journal.
>>>>>>>>>>> +	 */
>>>>>>>>>>> +	sbi->s_journal_destorying = true;
>>>>>>>>>>
>>>>>>>>>> This is not correct right. I think what we decided to set this flag
>>>>>>>>>> before we flush the workqueue. So that we don't schedule any new
>>>>>>>>>> work after this flag has been set. At least that is what I understood.
>>>>>>>>>>
>>>>>>>>>> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
>>>>>>>>>>
>>>>>>>>>> -ritesh
>>>>>>>>>
>>>>>>>>> Hey Ritesh,
>>>>>>>>>
>>>>>>>>> Yes that is not correct, I missed that in my patch however we realised
>>>>>>>>> that adding it before flush_work() also has issues [1]. More
>>>>>>>>> specifically:
>>>>>>>>
>>>>>>>> Ohk. right. 
>>>>>>>>
>>>>>>>>>
>>>>>>>>>                      **kjournald2**
>>>>>>>>>                      jbd2_journal_commit_transaction()
>>>>>>>>>                      ...
>>>>>>>>>                      ext4_handle_error()
>>>>>>>>>                         /* s_journal_destorying is not set */
>>>>>>>>>                         if (journal && !s_journal_destorying)
>>>>>>>>
>>>>>>>> Then maybe we should not schedule another work to update the superblock
>>>>>>>> via journalling, it the error itself occurred while were trying to
>>>>>>>> commit the journal txn? 
>>>>>>>>
>>>>>>>>
>>>>>>>> -ritesh
>>>>>>>
>>>>>>> Hmm, ideally yes that should not happen, but how can we achieve that?
>>>>>>> For example with the trace we saw:
>>>>>>>
>>>>>>>    **kjournald2**
>>>>>>>    jbd2_journal_commit_transaction()
>>>>>>>      jbd2_journal_get_descriptor_buffer
>>>>>>>        jbd2_journal_bmap
>>>>>>>          ext4_journal_bmap
>>>>>>>            ext4_map_blocks
>>>>>>>              ...
>>>>>>>              ext4_inode_error
>>>>>>>                ext4_handle_error
>>>>>>>                  schedule_work(&sbi->s_sb_upd_work)
>>>>>>>
>>>>>>> How do we tell ext4_handle_error that it is in the context of a
>>>>>>> committing txn.
>>>
>>> So I was thinking about this. It is not a problem to determine we are
>>> running in kjournald context - it is enough to check
>>>
>>> 	current == EXT4_SB(sb)->s_journal->j_task
>>
>> Oh, right :) 
>>
>>>
>>> But I'm not sure checking this in ext4_handle_error() and doing direct sb
>>> update instead of scheduling a journalled one is always correct. For
>>> example kjournald does also writeback of ordered data and if that hits an
>>> error, we do not necessarily abort the journal (well, currently we do as
>>> far as I'm checking but it seems a bit fragile to rely on this).
>>
>> Okay so IIUC your concern is there might be some codepaths, now or in
>> the future, where kjournald might call the FS layer, hit an error and
>> still decide to not abort. In which case we would still want to update
>> the sb via journal.
> 
> Yeah. The reason why I'm a bit concerned about it is mostly the case of
> kjournald also handling ordered data and situations like
> !(journal->j_flags & JBD2_ABORT_ON_SYNCDATA_ERR) where people want to
> continue although ordered data had issues. Or situations where something in
> j_commit_callback or another jbd2 hook ends up calling ext4_error()...
> 

Ha, right! This is a case where kjournald triggers an ext4 error but does
not abort the journal for now, I forgot this one, and there may be more.
Thanks for pointing it out. I would also prefer to use this solution of
adding ext4_journal_destory().

Thanks,
Yi.



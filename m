Return-Path: <linux-ext4+bounces-14685-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDJjE6ymqmlTVAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14685-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 11:04:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C836721E66F
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 11:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 310FB304EA45
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1335839F;
	Fri,  6 Mar 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HEuLWpDA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DA3590A9;
	Fri,  6 Mar 2026 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791261; cv=none; b=Tt8TjIAx5JnWOppxFxG/oxitskklftV+lDv4W7jZsOGghBNev64EuLgJQCDKlAKZFtMj8pWScVGLR6fPzxvfHHRiSRJchH2JK9Gx3Pintbp9h+H/EDZiErzIT8K1XmSRr/RykUyJr7TEUizSRO6di5vHd+b6ORS8uePObE1hFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791261; c=relaxed/simple;
	bh=to1h6nyJsP/6jJ6aElkhfONsB1k2y+frzq0M1f2H8Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC3CFUzmWud4pcnfsoB9PghXAHjIKTQGvidXcto23m27GH5FasrhpCES8TPu7d6PjNlVESFlipqR2c33Gx4CSys6aSuIe+EBj4Xgzkq3AgeSJLBCZFTvnhKORWjH6x/8VGjltKdbP645ngCceRDuMDF836Pn6JTs61FWtg2ofaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HEuLWpDA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=t8FqolWz5rxYxmQqL4/NDfsOlwCqIRItZ8uOllRTuWs=;
	b=HEuLWpDAb80FE2H6i3cnfWD0OR2VF2SYBr6c9RgjsEDOnsAujoswcGZvGMx9zA
	E/rD8xnqrkmIbarE6wU2H+szEXw3nEw3Ib9c+PnlmRDFVQgNaHPxZZEpJraF1vts
	PpBe/wd8o6EOBF1k7dzvQyZUhGeEfzFlpS4Lg5+rxjes0=
Received: from [192.168.213.68] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBHU6e+pappl2GSOQ--.53081S2;
	Fri, 06 Mar 2026 18:00:31 +0800 (CST)
Message-ID: <1fabe316-2c5b-45d1-8f56-48269f226b9c@163.com>
Date: Fri, 6 Mar 2026 18:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] jbd2: check transaction state before stopping handle
To: "yebin (H)" <yebin10@huawei.com>, tytso@mit.edu, jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangguanyu@vivo.com, Baolin Liu <liubaolin@kylinos.cn>
References: <20260305125402.71285-1-liubaolin12138@163.com>
 <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
 <e52f326a-8da2-457f-8aee-5729373b9582@163.com> <69AA2BF5.3000403@huawei.com>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <69AA2BF5.3000403@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHU6e+pappl2GSOQ--.53081S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry5uw1kKrWkXr45tr15CFg_yoWxXFyUpr
	y8C3WYkr4UJa4jvr1Ivr4jyrZFya48KryUXrZrKas3JanIgwn3tFWkt34jkr4qkr1ru3W8
	Xr1jk39xGw4jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USiiDUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6h+daGmqpb8eeAAA3-
X-Rspamd-Queue-Id: C836721E66F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14685-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liubaolin12138@163.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Action: no action

> Dear yebin,
> 
> Thank you for your feedback.
> 
> From the crash, we can see this issue was triggered by the MemTableFlushTh process. 
> I agree with your point that if this state occurs, there must be something wrong somewhere. 
> Once we find and fix the root cause, we should add J_ASSERT((transaction->t_state == T_RUNNING) || (transaction->t_state == T_LOCKED)) to detect such anomalies, rather than directly skipping the assertion check.
> 
> I will continue to investigate the root cause and try to find a way to reproduce this issue. 
> If you have any thoughts or suggestions on this problem, I'd be happy to discuss.
> 
> Best regards,
> Baolin Liu



在 2026/3/6 9:20, yebin (H) 写道:
> 
> 
> On 2026/3/5 21:11, liubaolin wrote:
>>> Dear maintainers and community,
>>>
>>> Our customer reported a kernel crash issue. The kernel crashes in
>>> stop_this_handle() with:
>>> J_ASSERT(atomic_read(&transaction->t_updates) > 0);
>>>
>>> Crash stack:
>>> Call trace:
>>> stop_this_handle+0x148/0x158
>>> jbd2_journal_stop+0x198/0x388
>>> __ext4_journal_stop+0x70/0xf0
>>> ext4_create+0x12c/0x188
>>> ...
>>>
>>> From the vmcore dump, I found that handle->h_transaction->t_updates is
>>> 0 and handle->h_transaction->t_state is T_FINISHED. This means the
>>> handle is still bound to a transaction that has already completed.
>>>
>>> In the JBD2 commit process, once a transaction enters T_LOCKED state,
>>> the commit thread waits for all associated handles to complete
>>> (t_updates becomes 0). After T_LOCKED completes, the transaction
>>> transitions to T_FLUSH, T_COMMIT, and eventually T_FINISHED. At this
>>> point, t_updates is legitimately 0, and there should be no active
>>> handles bound to this transaction.
>>>
>>> This appears to be a low-probability race condition that occurs under
>>> high concurrency scenarios. The crash happened during ext4_create(),
> I'm curious about what race condition causes this?
> 
>>> and at some rare timing point during the execution, a handle ended up
>>> bound to a transaction that had already completed. The symptom is
>>> clear: a handle is bound to a T_FINISHED transaction with t_updates 
>>> == 0.
>>>
>>> To prevent this, I added a transaction state check in both
>>> jbd2_journal_stop() and jbd2__journal_restart() before calling
>>> stop_this_handle().
>>> If the transaction is not in T_RUNNING or T_LOCKED state (i.e., it's
>>> in T_FLUSH or later states), I clear handle->h_transaction, clear
>>> current->journal_info if needed, restore the memalloc_nofs context,
>>> and skip calling stop_this_handle(). This is a defensive check to
>>> handle the edge case where a handle is bound to a transaction in an
>>> invalid state.
>>>
> If this state occurs, there must be something wrong somewhere.
> Assertions should also be added to detect such anomalies. I think
> directly skipping the assertion check is not a good way to solve the
> problem.
>>> Please let me know if you have any questions or concerns.
>>>
>>> Best regards,
>>> Baolin Liu
>>
>>
>>
>> 在 2026/3/5 20:57, Baolin Liu 写道:
>>>
>>> Add others
>>>
>>>
>>>
>>>
>>>
>>> At 2026-03-05 20:54:02, "Baolin Liu" <liubaolin12138@163.com> wrote:
>>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>>
>>>> When a transaction enters T_FLUSH or later states,
>>>> handle->h_transaction may still point to it.
>>>> If jbd2_journal_stop() or jbd2__journal_restart() is called,
>>>> stop_this_handle() checks t_updates > 0, but t_updates is
>>>> already 0 for these states, causing a kernel BUG.
>>>>
>>>> Fix by checking transaction->t_state in jbd2_journal_stop()
>>>> and jbd2__journal_restart() before calling stop_this_handle().
>>>> If the transaction is not in T_RUNNING or T_LOCKED state,
>>>> clear handle->h_transaction and skip stop_this_handle().
>>>>
>>>> Crash stack:
>>>>  Call trace:
>>>>  stop_this_handle+0x148/0x158
>>>>  jbd2_journal_stop+0x198/0x388
>>>>  __ext4_journal_stop+0x70/0xf0
>>>>  ext4_create+0x12c/0x188
>>>>  lookup_open+0x214/0x6d8
>>>>  do_last+0x364/0x878
>>>>  path_openat+0x6c/0x280
>>>>  do_filp_open+0x70/0xe8
>>>>  do_sys_open+0x178/0x200
>>>>  sys_openat+0x3c/0x50
>>>>  el0_svc_naked+0x44/0x48
>>>>
>>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>>> ---
>>>> fs/jbd2/transaction.c | 25 +++++++++++++++++++++++--
>>>> 1 file changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>>>> index dca4b5d8aaaa..3779382dbb80 100644
>>>> --- a/fs/jbd2/transaction.c
>>>> +++ b/fs/jbd2/transaction.c
>>>> @@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int
>>>> nblocks, int revoke_records,
>>>>     journal = transaction->t_journal;
>>>>     tid = transaction->t_tid;
>>>>
>>>> +    jbd2_debug(2, "restarting handle %p\n", handle);
>>>> +
>>>> +    /* Check if transaction is in invalid state */
>>>> +    if (transaction->t_state != T_RUNNING &&
>>>> +        transaction->t_state != T_LOCKED) {
>>>> +        if (current->journal_info == handle)
>>>> +            current->journal_info = NULL;
>>>> +        handle->h_transaction = NULL;
>>>> +        memalloc_nofs_restore(handle->saved_alloc_context);
>>>> +        goto skip_stop;
>>>> +    }
>>>> +
>>>>     /*
>>>>      * First unlink the handle from its current transaction, and
>>>> start the
>>>>      * commit on that.
>>>>      */
>>>> -    jbd2_debug(2, "restarting handle %p\n", handle);
>>>>     stop_this_handle(handle);
>>>>     handle->h_transaction = NULL;
>>>> -
>>>> +skip_stop:
>>>>     /*
>>>>      * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we
>>>> can
>>>>       * get rid of pointless j_state_lock traffic like this.
>>>> @@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
>>>>         memalloc_nofs_restore(handle->saved_alloc_context);
>>>>         goto free_and_exit;
>>>>     }
>>>> +    /* Check if transaction is in invalid state */
>>>> +    if (transaction->t_state != T_RUNNING &&
>>>> +        transaction->t_state != T_LOCKED) {
>>>> +        if (current->journal_info == handle)
>>>> +            current->journal_info = NULL;
>>>> +        handle->h_transaction = NULL;
>>>> +        memalloc_nofs_restore(handle->saved_alloc_context);
>>>> +        goto free_and_exit;
>>>> +    }
>>>> +
>>>>     journal = transaction->t_journal;
>>>>     tid = transaction->t_tid;
>>>>
>>>> -- 
>>>> 2.39.2
>>
>>
>>
>> .
>>



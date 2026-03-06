Return-Path: <linux-ext4+bounces-14672-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFjeAi4sqmlaMgEAu9opvQ
	(envelope-from <linux-ext4+bounces-14672-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 02:21:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9C21A347
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 02:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2320C304AA10
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75862315D43;
	Fri,  6 Mar 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BF9ip1/s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720D3101D4;
	Fri,  6 Mar 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760061; cv=none; b=CKirVmLgmJ2MOHEov8U29ji4ULFhCfOi9F50YN1LxQ7H+2wchhLkzZkuBmgT8WNPEl1ZORIfCSRQgz0VOAZr3Qh7YyXi5LUBKwfLw1uuRGo1orV6utt7Qtqg1QknEMBEGK0QzAm0p2T7Ezyo6Cf47HEGxxYjdHR8vVubftK3VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760061; c=relaxed/simple;
	bh=zaN7CMQmW8SgbLP8xVfKsrjtjojtJRQViS26yLuXnA4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=delDdXU+LjYKWObj5JZ3Mk3dexayjIggUDH9mx2Oh0If3xnbZuLm/0SAR6MYAALBNya5sCZsXmFyoOCI1XbEpxZzHIY7MR/f6Q4B+AAcm2r9b8SiYXM23f2Q5MdFWdkuLkePjBkraCcJqiu9zJHcxKuHPfo/Mow6Zbbw+fQJk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BF9ip1/s; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=urqxLOMi3kh6ZgxfqxL2c1tIXkvpx60jV50QIt2Pkyk=;
	b=BF9ip1/swI5F73eCNFxGa19MGme8wsb204CiwtmVBxSIZrfkBcNBpTmcJkQIIRBopqmsBYG1t
	0MaE21EJaA/boFBciRtzpVP5/vWIyTO4+vTIAZPLvnlIJhquNnCtseuaITOfKbdOYG3nHFAnyJJ
	huB5KwRTJY69rb6JHZtPcKc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fRpPh5Bb6zpSvK;
	Fri,  6 Mar 2026 09:15:52 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 102B92022B;
	Fri,  6 Mar 2026 09:20:55 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 09:20:54 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 09:20:54 +0800
Subject: Re: [PATCH v1] jbd2: check transaction state before stopping handle
To: liubaolin <liubaolin12138@163.com>, <tytso@mit.edu>, <jack@suse.com>
References: <20260305125402.71285-1-liubaolin12138@163.com>
 <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
 <e52f326a-8da2-457f-8aee-5729373b9582@163.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wangguanyu@vivo.com>, Baolin Liu <liubaolin@kylinos.cn>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69AA2BF5.3000403@huawei.com>
Date: Fri, 6 Mar 2026 09:20:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e52f326a-8da2-457f-8aee-5729373b9582@163.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: 70B9C21A347
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14672-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[163.com,mit.edu,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,huawei.com:dkim,huawei.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2026/3/5 21:11, liubaolin wrote:
>> Dear maintainers and community,
>>
>> Our customer reported a kernel crash issue. The kernel crashes in
>> stop_this_handle() with:
>> J_ASSERT(atomic_read(&transaction->t_updates) > 0);
>>
>> Crash stack:
>> Call trace:
>> stop_this_handle+0x148/0x158
>> jbd2_journal_stop+0x198/0x388
>> __ext4_journal_stop+0x70/0xf0
>> ext4_create+0x12c/0x188
>> ...
>>
>> From the vmcore dump, I found that handle->h_transaction->t_updates is
>> 0 and handle->h_transaction->t_state is T_FINISHED. This means the
>> handle is still bound to a transaction that has already completed.
>>
>> In the JBD2 commit process, once a transaction enters T_LOCKED state,
>> the commit thread waits for all associated handles to complete
>> (t_updates becomes 0). After T_LOCKED completes, the transaction
>> transitions to T_FLUSH, T_COMMIT, and eventually T_FINISHED. At this
>> point, t_updates is legitimately 0, and there should be no active
>> handles bound to this transaction.
>>
>> This appears to be a low-probability race condition that occurs under
>> high concurrency scenarios. The crash happened during ext4_create(),
I'm curious about what race condition causes this?

>> and at some rare timing point during the execution, a handle ended up
>> bound to a transaction that had already completed. The symptom is
>> clear: a handle is bound to a T_FINISHED transaction with t_updates == 0.
>>
>> To prevent this, I added a transaction state check in both
>> jbd2_journal_stop() and jbd2__journal_restart() before calling
>> stop_this_handle().
>> If the transaction is not in T_RUNNING or T_LOCKED state (i.e., it's
>> in T_FLUSH or later states), I clear handle->h_transaction, clear
>> current->journal_info if needed, restore the memalloc_nofs context,
>> and skip calling stop_this_handle(). This is a defensive check to
>> handle the edge case where a handle is bound to a transaction in an
>> invalid state.
>>
If this state occurs, there must be something wrong somewhere.
Assertions should also be added to detect such anomalies. I think
directly skipping the assertion check is not a good way to solve the
problem.
>> Please let me know if you have any questions or concerns.
>>
>> Best regards,
>> Baolin Liu
>
>
>
> 在 2026/3/5 20:57, Baolin Liu 写道:
>>
>> Add others
>>
>>
>>
>>
>>
>> At 2026-03-05 20:54:02, "Baolin Liu" <liubaolin12138@163.com> wrote:
>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>
>>> When a transaction enters T_FLUSH or later states,
>>> handle->h_transaction may still point to it.
>>> If jbd2_journal_stop() or jbd2__journal_restart() is called,
>>> stop_this_handle() checks t_updates > 0, but t_updates is
>>> already 0 for these states, causing a kernel BUG.
>>>
>>> Fix by checking transaction->t_state in jbd2_journal_stop()
>>> and jbd2__journal_restart() before calling stop_this_handle().
>>> If the transaction is not in T_RUNNING or T_LOCKED state,
>>> clear handle->h_transaction and skip stop_this_handle().
>>>
>>> Crash stack:
>>>  Call trace:
>>>  stop_this_handle+0x148/0x158
>>>  jbd2_journal_stop+0x198/0x388
>>>  __ext4_journal_stop+0x70/0xf0
>>>  ext4_create+0x12c/0x188
>>>  lookup_open+0x214/0x6d8
>>>  do_last+0x364/0x878
>>>  path_openat+0x6c/0x280
>>>  do_filp_open+0x70/0xe8
>>>  do_sys_open+0x178/0x200
>>>  sys_openat+0x3c/0x50
>>>  el0_svc_naked+0x44/0x48
>>>
>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>> ---
>>> fs/jbd2/transaction.c | 25 +++++++++++++++++++++++--
>>> 1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>>> index dca4b5d8aaaa..3779382dbb80 100644
>>> --- a/fs/jbd2/transaction.c
>>> +++ b/fs/jbd2/transaction.c
>>> @@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int
>>> nblocks, int revoke_records,
>>>     journal = transaction->t_journal;
>>>     tid = transaction->t_tid;
>>>
>>> +    jbd2_debug(2, "restarting handle %p\n", handle);
>>> +
>>> +    /* Check if transaction is in invalid state */
>>> +    if (transaction->t_state != T_RUNNING &&
>>> +        transaction->t_state != T_LOCKED) {
>>> +        if (current->journal_info == handle)
>>> +            current->journal_info = NULL;
>>> +        handle->h_transaction = NULL;
>>> +        memalloc_nofs_restore(handle->saved_alloc_context);
>>> +        goto skip_stop;
>>> +    }
>>> +
>>>     /*
>>>      * First unlink the handle from its current transaction, and
>>> start the
>>>      * commit on that.
>>>      */
>>> -    jbd2_debug(2, "restarting handle %p\n", handle);
>>>     stop_this_handle(handle);
>>>     handle->h_transaction = NULL;
>>> -
>>> +skip_stop:
>>>     /*
>>>      * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we
>>> can
>>>       * get rid of pointless j_state_lock traffic like this.
>>> @@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
>>>         memalloc_nofs_restore(handle->saved_alloc_context);
>>>         goto free_and_exit;
>>>     }
>>> +    /* Check if transaction is in invalid state */
>>> +    if (transaction->t_state != T_RUNNING &&
>>> +        transaction->t_state != T_LOCKED) {
>>> +        if (current->journal_info == handle)
>>> +            current->journal_info = NULL;
>>> +        handle->h_transaction = NULL;
>>> +        memalloc_nofs_restore(handle->saved_alloc_context);
>>> +        goto free_and_exit;
>>> +    }
>>> +
>>>     journal = transaction->t_journal;
>>>     tid = transaction->t_tid;
>>>
>>> --
>>> 2.39.2
>
>
>
> .
>


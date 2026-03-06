Return-Path: <linux-ext4+bounces-14683-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO3rMAGdqmnPUQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14683-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:23:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99421DD54
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED72F306A514
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE84344D86;
	Fri,  6 Mar 2026 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QS5JHsdl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DA2F361F;
	Fri,  6 Mar 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788830; cv=none; b=rcZRZQY3ot+VLRF8Hpz9oyQ33oMP+OFBic3hw79ZQCnLBNGoVnKQNZfOB0pwfU4OHbn3xn5L4aPs/pX5+SGznQSVzqNCkdfKW9Fwd4leFrK1tA6RMaXqJx38Gk8uk1//KU8WzxWQttl12I9pN91l6ZN0pBPR+ivYffTgmRnaY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788830; c=relaxed/simple;
	bh=dFJocEDFyAjQOeEba5+OwVmajXOFL23PXQiven+dDxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl1fPnXcR/U6LfgsCsDf0PGDlem4AJGF81/WzxiYgpfDHSWW0ec6ESqtsiCk0qQOskr8f9OzOUTrHpIJMN8tUuXHnN3QtdcmQZQeuSr1bXwNVZ/0Lc5AttZkTip6E7Xr8SN76HKEsXkPnp9V4/Eb1WhKO4ia+K1d5p3zED547wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QS5JHsdl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=jhLG7LLSw3BnBOThlEwC6EAsZ59uyL6sL+CPaTXO3hI=;
	b=QS5JHsdl6BSZmcz1CxuzKjz02HGmrYm8DRqY6zdwZFUPucAErnBMClF86u7102
	C/7HtSiilj3QfAKORgTgjFtViPR+314EksCG5l6qronOM3bqL/SeJoO76RrBFqDK
	nZjyJKtRU6+zcshzMgHmFYQfpJ5oUyQbg5u2QKpylnF54=
Received: from [192.168.213.68] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3qJQ3nKpppEh1PA--.61181S2;
	Fri, 06 Mar 2026 17:19:54 +0800 (CST)
Message-ID: <430101e2-9692-4d10-a4e9-9b1c82523eea@163.com>
Date: Fri, 6 Mar 2026 17:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] jbd2: check transaction state before stopping handle
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangguanyu@vivo.com,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20260305125402.71285-1-liubaolin12138@163.com>
 <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
 <cqmzdae2mou7gjt2ljcymji6jqwmca6lu2kwkeeo3buzohvbo3@4eq2xhgm7cej>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <cqmzdae2mou7gjt2ljcymji6jqwmca6lu2kwkeeo3buzohvbo3@4eq2xhgm7cej>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3qJQ3nKpppEh1PA--.61181S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw45Gw18uFW3uw1fGFy8Zrb_yoWxZr1Dpr
	W8Ca1Ykr1UJa48Zrn2vr48tr4093W8K34UWrZxKas7AanIq3ZayFWIg34jgr4DJrWru3W8
	Xryjkr9xGw4Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfOz-UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ho6BWmqnDon3AAA3R
X-Rspamd-Queue-Id: 1C99421DD54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14683-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liubaolin12138@163.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Dear Honza,

Thank you for your feedback. Yes, the BUG is exactly at:
J_ASSERT(atomic_read(&transaction->t_updates) > 0)

> Dear Honza,
> 
> Thank you for your feedback. Yes, the BUG is exactly at:
> J_ASSERT(atomic_read(&transaction->t_updates) > 0)
> 
> I understand your concern that this shouldn't happen in normal operation. However, from the vmcore dump, we can confirm that:
> - handle->h_transaction->t_updates == 0
> - handle->h_transaction->t_state == T_FINISHED
> - The crash occurred in stop_this_handle() when it tried to assert t_updates > 0
> 
> This is a real crash that happened in production. The crash stack shows it occurred during ext4_create(), and the process name was MemTableFlushTh.
> 
> I understand you want us to find and fix the root cause. I've reviewed the code but haven't found an obvious bug from the code that would cause this issue. 
> However, I suspect the issue might be related to credit exhaustion during ext4_create() that triggers a handle restart, 
> but this is just speculation and I'm still studying the code to confirm.
> 
> This crash only occurred once in production and we haven't been able to reproduce it. The crash happened under high concurrency, and appears to be timing-dependent. 
> I will continue to investigate the code and try to find a way to reproduce this issue to identify the root cause.
> 
> The patch I proposed is a defensive check to prevent the kernel BUG when this edge case occurs.
> 
> If you have any thoughts on where to look for the root cause, I'd really appreciate any suggestions.
> 
> Best regards,
> Baolin Liu

> Dear Honza,
> 
> Thank you for your feedback. Yes, the BUG is exactly at:
> J_ASSERT(atomic_read(&transaction->t_updates) > 0)
> 
> I understand your concern that this shouldn't happen in normal operation. However, from the vmcore dump, we can confirm that:
> - handle->h_transaction->t_updates == 0
> - handle->h_transaction->t_state == T_FINISHED
> - The crash occurred in stop_this_handle() when it tried to assert t_updates > 0
> 
> This is a real crash that happened in production. The crash stack shows it occurred during ext4_create(), and the process name was MemTableFlushTh.
> 
> I understand you want us to find and fix the root cause. I've reviewed the code but haven't found an obvious bug from the code that would cause this issue. 
> However, I suspect the issue might be related to credit exhaustion during ext4_create() that triggers a handle restart, 
> but this is just speculation and I'm still studying the code to confirm.
> 
> This crash only occurred once in production and we haven't been able to reproduce it. The crash happened under high concurrency, and appears to be timing-dependent. 
> I will continue to investigate the code and try to find a way to reproduce this issue to identify the root cause.
> 
> The patch I proposed is a defensive check to prevent the kernel BUG when this edge case occurs.
> 
> If you have any thoughts on where to look for the root cause, I'd really appreciate any suggestions.
> 
> Best regards,
> Baolin Liu



在 2026/3/5 21:08, Jan Kara 写道:
> On Thu 05-03-26 20:57:18, Baolin Liu wrote:
>> At 2026-03-05 20:54:02, "Baolin Liu" <liubaolin12138@163.com> wrote:
>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>
>>> When a transaction enters T_FLUSH or later states,
>>> handle->h_transaction may still point to it.
>>> If jbd2_journal_stop() or jbd2__journal_restart() is called,
>>> stop_this_handle() checks t_updates > 0, but t_updates is
>>> already 0 for these states, causing a kernel BUG.
> 
> Which bug please? Do you mean
> 
> J_ASSERT(atomic_read(&transaction->t_updates) > 0)
> 
> ? Anyway this just doesn't make sense. When stop_this_handle() the caller
> is holding t_updates reference which stop_this_handle() is supposed to drop
> and the transaction should never transition past T_LOCKED state. If you
> have a handle that's pointing to a transaction past T_LOCKED state, there's
> a bug somewhere and that bug needs to be fixed, not paper over it like you
> do in this patch. More details about reproducer etc. would be useful.
> 
> 								Honza
> 
>>>
>>> Fix by checking transaction->t_state in jbd2_journal_stop()
>>> and jbd2__journal_restart() before calling stop_this_handle().
>>> If the transaction is not in T_RUNNING or T_LOCKED state,
>>> clear handle->h_transaction and skip stop_this_handle().
>>>
>>> Crash stack:
>>>   Call trace:
>>>   stop_this_handle+0x148/0x158
>>>   jbd2_journal_stop+0x198/0x388
>>>   __ext4_journal_stop+0x70/0xf0
>>>   ext4_create+0x12c/0x188
>>>   lookup_open+0x214/0x6d8
>>>   do_last+0x364/0x878
>>>   path_openat+0x6c/0x280
>>>   do_filp_open+0x70/0xe8
>>>   do_sys_open+0x178/0x200
>>>   sys_openat+0x3c/0x50
>>>   el0_svc_naked+0x44/0x48
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
>>> @@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
>>> 	journal = transaction->t_journal;
>>> 	tid = transaction->t_tid;
>>>
>>> +	jbd2_debug(2, "restarting handle %p\n", handle);
>>> +
>>> +	/* Check if transaction is in invalid state */
>>> +	if (transaction->t_state != T_RUNNING &&
>>> +		transaction->t_state != T_LOCKED) {
>>> +		if (current->journal_info == handle)
>>> +			current->journal_info = NULL;
>>> +		handle->h_transaction = NULL;
>>> +		memalloc_nofs_restore(handle->saved_alloc_context);
>>> +		goto skip_stop;
>>> +	}
>>> +
>>> 	/*
>>> 	 * First unlink the handle from its current transaction, and start the
>>> 	 * commit on that.
>>> 	 */
>>> -	jbd2_debug(2, "restarting handle %p\n", handle);
>>> 	stop_this_handle(handle);
>>> 	handle->h_transaction = NULL;
>>> -
>>> +skip_stop:
>>> 	/*
>>> 	 * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we can
>>>   	 * get rid of pointless j_state_lock traffic like this.
>>> @@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
>>> 		memalloc_nofs_restore(handle->saved_alloc_context);
>>> 		goto free_and_exit;
>>> 	}
>>> +	/* Check if transaction is in invalid state */
>>> +	if (transaction->t_state != T_RUNNING &&
>>> +		transaction->t_state != T_LOCKED) {
>>> +		if (current->journal_info == handle)
>>> +			current->journal_info = NULL;
>>> +		handle->h_transaction = NULL;
>>> +		memalloc_nofs_restore(handle->saved_alloc_context);
>>> +		goto free_and_exit;
>>> +	}
>>> +
>>> 	journal = transaction->t_journal;
>>> 	tid = transaction->t_tid;
>>>
>>> -- 
>>> 2.39.2



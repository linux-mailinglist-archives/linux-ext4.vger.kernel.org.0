Return-Path: <linux-ext4+bounces-14657-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEsKBhiBqWnU9gAAu9opvQ
	(envelope-from <linux-ext4+bounces-14657-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 14:11:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B421274F
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6834330138B1
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0D39E6C5;
	Thu,  5 Mar 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lgYQShyP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076218EB0;
	Thu,  5 Mar 2026 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716309; cv=none; b=o8lrF5XNkXwdlfF/aL+7KbTAuI92DpGV6r+TtouDFaUyWUi7h1xNaL4ksWVPihHbBlH8UfJdfLD6HWAeQvnxZjN3psboRfBWmu4hiO+taT61kWow5w3unyg3lFRBaEeSgzUYw4FFrqS5y1lymLH4IUkU0tZrTc1rtEBB1m8QR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716309; c=relaxed/simple;
	bh=g8diDehkFpgnNRJTwgWgCQ6RmCFODQ3Sw7ud6LoYlOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edydEucgws2IA+tX0/fi9NxpOj1CnTYdjCixxy+CFLT0C35BTIQ7Sz3M/Rp3/RtEAhMlEDl7JKnb8RIt9n9mQLMZI+7pb2Wke0JewWNs3nzBR1TF9k+vdjaLqnVyNrtw8yNaC8ZICer3/Z5krwFHJFdmNeWaKyTl9IvtAz34zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lgYQShyP; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1XSshkBt0njgPa6nlJFa/gDTbR8BGoOYubn1JnlYETs=;
	b=lgYQShyP4qTGApw4IzWeNsAcOWItp8/swqrf03Of2PaePYLFeldor0Z//GZV+y
	bHeXZoBqGMcPHjIPmbU4CfinAnDhSgTms/DiiLU+AcDhSo0TaFd0Mzt7s8s4cxCG
	4V/jevjD4bLm7tLvMTT4KS3cX1b/IBrZmxXgheMUWfzRk=
Received: from [192.168.45.68] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXFqf+gKlpAwKIOw--.11899S2;
	Thu, 05 Mar 2026 21:11:29 +0800 (CST)
Message-ID: <e52f326a-8da2-457f-8aee-5729373b9582@163.com>
Date: Thu, 5 Mar 2026 21:11:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] jbd2: check transaction state before stopping handle
To: tytso@mit.edu, jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangguanyu@vivo.com, Baolin Liu <liubaolin@kylinos.cn>,
 liubaolin12138@163.com
References: <20260305125402.71285-1-liubaolin12138@163.com>
 <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXFqf+gKlpAwKIOw--.11899S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWkGF43KrykKw13uF4kZwb_yoW7GryUpr
	y8Cw1Ykr1Uta4jvF1Ivr4jyrW2va40kryUGrZrKas3Ja1agwn3tFZ7K34UKr4DCr4ru3W8
	XryjkwnrGw4jk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUl1gUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgIl72mpgQL4QgAA3z
X-Rspamd-Queue-Id: 809B421274F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14657-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,vivo.com,kylinos.cn,163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liubaolin12138@163.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> Dear maintainers and community,
> 
> Our customer reported a kernel crash issue. The kernel crashes in stop_this_handle() with:
> J_ASSERT(atomic_read(&transaction->t_updates) > 0);
> 
> Crash stack:
> Call trace:
> stop_this_handle+0x148/0x158
> jbd2_journal_stop+0x198/0x388
> __ext4_journal_stop+0x70/0xf0
> ext4_create+0x12c/0x188
> ...
> 
> From the vmcore dump, I found that handle->h_transaction->t_updates is 0 and handle->h_transaction->t_state is T_FINISHED. 
> This means the handle is still bound to a transaction that has already completed.
> 
> In the JBD2 commit process, once a transaction enters T_LOCKED state, the commit thread waits for all associated handles to complete (t_updates becomes 0). 
> After T_LOCKED completes, the transaction transitions to T_FLUSH, T_COMMIT, and eventually T_FINISHED. 
> At this point, t_updates is legitimately 0, and there should be no active handles bound to this transaction.
> 
> This appears to be a low-probability race condition that occurs under high concurrency scenarios. 
> The crash happened during ext4_create(), and at some rare timing point during the execution, a handle ended up bound to a transaction that had already completed. 
> The symptom is clear: a handle is bound to a T_FINISHED transaction with t_updates == 0.
> 
> To prevent this, I added a transaction state check in both jbd2_journal_stop() and jbd2__journal_restart() before calling stop_this_handle().
> If the transaction is not in T_RUNNING or T_LOCKED state (i.e., it's in T_FLUSH or later states), 
> I clear handle->h_transaction, clear current->journal_info if needed, restore the memalloc_nofs context, and skip calling stop_this_handle(). 
> This is a defensive check to handle the edge case where a handle is bound to a transaction in an invalid state.
> 
> Please let me know if you have any questions or concerns.
> 
> Best regards,
> Baolin Liu



在 2026/3/5 20:57, Baolin Liu 写道:
> 
> Add others
> 
> 
> 
> 
> 
> At 2026-03-05 20:54:02, "Baolin Liu" <liubaolin12138@163.com> wrote:
>>From: Baolin Liu <liubaolin@kylinos.cn>
>>
>>When a transaction enters T_FLUSH or later states,
>>handle->h_transaction may still point to it.
>>If jbd2_journal_stop() or jbd2__journal_restart() is called,
>>stop_this_handle() checks t_updates > 0, but t_updates is
>>already 0 for these states, causing a kernel BUG.
>>
>>Fix by checking transaction->t_state in jbd2_journal_stop()
>>and jbd2__journal_restart() before calling stop_this_handle().
>>If the transaction is not in T_RUNNING or T_LOCKED state,
>>clear handle->h_transaction and skip stop_this_handle().
>>
>>Crash stack:
>>  Call trace:
>>  stop_this_handle+0x148/0x158
>>  jbd2_journal_stop+0x198/0x388
>>  __ext4_journal_stop+0x70/0xf0
>>  ext4_create+0x12c/0x188
>>  lookup_open+0x214/0x6d8
>>  do_last+0x364/0x878
>>  path_openat+0x6c/0x280
>>  do_filp_open+0x70/0xe8
>>  do_sys_open+0x178/0x200
>>  sys_openat+0x3c/0x50
>>  el0_svc_naked+0x44/0x48
>>
>>Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>---
>> fs/jbd2/transaction.c | 25 +++++++++++++++++++++++--
>> 1 file changed, 23 insertions(+), 2 deletions(-)
>>
>>diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>>index dca4b5d8aaaa..3779382dbb80 100644
>>--- a/fs/jbd2/transaction.c
>>+++ b/fs/jbd2/transaction.c
>>@@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
>> 	journal = transaction->t_journal;
>> 	tid = transaction->t_tid;
>> 
>>+	jbd2_debug(2, "restarting handle %p\n", handle);
>>+
>>+	/* Check if transaction is in invalid state */
>>+	if (transaction->t_state != T_RUNNING &&
>>+		transaction->t_state != T_LOCKED) {
>>+		if (current->journal_info == handle)
>>+			current->journal_info = NULL;
>>+		handle->h_transaction = NULL;
>>+		memalloc_nofs_restore(handle->saved_alloc_context);
>>+		goto skip_stop;
>>+	}
>>+
>> 	/*
>> 	 * First unlink the handle from its current transaction, and start the
>> 	 * commit on that.
>> 	 */
>>-	jbd2_debug(2, "restarting handle %p\n", handle);
>> 	stop_this_handle(handle);
>> 	handle->h_transaction = NULL;
>>-
>>+skip_stop:
>> 	/*
>> 	 * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we can
>>  	 * get rid of pointless j_state_lock traffic like this.
>>@@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
>> 		memalloc_nofs_restore(handle->saved_alloc_context);
>> 		goto free_and_exit;
>> 	}
>>+	/* Check if transaction is in invalid state */
>>+	if (transaction->t_state != T_RUNNING &&
>>+		transaction->t_state != T_LOCKED) {
>>+		if (current->journal_info == handle)
>>+			current->journal_info = NULL;
>>+		handle->h_transaction = NULL;
>>+		memalloc_nofs_restore(handle->saved_alloc_context);
>>+		goto free_and_exit;
>>+	}
>>+
>> 	journal = transaction->t_journal;
>> 	tid = transaction->t_tid;
>> 
>>-- 
>>2.39.2



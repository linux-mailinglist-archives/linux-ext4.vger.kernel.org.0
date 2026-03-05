Return-Path: <linux-ext4+bounces-14656-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOFqOlKBqWkd9gAAu9opvQ
	(envelope-from <linux-ext4+bounces-14656-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 14:12:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2A2127A7
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9457D30D026D
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8139EF18;
	Thu,  5 Mar 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="209usyVU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8BeceqMX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="209usyVU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8BeceqMX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3B1EEA49
	for <linux-ext4@vger.kernel.org>; Thu,  5 Mar 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716105; cv=none; b=LSXKw3Zim8RqlpIU9Tf2H5x+JPLrxi0GZFqXF6gxHwNxhqC/2tZ02qSMMM3ZDlWupyTnHNboQvilblsYEACrCXe5AqP+R58TgF1d01pO3yWV9DA7b2Z+/rIXG2ticJR2pryBgqdi3fRnsgwUzIN44WM38rofYpUU4M2jG1zGbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716105; c=relaxed/simple;
	bh=WXWCqJOt2aMWFmN2gtHPWRX+XeCfq+z02eG/BI2Pvw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Bv82//I7nPYcJGMt6nnw44jYybkAz9nDsNBxs81ChYiC9a2YwCLHrYxdSL9gAb5h0E8vwAWoHAXS9r20RCGGal1Kcz7c+FUiOMd7NqjMpjtVXHIh8Sg6tXUgH82Oq781tcyj/33J0L2ZvY4y3hcIJFXTdtWE1YyZdqxWWO7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=209usyVU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8BeceqMX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=209usyVU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8BeceqMX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EA755BDEC;
	Thu,  5 Mar 2026 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772716102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4wlvqhuc1vuQR1Kxq5AedsRfjdCrhPG+GwR1XtxYIk=;
	b=209usyVU8jp1EyJuKkYqvZlk3rW1u7I5VGG5O1OJsjD61pgITa7aM1LVfmxtkLP5uSJShW
	3kZxrJJ/WFr+0BOiRfeTYKN8K3jFLmxEblFEfMheQJ8ORY1aVqjIL7XJ0hgITjctBp3Q1h
	/GKUgJzcJn3f6pezb0rHZ02qDqz7U5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772716102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4wlvqhuc1vuQR1Kxq5AedsRfjdCrhPG+GwR1XtxYIk=;
	b=8BeceqMX3NoT05Rcg3KdnIPugggnGmzKonQYuPSR712WlZ7ojyYjDhCtbKCTfYfrXxVNYS
	ug8SiGL1jqIF7WAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=209usyVU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8BeceqMX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772716102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4wlvqhuc1vuQR1Kxq5AedsRfjdCrhPG+GwR1XtxYIk=;
	b=209usyVU8jp1EyJuKkYqvZlk3rW1u7I5VGG5O1OJsjD61pgITa7aM1LVfmxtkLP5uSJShW
	3kZxrJJ/WFr+0BOiRfeTYKN8K3jFLmxEblFEfMheQJ8ORY1aVqjIL7XJ0hgITjctBp3Q1h
	/GKUgJzcJn3f6pezb0rHZ02qDqz7U5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772716102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4wlvqhuc1vuQR1Kxq5AedsRfjdCrhPG+GwR1XtxYIk=;
	b=8BeceqMX3NoT05Rcg3KdnIPugggnGmzKonQYuPSR712WlZ7ojyYjDhCtbKCTfYfrXxVNYS
	ug8SiGL1jqIF7WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 330173EA68;
	Thu,  5 Mar 2026 13:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MwlsDEaAqWnGHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 13:08:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2CBEA0A8D; Thu,  5 Mar 2026 14:08:17 +0100 (CET)
Date: Thu, 5 Mar 2026 14:08:17 +0100
From: Jan Kara <jack@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wangguanyu@vivo.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] jbd2: check transaction state before stopping handle
Message-ID: <cqmzdae2mou7gjt2ljcymji6jqwmca6lu2kwkeeo3buzohvbo3@4eq2xhgm7cej>
References: <20260305125402.71285-1-liubaolin12138@163.com>
 <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257c6f1e.a166.19cbe12f387.Coremail.liubaolin12138@163.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 8BE2A2127A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14656-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,kylinos.cn:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu 05-03-26 20:57:18, Baolin Liu wrote:
> At 2026-03-05 20:54:02, "Baolin Liu" <liubaolin12138@163.com> wrote:
> >From: Baolin Liu <liubaolin@kylinos.cn>
> >
> >When a transaction enters T_FLUSH or later states,
> >handle->h_transaction may still point to it.
> >If jbd2_journal_stop() or jbd2__journal_restart() is called,
> >stop_this_handle() checks t_updates > 0, but t_updates is
> >already 0 for these states, causing a kernel BUG.

Which bug please? Do you mean

J_ASSERT(atomic_read(&transaction->t_updates) > 0)

? Anyway this just doesn't make sense. When stop_this_handle() the caller
is holding t_updates reference which stop_this_handle() is supposed to drop
and the transaction should never transition past T_LOCKED state. If you
have a handle that's pointing to a transaction past T_LOCKED state, there's
a bug somewhere and that bug needs to be fixed, not paper over it like you
do in this patch. More details about reproducer etc. would be useful.

								Honza

> >
> >Fix by checking transaction->t_state in jbd2_journal_stop()
> >and jbd2__journal_restart() before calling stop_this_handle().
> >If the transaction is not in T_RUNNING or T_LOCKED state,
> >clear handle->h_transaction and skip stop_this_handle().
> >
> >Crash stack:
> >  Call trace:
> >  stop_this_handle+0x148/0x158
> >  jbd2_journal_stop+0x198/0x388
> >  __ext4_journal_stop+0x70/0xf0
> >  ext4_create+0x12c/0x188
> >  lookup_open+0x214/0x6d8
> >  do_last+0x364/0x878
> >  path_openat+0x6c/0x280
> >  do_filp_open+0x70/0xe8
> >  do_sys_open+0x178/0x200
> >  sys_openat+0x3c/0x50
> >  el0_svc_naked+0x44/0x48
> >
> >Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> >---
> > fs/jbd2/transaction.c | 25 +++++++++++++++++++++++--
> > 1 file changed, 23 insertions(+), 2 deletions(-)
> >
> >diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> >index dca4b5d8aaaa..3779382dbb80 100644
> >--- a/fs/jbd2/transaction.c
> >+++ b/fs/jbd2/transaction.c
> >@@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
> > 	journal = transaction->t_journal;
> > 	tid = transaction->t_tid;
> > 
> >+	jbd2_debug(2, "restarting handle %p\n", handle);
> >+
> >+	/* Check if transaction is in invalid state */
> >+	if (transaction->t_state != T_RUNNING &&
> >+		transaction->t_state != T_LOCKED) {
> >+		if (current->journal_info == handle)
> >+			current->journal_info = NULL;
> >+		handle->h_transaction = NULL;
> >+		memalloc_nofs_restore(handle->saved_alloc_context);
> >+		goto skip_stop;
> >+	}
> >+
> > 	/*
> > 	 * First unlink the handle from its current transaction, and start the
> > 	 * commit on that.
> > 	 */
> >-	jbd2_debug(2, "restarting handle %p\n", handle);
> > 	stop_this_handle(handle);
> > 	handle->h_transaction = NULL;
> >-
> >+skip_stop:
> > 	/*
> > 	 * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we can
> >  	 * get rid of pointless j_state_lock traffic like this.
> >@@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
> > 		memalloc_nofs_restore(handle->saved_alloc_context);
> > 		goto free_and_exit;
> > 	}
> >+	/* Check if transaction is in invalid state */
> >+	if (transaction->t_state != T_RUNNING &&
> >+		transaction->t_state != T_LOCKED) {
> >+		if (current->journal_info == handle)
> >+			current->journal_info = NULL;
> >+		handle->h_transaction = NULL;
> >+		memalloc_nofs_restore(handle->saved_alloc_context);
> >+		goto free_and_exit;
> >+	}
> >+
> > 	journal = transaction->t_journal;
> > 	tid = transaction->t_tid;
> > 
> >-- 
> >2.39.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


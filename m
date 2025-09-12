Return-Path: <linux-ext4+bounces-9947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE92B55216
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 16:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6D7189707F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DF30C375;
	Fri, 12 Sep 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILAWYJjI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWoixnuR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILAWYJjI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWoixnuR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB4309DDF
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688184; cv=none; b=Ep2TtXTX7/H08EgTsaSJm7q64wtkvdhVrbGGM2XADZu+Ymf57+iwD+klrEa8KFJ/aWL8DyNDOyRLhm6Z/EjifznRI72SsIe/WARbpWfbDpSvewGRP6WlImZtDS5r0QxTo8ICY3qbVMwug06KUiYitCiUzw7kK1Xq8XHdnwCh4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688184; c=relaxed/simple;
	bh=fgjwi1Jk2nmqZHKLu6RmiHdGOLVRuWwA7YOjxReIty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO41PXD3bFl42U9mqm4oejlddcjNCHev0N4CdWA31H/tOFZF8t/AyRkyzcyHm/KuQFbXh/p+QMkpTndBNOk8pCGZoAJlJto5jetl8vg3v5cdr6rLdwdNg2ImxVFUdefseV4Q/5u3fybnc5wIQ2/iDtFOXpz+8DZS/5Lwmsew5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILAWYJjI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWoixnuR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILAWYJjI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWoixnuR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63B445D373;
	Fri, 12 Sep 2025 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757688180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/KUPbtA7DT9FTXkpoit3U4LXdKtDghgRcnx8nMHsg=;
	b=ILAWYJjIsZqOL3RVedupu0piAhiL3yNh4JNL+iIagGeQSj/zLc5gnTVqRRHz/Ovz6Pw4g7
	fQEgzYgujeDT/X37V5RLe/o36o0DkuWoHdMnSJOCmGqeWVuE8Oj6UDNZvB2zfjizEFwRbv
	u4gv6hCRuM+pqVhiKz5I41f0DjTwHBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757688180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/KUPbtA7DT9FTXkpoit3U4LXdKtDghgRcnx8nMHsg=;
	b=lWoixnuRfXt0sqWlBgAXtYS2leQ9Yyqw+H2QV2ofPkHEf+1LaWSfUD+sGu2vRJ6tzmeIBw
	/mz4Rp0p2iN0vtAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ILAWYJjI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lWoixnuR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757688180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/KUPbtA7DT9FTXkpoit3U4LXdKtDghgRcnx8nMHsg=;
	b=ILAWYJjIsZqOL3RVedupu0piAhiL3yNh4JNL+iIagGeQSj/zLc5gnTVqRRHz/Ovz6Pw4g7
	fQEgzYgujeDT/X37V5RLe/o36o0DkuWoHdMnSJOCmGqeWVuE8Oj6UDNZvB2zfjizEFwRbv
	u4gv6hCRuM+pqVhiKz5I41f0DjTwHBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757688180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/KUPbtA7DT9FTXkpoit3U4LXdKtDghgRcnx8nMHsg=;
	b=lWoixnuRfXt0sqWlBgAXtYS2leQ9Yyqw+H2QV2ofPkHEf+1LaWSfUD+sGu2vRJ6tzmeIBw
	/mz4Rp0p2iN0vtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 503D013869;
	Fri, 12 Sep 2025 14:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bi9PE3QxxGh/KQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 14:43:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C286AA0993; Fri, 12 Sep 2025 16:42:51 +0200 (CEST)
Date: Fri, 12 Sep 2025 16:42:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>, 
	"Li,Baokun" <libaokun1@huawei.com>, hsiangkao@linux.alibaba.com, yangerkun <yangerkun@huawei.com>
Subject: Re: BUG report: an ext4 data corruption issue in nojournal mode
Message-ID: <4uv5ybqymydldxobeiwo2hnbvmoby3fo63rcrl6troy2sefycg@5el5wr6ajjyl>
References: <a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 63B445D373
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

Hello!

On Fri 12-09-25 11:28:13, Zhang Yi wrote:
> Gao Xiang recently discovered a data corruption issue in **nojournal**
> mode. After analysis, we found that the problem is after a metadata
> block is freed, it can be immediately reallocated as a data block.
> However, the metadata on this block may still be in the process of being
> written back, which means the new data in this block could potentially
> be overwritten by the stale metadata.
> 
> When releasing a metadata block, ext4_forget() calls bforget() in
> nojournal mode, which clears the dirty flag on the buffer_head. If the
> metadata has not yet started to be written back at this point, there is
> no issue. However, if the write-back has already begun but the I/O has
> not yet completed, ext4_forget() will have no effect, and the subsequent
> ext4_mb_clear_bb() will immediately return the block to the mb
> allocator. This block can then be immediately reallocated, potentially
> triggering a data loss issue.

Yes, I agree this can be a problem.

> This issue is somewhat related to this patch set[1] that have been
> merged. Before this patch set, clean_bdev_aliases() and
> clean_bdev_bh_alias() could ensure that the dirty flag of the block
> device buffer was cleared and the write-back was completed before using
> newly allocated blocks in most cases. However, this patch set have fixed
> a similar issues in journal mode and removed this safeguard because it's
> fragile and misses some corner cases[2], increasing the likelihood of
> triggering this issue.

Right.

> Furthermore, I found that this issue theoretically still appears to
> persist even in **ordered** journal mode. In the final else branch of
> jbd2_journal_forget(), if the metadata block to be released is also
> undergoing a write-back, jbd2_journal_forget() will add this buffer to
> the current transaction for forgetting. Once the current transaction is
> committed, the block can then be reallocated. However, there is no
> guarantee that the ongoing I/O will complete. Typically, the undergoing
> metadata writeback I/O does not take this long to complete, but it might
> be throttled by the block layer or delayed due to anomalies in some slow
> I/O processes in the underlying devices. Therefore, although it is
> difficult to trigger, it theoretically still exists.

I don't think this can actually happen. For writeback to be happening on a
buffer it still has to be part of a checkpoint list of some transaction.
That means we'll call jbd2_journal_try_remove_checkpoint() which will lock
the buffer and that's enough to make sure the buffer writeback has either
completed or not yet started. If I missed some case, please tell me.

> Consider the fix for now. In the **ordered** journal mode, I suppose we
> can add a wait_on_buffer() during the process of the freed buffer in
> jbd2_journal_commit_transaction(). This should not significantly impact
> performance. In **nojorunal** mode, I do not want to reintroduce
> clean_bdev_aliases(). One approach is to add wait_on_buffer() in
> __ext4_forget(), but I am concerned that this might impact performance.
> However, it seems reasonable to wait for ongoing I/O to complete before
> freeing the buffer.

I agree calling wait_on_buffer() before calling __bforget() is the best fix
for the problem in nojournal mode. Yes, it can slow down some cases where
we free metadata blocks that we recently modified but I think it should be
relatively rare.

> Otherwise, another solution is we may need to
> implement an asynchronous release process that returns the block to the
> buddy system only after the I/O operation has completed. However, since
> the write-back is triggered by bdev, it appears to be hard to implement
> this solution now. What do people think?

Yes, that will get rather complicated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-ext4+bounces-10028-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B3B5774F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F83B0935
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC32FD1CB;
	Mon, 15 Sep 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fVVA4jHV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmWCiGuF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGJBgYbT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q+3M6Duf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF52FD7A0
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933779; cv=none; b=qqVC0je3cjS7jCHPzC1wQBqDwmeuB8cSkA2WXWjo6RjioCv357JINvWvZI1/Sh0YBlfSxnB2CrVpJg72yR1RCqA/83s16gjm09ENSGwyzzPKKgaGajFXnejqtwHfnMB00IwSp3Cj9jExY6njclU4gnyLu0YWlIGkC7rT3i2qeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933779; c=relaxed/simple;
	bh=xy+e9HBJ1prMCtIuGWwcrTuSJmSPJ2eiWX2K2g6uCeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boHEZzUrNycpv6kgCUACezuajOqXyxZk7rUthWsCLMmaMyYADWLDq4cpH8g8oeLF4eBPuDABZLODniUjT9gv5smo7ke/I5PpfGof4guctClvAAZfYlR0VHnueyB2F+NWU5dZrZXd5HLEBlm3tgTXptd4NhZQ5Wj8yAm63EU/IX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fVVA4jHV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmWCiGuF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGJBgYbT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q+3M6Duf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFE5322097;
	Mon, 15 Sep 2025 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757933774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D58eNxLaFQN5ZVhb1wYBHHwSqbro3Lu/us9CAaWoLV8=;
	b=fVVA4jHV3NTZ/JXtJ/iePpPkvbgrzllvjMHY1jmk6TqO8MXE5RHWrBjZ9P0IVNK3IjBa93
	wzjN/vKS+D5JLbNPlvhA1WEujfeMjW6nJdep3EEHIOypycJtz1/HjJ93x6AKQ4/HrcQ8dO
	qVrs4up+S+A8vKv1dv4RnsIQKYT7UBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757933774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D58eNxLaFQN5ZVhb1wYBHHwSqbro3Lu/us9CAaWoLV8=;
	b=nmWCiGuFLPpFhC0D6g/W10d0xjwQzBNCZdjU5HlYeSCi2Q0lB3b7bRb0R4nKMDAM2N7ppc
	hOovTH8QhrvLF5Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MGJBgYbT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=q+3M6Duf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757933773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D58eNxLaFQN5ZVhb1wYBHHwSqbro3Lu/us9CAaWoLV8=;
	b=MGJBgYbTepbQ0bmHoDyIpj7dklBFM9YhwaaF00zf5DWF4wNjCRODAKwSFEfi8YDJxyMPPx
	YKwm84P6HdKw7qizTZ/lG72hnu7rcaG2FrPxJBl7/CHdyMhLOQm9F1QITxgJtxhL0rx/P4
	ZmQDSev4F78q6LzkU1ljVvd59uy33n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757933773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D58eNxLaFQN5ZVhb1wYBHHwSqbro3Lu/us9CAaWoLV8=;
	b=q+3M6DufWJGbqW52tWtjGCMbRMgf7H3G1iZ/CW1LkQVHVmPGk2MkMm21M0eZtoitISyqtL
	mzN9IVfu6RRz4PDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C314D1372E;
	Mon, 15 Sep 2025 10:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YviYL83wx2j1GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 10:56:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89807A09B1; Mon, 15 Sep 2025 12:56:09 +0200 (CEST)
Date: Mon, 15 Sep 2025 12:56:09 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>, 
	"Li,Baokun" <libaokun1@huawei.com>, hsiangkao@linux.alibaba.com, yangerkun <yangerkun@huawei.com>
Subject: Re: BUG report: an ext4 data corruption issue in nojournal mode
Message-ID: <mugnb73mvlvclccatavdd2rwczz3wl3gs7rh4kwcnejkdh4t6b@na743yuuidlj>
References: <a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com>
 <4uv5ybqymydldxobeiwo2hnbvmoby3fo63rcrl6troy2sefycg@5el5wr6ajjyl>
 <7b0ccbbc-edc1-4123-94b9-fa19f79ea968@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0ccbbc-edc1-4123-94b9-fa19f79ea968@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CFE5322097
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Sat 13-09-25 11:36:27, Zhang Yi wrote:
> On 9/12/2025 10:42 PM, Jan Kara wrote:
> > Hello!
> > 
> > On Fri 12-09-25 11:28:13, Zhang Yi wrote:
> >> Gao Xiang recently discovered a data corruption issue in **nojournal**
> >> mode. After analysis, we found that the problem is after a metadata
> >> block is freed, it can be immediately reallocated as a data block.
> >> However, the metadata on this block may still be in the process of being
> >> written back, which means the new data in this block could potentially
> >> be overwritten by the stale metadata.
> >>
> >> When releasing a metadata block, ext4_forget() calls bforget() in
> >> nojournal mode, which clears the dirty flag on the buffer_head. If the
> >> metadata has not yet started to be written back at this point, there is
> >> no issue. However, if the write-back has already begun but the I/O has
> >> not yet completed, ext4_forget() will have no effect, and the subsequent
> >> ext4_mb_clear_bb() will immediately return the block to the mb
> >> allocator. This block can then be immediately reallocated, potentially
> >> triggering a data loss issue.
> > 
> > Yes, I agree this can be a problem.
> > 
> >> This issue is somewhat related to this patch set[1] that have been
> >> merged. Before this patch set, clean_bdev_aliases() and
> >> clean_bdev_bh_alias() could ensure that the dirty flag of the block
> >> device buffer was cleared and the write-back was completed before using
> >> newly allocated blocks in most cases. However, this patch set have fixed
> >> a similar issues in journal mode and removed this safeguard because it's
> >> fragile and misses some corner cases[2], increasing the likelihood of
> >> triggering this issue.
> > 
> > Right.
> > 
> >> Furthermore, I found that this issue theoretically still appears to
> >> persist even in **ordered** journal mode. In the final else branch of
> >> jbd2_journal_forget(), if the metadata block to be released is also
> >> undergoing a write-back, jbd2_journal_forget() will add this buffer to
> >> the current transaction for forgetting. Once the current transaction is
> >> committed, the block can then be reallocated. However, there is no
> >> guarantee that the ongoing I/O will complete. Typically, the undergoing
> >> metadata writeback I/O does not take this long to complete, but it might
> >> be throttled by the block layer or delayed due to anomalies in some slow
> >> I/O processes in the underlying devices. Therefore, although it is
> >> difficult to trigger, it theoretically still exists.
> > 
> > I don't think this can actually happen. For writeback to be happening on a
> > buffer it still has to be part of a checkpoint list of some transaction.
> > That means we'll call jbd2_journal_try_remove_checkpoint() which will lock
> > the buffer and that's enough to make sure the buffer writeback has either
> > completed or not yet started. If I missed some case, please tell me.
> > 
> 
> Yes, jbd2_journal_try_remove_checkpoint() does lock the buffer and check
> the buffer's dirty status under the buffer lock. However. First, it returns
> immediately if the buffer is locked by the write-back process, which means
> that it does not wait the write-back to complete, thus, until the current
> transaction is committed, there is still no guarantee that the I/O will be
> completed.

Right, it will return with EBUSY for a buffer under IO, file the buffer to
BJ_forget list of the running transaction and in principle we're not
guaranteed IO completes before that transaction commits (although in
practice that's always true).

> Second, it unlocks the buffer once it finds the buffer is still
> dirty, if a concurrent write-back happens just after this unlocking and
> before clear_buffer_dirty() in jbd2_journal_forget(), the issue can still
> theoretically happen, right?

Hum, that as well.

> It seems that only the follow changes can make sure the buffer writeback has
> either completed or not yet started (and will never start again). What do
> you think?
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index c7867139af69..e4691e445106 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1772,23 +1772,26 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  			goto drop;
>  		}
> 
> -		/*
> -		 * Otherwise, if the buffer has been written to disk,
> -		 * it is safe to remove the checkpoint and drop it.
> -		 */
> -		if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
> -			spin_unlock(&journal->j_list_lock);
> -			goto drop;
> +		lock_buffer(bh);

We hold j_list_lock and b_state_lock here so you cannot lock the buffer...
I think we rather need something like:

                /*
                 * Otherwise, if the buffer has been written to disk,
                 * it is safe to remove the checkpoint and drop it.
                 */     
                if (jbd2_journal_try_remove_checkpoint(jh) >= 0) {
                        spin_unlock(&journal->j_list_lock);
                        goto drop;
                }

                /*
                 * The buffer is still not written to disk, we should
                 * attach this buffer to current transaction so that the
                 * buffer can be checkpointed only after the current
                 * transaction commits.
                 */
                clear_buffer_dirty(bh);
+		wait_for_writeback = 1;
		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
		spin_unlock(&journal->j_list_lock);
	}
drop:
	__brelse(bh);
	spin_unlock(&jh->b_state_lock);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
	jbd2_journal_put_journal_head(jh);
	if (drop_reserve) {
...

								Honza

> +		if (!buffer_dirty(bh)) {
> +			/*
> +			 * If the buffer has been written to disk, it is safe
> +			 * to remove the checkpoint and drop it.
> +			 */
> +			unlock_buffer(bh);
> +			JBUFFER_TRACE(jh, "remove from checkpoint list");
> +			__jbd2_journal_remove_checkpoint(jh);
> +		} else {
> +			/*
> +			 * Otherwise, the buffer is still not written to disk,
> +			 * we should attach this buffer to current transaction
> +			 * so that the buffer can be checkpointed only after
> +			 * the current transaction commits.
> +			 */
> +			clear_buffer_dirty(bh);
> +			unlock_buffer(bh);
> +			__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
>  		}
> -
> -		/*
> -		 * The buffer is still not written to disk, we should
> -		 * attach this buffer to current transaction so that the
> -		 * buffer can be checkpointed only after the current
> -		 * transaction commits.
> -		 */
> -		clear_buffer_dirty(bh);
> -		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
>  		spin_unlock(&journal->j_list_lock);
>  	}
>  drop:
> 
> 
> >> Consider the fix for now. In the **ordered** journal mode, I suppose we
> >> can add a wait_on_buffer() during the process of the freed buffer in
> >> jbd2_journal_commit_transaction(). This should not significantly impact
> >> performance. In **nojorunal** mode, I do not want to reintroduce
> >> clean_bdev_aliases(). One approach is to add wait_on_buffer() in
> >> __ext4_forget(), but I am concerned that this might impact performance.
> >> However, it seems reasonable to wait for ongoing I/O to complete before
> >> freeing the buffer.
> > 
> > I agree calling wait_on_buffer() before calling __bforget() is the best fix
> > for the problem in nojournal mode. Yes, it can slow down some cases where
> > we free metadata blocks that we recently modified but I think it should be
> > relatively rare.
> > 
> 
> Sure, I will fix it in this way.
> 
> Thanks,
> Yi.
> 
> >> Otherwise, another solution is we may need to
> >> implement an asynchronous release process that returns the block to the
> >> buddy system only after the I/O operation has completed. However, since
> >> the write-back is triggered by bdev, it appears to be hard to implement
> >> this solution now. What do people think?
> > 
> > Yes, that will get rather complicated.
> > 
> > 								Honza
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


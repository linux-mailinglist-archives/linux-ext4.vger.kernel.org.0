Return-Path: <linux-ext4+bounces-3657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E794A779
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C96282F92
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140D41E4EFC;
	Wed,  7 Aug 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJUmkm8s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eATYcvU7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJUmkm8s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eATYcvU7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE351CCB45;
	Wed,  7 Aug 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032423; cv=none; b=Z0yx4780M54GSsdXzKB99J/9BMCZk8uqEVcWyBUJMjmk+ZtIaQW6FCzDrLUkq3dRotvSpk4ItdvnpU/a45eEizzQr25l2BMv+hHBX0qWYYgkDmkWZhje3eqZRxPyAGEbf9fEpWOxlknfnAZQfW9yAmovSfCUwI3Y02RZbXpZ/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032423; c=relaxed/simple;
	bh=zCmGxEF9APvuWPStRnQnRubsZDU1Z5O+oDdBxoS0J5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8TIA/EDubXsRdWj9fUbH0zsZbSWXTdsK2svL7kn5llJQBFxYyIKb5C+YdM6D3kChhF+w7pUoqRIXvCfbaAFqNqj24MANhVjJDn0378UnRHlAijD/zP/IcamrqIoN5MFTdoQbScD+53UsAHpZKxhyBj+Lz8gcDs6WBT+sa2Us04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJUmkm8s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eATYcvU7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJUmkm8s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eATYcvU7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4C921FB58;
	Wed,  7 Aug 2024 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723032419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuGXUxtgZtj5IURkHUs6oGBXp2vpCl0BA9ouew+bgtI=;
	b=BJUmkm8sK9cH1tQ0FPAUIzoWt4MQKw5cDwDWTuV06vLDdViFL3ttpY4ZpNoNZuDRU7psCj
	yJ3bpqoX71+w4VBsDiHoi5JvZZ0A6ZhAoeQ7zwxX3M319axL9lHYuZxwKd6Sz+MVA3RL9S
	+OAdOuTvuacMyVhhW2baSK+Kev6Onx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723032419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuGXUxtgZtj5IURkHUs6oGBXp2vpCl0BA9ouew+bgtI=;
	b=eATYcvU7oSDXtbbieMjspz5W125CBuLzHey/XxPCkDU0fe1GPS/bjEDM8kHNErtYJvGQFM
	fP36a/iXajaPCkBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BJUmkm8s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eATYcvU7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723032419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuGXUxtgZtj5IURkHUs6oGBXp2vpCl0BA9ouew+bgtI=;
	b=BJUmkm8sK9cH1tQ0FPAUIzoWt4MQKw5cDwDWTuV06vLDdViFL3ttpY4ZpNoNZuDRU7psCj
	yJ3bpqoX71+w4VBsDiHoi5JvZZ0A6ZhAoeQ7zwxX3M319axL9lHYuZxwKd6Sz+MVA3RL9S
	+OAdOuTvuacMyVhhW2baSK+Kev6Onx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723032419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuGXUxtgZtj5IURkHUs6oGBXp2vpCl0BA9ouew+bgtI=;
	b=eATYcvU7oSDXtbbieMjspz5W125CBuLzHey/XxPCkDU0fe1GPS/bjEDM8kHNErtYJvGQFM
	fP36a/iXajaPCkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A686B13A7D;
	Wed,  7 Aug 2024 12:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uWyjKGNjs2Z4OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 12:06:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51B93A0762; Wed,  7 Aug 2024 14:06:59 +0200 (CEST)
Date: Wed, 7 Aug 2024 14:06:59 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [RFC PATCH] jbd2: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240807120659.y6cpxas5g3mze2rr@quack3>
References: <20240720062356.2522658-1-zhangshida@kylinos.cn>
 <20240806134023.rm2ggd7swopryqci@quack3>
 <CANubcdV32L71ARCznZgKdrt0BmSyOYwW50L17zP=TG4PO2MH4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdV32L71ARCznZgKdrt0BmSyOYwW50L17zP=TG4PO2MH4Q@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B4C921FB58
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 07-08-24 16:10:50, Stephen Zhang wrote:
> Jan Kara <jack@suse.cz> 于2024年8月6日周二 21:40写道：
> > On Sat 20-07-24 14:23:56, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > On an old kernel version(4.19, ext3, journal=data, pagesize=64k),
> > > an assertion failure will occasionally be triggered by the line below:
> >
> > OK, just out of curiosity, why are you using data=journal mode? It doesn't
> > really get that much testing and the performance is quite bad...
> >
> 
> It is used by one of our customers. It's more like a historical issue:
> About 12 years ago, they used data=journal mode for the benefit of user
> data consistency brought by the mode.
> Time goes by, they attempted to change, say, maybe change it to ext4
> at least, but found it is no more stable than it was under ext3...
> And yeah, they decided to just leave the thing as it was and keep the system
> under that state until now...

I see, thanks for sharing. I was asking because we are mostly trying to
steer away people from using data=journal mode and deprecate it because it
adds a lot of complexity into the code without significant benefit.

> > > jbd2_journal_commit_transaction
> > > {
> > > ...
> > > J_ASSERT_BH(bh, !buffer_dirty(bh));
> > > /*
> > > * The buffer on BJ_Forget list and not jbddirty means
> > > ...
> > > }
> > >
> > > AFAIC, that's how the problem works:
> > > --------
> > > journal_unmap_buffer
> > > jbd2_journal_invalidatepage
> > > __ext4_journalled_invalidatepage
> > > ext4_journalled_invalidatepage
> > > do_invalidatepage
> > > truncate_inode_pages_range
> > > truncate_inode_pages
> > > truncate_pagecache
> > > ext4_setattr
> > > --------
> > >
> > > First try to truncate and invalidate the page.
> > > Sometimes the buffer and the page won't be freed immediately.
> > > the buffer will be sent to the BJ_Forget list of the currently
> > > committing transaction. Maybe the transaction knows when and how
> > > to free the buffer better.
> > > The buffer's states now: !jbd_dirty !mapped !dirty
> > >
> > > Then jbd2_journal_commit_transaction(）will try to iterate over the
> > > BJ_Forget list:
> > > --------
> > > jbd2_journal_commit_transaction()
> > >       while (commit_transaction->t_forget) {
> > >       ...
> > >       }
> > > --------
> > >
> > > At this exact moment, another write comes:
> > > --------
> > > mark_buffer_dirty
> > > __block_write_begin_int
> > > __block_write_begin
> > > ext4_write_begin
> > > --------
> > > it sees a unmapped new buffer, and marks it as dirty.
> >
> > This should not happen. When ext4_setattr() truncates the file, we do not
> > allow reallocating these blocks for other purposes until the transaction
> 
> ext4_setattr() will try to free it by adding it to the BJ_Forget list
> for further processing.
> Put it more clearly,
> when ext4_setattr() truncates the file, the buffer is not fully freed
> yet. It's half-freed.
> Furthermore,
> Because the buffer is half-freed, the reallocating thing won't need to happen.
> Now,
> under that scenario, can we redirty the half-freed buffer on the BJ_Forget list?
> The answer may be 'yes'.
> 
> redirty it by the following code:
> ext4_block_write_begin
>     if (!buffer_mapped(bh)) { // check 1
>          _ext4_get_block(inode, block, bh, 1);
>         (buffer_new(bh)) { // check 2
>              if (folio_test_uptodate(folio)) { // check 3
>                  mark_buffer_dirty(bh);

<snip>

I see, right. It is not that the block would get reused. It is just that
the buffer_head on the file's tail page gets reused and this causes issues.
In fact, the problem is with ext4_block_write_begin() (and
__block_write_begin_int()) that they call mark_buffer_dirty() on a
journalled buffer before calling jbd2_journal_get_write_access() (which
would remove the buffer from BJ_Forget list). This is what ultimately
confuses the commit code.

> For another proof, there is indeed a small window where the buffer could be
> seen dirty.
> Have a look at the code and comment in do_journal_get_write_access:
> ----------------
> int do_journal_get_write_access(handle_t *handle, struct inode *inode,
> struct buffer_head *bh)
> {
> ...
> /*
> * __block_write_begin() could have dirtied some buffers. Clean
> * the dirty bit as jbd2_journal_get_write_access() could complain
> * otherwise about fs integrity issues. Setting of the dirty bit
> * by __block_write_begin() isn't a real problem here as we clear
> * the bit before releasing a page lock and thus writeback cannot
> * ever write the buffer.
> */
> if (dirty)
> clear_buffer_dirty(bh); // clear the dirty immdiately in case some bad
> things happen

OK, it was even me adding that comment 14 years ago ;) I already forgot
about this nuance.

So I agree with your analysis now. But still don't like adding hacks to
jbd2 to acommodate for this oddity of data=journal mode. Since we already
have ext4_block_write_begin() implementation anyway, we should be able to
tweak it to do the right thing for data=journal mode inodes...

So we could replace uses of __block_write_begin() with
ext4_block_write_begin() and then call do_journal_get_write_access() in
ext4_block_write_begin() for inodes with journalled data after the buffer
is mapped with get_block().

From the part:
                                if (folio_test_uptodate(folio)) {
                                        clear_buffer_new(bh);
                                        set_buffer_uptodate(bh);
                                        mark_buffer_dirty(bh);
                                        continue;
                                }

we can actually remove the clear_buffer_new() and mark_buffer_dirty() bits
because they will be done by block_commit_write() or
folio_zero_new_buffers() and they are superfluous and somewhat odd here
anyway.

And the call to folio_zero_new_buffers() from ext4_block_write_begin()
needs to call ext4_journalled_zero_new_buffers() for inodes where data is
journalled.

Will you try to implement this or should I look into it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


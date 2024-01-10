Return-Path: <linux-ext4+bounces-765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E309F8299EA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E441C25A6D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEB47F53;
	Wed, 10 Jan 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PdctFr7A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="177XBxxh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PdctFr7A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="177XBxxh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2038DED
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44DF91F850;
	Wed, 10 Jan 2024 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704887838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehHhy6dmtbfwXhKH8cGs/+Owsr6gQAUQcWp03i1Gj0=;
	b=PdctFr7A0dywIsZzchMO3xs63wcGKOX+C+2B69U+lHVwIRNBEEgiAk4hG6P0hfJHScJxr0
	L4/FVwnTAgx9OaxmBtKEcQ2/3OyWWG/gi7zTE+BBWjqdd9NoHO0EFRzEG6ncXKrtzcYFHY
	mfSyytu2X2soEfW5B4TzIUgXOQzZ5wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704887838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehHhy6dmtbfwXhKH8cGs/+Owsr6gQAUQcWp03i1Gj0=;
	b=177XBxxh2A2J9tVzyogi5O1df82JHDifxjU8sH7OH9AebW3rx4hb76grJfjV/sQ4URnqxI
	lBEcWayE3W6y6xDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704887838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehHhy6dmtbfwXhKH8cGs/+Owsr6gQAUQcWp03i1Gj0=;
	b=PdctFr7A0dywIsZzchMO3xs63wcGKOX+C+2B69U+lHVwIRNBEEgiAk4hG6P0hfJHScJxr0
	L4/FVwnTAgx9OaxmBtKEcQ2/3OyWWG/gi7zTE+BBWjqdd9NoHO0EFRzEG6ncXKrtzcYFHY
	mfSyytu2X2soEfW5B4TzIUgXOQzZ5wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704887838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehHhy6dmtbfwXhKH8cGs/+Owsr6gQAUQcWp03i1Gj0=;
	b=177XBxxh2A2J9tVzyogi5O1df82JHDifxjU8sH7OH9AebW3rx4hb76grJfjV/sQ4URnqxI
	lBEcWayE3W6y6xDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383F61398A;
	Wed, 10 Jan 2024 11:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p0W0DR6GnmX7CAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 11:57:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D03A6A07EB; Wed, 10 Jan 2024 12:57:17 +0100 (CET)
Date: Wed, 10 Jan 2024 12:57:17 +0100
From: Jan Kara <jack@suse.cz>
To: Free Ekanayaka <free.ekanayaka@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
Message-ID: <20240110115717.sn5yuyjuwaixs5ra@quack3>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
 <20240108213112.m3f5djzesbvrc3rd@quack3>
 <87a5peo6g0.fsf@x1.mail-host-address-is-not-set>
 <20240110100148.v2vd63zb4gl3rmlf@quack3>
 <87y1cx306p.fsf@x1.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1cx306p.fsf@x1.mail-host-address-is-not-set>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.81
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44DF91F850
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PdctFr7A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=177XBxxh

On Wed 10-01-24 11:19:42, Free Ekanayaka wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> [...]
> 
> >> I've re-ran the same code with kernel 6.5.0 and indeed the behavior has
> >> changed and an actual NVMe flush command seems to be issued (the flags
> >> passed to nvme_setup_cmd match the ones that I see in the case I write
> >> to the raw block device). So that part seems fixed. I thought I had
> >> tried with 6.5.1 when I had posted this issue, and that it was present
> >> there too, but maybe I was mistaken.
> >> 
> >> I'm not entirely sure what you mean about flushing the inode buffer
> >> properly. As far as I see, the current behavior I see matches what I'd
> >> expect.
> >
> > The thing is: fallocate(2) does preallocate blocks to the file so
> > block allocation is not needed when writing to those blocks. However that
> > does not mean metadata changes are not needed when writing to those blocks.
> > In case of ext4 (and other filesystems such as xfs or btrfs as well) blocks
> > allocated using fallocate(2) are tracked as unwritten in inode's metadata (so
> > reads from them return 0 instead of random garbage). After block contents
> > is written with iouring write, we need to convert the state of blocks from
> > unwritten to written and that needs metadata modifications. So the first
> > write to the file after fallocate(2) call still needs to do metadata
> > modifications and these need to be persisted as part of fdatasync(2). And
> > by mistake this did not happen in nojournal mode.
> 
> Thanks for the explanation.
> 
> Since I want to achieve the lowest possible latency for these writes, is
> there a way to not onlly preallocate blocks with fallocate() but also to
> avoid the extra write for metadata modifications that you mention?
> 
> I mean, I could of course take the brute force approach of performing
> dump "pre" writes of those blocks, but I'm wondering if there's a better
> way that doesn't require writing those blocks twice (which might end up
> defeating the purpose of lowering overall latency).

No, if you really want to make sure there will be no metadata modifications
while writing to a file, writing 0's (or whatever you wish) to it is the
only way.

> >> For reference I'm attaching below the trace of the same user code, this
> >> time run on kernel 6.5.0, which is the one currently shipping with
> >> Debian/testing. Note that there are quite a bit less trace lines emitted
> >> by the ext4 sub-system, not sure if it's related/relevant.
> >> 
> >>   raft-benchmark-35708   [000] .....  9203.271114: io_uring_submit_req: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
> >>   raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
> >>   raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
> >>   raft-benchmark-35708   [000] .....  9203.271118: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 16, caller ext4_dirty_inode+0x38/0x80 [ext4]
> >>   raft-benchmark-35708   [000] .....  9203.271119: ext4_mark_inode_dirty: dev 259,5 ino 16 caller ext4_dirty_inode+0x5b/0x80 [ext4]
> >>   raft-benchmark-35708   [000] .....  9203.271119: block_touch_buffer: 259,5 sector=135 size=4096
> >>   raft-benchmark-35708   [000] .....  9203.271120: block_dirty_buffer: 259,5 sector=135 size=4096
> >>   raft-benchmark-35708   [000] .....  9203.271120: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
> >>   raft-benchmark-35708   [000] .....  9203.271121: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
> >>   raft-benchmark-35708   [000] .....  9203.271122: block_bio_remap: 259,0 WFS 498455552 + 8 <- (259,5) 263168
> >>   raft-benchmark-35708   [000] .....  9203.271122: block_bio_queue: 259,0 WFS 498455552 + 8 [raft-benchmark]
> >>   raft-benchmark-35708   [000] .....  9203.271123: block_getrq: 259,0 WFS 498455552 + 8 [raft-benchmark]
> >>   raft-benchmark-35708   [000] .....  9203.271123: block_io_start: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
> >>   raft-benchmark-35708   [000] .....  9203.271124: block_plug: [raft-benchmark]
> >>   raft-benchmark-35708   [000] .....  9203.271124: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=53265, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455552, len=7, ctrl=0x4000, dsmgmt=0, reftag=0)
> >>   raft-benchmark-35708   [000] .....  9203.271126: block_rq_issue: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
> >>   raft-benchmark-35708   [000] d.h..  9203.271382: nvme_sq: nvme0: disk=nvme0n1, qid=1, head=79, tail=79
> >>   raft-benchmark-35708   [000] d.h..  9203.271384: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=53265, res=0x0, retries=0, flags=0x0, status=0x0
> >>   raft-benchmark-35708   [000] d.h..  9203.271384: block_rq_complete: 259,0 WFS () 498455552 + 8 [0]
> >>   raft-benchmark-35708   [000] dNh..  9203.271386: block_io_done: 259,0 WFS 0 () 498455552 + 0 [raft-benchmark]
> >>   raft-benchmark-35708   [000] ...1.  9203.271391: io_uring_complete: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, result 4096, cflags 0x0 extra1 0 extra2 0 
> >>   raft-benchmark-35708   [000] .....  9203.271391: io_uring_task_work_run: tctx 00000000f15587dc, count 1, loops 1
> >
> > So in this case the file blocks seem to have been already written.
> 
> Do you mean that they have been already written at some point in the
> past after the file system was created?

No, I mean this particular file offset has already been written to since
the file was created. The line:

raft-benchmark-35708   [000] .....  9203.271121: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR

at the end has 'WR' which is the status of the found extent (contiguous
sequence of blocks) and 'WR' means 'written' and 'referenced'.

> I guess it doesn't matter if they were written as part of the new file
> that is being written (and that was created with open()/fallocate()), or
> if they were written before as part of some other file that was deleted
> since then.

No, the block must have been written when it was already part of this file.
The block being written is tracked on logical-file-offset basis and this
tracking is there exactly so that you cannot read some stale data
(potentially sensitive data of another user) after fallocating some blocks
to the file.

I understand this protection need not be that interesting for your usecase
and in nojournal mode you still may potentially see such stale data but
there's a big difference between possibly seeing such data only after a
crash and giving user a way to read such data at will.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


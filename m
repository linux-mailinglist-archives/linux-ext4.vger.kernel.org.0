Return-Path: <linux-ext4+bounces-738-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C086827A37
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jan 2024 22:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898141F2376F
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jan 2024 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC85644E;
	Mon,  8 Jan 2024 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8F8KRL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJBZ029H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8F8KRL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJBZ029H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EB56442
	for <linux-ext4@vger.kernel.org>; Mon,  8 Jan 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 996012200C;
	Mon,  8 Jan 2024 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704749472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPgthVW6k+88BbFi5LdXqOrvxpkhDdhLYU55D8nqJ+o=;
	b=k8F8KRL7ngGZywW6u8ewPlxUwWyN+KDjFEMTgLcCknLbzdNaz5uU9h5h/Kmo8Kw0+eGDiT
	TfLq/aO/JqV8vGbpsRedTSPXXjqYWdze4M9fDHHRaACY2ovcMyrE/MjymDrFXxYkg+lcXb
	X+JNhz1/kSq2wim+oxitTj65tJecx2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704749472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPgthVW6k+88BbFi5LdXqOrvxpkhDdhLYU55D8nqJ+o=;
	b=wJBZ029HKJjVFYTDwTmgErufuThhtS2osXlbUluvN1i0ZEkppo+fzlS9Rx777X7DS3Fysz
	aABR8UhfYvArBCAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704749472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPgthVW6k+88BbFi5LdXqOrvxpkhDdhLYU55D8nqJ+o=;
	b=k8F8KRL7ngGZywW6u8ewPlxUwWyN+KDjFEMTgLcCknLbzdNaz5uU9h5h/Kmo8Kw0+eGDiT
	TfLq/aO/JqV8vGbpsRedTSPXXjqYWdze4M9fDHHRaACY2ovcMyrE/MjymDrFXxYkg+lcXb
	X+JNhz1/kSq2wim+oxitTj65tJecx2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704749472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pPgthVW6k+88BbFi5LdXqOrvxpkhDdhLYU55D8nqJ+o=;
	b=wJBZ029HKJjVFYTDwTmgErufuThhtS2osXlbUluvN1i0ZEkppo+fzlS9Rx777X7DS3Fysz
	aABR8UhfYvArBCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88F0A13686;
	Mon,  8 Jan 2024 21:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sShsIaBpnGWgcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jan 2024 21:31:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2896AA07EB; Mon,  8 Jan 2024 22:31:12 +0100 (CET)
Date: Mon, 8 Jan 2024 22:31:12 +0100
From: Jan Kara <jack@suse.cz>
To: Free Ekanayaka <free.ekanayaka@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
Message-ID: <20240108213112.m3f5djzesbvrc3rd@quack3>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hello,

I've found this when going through some old email. Were you able to debug
this?

On Wed 06-09-23 21:15:01, Free Ekanayaka wrote:
> I'm using Linux 6.4.0 from Debian/testing (but tried this with 6.5.1
> too).
> 
> I've created an ext4 filesystem with journalling disabled on an NVMe
> drive:
> 
> mkfs.ext4 -O ^has_journal -F /dev/nvme0n1p6
> 
> I have a program that creates and open a new file with O_DIRECT, and
> sets its size to 8M with posix_fallocate(), something like:
> 
> fd = open("/dir/file", O_CREAT | O_WRONLY | O_DIRECT);
> posix_fallocate(fd, 0, 8 * 1024 * 1024);
> fsync(fd);
> dirfd = open("/dir", O_RDONLY | O_DIRECTORY);
> fsync(dirfd);
> 
> and then it uses io_uring to perform a single write of 4096 bytes at the
> beginning of the file, passing RWF_DSYNC to the submitted
> IORING_OP_WRITE_FIXED entry,
> 
> I would expect the kernel to tell the NVMe device to actually flush the
> write, not only buffer it. However I measured the end-to-end latency of
> the io_uring operation and it was very low, as if the write was only
> buffered by the NVMe device, but not flushed.

Yes, the kernel should issue device cache flush or mark the IO as FUA.

> This suspicion seems to be confirmed by tracing the write nvme command
> sent to the device:
> 
> raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> 
> notice the "ctrl=0x0" in there.

Not quite sure about the NVME here but ...

> == ext4 ==
> 
>   raft-benchmark-37801   [003] .....  9904.830974: io_uring_submit_req: ring 0000000011cab2e4, req 00000000c7a7d835, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
>   raft-benchmark-37801   [003] .....  9904.830982: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>   raft-benchmark-37801   [003] .....  9904.830983: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
>   raft-benchmark-37801   [003] .....  9904.830985: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 12, caller ext4_dirty_inode+0x38/0x80 [ext4]
>   raft-benchmark-37801   [003] .....  9904.830987: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_dirty_inode+0x5b/0x80 [ext4]
>   raft-benchmark-37801   [003] .....  9904.830989: block_touch_buffer: 259,5 sector=135 size=4096
>   raft-benchmark-37801   [003] .....  9904.830993: block_dirty_buffer: 259,5 sector=135 size=4096
>   raft-benchmark-37801   [003] .....  9904.831121: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>   raft-benchmark-37801   [003] .....  9904.831122: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>   raft-benchmark-37801   [003] .....  9904.831123: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_iomap_begin+0x1c2/0x2f0 [ext4]
>   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>   raft-benchmark-37801   [003] .....  9904.831125: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|PRE_IO
>   raft-benchmark-37801   [003] .....  9904.831126: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>   raft-benchmark-37801   [003] .....  9904.831127: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
>   raft-benchmark-37801   [003] .....  9904.831128: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|PRE_IO|METADATA_NOFAIL allocated 1 newblock 32887
>   raft-benchmark-37801   [003] .....  9904.831129: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>   raft-benchmark-37801   [003] .....  9904.831130: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_split_extent+0xcd/0x190 [ext4]
>   raft-benchmark-37801   [003] .....  9904.831131: block_touch_buffer: 259,5 sector=135 size=4096
>   raft-benchmark-37801   [003] .....  9904.831133: block_dirty_buffer: 259,5 sector=135 size=4096
>   raft-benchmark-37801   [003] .....  9904.831134: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|PRE_IO lblk 0 pblk 32887 len 1 mflags NMU ret 1
>   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>   raft-benchmark-37801   [003] .....  9904.831136: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>   raft-benchmark-37801   [003] .....  9904.831143: block_bio_remap: 259,0 WS 498455480 + 8 <- (259,5) 263096
>   raft-benchmark-37801   [003] .....  9904.831144: block_bio_queue: 259,0 WS 498455480 + 8 [raft-benchmark]
>   raft-benchmark-37801   [003] .....  9904.831149: block_getrq: 259,0 WS 498455480 + 8 [raft-benchmark]

Here we can see the indeed the write was submitted without the cache flush.
However we can also see that the write was going into unwritten extent
so...

>   raft-benchmark-37801   [003] .....  9904.831149: block_plug: [raft-benchmark]
>   raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
>   raft-benchmark-37801   [003] .....  9904.831159: block_rq_issue: 259,0 WS 4096 () 498455480 + 8 [raft-benchmark]
>   raft-benchmark-37801   [003] d.h..  9904.831173: nvme_sq: nvme0: disk=nvme0n1, qid=4, head=783, tail=783
>   raft-benchmark-37801   [003] d.h..  9904.831177: nvme_complete_rq: nvme0: disk=nvme0n1, qid=4, cmdid=25169, res=0x0, retries=0, flags=0x0, status=0x0
>   raft-benchmark-37801   [003] d.h..  9904.831178: block_rq_complete: 259,0 WS () 498455480 + 8 [0]
>      kworker/3:1-30279   [003] .....  9904.831193: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_convert_unwritten_extents+0xb4/0x260 [ext4]

... after io completed here, we need to convert unwritten extent into a
written one.

>      kworker/3:1-30279   [003] .....  9904.831193: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>      kworker/3:1-30279   [003] .....  9904.831194: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
>      kworker/3:1-30279   [003] .....  9904.831194: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|CONVERT
>      kworker/3:1-30279   [003] .....  9904.831195: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>      kworker/3:1-30279   [003] .....  9904.831195: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
>      kworker/3:1-30279   [003] .....  9904.831196: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|CONVERT|METADATA_NOFAIL allocated 1 newblock 32887
>      kworker/3:1-30279   [003] .....  9904.831196: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_ext_map_blocks+0xeee/0x1980 [ext4]
>      kworker/3:1-30279   [003] .....  9904.831197: block_touch_buffer: 259,5 sector=135 size=4096
>      kworker/3:1-30279   [003] .....  9904.831198: block_dirty_buffer: 259,5 sector=135 size=4096
>      kworker/3:1-30279   [003] .....  9904.831199: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|CONVERT lblk 0 pblk 32887 len 1 mflags M ret 1
>      kworker/3:1-30279   [003] .....  9904.831199: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status W
>      kworker/3:1-30279   [003] .....  9904.831200: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_convert_unwritten_extents+0x1e2/0x260 [ext4]
>      kworker/3:1-30279   [003] .....  9904.831200: block_touch_buffer: 259,5 sector=135 size=4096
>      kworker/3:1-30279   [003] .....  9904.831201: block_dirty_buffer: 259,5 sector=135 size=4096

The conversion to written extents happened here.

>      kworker/3:1-30279   [003] .....  9904.831202: ext4_sync_file_enter: dev 259,5 ino 12 parent 2 datasync 1 
>      kworker/3:1-30279   [003] .....  9904.831203: ext4_sync_file_exit: dev 259,5 ino 12 ret 0

And here we've called fdatasync() for the inode. Now this should have
submitted a cache flush through blkdev_issue_flush() but that doesn't seem
to happen. Indeed checking the code in 6.4 the problem is that inode is
dirtied only through ext4_mark_inode_dirty() which does not alter
inode->i_state and thus neither the inode buffer is properly flushed to the
disk in this case as it should (as it contains the converted extent) nor do
we issue the cache flush. As part of commit 5b5b4ff8f92da ("ext4: Use
generic_buffers_fsync_noflush() implementation") in 6.5 we accidentally
fixed the second problem AFAICT but the first problem with not flushing inode
buffer properly is still there... I'll have to think how to fix that
properly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


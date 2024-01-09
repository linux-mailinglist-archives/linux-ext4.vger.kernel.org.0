Return-Path: <linux-ext4+bounces-750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69D827E9E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 07:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154ACB235C5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0E3D86;
	Tue,  9 Jan 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LEgu/AOw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05461873
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b6218d102so2288648a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 08 Jan 2024 22:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704780304; x=1705385104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PaES+COwhq25pTrjJ5usj8U0d3s/Hzrrd29nN5qPb0=;
        b=LEgu/AOw69S8ZZ5tCVB/0tPsrK7E8AyhvjjVMJMTRvKgSyPvtY1jja4AYSvWQpJ088
         R6TA62uQr87Zr62zMHatHsjIu9CHA5lip9FYnRQPMn/9H9GVk+wVFtPU0/NYmZA2crmp
         VT3oJ7U/aOX9HnZcdRFqzF+V2QbXUVS2YCB3IANmoZXFAGY4Q1J37gxDJz3YrvVBEhIH
         HSruP+IO5kkjc9D27xlV3h2Mr/gSSWnP/T9rT2DYMTEE5Fb8LsfdTgdzg9poPr8Jnktz
         Gu/7fB+/tvDEGsqsZ3d/JaPOruHdU8+fSJJKdJTCMG6CbNJwrdJrFTaSzb5qqz+9c9fi
         xJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780304; x=1705385104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PaES+COwhq25pTrjJ5usj8U0d3s/Hzrrd29nN5qPb0=;
        b=TsqduNzf0ERPLRvsOScU2GSqSV2zP4nctQXfbNN0ea1i+dORt2xaVCcAagmcyFi2lE
         lkp1bd2s8QOPfGlBQFGp49/NWZ8eL9yRBvR+XTc+4OUmX5e+/NX/oKfzpqhW07VI7ALq
         3FaOjO/SUBNnpIWxK0XtoqwxOvmz7XDH7mzb/hdRJqxmpuaLn+SE4qN8I/n1BQcGhRvB
         I5ouvyr3go3AOqLDlJlJHbnORG86Xvjv6Q6dIYjpCJcIeQylrx1XY7xUYJvYaT/xKTpj
         GE+RNHhqMLJ4jwfEIAnMcDwJAOuzhj4wGUfSrLLdHo7K9azKoXvRy4I82BgyRqZ0BgYa
         BhLw==
X-Gm-Message-State: AOJu0Yxhk9Wh5GH5g5JQWnGU+Clk5Elq8zW0pBRF71kG9LdgVDDT06Vs
	uuFgxSFpsRymD3B9BGnyoqA4VXm0sbHr9H76MvfNdXE6xOI=
X-Google-Smtp-Source: AGHT+IGzUHcTgQqGOlCGfjk7L0IrMUclwKAcKO3DFCPG69YCmGKimI6Ljf6asuNOFGetfiKE0aqnoQ==
X-Received: by 2002:a17:90a:c70d:b0:28b:d319:2d8b with SMTP id o13-20020a17090ac70d00b0028bd3192d8bmr2450755pjt.97.1704780303940;
        Mon, 08 Jan 2024 22:05:03 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a2ac200b0028bc1df95c7sm1111903pjg.4.2024.01.08.22.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 22:05:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rN5ES-007xDY-2E;
	Tue, 09 Jan 2024 17:05:00 +1100
Date: Tue, 9 Jan 2024 17:05:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Free Ekanayaka <free.ekanayaka@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
Message-ID: <ZZziDCELOmXK/zDP@dread.disaster.area>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
 <20240108213112.m3f5djzesbvrc3rd@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108213112.m3f5djzesbvrc3rd@quack3>

On Mon, Jan 08, 2024 at 10:31:12PM +0100, Jan Kara wrote:
> Hello,
> 
> I've found this when going through some old email. Were you able to debug
> this?
> 
> On Wed 06-09-23 21:15:01, Free Ekanayaka wrote:
> > I'm using Linux 6.4.0 from Debian/testing (but tried this with 6.5.1
> > too).
> > 
> > I've created an ext4 filesystem with journalling disabled on an NVMe
> > drive:
> > 
> > mkfs.ext4 -O ^has_journal -F /dev/nvme0n1p6
> > 
> > I have a program that creates and open a new file with O_DIRECT, and
> > sets its size to 8M with posix_fallocate(), something like:
> > 
> > fd = open("/dir/file", O_CREAT | O_WRONLY | O_DIRECT);
> > posix_fallocate(fd, 0, 8 * 1024 * 1024);
> > fsync(fd);
> > dirfd = open("/dir", O_RDONLY | O_DIRECTORY);
> > fsync(dirfd);
> > 
> > and then it uses io_uring to perform a single write of 4096 bytes at the
> > beginning of the file, passing RWF_DSYNC to the submitted
> > IORING_OP_WRITE_FIXED entry,
> > 
> > I would expect the kernel to tell the NVMe device to actually flush the
> > write, not only buffer it. However I measured the end-to-end latency of
> > the io_uring operation and it was very low, as if the write was only
> > buffered by the NVMe device, but not flushed.
> 
> Yes, the kernel should issue device cache flush or mark the IO as FUA.
> 
> > This suspicion seems to be confirmed by tracing the write nvme command
> > sent to the device:
> > 
> > raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> > 
> > notice the "ctrl=0x0" in there.
> 
> Not quite sure about the NVME here but ...
> 
> > == ext4 ==
> > 
> >   raft-benchmark-37801   [003] .....  9904.830974: io_uring_submit_req: ring 0000000011cab2e4, req 00000000c7a7d835, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
> >   raft-benchmark-37801   [003] .....  9904.830982: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
> >   raft-benchmark-37801   [003] .....  9904.830983: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
> >   raft-benchmark-37801   [003] .....  9904.830985: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 12, caller ext4_dirty_inode+0x38/0x80 [ext4]
> >   raft-benchmark-37801   [003] .....  9904.830987: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_dirty_inode+0x5b/0x80 [ext4]
> >   raft-benchmark-37801   [003] .....  9904.830989: block_touch_buffer: 259,5 sector=135 size=4096
> >   raft-benchmark-37801   [003] .....  9904.830993: block_dirty_buffer: 259,5 sector=135 size=4096
> >   raft-benchmark-37801   [003] .....  9904.831121: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
> >   raft-benchmark-37801   [003] .....  9904.831122: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
> >   raft-benchmark-37801   [003] .....  9904.831123: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_iomap_begin+0x1c2/0x2f0 [ext4]
> >   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
> >   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
> >   raft-benchmark-37801   [003] .....  9904.831125: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|PRE_IO
> >   raft-benchmark-37801   [003] .....  9904.831126: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
> >   raft-benchmark-37801   [003] .....  9904.831127: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
> >   raft-benchmark-37801   [003] .....  9904.831128: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|PRE_IO|METADATA_NOFAIL allocated 1 newblock 32887
> >   raft-benchmark-37801   [003] .....  9904.831129: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
> >   raft-benchmark-37801   [003] .....  9904.831130: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_split_extent+0xcd/0x190 [ext4]
> >   raft-benchmark-37801   [003] .....  9904.831131: block_touch_buffer: 259,5 sector=135 size=4096
> >   raft-benchmark-37801   [003] .....  9904.831133: block_dirty_buffer: 259,5 sector=135 size=4096
> >   raft-benchmark-37801   [003] .....  9904.831134: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|PRE_IO lblk 0 pblk 32887 len 1 mflags NMU ret 1
> >   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
> >   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
> >   raft-benchmark-37801   [003] .....  9904.831136: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
> >   raft-benchmark-37801   [003] .....  9904.831143: block_bio_remap: 259,0 WS 498455480 + 8 <- (259,5) 263096
> >   raft-benchmark-37801   [003] .....  9904.831144: block_bio_queue: 259,0 WS 498455480 + 8 [raft-benchmark]
> >   raft-benchmark-37801   [003] .....  9904.831149: block_getrq: 259,0 WS 498455480 + 8 [raft-benchmark]
> 
> Here we can see the indeed the write was submitted without the cache flush.
> However we can also see that the write was going into unwritten extent
> so...
> 
> >   raft-benchmark-37801   [003] .....  9904.831149: block_plug: [raft-benchmark]
> >   raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> >   raft-benchmark-37801   [003] .....  9904.831159: block_rq_issue: 259,0 WS 4096 () 498455480 + 8 [raft-benchmark]
> >   raft-benchmark-37801   [003] d.h..  9904.831173: nvme_sq: nvme0: disk=nvme0n1, qid=4, head=783, tail=783
> >   raft-benchmark-37801   [003] d.h..  9904.831177: nvme_complete_rq: nvme0: disk=nvme0n1, qid=4, cmdid=25169, res=0x0, retries=0, flags=0x0, status=0x0
> >   raft-benchmark-37801   [003] d.h..  9904.831178: block_rq_complete: 259,0 WS () 498455480 + 8 [0]
> >      kworker/3:1-30279   [003] .....  9904.831193: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_convert_unwritten_extents+0xb4/0x260 [ext4]
> 
> ... after io completed here, we need to convert unwritten extent into a
> written one.
> 
> >      kworker/3:1-30279   [003] .....  9904.831193: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
> >      kworker/3:1-30279   [003] .....  9904.831194: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
> >      kworker/3:1-30279   [003] .....  9904.831194: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|CONVERT
> >      kworker/3:1-30279   [003] .....  9904.831195: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
> >      kworker/3:1-30279   [003] .....  9904.831195: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
> >      kworker/3:1-30279   [003] .....  9904.831196: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|CONVERT|METADATA_NOFAIL allocated 1 newblock 32887
> >      kworker/3:1-30279   [003] .....  9904.831196: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_ext_map_blocks+0xeee/0x1980 [ext4]
> >      kworker/3:1-30279   [003] .....  9904.831197: block_touch_buffer: 259,5 sector=135 size=4096
> >      kworker/3:1-30279   [003] .....  9904.831198: block_dirty_buffer: 259,5 sector=135 size=4096
> >      kworker/3:1-30279   [003] .....  9904.831199: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|CONVERT lblk 0 pblk 32887 len 1 mflags M ret 1
> >      kworker/3:1-30279   [003] .....  9904.831199: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status W
> >      kworker/3:1-30279   [003] .....  9904.831200: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_convert_unwritten_extents+0x1e2/0x260 [ext4]
> >      kworker/3:1-30279   [003] .....  9904.831200: block_touch_buffer: 259,5 sector=135 size=4096
> >      kworker/3:1-30279   [003] .....  9904.831201: block_dirty_buffer: 259,5 sector=135 size=4096
> 
> The conversion to written extents happened here.

Which dirties metadata buffers....

> >      kworker/3:1-30279   [003] .....  9904.831202: ext4_sync_file_enter: dev 259,5 ino 12 parent 2 datasync 1 
> >      kworker/3:1-30279   [003] .....  9904.831203: ext4_sync_file_exit: dev 259,5 ino 12 ret 0
> 
> And here we've called fdatasync() for the inode. Now this should have
> submitted a cache flush through blkdev_issue_flush() but that doesn't seem
> to happen.

I suspect correct crash recovery behaviour here requires
multiple cache flushes to ensure the correct ordering or data vs
metadata updates. i.e:

	....
	data write completes
	fdatasync()
	  cache flush to ensure data is on disk
	  if (dirty metadata) {
		issue metadata write(s) for extent records and inode
		....
		metadata write(s) complete
		cache flush to ensure metadata is on disk
	  }

If we don't flush the cache between the data write and the metadata
write(s) that marks the extent as written, we could have a state
after a power fail where the metadata writes hit the disk
before the data write and after the system comes back up that file
now it exposes stale data to the user.

This is a problem we have to deal with in XFS because we have
external logs and multiple data devices - we can't rely on the cache
flush issued before a log write to flush the data write to stable
storage if the data is on a different device to the metadata. In
that situation, we have to explicitly flush the data device cache
before we flush the log and persist the metadata changes.

Indeed, I suspect that ext4 needs the same device cache flushing
logic in the fsync path as XFS because it, like XFS, can have an
external log device and so multiple device cache flushes are needed
to ensure correct persistent ordering of data vs metadata updates...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


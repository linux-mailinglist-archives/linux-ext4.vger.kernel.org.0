Return-Path: <linux-ext4+bounces-756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72D828930
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288841C2420D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BC39FE8;
	Tue,  9 Jan 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCuYVR/N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AD39FDD
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e52ebd63dso3414965e9.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jan 2024 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704815074; x=1705419874; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkKBXFyfVCYXrYWqQCaSloZ5f3RsHuXj6Khe1889J9Q=;
        b=VCuYVR/NW1G/kCd3tR/SAFd8lr2AZcL6XVnEsRZ3Un4PwszarqX614DKm6iX1FtZcd
         IU/tOxcYKPtmEp2RJTD/+W2qj+Bga9NiBnz8u1yWKRoPyN/tpV4d4cWtoW75GaRA/HKA
         qX4id5G+o2jk+Ud6fTGDWOQ/KIiO9R3QfzklpHr0NP8Qhkzo92jtL++wzjZipw82U5th
         VsKwoAacURyawxo+3RA+7c/gdu9rmp6/HuLkvmb4gAO00hDOXb6OiIv4lzvXrFo1DTTX
         i7/Dkrgv/0t2hf87CFdUfBc1PT+3Nb66iCxdikD4DDx7HpgP0X8kEybbyPhfw47q9Xcr
         kwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704815074; x=1705419874;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkKBXFyfVCYXrYWqQCaSloZ5f3RsHuXj6Khe1889J9Q=;
        b=hjlP0Cv1PTx/ldulpguFpPok89JeMJstCj/NvxdwTKihHVs5ON2W0XfVRmcIeJ1JZm
         g9TUP+UFxp80xzkhVnDd4g0Gd96RdLtgPkMxZ6SIcCOmx3tKzn//tlx1+RQyhYNXrsm+
         eTTz5D+cqT3naDmM8haEoD2TeE2098tMIZucGqmzBu+1GHOSQoNP60sNw0HB0JYh2buD
         mKTtoeeF7wRMtIA0Rd94m9yGLRFn0+5Iv/2nhRsmMxbpO4ZNV/mOaZroDEyfoGXLBzub
         HM2QJEBpsfZwElpLBA0cia52xOp/rNa+LbERuxgSWai9W34dxP8+w/CYRqt15ApHGdK2
         Aodg==
X-Gm-Message-State: AOJu0Yweek9YfeDuIjqJJ/80gP5PyizqGJph97Jjy/InjLu76ROf6K+3
	lOHfwqWPItIJulDXi3QiITKoh5coMRE=
X-Google-Smtp-Source: AGHT+IFsF9DG2s9sA/SXqeB/FxnUTBG7ZZKa11e63fjrSY0R64dorZ6CPtnNxkcMbY6qv0NL3e5rgQ==
X-Received: by 2002:a05:600c:3f85:b0:40e:44aa:9384 with SMTP id fs5-20020a05600c3f8500b0040e44aa9384mr2131252wmb.135.1704815073448;
        Tue, 09 Jan 2024 07:44:33 -0800 (PST)
Received: from x1 ([2a02:2e02:45a:4d00:96e7:bff:fe65:b0ad])
        by smtp.gmail.com with ESMTPSA id n43-20020a05600c502b00b0040e4abebaf7sm4026933wmr.34.2024.01.09.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:44:32 -0800 (PST)
From: Free Ekanayaka <free.ekanayaka@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
In-Reply-To: <20240108213112.m3f5djzesbvrc3rd@quack3>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
 <20240108213112.m3f5djzesbvrc3rd@quack3>
Date: Tue, 09 Jan 2024 15:46:39 +0000
Message-ID: <87a5peo6g0.fsf@x1.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello Jan,

thanks for getting back to me on this one.

Jan Kara <jack@suse.cz> writes:

> Hello,
>
> I've found this when going through some old email. Were you able to debug
> this?

If you mean looking at the kernel code to understand what was going on,
no I didn't. Wanted to ask you guys first.

>
> On Wed 06-09-23 21:15:01, Free Ekanayaka wrote:
>> I'm using Linux 6.4.0 from Debian/testing (but tried this with 6.5.1
>> too).
>> 
>> I've created an ext4 filesystem with journalling disabled on an NVMe
>> drive:
>> 
>> mkfs.ext4 -O ^has_journal -F /dev/nvme0n1p6
>> 
>> I have a program that creates and open a new file with O_DIRECT, and
>> sets its size to 8M with posix_fallocate(), something like:
>> 
>> fd = open("/dir/file", O_CREAT | O_WRONLY | O_DIRECT);
>> posix_fallocate(fd, 0, 8 * 1024 * 1024);
>> fsync(fd);
>> dirfd = open("/dir", O_RDONLY | O_DIRECTORY);
>> fsync(dirfd);
>> 
>> and then it uses io_uring to perform a single write of 4096 bytes at the
>> beginning of the file, passing RWF_DSYNC to the submitted
>> IORING_OP_WRITE_FIXED entry,
>> 
>> I would expect the kernel to tell the NVMe device to actually flush the
>> write, not only buffer it. However I measured the end-to-end latency of
>> the io_uring operation and it was very low, as if the write was only
>> buffered by the NVMe device, but not flushed.
>
> Yes, the kernel should issue device cache flush or mark the IO as FUA.

Good, thanks for confirming.

>
>> This suspicion seems to be confirmed by tracing the write nvme command
>> sent to the device:
>> 
>> raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
>> 
>> notice the "ctrl=0x0" in there.
>
> Not quite sure about the NVME here but ...
>
>> == ext4 ==
>> 
>>   raft-benchmark-37801   [003] .....  9904.830974: io_uring_submit_req: ring 0000000011cab2e4, req 00000000c7a7d835, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
>>   raft-benchmark-37801   [003] .....  9904.830982: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>>   raft-benchmark-37801   [003] .....  9904.830983: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
>>   raft-benchmark-37801   [003] .....  9904.830985: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 12, caller ext4_dirty_inode+0x38/0x80 [ext4]
>>   raft-benchmark-37801   [003] .....  9904.830987: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_dirty_inode+0x5b/0x80 [ext4]
>>   raft-benchmark-37801   [003] .....  9904.830989: block_touch_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-37801   [003] .....  9904.830993: block_dirty_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-37801   [003] .....  9904.831121: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>>   raft-benchmark-37801   [003] .....  9904.831122: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>>   raft-benchmark-37801   [003] .....  9904.831123: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_iomap_begin+0x1c2/0x2f0 [ext4]
>>   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>>   raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>>   raft-benchmark-37801   [003] .....  9904.831125: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|PRE_IO
>>   raft-benchmark-37801   [003] .....  9904.831126: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>>   raft-benchmark-37801   [003] .....  9904.831127: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
>>   raft-benchmark-37801   [003] .....  9904.831128: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|PRE_IO|METADATA_NOFAIL allocated 1 newblock 32887
>>   raft-benchmark-37801   [003] .....  9904.831129: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>>   raft-benchmark-37801   [003] .....  9904.831130: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_split_extent+0xcd/0x190 [ext4]
>>   raft-benchmark-37801   [003] .....  9904.831131: block_touch_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-37801   [003] .....  9904.831133: block_dirty_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-37801   [003] .....  9904.831134: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|PRE_IO lblk 0 pblk 32887 len 1 mflags NMU ret 1
>>   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>>   raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
>>   raft-benchmark-37801   [003] .....  9904.831136: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>>   raft-benchmark-37801   [003] .....  9904.831143: block_bio_remap: 259,0 WS 498455480 + 8 <- (259,5) 263096
>>   raft-benchmark-37801   [003] .....  9904.831144: block_bio_queue: 259,0 WS 498455480 + 8 [raft-benchmark]
>>   raft-benchmark-37801   [003] .....  9904.831149: block_getrq: 259,0 WS 498455480 + 8 [raft-benchmark]
>
> Here we can see the indeed the write was submitted without the cache flush.
> However we can also see that the write was going into unwritten extent
> so...
>
>>   raft-benchmark-37801   [003] .....  9904.831149: block_plug: [raft-benchmark]
>>   raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
>>   raft-benchmark-37801   [003] .....  9904.831159: block_rq_issue: 259,0 WS 4096 () 498455480 + 8 [raft-benchmark]
>>   raft-benchmark-37801   [003] d.h..  9904.831173: nvme_sq: nvme0: disk=nvme0n1, qid=4, head=783, tail=783
>>   raft-benchmark-37801   [003] d.h..  9904.831177: nvme_complete_rq: nvme0: disk=nvme0n1, qid=4, cmdid=25169, res=0x0, retries=0, flags=0x0, status=0x0
>>   raft-benchmark-37801   [003] d.h..  9904.831178: block_rq_complete: 259,0 WS () 498455480 + 8 [0]
>>      kworker/3:1-30279   [003] .....  9904.831193: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_convert_unwritten_extents+0xb4/0x260 [ext4]
>
> ... after io completed here, we need to convert unwritten extent into a
> written one.
>
>>      kworker/3:1-30279   [003] .....  9904.831193: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
>>      kworker/3:1-30279   [003] .....  9904.831194: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
>>      kworker/3:1-30279   [003] .....  9904.831194: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|CONVERT
>>      kworker/3:1-30279   [003] .....  9904.831195: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
>>      kworker/3:1-30279   [003] .....  9904.831195: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
>>      kworker/3:1-30279   [003] .....  9904.831196: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|CONVERT|METADATA_NOFAIL allocated 1 newblock 32887
>>      kworker/3:1-30279   [003] .....  9904.831196: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_ext_map_blocks+0xeee/0x1980 [ext4]
>>      kworker/3:1-30279   [003] .....  9904.831197: block_touch_buffer: 259,5 sector=135 size=4096
>>      kworker/3:1-30279   [003] .....  9904.831198: block_dirty_buffer: 259,5 sector=135 size=4096
>>      kworker/3:1-30279   [003] .....  9904.831199: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|CONVERT lblk 0 pblk 32887 len 1 mflags M ret 1
>>      kworker/3:1-30279   [003] .....  9904.831199: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status W
>>      kworker/3:1-30279   [003] .....  9904.831200: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_convert_unwritten_extents+0x1e2/0x260 [ext4]
>>      kworker/3:1-30279   [003] .....  9904.831200: block_touch_buffer: 259,5 sector=135 size=4096
>>      kworker/3:1-30279   [003] .....  9904.831201: block_dirty_buffer: 259,5 sector=135 size=4096
>
> The conversion to written extents happened here.
>
>>      kworker/3:1-30279   [003] .....  9904.831202: ext4_sync_file_enter: dev 259,5 ino 12 parent 2 datasync 1 
>>      kworker/3:1-30279   [003] .....  9904.831203: ext4_sync_file_exit: dev 259,5 ino 12 ret 0
>
> And here we've called fdatasync() for the inode. Now this should have
> submitted a cache flush through blkdev_issue_flush() but that doesn't seem
> to happen.

Right.

> Indeed checking the code in 6.4 the problem is that inode is
> dirtied only through ext4_mark_inode_dirty() which does not alter
> inode->i_state and thus neither the inode buffer is properly flushed to the
> disk in this case as it should (as it contains the converted extent) nor do
> we issue the cache flush. As part of commit 5b5b4ff8f92da ("ext4: Use
> generic_buffers_fsync_noflush() implementation") in 6.5 we accidentally
> fixed the second problem AFAICT but the first problem with not flushing inode
> buffer properly is still there... I'll have to think how to fix that
> properly.

I've re-ran the same code with kernel 6.5.0 and indeed the behavior has
changed and an actual NVMe flush command seems to be issued (the flags
passed to nvme_setup_cmd match the ones that I see in the case I write
to the raw block device). So that part seems fixed. I thought I had
tried with 6.5.1 when I had posted this issue, and that it was present
there too, but maybe I was mistaken.

I'm not entirely sure what you mean about flushing the inode buffer
properly. As far as I see, the current behavior I see matches what I'd
expect.

For reference I'm attaching below the trace of the same user code, this
time run on kernel 6.5.0, which is the one currently shipping with
Debian/testing. Note that there are quite a bit less trace lines emitted
by the ext4 sub-system, not sure if it's related/relevant.

  raft-benchmark-35708   [000] .....  9203.271114: io_uring_submit_req: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
  raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
  raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
  raft-benchmark-35708   [000] .....  9203.271118: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 16, caller ext4_dirty_inode+0x38/0x80 [ext4]
  raft-benchmark-35708   [000] .....  9203.271119: ext4_mark_inode_dirty: dev 259,5 ino 16 caller ext4_dirty_inode+0x5b/0x80 [ext4]
  raft-benchmark-35708   [000] .....  9203.271119: block_touch_buffer: 259,5 sector=135 size=4096
  raft-benchmark-35708   [000] .....  9203.271120: block_dirty_buffer: 259,5 sector=135 size=4096
  raft-benchmark-35708   [000] .....  9203.271120: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
  raft-benchmark-35708   [000] .....  9203.271121: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
  raft-benchmark-35708   [000] .....  9203.271122: block_bio_remap: 259,0 WFS 498455552 + 8 <- (259,5) 263168
  raft-benchmark-35708   [000] .....  9203.271122: block_bio_queue: 259,0 WFS 498455552 + 8 [raft-benchmark]
  raft-benchmark-35708   [000] .....  9203.271123: block_getrq: 259,0 WFS 498455552 + 8 [raft-benchmark]
  raft-benchmark-35708   [000] .....  9203.271123: block_io_start: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
  raft-benchmark-35708   [000] .....  9203.271124: block_plug: [raft-benchmark]
  raft-benchmark-35708   [000] .....  9203.271124: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=53265, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455552, len=7, ctrl=0x4000, dsmgmt=0, reftag=0)
  raft-benchmark-35708   [000] .....  9203.271126: block_rq_issue: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
  raft-benchmark-35708   [000] d.h..  9203.271382: nvme_sq: nvme0: disk=nvme0n1, qid=1, head=79, tail=79
  raft-benchmark-35708   [000] d.h..  9203.271384: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=53265, res=0x0, retries=0, flags=0x0, status=0x0
  raft-benchmark-35708   [000] d.h..  9203.271384: block_rq_complete: 259,0 WFS () 498455552 + 8 [0]
  raft-benchmark-35708   [000] dNh..  9203.271386: block_io_done: 259,0 WFS 0 () 498455552 + 0 [raft-benchmark]
  raft-benchmark-35708   [000] ...1.  9203.271391: io_uring_complete: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, result 4096, cflags 0x0 extra1 0 extra2 0 
  raft-benchmark-35708   [000] .....  9203.271391: io_uring_task_work_run: tctx 00000000f15587dc, count 1, loops 1


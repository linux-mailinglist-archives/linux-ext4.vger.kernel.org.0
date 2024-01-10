Return-Path: <linux-ext4+bounces-764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA18298A1
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 12:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718901F2936E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0D47A4F;
	Wed, 10 Jan 2024 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx5g40T6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BB47F63
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5701cbbaso2485235e9.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704885458; x=1705490258; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoMpGFoRsZ/MeJ+8aHyok9EDtsnFlIIP8IBFGhGjm/U=;
        b=gx5g40T6oRNFvKJT+issiCUfbI1T05X3gCDf9bRxqeEW5vtPJxrIxTyh2bgQggry65
         mnAgkDI9IBmviTHIzK9aPKYNUJVOVEcetZOfwXgK1ZRPj6CXL8P8gzgT9HGzfUYvq/VL
         skMzwZ80Aj9ppqNTYBVblRo6dI8z6UlzhgflGX9xkKfHVR0lc2MLVWf8uctdJ5Rxb5lA
         cqoP6heCn01o2V2tKXA4qx9HQPV64XNlLYqR8IQk0g7ActkqJGGoEl4r0VD0vvncbb0m
         J/Y73nP8jBMi53SYrSv4niEIKCCNKgcFcA42fLYZMXHLBcBbW6EeqbtH3Jz0SVfaS6Qx
         NDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704885458; x=1705490258;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoMpGFoRsZ/MeJ+8aHyok9EDtsnFlIIP8IBFGhGjm/U=;
        b=eO/ZD6sOqa4WH4URUVeBTW/aHaWNQiC59ZoYZDvqOWo12RPUKU/1mEOBcifYXgSGKm
         d4lkZXeGc9TVX+xKgP+EMxLtRHcd4PMuufxSOTbWmvCF7u3x4ETLesyd8Ki+n+mHP2my
         dbnbT5zOpkWtSxFtShWTT1vEpwaZ7eKPl24hhVHmb0TVTDI1SQ/E+qdGGecDeYBILrux
         59Dst2LYvpMP1s3V0iXiHyWf2iDtSwfeMYTz6FRem9wnILaN+H4rM8FeRPdBABJ5+a9F
         4ZSyhZUsoZRJKCPE0t88fB1sHaNmvAFkF2LSwH5xsOlOP2EV8pP/gQG393Hdw0GHpHJb
         3cBg==
X-Gm-Message-State: AOJu0Ywe2PgUk2old1gbFn7KMxTd+AZ15rV+En5ofetzcKHHQAHI2oHw
	/DfCRp1u/nnWqWm6UfQ+Cxs7H+sP3xE=
X-Google-Smtp-Source: AGHT+IFQNA+Gsvz5zmjUpDneFGqcNmmZBXfUepe05ytD4ZnGSZtzYTP2hKmmC5MwBhPKvRMxg3hMng==
X-Received: by 2002:a05:600c:1391:b0:40c:2960:960c with SMTP id u17-20020a05600c139100b0040c2960960cmr581328wmf.23.1704885457335;
        Wed, 10 Jan 2024 03:17:37 -0800 (PST)
Received: from x1 ([2a02:2e02:45a:4d00:96e7:bff:fe65:b0ad])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040d7c3d5454sm1826507wmo.3.2024.01.10.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:17:36 -0800 (PST)
From: Free Ekanayaka <free.ekanayaka@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
In-Reply-To: <20240110100148.v2vd63zb4gl3rmlf@quack3>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
 <20240108213112.m3f5djzesbvrc3rd@quack3>
 <87a5peo6g0.fsf@x1.mail-host-address-is-not-set>
 <20240110100148.v2vd63zb4gl3rmlf@quack3>
Date: Wed, 10 Jan 2024 11:19:42 +0000
Message-ID: <87y1cx306p.fsf@x1.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kara <jack@suse.cz> writes:

[...]

>> I've re-ran the same code with kernel 6.5.0 and indeed the behavior has
>> changed and an actual NVMe flush command seems to be issued (the flags
>> passed to nvme_setup_cmd match the ones that I see in the case I write
>> to the raw block device). So that part seems fixed. I thought I had
>> tried with 6.5.1 when I had posted this issue, and that it was present
>> there too, but maybe I was mistaken.
>> 
>> I'm not entirely sure what you mean about flushing the inode buffer
>> properly. As far as I see, the current behavior I see matches what I'd
>> expect.
>
> The thing is: fallocate(2) does preallocate blocks to the file so
> block allocation is not needed when writing to those blocks. However that
> does not mean metadata changes are not needed when writing to those blocks.
> In case of ext4 (and other filesystems such as xfs or btrfs as well) blocks
> allocated using fallocate(2) are tracked as unwritten in inode's metadata (so
> reads from them return 0 instead of random garbage). After block contents
> is written with iouring write, we need to convert the state of blocks from
> unwritten to written and that needs metadata modifications. So the first
> write to the file after fallocate(2) call still needs to do metadata
> modifications and these need to be persisted as part of fdatasync(2). And
> by mistake this did not happen in nojournal mode.

Thanks for the explanation.

Since I want to achieve the lowest possible latency for these writes, is
there a way to not onlly preallocate blocks with fallocate() but also to
avoid the extra write for metadata modifications that you mention?

I mean, I could of course take the brute force approach of performing
dump "pre" writes of those blocks, but I'm wondering if there's a better
way that doesn't require writing those blocks twice (which might end up
defeating the purpose of lowering overall latency).

>
>> For reference I'm attaching below the trace of the same user code, this
>> time run on kernel 6.5.0, which is the one currently shipping with
>> Debian/testing. Note that there are quite a bit less trace lines emitted
>> by the ext4 sub-system, not sure if it's related/relevant.
>> 
>>   raft-benchmark-35708   [000] .....  9203.271114: io_uring_submit_req: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
>>   raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
>>   raft-benchmark-35708   [000] .....  9203.271117: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
>>   raft-benchmark-35708   [000] .....  9203.271118: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 16, caller ext4_dirty_inode+0x38/0x80 [ext4]
>>   raft-benchmark-35708   [000] .....  9203.271119: ext4_mark_inode_dirty: dev 259,5 ino 16 caller ext4_dirty_inode+0x5b/0x80 [ext4]
>>   raft-benchmark-35708   [000] .....  9203.271119: block_touch_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-35708   [000] .....  9203.271120: block_dirty_buffer: 259,5 sector=135 size=4096
>>   raft-benchmark-35708   [000] .....  9203.271120: ext4_es_lookup_extent_enter: dev 259,5 ino 16 lblk 0
>>   raft-benchmark-35708   [000] .....  9203.271121: ext4_es_lookup_extent_exit: dev 259,5 ino 16 found 1 [0/16) 32896 WR
>>   raft-benchmark-35708   [000] .....  9203.271122: block_bio_remap: 259,0 WFS 498455552 + 8 <- (259,5) 263168
>>   raft-benchmark-35708   [000] .....  9203.271122: block_bio_queue: 259,0 WFS 498455552 + 8 [raft-benchmark]
>>   raft-benchmark-35708   [000] .....  9203.271123: block_getrq: 259,0 WFS 498455552 + 8 [raft-benchmark]
>>   raft-benchmark-35708   [000] .....  9203.271123: block_io_start: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
>>   raft-benchmark-35708   [000] .....  9203.271124: block_plug: [raft-benchmark]
>>   raft-benchmark-35708   [000] .....  9203.271124: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=53265, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455552, len=7, ctrl=0x4000, dsmgmt=0, reftag=0)
>>   raft-benchmark-35708   [000] .....  9203.271126: block_rq_issue: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
>>   raft-benchmark-35708   [000] d.h..  9203.271382: nvme_sq: nvme0: disk=nvme0n1, qid=1, head=79, tail=79
>>   raft-benchmark-35708   [000] d.h..  9203.271384: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=53265, res=0x0, retries=0, flags=0x0, status=0x0
>>   raft-benchmark-35708   [000] d.h..  9203.271384: block_rq_complete: 259,0 WFS () 498455552 + 8 [0]
>>   raft-benchmark-35708   [000] dNh..  9203.271386: block_io_done: 259,0 WFS 0 () 498455552 + 0 [raft-benchmark]
>>   raft-benchmark-35708   [000] ...1.  9203.271391: io_uring_complete: ring 000000007ee609d1, req 00000000221c7d2e, user_data 0x0, result 4096, cflags 0x0 extra1 0 extra2 0 
>>   raft-benchmark-35708   [000] .....  9203.271391: io_uring_task_work_run: tctx 00000000f15587dc, count 1, loops 1
>
> So in this case the file blocks seem to have been already written.

Do you mean that they have been already written at some point in the
past after the file system was created?

I guess it doesn't matter if they were written as part of the new file
that is being written (and that was created with open()/fallocate()), or
if they were written before as part of some other file that was deleted
since then.

> In this
> case we don't need to do any block conversions (thus no metadata changes)
> and we also submit the write including the flush in the single block
> request. In the trace:
>
> raft-benchmark-35708   [000] .....  9203.271126: block_rq_issue: 259,0 WFS 4096 () 498455552 + 8 [raft-benchmark]
>
> this line shows the request submission. The type of request is 'WFS' which
> means 'write' with 'flush' (this makes sure write does not just go to
> devices' cache) and 'sync' (which just says somebody is waiting for
> completion of the IO so it should be treated with priority by IO scheduling
> algorithms).

Thanks, that's helpful.


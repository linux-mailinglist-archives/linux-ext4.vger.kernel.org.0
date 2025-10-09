Return-Path: <linux-ext4+bounces-10719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E272EBC870B
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 12:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81664E4E42
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB92D9482;
	Thu,  9 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="MBPSuULL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557942C0323
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005075; cv=none; b=pO0oItXOJ88tV1hpBr10/OewUg6iJ8Yk3fCVcTEwVUwcHe2kzPQVfLx54ZPD3KcxGlGoPwyc2NMCbaJ/fMDa9VR9FYtIfQq+S6vLRgL9FEw+INy8xiun4lV3pWP21WNaS3W2Bl04PIAvsHjXubqImbUcccc5S03m8t4k9qdV+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005075; c=relaxed/simple;
	bh=j+fmUXd6xQL9GDzbB+vnAAIgPklV/Xk+9LiMGhOmvy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=ahxHWr7hm2KlTO03PJNA/fFyzwmh+HYlO7QmhNEc6Q01pZIIkdCkHAKliTdkbgjBiSPvBYk0rfgnWbVfxwwmRQW+Gklng87Qd7DjGJuwK5gtWBB1RoGlUd4kdCR1rNV12G/qbL+XiMGVSoXQLOi+5q46tftNLI5fG377AcPe+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=MBPSuULL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e5980471eso4435155e9.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760005072; x=1760609872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwmSwkUktuGN2lTX/avRfIDxnGckKIu3Gz1DedDxn7c=;
        b=MBPSuULLmPt9UA949r4o8qqCiNsGLA2sj4XrdgFWQBet7x5c7Zd1/8v+76t6h/HiiM
         axtHIJsZN11L9jGEH1XXker8b5H4AlHEILGhitx76p2WhjkiVtC7yRVFYKalm+82AAnd
         M7pfSjYJn62h1zpVmgzaLMqdGnzvH1Y5ijwcCX7FOurCI7mhyNYS4GQPMZwTR1Hl5D0U
         M7WqyoTAJ+2AJr0DPueGJ5ugIv9i6eN1UJ51cu+3iAYi9aEXRtDDCzW37JOnWY4gmQ53
         vldrldXuH6GEQJYz5yiXpatB12RMoilpkVZHnm2ZGcwUk4Fa+PuLrnu91kYP3AuPf7JX
         P89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005072; x=1760609872;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwmSwkUktuGN2lTX/avRfIDxnGckKIu3Gz1DedDxn7c=;
        b=UgJaba5lgUhli9uj0+BtAkGq7ce8/mKqcbfh/ZFKs8sGdD2yjRGtTO5CofswO27t6S
         w/Jwfg0P0FrA1hrMWNBPBwspIgkPvJTYyK8C99rdYXejTTPKHxIF8yAOI8eVniFnRvY5
         WLhSNOTtCJ7GJ3GG35kJkvPHxlfnaX1LK0ceQ8mHputRdhqPTk1C0PMMiT9zua/fZ8/c
         pY02FwUM+cIU6yUiUhH3di2mzxNcF6YlQTgPvf7Uz70Jj9FWAyDfNfyj5e7HvnbCdpi4
         uhJ411CpVzbl6vDQdgDnMXVLxi6P9r4inXv0341dZAI4kuBljLIxzNoljnMarAlpK2TU
         up5w==
X-Forwarded-Encrypted: i=1; AJvYcCUVmPuom6VsogKgdSt2+j7LpGRXculzImk9/kiBRfmXZvtNX5JsyZWlz3321uuOwGWHDUU+6+aib5g5@vger.kernel.org
X-Gm-Message-State: AOJu0YybKU5xhc0obkuKuDYHVXJ5EnRkFeUAwYQc8Clb0DfPOOSJnYdl
	JSSQmQtChYC4w7QlLF8vQ+kiQ2ml5iqzfBIVnK8bB/2yIJoA6nIP25a91GDxEPS3Gzk=
X-Gm-Gg: ASbGncutNyDKsFsLLM7+zD/Sj0j/F1nTs46I8IDnYf9mYGx9ftuzUTc2p1jiM5umwg3
	6kurHAxdNG5g+mPl3z4CoN0mmEaMGLZz7G04KuTraUNJxbH3e38o7UTUC6WKd1Afwz40yk+b0xa
	mmVsM/yWlEsrWjiQqlKlN5FqcG3u0sTgG4OueKVXQHQSP1ozDlD5ZaHwUYJ7e9oEv5uODJHU+W0
	9LV5lp28GBcSHzWgFDxcY4M+g0gwpmTUATyy25kUIZ24Sr+kFzmXOruUvMNPu+BDmaYGii32B3p
	0icDtG4TqVe7NbGONHcuuNbfOCOEdbJ4dfkEJgsh9I9HHTuH5iuL9nkzbiwm9FdU6GkgV++ivce
	2cz1X4LQLnDH75yGOhF2beQIzqeGizAounorJDHb3DJspo2QVm2NHIAbmKg==
X-Google-Smtp-Source: AGHT+IGwacbifiC1M5sZwj6eWdiAAxc5lwLIbJjHBooQIYKtxGjYSWSnlEuG/9LcwLnvjTDFuT1HuA==
X-Received: by 2002:a05:600c:8206:b0:46e:19f8:88d3 with SMTP id 5b1f17b1804b1-46fa9af313bmr41910765e9.22.1760005071533;
        Thu, 09 Oct 2025 03:17:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf11197esm42187475e9.6.2025.10.09.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:17:51 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca,
	kernel-team@cloudflare.com,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matt@readmodwrite.com,
	tytso@mit.edu,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Date: Thu,  9 Oct 2025 11:17:48 +0100
Message-Id: <20251009101748.529277-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
References: <20251006115615.2289526-1-matt@readmodwrite.com> <20251008150705.4090434-1-matt@readmodwrite.com> <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 08, 2025 at 06:35:29PM +0200, Jan Kara wrote:
> Hi Matt!
> 
> Nice talking to you again :)
 
Same. It's been too long :)

> On Wed 08-10-25 16:07:05, Matt Fleming wrote:
> 

[...]

> So this particular hang check warning will be silenced by [1]. That being
> said if the writeback is indeed taking longer than expected (depends on
> cgroup configuration etc.) these patches will obviously not fix it. Based
> on what you write below, are you saying that most of the time from these
> 225s is spent in the filesystem allocating blocks? I'd expect we'd spend
> most of the time waiting for IO to complete...
 
Yeah, you're right. Most of the time is spenting waiting for writeback
to complete.

> So I'm somewhat confused here. How big is the allocation request? Above you
> write that average size of order 9 bucket is < 1280 which is true and
> makes me assume the allocation is for 1 stripe which is 1280 blocks. But
> here you write about order 9 allocation.
 
Sorry, I muddled my words. The allocation request is for 1280 blocks.

> Anyway, stripe aligned allocations don't always play well with
> mb_optimize_scan logic, so you can try mounting the filesystem with
> mb_optimize_scan=0 mount option.

Thanks, but unfortunately running with mb_optimize_scan=0 gives us much
worse performance. It looks like it's taking a long time to write out
even 1 page to disk. The flusher thread has been running for 20+hours
now non-stop and it's blocking tasks waiting on writeback.

[Thu Oct  9 09:49:59 2025] INFO: task dockerd:45649 blocked for more than 70565 seconds.

mfleming@node:~$ ps -p 50674 -o pid,etime,cputime,comm
    PID     ELAPSED     TIME COMMAND
  50674    20:18:25 20:14:15 kworker/u400:20+flush-9:127

A perf profile shows:

# Overhead  Command          Shared Object      Symbol                             
# ........  ...............  .................  ...................................
#
    32.09%  kworker/u400:20  [kernel.kallsyms]  [k] ext4_get_group_info
            |          
            |--11.91%--ext4_mb_prefetch
            |          ext4_mb_regular_allocator
            |          ext4_mb_new_blocks
            |          ext4_ext_map_blocks
            |          ext4_map_blocks
            |          ext4_do_writepages
            |          ext4_writepages
            |          do_writepages
            |          __writeback_single_inode
            |          writeback_sb_inodes
            |          __writeback_inodes_wb
            |          wb_writeback
            |          wb_workfn
            |          process_one_work
            |          worker_thread
            |          kthread
            |          ret_from_fork
            |          ret_from_fork_asm
            |          
            |--7.23%--ext4_mb_regular_allocator
            |          ext4_mb_new_blocks
            |          ext4_ext_map_blocks
            |          ext4_map_blocks
            |          ext4_do_writepages
            |          ext4_writepages
            |          do_writepages
            |          __writeback_single_inode
            |          writeback_sb_inodes
            |          __writeback_inodes_wb
            |          wb_writeback
            |          wb_workfn
            |          process_one_work
            |          worker_thread
            |          kthread
            |          ret_from_fork
            |          ret_from_fork_asm

mfleming@node:~$ sudo perf ftrace latency -b  -p 50674 -T ext4_mb_regular_allocator -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |          0 |                                                |
     1 - 2    us |          0 |                                                |
     2 - 4    us |          0 |                                                |
     4 - 8    us |          0 |                                                |
     8 - 16   us |          0 |                                                |
    16 - 32   us |          0 |                                                |
    32 - 64   us |          0 |                                                |
    64 - 128  us |          0 |                                                |
   128 - 256  us |          0 |                                                |
   256 - 512  us |          0 |                                                |
   512 - 1024 us |          0 |                                                |
     1 - 2    ms |          0 |                                                |
     2 - 4    ms |          0 |                                                |
     4 - 8    ms |          0 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |         85 | #############################################  |
   128 - 256  ms |          1 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

mfleming@node:~$ sudo perf ftrace latency -b  -p 50674 -T ext4_mb_prefetch -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |        130 |                                                |
     1 - 2    us |    1962306 | ####################################           |
     2 - 4    us |     497793 | #########                                      |
     4 - 8    us |       4598 |                                                |
     8 - 16   us |        277 |                                                |
    16 - 32   us |         21 |                                                |
    32 - 64   us |         10 |                                                |
    64 - 128  us |          1 |                                                |
   128 - 256  us |          0 |                                                |
   256 - 512  us |          0 |                                                |
   512 - 1024 us |          0 |                                                |
     1 - 2    ms |          0 |                                                |
     2 - 4    ms |          0 |                                                |
     4 - 8    ms |          0 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |          0 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

mfleming@node:~$ sudo bpftrace -e 'fentry:vmlinux:writeback_sb_inodes / tid==50674/ { @in = args.work->nr_pages; @start=nsecs;} fexit:vmlinux:writeback_sb_inodes /tid == 50674/ { $delta = (nsecs - @start) / 1000000; printf("IN: work->nr_pages=%d, OUT: work->nr_pages=%d, wrote=%d page(s) in %dms\n", @in, args.work->nr_pages, @in - args.work->nr_pages, $delta);} END{clear(@in);} interval:s:5 { exit();}'
Attaching 4 probes...
IN: work->nr_pages=6095831, OUT: work->nr_pages=6095830, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095830, OUT: work->nr_pages=6095829, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095829, OUT: work->nr_pages=6095828, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095828, OUT: work->nr_pages=6095827, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095827, OUT: work->nr_pages=6095826, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095826, OUT: work->nr_pages=6095825, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095825, OUT: work->nr_pages=6095824, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095824, OUT: work->nr_pages=6095823, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095823, OUT: work->nr_pages=6095822, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095822, OUT: work->nr_pages=6095821, wrote=1 page(s) in 106ms

Thanks,
Matt


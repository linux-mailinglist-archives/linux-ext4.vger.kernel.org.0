Return-Path: <linux-ext4+bounces-37-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897867F0E61
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 10:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4961A282086
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD5107AB;
	Mon, 20 Nov 2023 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev8B99Gj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15710B8;
	Mon, 20 Nov 2023 01:04:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc2fc281cdso27642335ad.0;
        Mon, 20 Nov 2023 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700471087; x=1701075887; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP2pGqhjcW1cIuiHffLEE4yPgm+Ha/UDWGdnJ3PgW/s=;
        b=Ev8B99GjGIsuGmff5qc49zbzz0fkIzeaum6u5sabqbLjo4PS376CPVco7UeUAdfatc
         Su6goIfXBtEsytyhCX5kCbNxm7gqhUhBYKs9/SfgcJ5D/ZFct52aTFWGnA7xk7uQJFcG
         kJVVFDGkFM/pt+BP3vAVGJOtAiMeLhW5E3PukNzPjEhp9tsZZd4V03M0ooU+tqR6yTwY
         OUbzWn+gzCuwxGJXgTyzgNs6hNMabu8l7n0Ts9e2gxDg/BqJde+cG5mTfKGKbHTQax7W
         oYuCLfYEwUsvWUUIzI/xiel4C8Cp8kUU+eU24aUzhEJ14TlBKFDsuAFI43ZVKaSlB+n8
         KgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471087; x=1701075887;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZP2pGqhjcW1cIuiHffLEE4yPgm+Ha/UDWGdnJ3PgW/s=;
        b=j4ElTqXdQApSRRe71hnRQyiYuFCA/E2zo/683zzRMsvkgb1KMxno8T35arIEImBx1T
         cAt5AMFN5gXzXdUgMieZL+Gi3gwoVD6iJ2U/yODc+bOIPdHFg91Au6ec3AOai1ZMqWBA
         f6Voct2KJyFA0ZgE3W2unsU8/xhj0Ix2VQb52D94VcxKnMHArW9KwCWSdWlVGHlqGYl/
         Q6WRv1VwEuJ08Dgu3vUWlhBABwD8AWxy9QWz8fUApHfJI8X63bs2j6q6pXwN9Rj4n361
         hAPbXkm+yUJiKPqjRqc4bPt/9nPh1P8VCv9TbFl4Va3uvNICDM4D+TaeHaRvPkPkL1N7
         NnXw==
X-Gm-Message-State: AOJu0YwRTU4/MCZm8R68Ua/jYSRcMUGSm49rWC8xD8VH4onRcI2HppUQ
	Popf1KJyMmnMxK3WS+j9AShi3MgnPLYeOQ==
X-Google-Smtp-Source: AGHT+IEUlQG5PpnhVHUcFkVZilyCsDB9tsc2mW+VYDfgwTm51ozkMKDsha1GzPMpCFZggdSBJCH9Jw==
X-Received: by 2002:a17:902:d381:b0:1cc:5258:845c with SMTP id e1-20020a170902d38100b001cc5258845cmr4627042pld.57.1700471086948;
        Mon, 20 Nov 2023 01:04:46 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001c9c47d6cb9sm2563398pld.99.2023.11.20.01.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:04:46 -0800 (PST)
Message-ID: <8539e7cb-43d7-4191-bf55-6ac15b5e9e48@gmail.com>
Date: Mon, 20 Nov 2023 16:04:41 +0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Device Mapper <dm-devel@lists.linux.dev>,
 Linux ext4 <linux-ext4@vger.kernel.org>,
 Linux RAID <linux-raid@vger.kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Song Liu <song@kernel.org>,
 Matthew Stapleton <matthew4196@gmail.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: fdatasync to a block device seems to block writes on unrelated
 devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> I was running nwipe on a failing hard drive that was running very slow and while nwipe was running fdatasync it seemed to cause delays for the filesystems on the other drives.  The other drives are attached to the same onboard ahci sata adapter if that is important.  After stopping nwipe, performance returned to normal
> 
> The system is using ext4 filesystems on top of LVM on top of Linux RAID6 and the kernel is 6.1.53.
> 
> Is this a design problem with fdatasync or could it be something else?
> 
> Nov 18 08:10:27 server kernel: sysrq: Show Blocked State
> Nov 18 08:10:27 server kernel: task:nwipe           state:D stack:0     pid:61181 ppid:42337  flags:0x00004000
> Nov 18 08:10:27 server kernel: Call Trace:
> Nov 18 08:10:27 server kernel:  <TASK>
> Nov 18 08:10:27 server kernel:  __schedule+0x2f8/0x870
> Nov 18 08:10:27 server kernel:  schedule+0x55/0xc0
> Nov 18 08:10:27 server kernel:  io_schedule+0x3d/0x60
> Nov 18 08:10:27 server kernel:  folio_wait_bit_common+0x12c/0x300
> Nov 18 08:10:27 server kernel:  ? filemap_invalidate_unlock_two+0x30/0x30
> Nov 18 08:10:27 server kernel:  write_cache_pages+0x1c6/0x460
> Nov 18 08:10:27 server kernel:  ? dirty_background_bytes_handler+0x20/0x20
> Nov 18 08:10:27 server kernel:  generic_writepages+0x76/0xa0
> Nov 18 08:10:27 server kernel:  do_writepages+0xbb/0x1c0
> Nov 18 08:10:27 server kernel:  filemap_fdatawrite_wbc+0x56/0x80
> Nov 18 08:10:27 server kernel:  __filemap_fdatawrite_range+0x53/0x70
> Nov 18 08:10:27 server kernel:  file_write_and_wait_range+0x3c/0x90
> Nov 18 08:10:27 server kernel:  blkdev_fsync+0xe/0x30
> Nov 18 08:10:27 server kernel:  __x64_sys_fdatasync+0x46/0x80
> Nov 18 08:10:27 server kernel:  do_syscall_64+0x3a/0xb0
> Nov 18 08:10:27 server kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
> Nov 18 08:10:27 server kernel: RIP: 0033:0x7f02a735f00b
> Nov 18 08:10:27 server kernel: RSP: 002b:00007f02a6858c80 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
> Nov 18 08:10:27 server kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f02a735f00b
> Nov 18 08:10:27 server kernel: RDX: 0000000000000002 RSI: 00007f02a6858d80 RDI: 0000000000000004
> Nov 18 08:10:27 server kernel: RBP: 00000118badb6000 R08: 0000000000000000 R09: 00007f02a0000080
> Nov 18 08:10:27 server kernel: R10: 0000000000001000 R11: 0000000000000293 R12: 00000000000186a0
> Nov 18 08:10:27 server kernel: R13: 00000000000186a0 R14: 0000000000001000 R15: 000055b7a0775850
> Nov 18 08:10:27 server kernel:  </TASK>
> Nov 18 08:10:27 server kernel: task:kworker/u64:4   state:D stack:0     pid:7842  ppid:2      flags:0x00004000
> Nov 18 08:10:27 server kernel: Workqueue: writeback wb_workfn (flush-8:0)
> Nov 18 08:10:27 server kernel: Call Trace:
> Nov 18 08:10:27 server kernel:  <TASK>
> Nov 18 08:10:27 server kernel:  __schedule+0x2f8/0x870
> Nov 18 08:10:27 server kernel:  schedule+0x55/0xc0
> Nov 18 08:10:27 server kernel:  io_schedule+0x3d/0x60
> Nov 18 08:10:27 server kernel:  blk_mq_get_tag+0x115/0x2a0
> Nov 18 08:10:27 server kernel:  ? destroy_sched_domains_rcu+0x20/0x20
> Nov 18 08:10:27 server kernel:  __blk_mq_alloc_requests+0x18c/0x2e0
> Nov 18 08:10:27 server kernel:  blk_mq_submit_bio+0x3dc/0x590
> Nov 18 08:10:27 server kernel:  __submit_bio+0xec/0x170
> Nov 18 08:10:27 server kernel:  submit_bio_noacct_nocheck+0x2bd/0x2f0
> Nov 18 08:10:27 server kernel:  ? submit_bio_noacct+0x68/0x440
> Nov 18 08:10:27 server kernel:  __block_write_full_page+0x1ef/0x4c0
> Nov 18 08:10:27 server kernel:  ? bh_uptodate_or_lock+0x70/0x70
> Nov 18 08:10:27 server kernel:  ? blkdev_write_begin+0x20/0x20
> Nov 18 08:10:27 server kernel:  __writepage+0x14/0x60
> Nov 18 08:10:27 server kernel:  write_cache_pages+0x172/0x460
> Nov 18 08:10:27 server kernel:  ? dirty_background_bytes_handler+0x20/0x20
> Nov 18 08:10:27 server kernel:  generic_writepages+0x76/0xa0
> Nov 18 08:10:27 server kernel:  do_writepages+0xbb/0x1c0
> Nov 18 08:10:27 server kernel:  ? __wb_calc_thresh+0x46/0x130
> Nov 18 08:10:27 server kernel:  __writeback_single_inode+0x30/0x1a0
> Nov 18 08:10:27 server kernel:  writeback_sb_inodes+0x205/0x4a0
> Nov 18 08:10:27 server kernel:  __writeback_inodes_wb+0x47/0xe0
> Nov 18 08:10:27 server kernel:  wb_writeback.isra.0+0x189/0x1d0
> Nov 18 08:10:27 server kernel:  wb_workfn+0x1d0/0x3a0
> Nov 18 08:10:27 server kernel:  process_one_work+0x1e5/0x320
> Nov 18 08:10:27 server kernel:  worker_thread+0x45/0x3a0
> Nov 18 08:10:27 server kernel:  ? rescuer_thread+0x390/0x390
> Nov 18 08:10:27 server kernel:  kthread+0xd5/0x100
> Nov 18 08:10:27 server kernel:  ? kthread_complete_and_exit+0x20/0x20
> Nov 18 08:10:27 server kernel:  ret_from_fork+0x22/0x30
> Nov 18 08:10:27 server kernel:  </TASK>
> Nov 18 08:10:27 server kernel: task:rm              state:D stack:0     pid:54615 ppid:54597  flags:0x00004000
> Nov 18 08:10:27 server kernel: Call Trace:
> Nov 18 08:10:27 server kernel:  <TASK>
> Nov 18 08:10:27 server kernel:  __schedule+0x2f8/0x870
> Nov 18 08:10:27 server kernel:  schedule+0x55/0xc0
> Nov 18 08:10:27 server kernel:  io_schedule+0x3d/0x60
> Nov 18 08:10:27 server kernel:  bit_wait_io+0x8/0x50
> Nov 18 08:10:27 server kernel:  __wait_on_bit+0x46/0x100
> Nov 18 08:10:27 server kernel:  ? bit_wait+0x50/0x50
> Nov 18 08:10:27 server kernel:  out_of_line_wait_on_bit+0x8c/0xb0
> Nov 18 08:10:27 server kernel:  ? sugov_start+0x140/0x140
> Nov 18 08:10:27 server kernel:  ext4_read_bh+0x6e/0x80
> Nov 18 08:10:27 server kernel:  ext4_bread+0x45/0x60
> Nov 18 08:10:27 server kernel:  __ext4_read_dirblock+0x4d/0x330
> Nov 18 08:10:27 server kernel:  htree_dirblock_to_tree+0xa7/0x370
> Nov 18 08:10:27 server kernel:  ? path_lookupat+0x92/0x190
> Nov 18 08:10:27 server kernel:  ? filename_lookup+0xdf/0x1e0
> Nov 18 08:10:27 server kernel:  ext4_htree_fill_tree+0x108/0x3c0
> Nov 18 08:10:27 server kernel:  ext4_readdir+0x725/0xb40
> Nov 18 08:10:27 server kernel:  iterate_dir+0x16a/0x1b0
> Nov 18 08:10:27 server kernel:  __x64_sys_getdents64+0x7f/0x120
> Nov 18 08:10:27 server kernel:  ? compat_filldir+0x180/0x180
> Nov 18 08:10:27 server kernel:  do_syscall_64+0x3a/0xb0
> Nov 18 08:10:27 server kernel:  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
> Nov 18 08:10:27 server kernel: RIP: 0033:0x7f8e32834897
> Nov 18 08:10:27 server kernel: RSP: 002b:00007fffa3fb78c8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
> Nov 18 08:10:27 server kernel: RAX: ffffffffffffffda RBX: 0000558d8c4f8a70 RCX: 00007f8e32834897
> Nov 18 08:10:27 server kernel: RDX: 0000000000008000 RSI: 0000558d8c4f8aa0 RDI: 0000000000000004
> Nov 18 08:10:27 server kernel: RBP: 0000558d8c4f8aa0 R08: 0000000000000030 R09: 00007f8e3292da60
> Nov 18 08:10:27 server kernel: R10: 00007f8e3292e140 R11: 0000000000000293 R12: ffffffffffffff88
> Nov 18 08:10:27 server kernel: R13: 0000558d8c4f8a74 R14: 0000000000000000 R15: 0000558d8c503c78
> Nov 18 08:10:27 server kernel:  </TASK>

And then ...

> Also, I was running badblocks -b 4096 -w -s -v on the failing hard drive for a few days before trying nwipe and it didn't seem to be causing slowdowns on the server and the man page for badblocks says it uses Direct I/O by default.  I decided to try nwipe as it provides the option disable read verifying.
> 
> I could probably try removing fdatasync from nwipe or modifying it to use Direct I/O, but I haven't done that yet.

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218158

-- 
An old man doll... just what I always wanted! - Clara


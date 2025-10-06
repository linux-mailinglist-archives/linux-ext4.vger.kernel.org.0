Return-Path: <linux-ext4+bounces-10637-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F407BBDEF4
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049C33B4102
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FA27602E;
	Mon,  6 Oct 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uGBW4ypu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A5275864
	for <linux-ext4@vger.kernel.org>; Mon,  6 Oct 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751782; cv=none; b=MyuA8ZKQimdW1lc+TBH10wqA3xGWLjWIIRnZ1rntg0WVJmd9KwGQRq0uGVrf7YcH7f8bDvsm4arvDl2qSw5o9Qtej/Z1pFpFKDJh0QnWx+cr2bqs8gOYVAdh0uxCGJ8mBsOzLBUR+hFc/G2uycIeJVy97umN1JyAn4LGyzlsnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751782; c=relaxed/simple;
	bh=wrbHTVgjTq2O8XParlMCWpyu37Ui/UVjk417+ozSffY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxEM0nbz1EC3Y5lT+DvapkST/zrF8hPjIR35PS5AInSCoRdgpXuvW4J/GvuLuqy1zW/AZraE06T7+6DE+MUvHuEVc2Ld1t3y1ALNpZI/m/MgEm0zdXAEwclP0qVkLLNLPVmvAmzvrM0sKIvnelTmSOgJBWCRlxA90M5LdRqN3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uGBW4ypu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4395903f8f.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Oct 2025 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1759751778; x=1760356578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=uGBW4ypu9qZztNYMii3UQuwE6a8QChNiNYr86UHjoMvm9hoC0pgON4tfxCntCnF4PF
         HV7gVw6Up3Nlg/4L0svu3+ze8WuDMrNaeXq57U43WEQ22fwYs891nXmSHDulDo42mL2P
         umOGqqolU17vBjRjUAv0qdh9toWXT1zEndmpqgJvq9PJEiq6MrCLLadxa1ZVCkj5WLB2
         S62MLKel7VtDYwaCpT36f63D1pOSM+eow4ov0ZMjIBvPJxwX5H+04LH7/2Gd2ieUzmGD
         5RUSKsSuM/61y3hzqAR8wfOvjh+s8opK80s1OtD73Kg8Fp+DYSuxTVviOvHlQnSJUOlr
         8HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751778; x=1760356578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=VZjFYaWo8LGYrTnz7I+lfUfPJUdjCXwpD4g8tw8xSSc9bQMILiV7z15xrzlx1WjpNK
         /wCMLi7TrE07FtCzwy0ZZWIPQeOAB2A6BlyIhODvWRlZGB0wdsIAkf4pxZbf6VcCpgxR
         +8D4JgDmEO9X8X0gcFGHOeAnDNSH3+7JGSYEYNu3+u35b1Sj/zyLXxsxiQ6b0hzr538B
         aJ9GlXRfNKMtNRM6no+pHHUXooKrjkcpkYE32voO7chpJ4nqn9N1RnNIhLI07PwTG4DD
         8pj2J1rF1b3WWDVzDmJTJcVgKz/KjA0xWoLBGt6KdE6cX48c0UHolz3+RZ04/QN6e1bE
         1lOg==
X-Gm-Message-State: AOJu0Yyg4MAWUs6fDz5g5Ts4ynr3gMCxvAj1nw3BHMBn/i0qup5AkMnv
	0GQnYDUJfEYRCNsiCVnSJCQpI9HQ3+Z39DfR5xR2hSI3EDez11qUtfj6GgzFYl4engw=
X-Gm-Gg: ASbGnctUvZdLHukYogBayE+vFOkQzdxRTYeRuP65CN2uom0FvPcv9mPiWz5wERow8Dh
	gADsMIEw10888zqzpWki1tLzZTkZJUOp2aXh0wn5zVgQBHsoe8gEEN6jdJrKpG0m3nftNHRtgp3
	7en2KUoHRnRgkZDTE8ob3eUBveP86JdBNawwIRC7DtApt1NLkQMJYiyXXnJ4tHo6sH6JB3VCnLX
	yV0JU5ZJP7kU0l/P2/zktlOaaYzfUYpV4NTAxoLPIrgu1Q0I0tkCfeWSs69W4ahsBmZPlA6a7Vc
	a8LW+M84umZv66xy7YR9aMls+9g+Mv3X9Abl5A62U57ndSKJFjizSZAMF4l9DZ9/kW+xnV1Mrgs
	XQ+4RabqiB/GwvXh3Vggh1HzTGkPJPJJ72qZsUtLlJYZdiQK5FryPxgTWCw==
X-Google-Smtp-Source: AGHT+IHcu55JZb+QMGkTtdqsOpdfQTS9H0v4wFjgnm088OjhN8myHoA2yHtMbs7aZj1YDYIl3fN4uQ==
X-Received: by 2002:a05:6000:604:b0:424:211a:4141 with SMTP id ffacd0b85a97d-42567165eabmr8187487f8f.27.1759751777806;
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72343260sm154020345e9.4.2025.10.06.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: ext4 writeback performance issue in 6.12
Date: Mon,  6 Oct 2025 12:56:15 +0100
Message-Id: <20251006115615.2289526-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We're seeing writeback take a long time and triggering blocked task
warnings on some of our database nodes, e.g.

  INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
        Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
  Workqueue: cgroup_destroy css_free_rwork_fn
  Call Trace:
   <TASK>
   __schedule+0x4fb/0xbf0
   schedule+0x27/0xf0
   wb_wait_for_completion+0x5d/0x90
   ? __pfx_autoremove_wake_function+0x10/0x10
   mem_cgroup_css_free+0x19/0xb0
   css_free_rwork_fn+0x4e/0x430
   process_one_work+0x17e/0x330
   worker_thread+0x2ce/0x3f0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xd2/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

A large chunk of system time (4.43%) is being spent in the following
code path:

   ext4_get_group_info+9
   ext4_mb_good_group+41
   ext4_mb_find_good_group_avg_frag_lists+136
   ext4_mb_regular_allocator+2748
   ext4_mb_new_blocks+2373
   ext4_ext_map_blocks+2149
   ext4_map_blocks+294
   ext4_do_writepages+2031
   ext4_writepages+173
   do_writepages+229
   __writeback_single_inode+65
   writeback_sb_inodes+544
   __writeback_inodes_wb+76
   wb_writeback+413
   wb_workfn+196
   process_one_work+382
   worker_thread+718
   kthread+210
   ret_from_fork+52
   ret_from_fork_asm+26

That's the path through the CR_GOAL_LEN_FAST allocator.

The primary reason for all these cycles looks to be that we're spending
a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
lists seem quite big and the function fails to find a suitable group
pretty much every time it's called either because the frag list is empty
(orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
falls back to a linear scan at that point.

  https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8

$ sudo cat /proc/fs/ext4/md127/mb_structs_summary
optimize_scan: 1
max_free_order_lists:
	list_order_0_groups: 0
	list_order_1_groups: 1
	list_order_2_groups: 6
	list_order_3_groups: 42
	list_order_4_groups: 513
	list_order_5_groups: 62
	list_order_6_groups: 434
	list_order_7_groups: 2602
	list_order_8_groups: 10951
	list_order_9_groups: 44883
	list_order_10_groups: 152357
	list_order_11_groups: 24899
	list_order_12_groups: 30461
	list_order_13_groups: 18756
avg_fragment_size_lists:
	list_order_0_groups: 108
	list_order_1_groups: 411
	list_order_2_groups: 1640
	list_order_3_groups: 5809
	list_order_4_groups: 14909
	list_order_5_groups: 31345
	list_order_6_groups: 54132
	list_order_7_groups: 90294
	list_order_8_groups: 77322
	list_order_9_groups: 10096
	list_order_10_groups: 0
	list_order_11_groups: 0
	list_order_12_groups: 0
	list_order_13_groups: 0

These machines are striped and are using noatime:

$ grep ext4 /proc/mounts
/dev/md127 /state ext4 rw,noatime,stripe=1280 0 0

Is there some tunable or configuration option that I'm missing that
could help here to avoid wasting time in
ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
fail an order 9 allocation anyway?

I'm happy to provide any more details that might help.

Thanks,
Matt


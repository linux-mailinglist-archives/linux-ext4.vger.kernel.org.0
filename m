Return-Path: <linux-ext4+bounces-3775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E10956821
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DD283899
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B501607A4;
	Mon, 19 Aug 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="VbSc8Kxi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4015E5CC
	for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062790; cv=none; b=ExdepddgZNwVOvZ2120E2WDlS3Ak538VsDuQLhkRHwpIm5fb6mxBbkhvXSvVEzG3gAFNAPGKvHUMWdcOvO7SVlnSQClHVyHH9zz52mNcTHzjv8A55rh2LrCrDguRONBfwoHe6LzlXKcw8eMtm5KoMZUQDMPujSk98dzBzUuRxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062790; c=relaxed/simple;
	bh=HRrXeSpqxMn4cHbV5csnXIpRlyy3gL+5H+8DomyTLfU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JT7WVEhujlrAYK3YN6DQRFDl0i4/ZXJzzAp/V33LGaOvS15AgECHJQAlygleWlsI0r3vqtnDFtK1NDPWk4N1TVEpB6hTM+iDuB/IPlxvjbTEnlYcrXGk7LFRMukS3cX+d92ex94MMDSQVHHwNEui0vBrPSA3ZDAtEYqkusxID74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=VbSc8Kxi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3dacaccfaso2226034a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1724062788; x=1724667588; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w10OW70sQb54xoO4mS/lvMMIc5OboPqe69kRxVXxMU8=;
        b=VbSc8KxiBWy/8fXuteU0Yf0oYRz46WfXds1IWi3hu7NveAmBAaM8UnX5pLwW0qT29W
         PFS5ziwBUGtYnHDb/FneLOeNVH3L+xhODnSP0S+nNLVy2819QK7VMNB8tj5Tp15ybA5Y
         Ep2MdrA4D2qQYHHm7upYnssxTtvUuWFBnxV4om+QKr/Ire8k3DxSR26Kyntf7yHm91gu
         d5rd96vNBhX1jIBTG6wqyzrNH9WtbSNOpuYDRyTRrbl9lnpaZsOa2Ryy9shwTsBCUS9c
         fHn55yDVolrgLkCTTb4kSoewWUxb32kF/FuSz30LZBhreEc/wRxZN7N+lE/rlefvQxF8
         ywTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062788; x=1724667588;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w10OW70sQb54xoO4mS/lvMMIc5OboPqe69kRxVXxMU8=;
        b=XPVwAxkGJ31eyl0fWg65H+Kcc8zle5JqrxhlfxlXw6toedfib6+LFnu3ZGJD1KDyPa
         5Oa2azUuo1+dly5NMBvmgfzj5KjC08BrXVoJA4+GcC5/LTmLrMQcFuBSwC6tQuhp8bnX
         sXH0dLWBM4TnHL6hfB1hNdVNcdC103eCTd/6mS9ETHU1gRTcIuPAv75QLXwHJSk3gzGv
         MuK+d+L8TFTWmlRFXv3/nlQy6aPL8urm08rEA9apneeKQsQTwDHdWmH/4BPco7hAvW/E
         /ftgTxAg2MxunKWTfibPcapYupom9Zo7YMvRpia9u/Rn6upkMY7aIrVfVJ8hifVBw+wM
         XKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsSJ04lmISf6rRtjg5Um/FNmYpOuyrst8i8uyv1p6IHB+dzdF+pQH9T0AjRr3mcdg/fmGzK92NxkfxK8g5dct9opDjpp5vvdD7jw==
X-Gm-Message-State: AOJu0Yx12OLCyZEAy0C+jgQDLwY9Ys/8qeOZHAnhMGOy0t/VkWTTYKTx
	YPkl93hyT0ZteYCytol4mb/W2gCQy0MrF0txdzhyRNB3rSHS03S2NOSDCY0fO/M=
X-Google-Smtp-Source: AGHT+IHE0HpPiE6oZpBycdlavux+wGOK5rdOlRFxbuSYY4TFf5U13iDlBYp5KOvTAaSSSIk9pF9oJg==
X-Received: by 2002:a17:90a:8984:b0:2d3:b7c7:d67f with SMTP id 98e67ed59e1d1-2d3e00ec434mr9120332a91.26.1724062788144;
        Mon, 19 Aug 2024 03:19:48 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e70c88d1sm6666751a91.21.2024.08.19.03.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:19:47 -0700 (PDT)
Message-ID: <9914a4b4-eb4d-44de-a48c-8ae08eedebe8@shopee.com>
Date: Mon, 19 Aug 2024 18:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Haifeng Xu <haifeng.xu@shopee.com>
Subject: jbd2: io throttle for metadata buffers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, matsers!


We encountered high load issuses in our production environment recently. And the kernel version is stable-5.15.39
the filesystem is ext4(ordered).


After digging into it, we found the problem is due to io.max


thread 1:                                             

PID: 189529  TASK: ffff92ab51e5c080  CPU: 34  COMMAND: "mc"
 #0 [ffffa638db807800] __schedule at ffffffff83b19898
 #1 [ffffa638db807888] schedule at ffffffff83b19e9e
 #2 [ffffa638db8078a8] io_schedule at ffffffff83b1a316
 #3 [ffffa638db8078c0] bit_wait_io at ffffffff83b1a751
 #4 [ffffa638db8078d8] __wait_on_bit at ffffffff83b1a373
 #5 [ffffa638db807918] out_of_line_wait_on_bit at ffffffff83b1a46d
 #6 [ffffa638db807970] __wait_on_buffer at ffffffff831b9c64
 #7 [ffffa638db807988] jbd2_log_do_checkpoint at ffffffff832b556e
 #8 [ffffa638db8079e8] __jbd2_log_wait_for_space at ffffffff832b55dc
 #9 [ffffa638db807a30] add_transaction_credits at ffffffff832af369
#10 [ffffa638db807a98] start_this_handle at ffffffff832af50f
#11 [ffffa638db807b20] jbd2__journal_start at ffffffff832afe1f
#12 [ffffa638db807b60] __ext4_journal_start_sb at ffffffff83241af3
#13 [ffffa638db807ba8] __ext4_new_inode at ffffffff83253be6
#14 [ffffa638db807c80] ext4_mkdir at ffffffff8327ec9e
#15 [ffffa638db807d10] vfs_mkdir at ffffffff83182a92
#16 [ffffa638db807d50] ovl_mkdir_real at ffffffffc0965c9f [overlay]
#17 [ffffa638db807d80] ovl_create_real at ffffffffc0965e8b [overlay]
#18 [ffffa638db807db8] ovl_create_or_link at ffffffffc09677cc [overlay]
#19 [ffffa638db807e10] ovl_create_object at ffffffffc0967a48 [overlay]
#20 [ffffa638db807e60] ovl_mkdir at ffffffffc0967ad3 [overlay]
#21 [ffffa638db807e70] vfs_mkdir at ffffffff83182a92
#22 [ffffa638db807eb0] do_mkdirat at ffffffff83184305
#23 [ffffa638db807f08] __x64_sys_mkdirat at ffffffff831843df
#24 [ffffa638db807f28] do_syscall_64 at ffffffff83b0bf1c
#25 [ffffa638db807f50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c

other threads:


PID: 21125  TASK: ffff929f5b9a0000  CPU: 44  COMMAND: "task_server"
 #0 [ffffa638aff9b900] __schedule at ffffffff83b19898
 #1 [ffffa638aff9b988] schedule at ffffffff83b19e9e
 #2 [ffffa638aff9b9a8] schedule_preempt_disabled at ffffffff83b1a24e
 #3 [ffffa638aff9b9b8] __mutex_lock at ffffffff83b1af28
 #4 [ffffa638aff9ba38] __mutex_lock_slowpath at ffffffff83b1b1a3
 #5 [ffffa638aff9ba48] mutex_lock at ffffffff83b1b1e2
 #6 [ffffa638aff9ba60] mutex_lock_io at ffffffff83b1b210
 #7 [ffffa638aff9ba80] __jbd2_log_wait_for_space at ffffffff832b563b
 #8 [ffffa638aff9bac8] add_transaction_credits at ffffffff832af369
 #9 [ffffa638aff9bb30] start_this_handle at ffffffff832af50f
#10 [ffffa638aff9bbb8] jbd2__journal_start at ffffffff832afe1f
#11 [ffffa638aff9bbf8] __ext4_journal_start_sb at ffffffff83241af3
#12 [ffffa638aff9bc40] ext4_dirty_inode at ffffffff83266d0a
#13 [ffffa638aff9bc60] __mark_inode_dirty at ffffffff831ab423
#14 [ffffa638aff9bca0] generic_update_time at ffffffff8319169d
#15 [ffffa638aff9bcb0] inode_update_time at ffffffff831916e5
#16 [ffffa638aff9bcc0] file_update_time at ffffffff83191b01
#17 [ffffa638aff9bd08] file_modified at ffffffff83191d47
#18 [ffffa638aff9bd20] ext4_write_checks at ffffffff8324e6e4
#19 [ffffa638aff9bd40] ext4_buffered_write_iter at ffffffff8324edfb
#20 [ffffa638aff9bd78] ext4_file_write_iter at ffffffff8324f553
#21 [ffffa638aff9bdf8] ext4_file_write_iter at ffffffff8324f505
#22 [ffffa638aff9be00] new_sync_write at ffffffff8316dfca
#23 [ffffa638aff9be90] vfs_write at ffffffff8316e975
#24 [ffffa638aff9bec8] ksys_write at ffffffff83170a97
#25 [ffffa638aff9bf08] __x64_sys_write at ffffffff83170b2a
#26 [ffffa638aff9bf18] do_syscall_64 at ffffffff83b0bf1c
#27 [ffffa638aff9bf38] asm_common_interrupt at ffffffff83c00cc8
#28 [ffffa638aff9bf50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c


The cgroup of thread1 has set io.max, so the j_checkpoint_mutex can't be released and many threads must wait for it.
I have some questions about the throttle for the metadata buffers.

1) writeback 

jbd2 converts the buffer head from jbddirty to buffer_dirty and trigger the write back in __jbd2_journal_temp_unlink_buffer().
By default, the blkcg in bdi_writeback attached to block device inode is blkcg_root which has no io throttle rules. But there may be other
threads which invoke sync_filesystem, such as umount overlayfs. This operation will write out all dirty data associated with the block
device. In this case, the bdi_writeback attached to block device inode may changed due to Boyer-Moore majority vote algorithm.
And the blkcg in bdi_writeback attached to block device inode is the group where the thread allocate the buffer head and dev page.

So the writeback process of metadata buffers can also be throttled, right?


2) checkpoint

If the free log space is not suffcient, we will do checkpoint to update log tail. During the process, if the buffer head hasn't been 
written out by wirteback. we will lock the buffer head and submit bio in current context.

So the throttle rules may be different from writeback?


3）j_checkpoint_mutex
If we can't make any progress in checkpoint due to io throttle, the j_checkpoint_mutex can'be release and block many others threads.

So can we cancel the throttle rules for metadata buffers and keep it in blkcg_root?

Thanks!



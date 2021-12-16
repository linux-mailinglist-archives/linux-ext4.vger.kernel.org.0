Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C8477EE7
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Dec 2021 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhLPVgc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 16:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhLPVgc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 16:36:32 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5AC061574
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 13:36:32 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so282075qke.8
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 13:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKVmuY5Rba11WVq3tPixbwRDujQ2lDJwqCPyeSzdRIE=;
        b=JiQZKyA/RVyPxmpsp8VXnz7Ss4qgxrNjmsQk7K8dzPEgtL6WOYGcDAKwxjgGjUZ7VZ
         uOsIcjR3x//6l0mIdmj8iIovTR/htlT5Xl1I8fucxjuGe9T5y5s0T9ErCfF8hRksEHAP
         lJYDsx1jjVubP8bWLpCstOY/ryeIvW3JHjoSEgge/qMM9IocLsPAgUnEmuDPfbVkeMGd
         pG6Yru1ESTgXeCtFCXREST11fS+XdjWjkoOxhail3P9Qx0A6Nch2VPJiIEEPbqReNPOW
         JYFCM6M6+dwtSqGFqNYttLnRu4xhI9+12y/WAMaYdANHaDjyet3HCat5C8eDCHfqIeqX
         Bk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKVmuY5Rba11WVq3tPixbwRDujQ2lDJwqCPyeSzdRIE=;
        b=KtCTW1X486UzubU0oBAv6jt7NXjK5qzH0jozMbjPdKAaWxFFZYahH9B/nOYE2IdXp5
         ZoDVq5LwLp0M0iKQpe/OO8a4kNGmzyp4IcSrM9oltxEt/9qeWDV1Rd1v9wDU2teU5pk6
         v8O+J0p8ZwQOcWDb3B1eNiKZB9m7nZyb6UxYBMrHjwHfFCNgJjdMq2GZ7Dc/l9uITX/o
         AypdY5cRax4nGWvoirPx6ZXDkArIM6FpG1L2CqI0EkFEkf3N2By45WDKJT4Nvakk8UKb
         /WvW/z89Ax17hq1hTHJsBmFyLr2gmbzEhMt+v6GzwqHsrzYfTpjeD1+PiO4u0ahqChos
         jTZA==
X-Gm-Message-State: AOAM531OAc+CSG2CoBX1m4K+Tckssp+zVzylea11880PK7BIuT79ofGw
        uGh3q9052DcMw2dXc4CMTI4BhgLu0BY=
X-Google-Smtp-Source: ABdhPJwcft7bmxrVncghdhG/+lDRU0Fj8SWknSyYQJrudyzV+V4T1rV+Yp/HeaiRUkriH6oJzHtxrA==
X-Received: by 2002:a05:620a:38f:: with SMTP id q15mr12939540qkm.291.1639690591096;
        Thu, 16 Dec 2021 13:36:31 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id j20sm5150461qtj.43.2021.12.16.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:36:30 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:36:29 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     harshadshirwadkar@gmail.com
Cc:     linux-ext4@vger.kernel.org
Subject: Re: generic/083 triggers hang on 5.16-rc5 w/fast_commit
Message-ID: <20211216213628.GA18665@localhost.localdomain>
References: <20211215193323.GA24187@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215193323.GA24187@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> I'm observing kernel hangs when running generic/083 using the latest version
> of the xfstests-bld test appliance on 5.16-rc5 with the adv test case.  The
> hangs typically occur once in 16 or 17 trials.  This is not a regression in
> 5.16, as it's reproducible in 5.15.  Modifying the adv test case to exclude
> the inline_data feature and then all features results in 100 passed tests
> out of 100 trials in each case.  Modifying adv to include only the fast_commit
> feature leads to hangs at the same rate as described above.  Output from a hung
> test run follows below.
> 
> Thanks,
> Eric
> 
> generic/083 5s ... 	[16:09:08][   24.909037] run fstests generic/083 at 2028
> [   25.266112] EXT4-fs (vdc): mounted filesystem with ordered data mode. Opts: .
> [  245.414394] INFO: task jbd2/vdc-8:4436 blocked for more than 122 seconds.
> [  245.418977]       Not tainted 5.16.0-rc5 #1
> [  245.421909] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.425207] task:jbd2/vdc-8      state:D stack:    0 pid: 4436 ppid:     2 f0
> [  245.426372] Call Trace:
> [  245.426777]  <TASK>
> [  245.427130]  __schedule+0x309/0xab0
> [  245.427722]  ? lock_release+0x132/0x2a0
> [  245.428338]  ? wait_woken+0x60/0x60
> [  245.428899]  schedule+0x44/0xc0
> [  245.429407]  jbd2_journal_commit_transaction+0x174/0x1e40
> [  245.430276]  ? find_held_lock+0x2d/0x90
> [  245.430920]  ? try_to_del_timer_sync+0x4d/0x80
> [  245.431622]  ? wait_woken+0x60/0x60
> [  245.432189]  ? _raw_spin_unlock_irqrestore+0x3b/0x50
> [  245.432982]  ? try_to_del_timer_sync+0x4d/0x80
> [  245.433692]  kjournald2+0xcc/0x2a0
> [  245.434263]  ? wait_woken+0x60/0x60
> [  245.434820]  ? commit_timeout+0x10/0x10
> [  245.435435]  kthread+0x164/0x190
> [  245.435957]  ? set_kthread_struct+0x40/0x40
> [  245.436630]  ret_from_fork+0x22/0x30
> [  245.437218]  </TASK>
> [  245.437602] INFO: task fsstress:4440 blocked for more than 122 seconds.
> [  245.438643]       Not tainted 5.16.0-rc5 #1
> [  245.439306] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.440513] task:fsstress        state:D stack:    0 pid: 4440 ppid:  4439 f0
> [  245.441857] Call Trace:
> [  245.442240]  <TASK>
> [  245.442530]  __schedule+0x309/0xab0
> [  245.442903]  schedule+0x44/0xc0
> [  245.443237]  jbd2_log_wait_commit+0x119/0x190
> [  245.444011]  ? wait_woken+0x60/0x60
> [  245.444616]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.445374]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.446181]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.446882]  ext4_da_write_begin+0xf2/0x310
> [  245.447572]  generic_perform_write+0xf0/0x1d0
> [  245.448258]  ? generic_update_time+0xa0/0xc0
> [  245.448935]  ? file_update_time+0xd4/0x110
> [  245.449582]  ext4_buffered_write_iter+0x88/0x120
> [  245.450314]  ext4_file_write_iter+0x5f/0x8a0
> [  245.451011]  ? lock_is_held_type+0xd8/0x130
> [  245.451662]  ? find_held_lock+0x2d/0x90
> [  245.452275]  do_iter_readv_writev+0x169/0x1d0
> [  245.452972]  do_iter_write+0x83/0x1c0
> [  245.453554]  iter_file_splice_write+0x265/0x390
> [  245.454298]  direct_splice_actor+0x31/0x40
> [  245.454934]  splice_direct_to_actor+0xfb/0x220
> [  245.455640]  ? pipe_to_sendpage+0xa0/0xa0
> [  245.456279]  do_splice_direct+0xa0/0xd0
> [  245.456895]  vfs_copy_file_range+0x1b6/0x5b0
> [  245.457590]  __x64_sys_copy_file_range+0xdd/0x200
> [  245.458325]  do_syscall_64+0x3a/0x80
> [  245.458891]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.459682] RIP: 0033:0x7f9419fb5f59
> [  245.460247] RSP: 002b:00007ffdf52d2428 EFLAGS: 00000246 ORIG_RAX: 00000000006
> [  245.461444] RAX: ffffffffffffffda RBX: 00007ffdf52d2478 RCX: 00007f9419fb5f59
> [  245.462537] RDX: 0000000000000004 RSI: 00007ffdf52d2470 RDI: 0000000000000003
> [  245.463640] RBP: 0000000000019f46 R08: 0000000000019f46 R09: 0000000000000000
> [  245.464770] R10: 00007ffdf52d2478 R11: 0000000000000246 R12: 0000000000000004
> [  245.465876] R13: 00007ffdf52d2470 R14: 0000000000000003 R15: 000000000009858f
> [  245.466989]  </TASK>
> [  245.467343] INFO: task fsstress:4441 blocked for more than 122 seconds.
> [  245.468383]       Not tainted 5.16.0-rc5 #1
> [  245.469031] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.470238] task:fsstress        state:D stack:    0 pid: 4441 ppid:  4439 f0
> [  245.471436] Call Trace:
> [  245.471681]  <TASK>
> [  245.471924]  __schedule+0x309/0xab0
> [  245.472683]  schedule+0x44/0xc0
> [  245.473181]  jbd2_log_wait_commit+0x119/0x190
> [  245.473869]  ? wait_woken+0x60/0x60
> [  245.474448]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.475197]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.476004]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.476709]  ext4_write_begin+0x168/0x520
> [  245.477352]  __page_symlink+0xbe/0x110
> [  245.477977]  ext4_symlink+0x1db/0x3d0
> [  245.478561]  vfs_symlink+0x109/0x1b0
> [  245.479124]  do_symlinkat+0xde/0xf0
> [  245.479685]  __x64_sys_symlink+0x37/0x40
> [  245.480306]  do_syscall_64+0x3a/0x80
> [  245.480903]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.481677] RIP: 0033:0x7f9419fadf07
> [  245.482266] RSP: 002b:00007ffdf52d2c58 EFLAGS: 00000206 ORIG_RAX: 00000000008
> [  245.483436] RAX: ffffffffffffffda RBX: 000000000000023d RCX: 00007f9419fadf07
> [  245.484573] RDX: 0000000000000064 RSI: 00005595aed07d60 RDI: 00005595aed0bd00
> [  245.485680] RBP: 00005595aed0bd00 R08: 0000000000000004 R09: 00005595aecf3980
> [  245.486774] R10: 0000000000000006 R11: 0000000000000206 R12: 00005595aed07d60
> [  245.487901] R13: 00007ffdf52d2dc0 R14: 00005595aed0bd00 R15: 00005595ad3dd450
> [  245.489012]  </TASK>
> [  245.489358] INFO: task fsstress:4442 blocked for more than 122 seconds.
> [  245.490390]       Not tainted 5.16.0-rc5 #1
> [  245.491059] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.492255] task:fsstress        state:D stack:    0 pid: 4442 ppid:  4439 f0
> [  245.493541] Call Trace:
> [  245.493933]  <TASK>
> [  245.494298]  __schedule+0x309/0xab0
> [  245.494851]  schedule+0x44/0xc0
> [  245.495355]  jbd2_log_wait_commit+0x119/0x190
> [  245.496038]  ? wait_woken+0x60/0x60
> [  245.496604]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.497358]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.498175]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.498865]  ext4_iomap_begin+0x193/0x2b0
> [  245.499499]  iomap_iter+0x184/0x4a0
> [  245.500053]  __iomap_dio_rw+0x249/0x7b0
> [  245.500686]  iomap_dio_rw+0xa/0x30
> [  245.501203]  ext4_file_write_iter+0x421/0x8a0
> [  245.501840]  new_sync_write+0x125/0x1c0
> [  245.502355]  vfs_write+0x20f/0x370
> [  245.502757]  ksys_write+0x5f/0xe0
> [  245.503120]  do_syscall_64+0x3a/0x80
> [  245.503472]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.503956] RIP: 0033:0x7f941a094471
> [  245.504328] RSP: 002b:00007ffdf52d2908 EFLAGS: 00000246 ORIG_RAX: 00000000001
> [  245.505399] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f941a094471
> [  245.506509] RDX: 000000000000c000 RSI: 00005595aed08000 RDI: 0000000000000003
> [  245.507663] RBP: 000000000018f000 R08: 0000000000000b4f R09: 00007f941a07e0d0
> [  245.508776] R10: 00005595aecf2010 R11: 0000000000000246 R12: 00000000000003c7
> [  245.509888] R13: 000000000000c000 R14: 00005595aed08000 R15: 0000000000000000
> [  245.511041]  </TASK>
> [  245.511398] INFO: task fsstress:4443 blocked for more than 122 seconds.
> [  245.512430]       Not tainted 5.16.0-rc5 #1
> [  245.513103] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.514354] task:fsstress        state:D stack:    0 pid: 4443 ppid:  4439 f0
> [  245.515652] Call Trace:
> [  245.516054]  <TASK>
> [  245.516408]  __schedule+0x309/0xab0
> [  245.516976]  schedule+0x44/0xc0
> [  245.517483]  jbd2_log_wait_commit+0x119/0x190
> [  245.518199]  ? wait_woken+0x60/0x60
> [  245.518758]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.519520]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.520330]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.521065]  ext4_da_write_begin+0xf2/0x310
> [  245.521736]  generic_perform_write+0xf0/0x1d0
> [  245.522425]  ? generic_update_time+0xa0/0xc0
> [  245.523102]  ? file_update_time+0xd4/0x110
> [  245.523759]  ext4_buffered_write_iter+0x88/0x120
> [  245.524521]  ext4_file_write_iter+0x5f/0x8a0
> [  245.525197]  ? lock_is_held_type+0xd8/0x130
> [  245.525875]  do_iter_readv_writev+0x169/0x1d0
> [  245.526568]  do_iter_write+0x83/0x1c0
> [  245.527155]  vfs_writev+0x9c/0x280
> [  245.527725]  ? lock_is_held_type+0xd8/0x130
> [  245.528388]  ? find_held_lock+0x2d/0x90
> [  245.528911]  ? do_writev+0x6b/0x110
> [  245.529443]  ? syscall_enter_from_user_mode+0x20/0x70
> [  245.530182]  do_writev+0x6b/0x110
> [  245.530674]  do_syscall_64+0x3a/0x80
> [  245.531219]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.531978] RIP: 0033:0x7f9419fb2504
> [  245.532498] RSP: 002b:00007ffdf52d28f8 EFLAGS: 00000246 ORIG_RAX: 00000000004
> [  245.533817] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9419fb2504
> [  245.534870] RDX: 00000000000000d9 RSI: 00005595aed072f0 RDI: 0000000000000003
> [  245.535915] RBP: 000000000000040a R08: 00005595aed7cf55 R09: 00007f941a07e3a0
> [  245.536957] R10: 00005595aecf2010 R11: 0000000000000246 R12: 00005595aed072f0
> [  245.538003] R13: 00005595aed61250 R14: 00000000000000d9 R15: 000000000000020d
> [  245.539051]  </TASK>
> [  245.539382] INFO: task fsstress:4444 blocked for more than 123 seconds.
> [  245.540346]       Not tainted 5.16.0-rc5 #1
> [  245.541007] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.542237] task:fsstress        state:D stack:    0 pid: 4444 ppid:  4439 f0
> [  245.543252] Call Trace:
> [  245.543555]  <TASK>
> [  245.543821]  __schedule+0x309/0xab0
> [  245.544294]  schedule+0x44/0xc0
> [  245.544779]  jbd2_log_wait_commit+0x119/0x190
> [  245.545203]  ? wait_woken+0x60/0x60
> [  245.545546]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.546009]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.546501]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.546929]  ext4_da_write_begin+0xf2/0x310
> [  245.547337]  generic_perform_write+0xf0/0x1d0
> [  245.547797]  ext4_buffered_write_iter+0x88/0x120
> [  245.548398]  ext4_file_write_iter+0x5f/0x8a0
> [  245.548998]  new_sync_write+0x125/0x1c0
> [  245.549568]  vfs_write+0x20f/0x370
> [  245.550070]  ksys_write+0x5f/0xe0
> [  245.550560]  do_syscall_64+0x3a/0x80
> [  245.551109]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.551857] RIP: 0033:0x7f941a094471
> [  245.552384] RSP: 002b:00007ffdf52d2908 EFLAGS: 00000246 ORIG_RAX: 00000000001
> [  245.553480] RAX: ffffffffffffffda RBX: 00000000000184da RCX: 00007f941a094471
> [  245.554527] RDX: 00000000000184da RSI: 00005595aedc43c0 RDI: 0000000000000003
> [  245.555564] RBP: 0000000000000311 R08: 0000000000000000 R09: 00007f941a07dcd0
> [  245.556601] R10: 00005595aecf2010 R11: 0000000000000246 R12: 0000000000000003
> [  245.557648] R13: 00000000001d8893 R14: 00005595aedc43c0 R15: 0000000000000000
> [  245.558694]  </TASK>
> [  245.559021] INFO: task fsstress:4445 blocked for more than 123 seconds.
> [  245.559977]       Not tainted 5.16.0-rc5 #1
> [  245.560591] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.561733] task:fsstress        state:D stack:    0 pid: 4445 ppid:  4439 f0
> [  245.562945] Call Trace:
> [  245.563491]  <TASK>
> [  245.563887]  __schedule+0x309/0xab0
> [  245.564427]  schedule+0x44/0xc0
> [  245.564905]  jbd2_log_wait_commit+0x119/0x190
> [  245.565542]  ? wait_woken+0x60/0x60
> [  245.566056]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.566750]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.567494]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.568156]  ext4_da_write_begin+0xf2/0x310
> [  245.568788]  generic_perform_write+0xf0/0x1d0
> [  245.569429]  ext4_buffered_write_iter+0x88/0x120
> [  245.570102]  ext4_file_write_iter+0x5f/0x8a0
> [  245.570730]  new_sync_write+0x125/0x1c0
> [  245.571313]  vfs_write+0x20f/0x370
> [  245.571821]  ksys_write+0x5f/0xe0
> [  245.572311]  do_syscall_64+0x3a/0x80
> [  245.572842]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.573573] RIP: 0033:0x7f941a094471
> [  245.574097] RSP: 002b:00007ffdf52d2908 EFLAGS: 00000246 ORIG_RAX: 00000000001
> [  245.575199] RAX: ffffffffffffffda RBX: 0000000000019da9 RCX: 00007f941a094471
> [  245.576239] RDX: 0000000000019da9 RSI: 00005595aedc23f0 RDI: 0000000000000003
> [  245.577271] RBP: 0000000000000359 R08: 0000000000000003 R09: 00007f941a07dd60
> [  245.578319] R10: 00005595aecf2010 R11: 0000000000000246 R12: 0000000000000003
> [  245.579357] R13: 0000000000147e54 R14: 00005595aedc23f0 R15: 0000000000000000
> [  245.580395]  </TASK>
> [  245.580729] INFO: task fsstress:4446 blocked for more than 123 seconds.
> [  245.581693]       Not tainted 5.16.0-rc5 #1
> [  245.582344] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.583552] task:fsstress        state:D stack:    0 pid: 4446 ppid:  4439 f0
> [  245.584844] Call Trace:
> [  245.585145]  <TASK>
> [  245.585491]  __schedule+0x309/0xab0
> [  245.586040]  ? lock_release+0x132/0x2a0
> [  245.586560]  schedule+0x44/0xc0
> [  245.586866]  ext4_fc_commit+0x447/0xa90
> [  245.587231]  ? jbd2_trans_will_send_data_barrier+0x7f/0xa0
> [  245.587765]  ? wait_woken+0x60/0x60
> [  245.588103]  ext4_sync_file+0x3fc/0x470
> [  245.588466]  do_fsync+0x38/0x70
> [  245.588917]  __x64_sys_fdatasync+0x13/0x20
> [  245.589517]  do_syscall_64+0x3a/0x80
> [  245.590042]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.590774] RIP: 0033:0x7f9419fb32c4
> [  245.591317] RSP: 002b:00007ffdf52d2db8 EFLAGS: 00000246 ORIG_RAX: 0000000000b
> [  245.592439] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9419fb32c4
> [  245.593465] RDX: 00007ffdf52d2d20 RSI: 00007ffdf52d2d20 RDI: 0000000000000003
> [  245.594762] RBP: 00000000000003df R08: 00007f941a07dc40 R09: 00007ffdf52d2a06
> [  245.595861] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000002ee
> [  245.596968] R13: 0000000051eb851f R14: 00007ffdf52d2e60 R15: 00005595ad3d85f0
> [  245.598100]  </TASK>
> [  245.598364] INFO: task fsstress:4447 blocked for more than 123 seconds.
> [  245.599382]       Not tainted 5.16.0-rc5 #1
> [  245.600039] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.601273] task:fsstress        state:D stack:    0 pid: 4447 ppid:  4439 f0
> [  245.602406] Call Trace:
> [  245.602829]  <TASK>
> [  245.603191]  __schedule+0x309/0xab0
> [  245.603788]  schedule+0x44/0xc0
> [  245.604324]  jbd2_log_wait_commit+0x119/0x190
> [  245.604897]  ? wait_woken+0x60/0x60
> [  245.605493]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.606290]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.607136]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.607885]  ext4_da_write_begin+0xf2/0x310
> [  245.608423]  generic_perform_write+0xf0/0x1d0
> [  245.609148]  ? generic_update_time+0xa0/0xc0
> [  245.609861]  ? file_update_time+0xd4/0x110
> [  245.610527]  ext4_buffered_write_iter+0x88/0x120
> [  245.611296]  ext4_file_write_iter+0x5f/0x8a0
> [  245.611840]  ? lock_is_held_type+0xd8/0x130
> [  245.612470]  ? find_held_lock+0x2d/0x90
> [  245.613055]  do_iter_readv_writev+0x169/0x1d0
> [  245.613709]  do_iter_write+0x83/0x1c0
> [  245.614272]  iter_file_splice_write+0x265/0x390
> [  245.615015]  direct_splice_actor+0x31/0x40
> [  245.615676]  splice_direct_to_actor+0xfb/0x220
> [  245.616390]  ? pipe_to_sendpage+0xa0/0xa0
> [  245.617038]  do_splice_direct+0xa0/0xd0
> [  245.617684]  vfs_copy_file_range+0x1b6/0x5b0
> [  245.618338]  __x64_sys_copy_file_range+0xdd/0x200
> [  245.619026]  do_syscall_64+0x3a/0x80
> [  245.619552]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.620283] RIP: 0033:0x7f9419fb5f59
> [  245.620811] RSP: 002b:00007ffdf52d2428 EFLAGS: 00000246 ORIG_RAX: 00000000006
> [  245.621907] RAX: ffffffffffffffda RBX: 00007ffdf52d2478 RCX: 00007f9419fb5f59
> [  245.622986] RDX: 0000000000000004 RSI: 00007ffdf52d2470 RDI: 0000000000000003
> [  245.623983] RBP: 000000000001ddb5 R08: 000000000001ddb5 R09: 0000000000000000
> [  245.625033] R10: 00007ffdf52d2478 R11: 0000000000000246 R12: 0000000000000004
> [  245.626162] R13: 00007ffdf52d2470 R14: 0000000000000003 R15: 000000000030e49f
> [  245.627282]  </TASK>
> [  245.627654] INFO: task fsstress:4448 blocked for more than 123 seconds.
> [  245.628601]       Not tainted 5.16.0-rc5 #1
> [  245.629266] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
> [  245.630484] task:fsstress        state:D stack:    0 pid: 4448 ppid:  4439 f0
> [  245.631788] Call Trace:
> [  245.632162]  <TASK>
> [  245.632495]  __schedule+0x309/0xab0
> [  245.632991]  schedule+0x44/0xc0
> [  245.633395]  jbd2_log_wait_commit+0x119/0x190
> [  245.633958]  ? wait_woken+0x60/0x60
> [  245.634465]  __jbd2_journal_force_commit+0x5d/0xb0
> [  245.635224]  jbd2_journal_force_commit_nested+0xa/0x20
> [  245.635889]  ext4_should_retry_alloc+0x5c/0xb0
> [  245.636464]  ext4_da_write_begin+0xf2/0x310
> [  245.637042]  generic_perform_write+0xf0/0x1d0
> [  245.637631]  ext4_buffered_write_iter+0x88/0x120
> [  245.638294]  ext4_file_write_iter+0x5f/0x8a0
> [  245.638847]  new_sync_write+0x125/0x1c0
> [  245.639349]  vfs_write+0x20f/0x370
> [  245.639787]  ksys_write+0x5f/0xe0
> [  245.640220]  do_syscall_64+0x3a/0x80
> [  245.640685]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  245.641351] RIP: 0033:0x7f941a094471
> [  245.641910] RSP: 002b:00007ffdf52d2908 EFLAGS: 00000246 ORIG_RAX: 00000000001
> [  245.642861] RAX: ffffffffffffffda RBX: 00000000000094f2 RCX: 00007f941a094471
> [  245.643751] RDX: 00000000000094f2 RSI: 00005595aecf55c0 RDI: 0000000000000003
> [  245.644686] RBP: 000000000000040e R08: 00005595aed4d330 R09: 00007f941a07dcc0
> [  245.645630] R10: 00005595aecf2010 R11: 0000000000000246 R12: 0000000000000003
> [  245.646501] R13: 00000000000dd6d8 R14: 00005595aecf55c0 R15: 0000000000000000
> [  245.647380]  </TASK>
> [  245.647684] 
> [  245.647684] Showing all locks held in the system:
> [  245.648492] 1 lock held by khungtaskd/25:
> [  245.648992]  #0: ffffffff82762e40 (rcu_read_lock){....}-{1:2}, at: debug_shoa
> [  245.650094] 2 locks held by fsstress/4440:
> [  245.650600]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_0
> [  245.651761]  #1: ffff888013cad850 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.653096] 2 locks held by fsstress/4441:
> [  245.653595]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: filename_c0
> [  245.654650]  #1: ffff88800750f470 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, 0
> [  245.656111] 2 locks held by fsstress/4442:
> [  245.656655]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_write0
> [  245.657707]  #1: ffff8880076f32d0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.659084] 2 locks held by fsstress/4443:
> [  245.659618]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: do_writev+0
> [  245.660632]  #1: ffff888007686b10 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.661960] 2 locks held by fsstress/4444:
> [  245.662540]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_write0
> [  245.663538]  #1: ffff8880178c96b0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.664873] 2 locks held by fsstress/4445:
> [  245.665442]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_write0
> [  245.666441]  #1: ffff88801a8da970 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.667806] 2 locks held by fsstress/4447:
> [  245.668389]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_0
> [  245.669588]  #1: ffff88800777c590 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.670944] 2 locks held by fsstress/4448:
> [  245.671520]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_write0
> [  245.672537]  #1: ffff888017ac2010 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.673888] 2 locks held by fsstress/4449:
> [  245.674455]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_fallo0
> [  245.675596]  #1: ffff88800747bc30 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.676839] 2 locks held by fsstress/4450:
> [  245.677356]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: do_writev+0
> [  245.678379]  #1: ffff888013caf470 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.679794] 2 locks held by fsstress/4451:
> [  245.680329]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: ksys_write0
> [  245.681390]  #1: ffff888007542010 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.682734] 1 lock held by fsstress/4452:
> [  245.683243]  #0: ffff88800bb090e0 (&type->s_umount_key#31){++++}-{3:3}, at: 0
> [  245.684412] 1 lock held by fsstress/4453:
> [  245.684967]  #0: ffff88800bb090e0 (&type->s_umount_key#31){++++}-{3:3}, at: 0
> [  245.686109] 2 locks held by fsstress/4454:
> [  245.686674]  #0: ffff88800bb09448 (sb_writers#3){.+.+}-{0:0}, at: do_writev+0
> [  245.687718]  #1: ffff8880178461b0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, 0
> [  245.689137] 
> [  245.689346] =============================================
> [  245.689346] 
>


Hi Harshad:

FWIW, I've applied Xin Yin's hang fix for fallocate when using fast_commit to a
5.16-rc5 kernel and I'm still seeing generic/083 hang when running the adv
test case on the test appliance.  If anything, it actually hangs more quickly
and reliably - generally on the first or second trial in a sequence.

Eric


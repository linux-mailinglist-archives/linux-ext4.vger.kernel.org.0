Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97D4F87FA
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiDGTY3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 15:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDGTY2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 15:24:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1126AE28
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 12:22:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p25so3039372qkj.10
        for <linux-ext4@vger.kernel.org>; Thu, 07 Apr 2022 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GMGF+UQuWtny/M6JZzbmNZrWvKT7HHKQLTp6ZH0e414=;
        b=LIq7lhtXtR457SngrPUvwEemoHI/ojFf4rk6KI+AvnU5J+L7V/y5rnZET5NkRpDydK
         FNEfZqfWHyhio+pybxSOvEdJwn0vcWBRkZhBpXEp9UpgnYG4gietk3O39tvN/3theviT
         UDLtmVAxUIYNuNBgGzfY3z+VuJQgQs+U4tP90HQUxzVUdxI9hkS8/GfVT2xZBZMPi/tT
         87DFuCEFL4kod6jEeOlJKPqOsPVhXXX3uCF1qeBMY9kTyaTqhUqnUytCoiU9S+XubszT
         6ur6h2iiCh8UjIivnr6HSksjElXmpNMsfLD/OZrZ02e7I3DXW3G1yOv7HR5nQC6csNFk
         AyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GMGF+UQuWtny/M6JZzbmNZrWvKT7HHKQLTp6ZH0e414=;
        b=zu24f+Jl3SFVdvtUtyseTrKp/l0W+MamgNvukiWYRcC4rPkzokLmen+RmmzFGnt6QW
         cl+rlRCCQYkTu/L3GAnHkaqglU93pGqgui8nFBGsiFcHfbeuVxNXADnc5yE+ESHO0PGj
         Pdv+8Q68fCD7awhFhk0vPve+eXgP7OlDKXA2KsuRjiTODILoTzDxY2R1CdV0OcpORl6D
         Q3KkoghGU0zJUhTRkravHau1ZIrwERRPImRm4ZOxxIA4b1yUnjgjSCyNJlFpxmQ+XFWw
         TMeWPfRqp28O8etGeADO0r4/mpS1/ns5Po3yIQZxBXhWlJ2xB1AkCjiXTEWIhrPre4uf
         C92A==
X-Gm-Message-State: AOAM532r/UaX5V/qJ/1jVSoeuIbmrpx82WBGsWnAR0qkW+OB8H7c+xtJ
        mecWFnAlL4YelaRUYni+bUrrrTgGleg=
X-Google-Smtp-Source: ABdhPJygUZhfEf0u6Bey6oDzwyYGUJAkL+O6v5qX5V+Dl0wbxfJIWdowBByvha4xtqGiVrc/3nCzjg==
X-Received: by 2002:a37:89c7:0:b0:69a:121b:9256 with SMTP id l190-20020a3789c7000000b0069a121b9256mr1940312qkd.218.1649359344536;
        Thu, 07 Apr 2022 12:22:24 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id k20-20020a05622a03d400b002ec16d2694fsm234355qtx.39.2022.04.07.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:22:24 -0700 (PDT)
Date:   Thu, 7 Apr 2022 15:22:22 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz
Subject: ext4/052 test failures and possible circular locking
Message-ID: <Yk857gXs6sD1tspX@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've been seeing consistent failures of ext4/052 in the 1k test scenario when
running kvm-xfstests with -g auto since 5.17-rc4 in my upstream regression
runs.The kernels have lockdep enabled and the test failure is caused by a kernel
warning reporting a possible circular locking dependency.  I've included the
lockdep splat below.

It's difficult to reproduce this failure.  The only way I've been able to do
so is to start an entire testing run with "kvm-xfstests -g auto".  This runs
all the tests in the auto group in the 4k test scenario, followed by the tests
in the auto group in the 1k scenario up to ext4/052, when the failure
consistently occurs.  500 runs of ext4/052 on 1k alone fail to reproduce the
failure, as do other combination of tests or running the quick group instead
of auto.

Reverting a kernel commit that landed in -rc4 appears to correct this failure:
bf23747ee053 ("loop: revert "make autoclear operation asynchronous" ").
However, I'm told there were good reasons for that revert, so simply reverting
the revert isn't a solution.

The original patch reverted by this patch landed in 5.17-rc1.  Repeated test
runs on 5.16 final and 5.17-rc3 as described above have failed to reproduce
the failure.

Thanks,
Eric

ext4/052 16s ... 	[01:27:37][ 3785.331537] run fstests ext4/052 at 2022-04-04 01:27:37
[ 3785.584084] EXT4-fs (vdd): mounted filesystem with ordered data mode. Quota mode: none.
[ 3785.732395] EXT4-fs (vdc): mounted filesystem with ordered data mode. Quota mode: none.
[ 3785.808616] loop0: detected capacity change from 0 to 41943040
[ 3785.848334] EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
[ 3800.334824] 
[ 3800.335030] ======================================================
[ 3800.335712] WARNING: possible circular locking dependency detected
[ 3800.336386] 5.18.0-rc1 #1 Not tainted
[ 3800.336789] ------------------------------------------------------
[ 3800.337466] umount/900388 is trying to acquire lock:
[ 3800.337905] ffff88800ba32d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x7f/0x500
[ 3800.338607] 
[ 3800.338607] but task is already holding lock:
[ 3800.339063] ffff888005d1f118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x3a/0x220
[ 3800.339686] 
[ 3800.339686] which lock already depends on the new lock.
[ 3800.339686] 
[ 3800.340319] 
[ 3800.340319] the existing dependency chain (in reverse order) is:
[ 3800.340896] 
[ 3800.340896] -> #4 (&disk->open_mutex){+.+.}-{3:3}:
[ 3800.341383]        __mutex_lock+0x7c/0x940
[ 3800.341704]        blkdev_put+0x3a/0x220
[ 3800.342011]        ext4_put_super+0x2fb/0x5b0
[ 3800.342352]        generic_shutdown_super+0x71/0x120
[ 3800.342742]        kill_block_super+0x21/0x50
[ 3800.343082]        deactivate_locked_super+0x2e/0x90
[ 3800.343467]        cleanup_mnt+0x131/0x190
[ 3800.343788]        task_work_run+0x59/0x90
[ 3800.344109]        exit_to_user_mode_prepare+0x19d/0x1a0
[ 3800.344523]        syscall_exit_to_user_mode+0x19/0x60
[ 3800.344923]        do_syscall_64+0x48/0x90
[ 3800.345244]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3800.345656] 
[ 3800.345656] -> #3 (&type->s_umount_key#32){++++}-{3:3}:
[ 3800.346104]        down_write+0x2a/0x60
[ 3800.346363]        freeze_super+0x80/0x1b0
[ 3800.346615]        __x64_sys_ioctl+0x62/0xb0
[ 3800.346882]        do_syscall_64+0x38/0x90
[ 3800.347136]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3800.347479] 
[ 3800.347479] -> #2 (sb_writers#3){++++}-{0:0}:
[ 3800.347838]        loop_process_work+0x53b/0x900
[ 3800.348124]        process_one_work+0x271/0x590
[ 3800.348403]        worker_thread+0x4f/0x3d0
[ 3800.348665]        kthread+0xdf/0x110
[ 3800.348905]        ret_from_fork+0x1f/0x30
[ 3800.349170] 
[ 3800.349170] -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
[ 3800.349652]        process_one_work+0x24b/0x590
[ 3800.349932]        worker_thread+0x4f/0x3d0
[ 3800.350189]        kthread+0xdf/0x110
[ 3800.350448]        ret_from_fork+0x1f/0x30
[ 3800.350706] 
[ 3800.350706] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[ 3800.351103]        __lock_acquire+0x1182/0x1ed0
[ 3800.351394]        lock_acquire+0xca/0x2f0
[ 3800.351645]        flush_workqueue+0xa9/0x500
[ 3800.351913]        drain_workqueue+0xa0/0x110
[ 3800.352180]        destroy_workqueue+0x36/0x250
[ 3800.352456]        __loop_clr_fd+0xad/0x460
[ 3800.352713]        blkdev_put+0xc0/0x220
[ 3800.352990]        deactivate_locked_super+0x2e/0x90
[ 3800.353319]        cleanup_mnt+0x131/0x190
[ 3800.353570]        task_work_run+0x59/0x90
[ 3800.353824]        exit_to_user_mode_prepare+0x19d/0x1a0
[ 3800.354148]        syscall_exit_to_user_mode+0x19/0x60
[ 3800.354462]        do_syscall_64+0x48/0x90
[ 3800.354713]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3800.355056] 
[ 3800.355056] other info that might help us debug this:
[ 3800.355056] 
[ 3800.355542] Chain exists of:
[ 3800.355542]   (wq_completion)loop0 --> &type->s_umount_key#32 --> &disk->open_mutex
[ 3800.355542] 
[ 3800.356269]  Possible unsafe locking scenario:
[ 3800.356269] 
[ 3800.356631]        CPU0                    CPU1
[ 3800.356909]        ----                    ----
[ 3800.357187]   lock(&disk->open_mutex);
[ 3800.357418]                                lock(&type->s_umount_key#32);
[ 3800.357827]                                lock(&disk->open_mutex);
[ 3800.358210]   lock((wq_completion)loop0);
[ 3800.358458] 
[ 3800.358458]  *** DEADLOCK ***
[ 3800.358458] 
[ 3800.358823] 1 lock held by umount/900388:
[ 3800.359069]  #0: ffff888005d1f118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x3a/0x220
[ 3800.359581] 
[ 3800.359581] stack backtrace:
[ 3800.359866] CPU: 1 PID: 900388 Comm: umount Not tainted 5.18.0-rc1 #1
[ 3800.360259] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[ 3800.360781] Call Trace:
[ 3800.360981]  <TASK>
[ 3800.361150]  dump_stack_lvl+0x45/0x59
[ 3800.361439]  check_noncircular+0xf2/0x110
[ 3800.361753]  __lock_acquire+0x1182/0x1ed0
[ 3800.362068]  lock_acquire+0xca/0x2f0
[ 3800.362349]  ? flush_workqueue+0x7f/0x500
[ 3800.362665]  ? lockdep_init_map_type+0x47/0x260
[ 3800.363021]  flush_workqueue+0xa9/0x500
[ 3800.363323]  ? flush_workqueue+0x7f/0x500
[ 3800.363639]  drain_workqueue+0xa0/0x110
[ 3800.363941]  destroy_workqueue+0x36/0x250
[ 3800.364256]  __loop_clr_fd+0xad/0x460
[ 3800.364546]  blkdev_put+0xc0/0x220
[ 3800.364814]  deactivate_locked_super+0x2e/0x90
[ 3800.365162]  cleanup_mnt+0x131/0x190
[ 3800.365443]  task_work_run+0x59/0x90
[ 3800.365723]  exit_to_user_mode_prepare+0x19d/0x1a0
[ 3800.366100]  syscall_exit_to_user_mode+0x19/0x60
[ 3800.366460]  do_syscall_64+0x48/0x90
[ 3800.366747]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3800.367143] RIP: 0033:0x7fa7fa263e27
[ 3800.367424] Code: 00 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 00 0c 00 f7 d8 64 89 01 48
[ 3800.368857] RSP: 002b:00007ffd53d1e268 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 3800.369439] RAX: 0000000000000000 RBX: 00007fa7fa387264 RCX: 00007fa7fa263e27
[ 3800.369990] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055848a1b6b90
[ 3800.370542] RBP: 000055848a1b6960 R08: 0000000000000000 R09: 00007ffd53d1cfe0
[ 3800.371095] R10: 000055848a1b6bb0 R11: 0000000000000246 R12: 0000000000000000
[ 3800.371645] R13: 000055848a1b6b90 R14: 000055848a1b6a70 R15: 0000000000000000
[ 3800.372197]  </TASK>
[ 3801.788395] EXT4-fs (vdd): mounted filesystem with ordered data mode. Quota mode: none.
_check_dmesg: something found in dmesg (see /results/ext4/results-1k/ext4/052.dmesg)



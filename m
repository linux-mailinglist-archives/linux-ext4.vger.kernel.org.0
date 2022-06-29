Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF75606DB
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiF2RBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiF2RBd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 13:01:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA1393FF
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 10:01:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id be10so22461664oib.7
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NpwH8g/eys1RC2/tQqkArhPANM+7/QcgnaLosW/vXNA=;
        b=fQMMuji/o4HHDAXvrviMvQchc0SYRVdZ6twFGrQNMZ9QvCH1Rz8xgfs55Sh7KuefB/
         D2leZxpeVUwm3joKVQiQsuOIPopcP7hVDp47VmoPHadvST9K7ZSW2s3MIpZc8zIOHUuw
         e13KmZEZtwBvH96jLKZv3V1ui+zlzG77ZP1SiCSjIsYP6CuJoVsqy1wo/WKNwqbM3puE
         7M5L0l3edCf9k+ynGArfdKd86enzuJUyZ9UdwHZF04hEMEG+3esMPwOxq0U1qrsh9Gry
         LQ9G7cWafqJfuCGbNFO1eoFtyojdelx0YyyC+e2xT3ucH6cRFvQcLN5LcS9Xi8FIT3Y1
         +9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NpwH8g/eys1RC2/tQqkArhPANM+7/QcgnaLosW/vXNA=;
        b=vkopFoma64WPD68557K591/3FEaoWxV8njgdZPl3xh3kU4xb2n8Lw+O/YT9w4/YyEg
         eM9kCmV7WyJ4HRzY/zIsKC7BR7OBr4u441DS9iXwbvWwujinQgg42jZZDgFAZfTBBb74
         gfYPvOrcp4kgSe8UKmu1F1rBDFb9NoaH7q43i+eL7WSYfXpO5nymW2HcZ858zFJhgGLO
         xB7kOtZxtskI2tJ+I+FAWUST6waWFJl61aRDoj7aasbrQ2YvF21M1O0dOL3ZCLPuwIBa
         RaTvisM6bsCESU2EGUFSz40fvI4A1vgmhcG3AqDOm57ywhbPcX785nyrlSdXBH8BbUns
         POdQ==
X-Gm-Message-State: AJIora9OR5qAip3TXtjV2M2f/f12d/QfqMy1v9j4VqhdqXnLlrVpyV1R
        bJxsVNett7V0GcbA0Iux1yOUaxu/T7GPV+xoEBo2D9II
X-Google-Smtp-Source: AGRyM1tbJLOFiSiU5dOdW+dYWIUwpCQRAXPUbhdnmRt7BMnVkCsIkYEI8KAy1ws2AhOCjrvLHs88Fu4+FWFrJ8YsU2s=
X-Received: by 2002:a05:6808:1490:b0:335:22b6:7a6f with SMTP id
 e16-20020a056808149000b0033522b67a6fmr3633663oiw.143.1656522090474; Wed, 29
 Jun 2022 10:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJJufw5AguY=T0KZ=W3OZCxKJj0VRueoLqRjWw99qPFeJE6UrA@mail.gmail.com>
In-Reply-To: <CAJJufw5AguY=T0KZ=W3OZCxKJj0VRueoLqRjWw99qPFeJE6UrA@mail.gmail.com>
From:   Dmitry <ilyevsky@gmail.com>
Date:   Wed, 29 Jun 2022 10:01:19 -0700
Message-ID: <CAGOdRhMOrqfqN+Yz2mWWRfQinBif7uW3AxOC5ipVkgnTcRoeiQ@mail.gmail.com>
Subject: Fwd: ext: hang in jbd2_journal_commit_transaction/wait_transaction_locked
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi All,

I'm having deadlock issues with ext4 after upgrading 5.14.14 ->
5.16.13. Here's the excerpt of blocked threads dump (the are roughly
200 D threads with a Z parent + jbd2 D thread):

Jun 28 17:43:32 ip-10-66-2-23 kernel: sysrq: Show Blocked State
Jun 28 17:43:32 ip-10-66-2-23 kernel: task:jbd2/nvme3n1-8  state:D
stack:    0 pid:11163 ppid:     2 flags:0x00004000
Jun 28 17:43:32 ip-10-66-2-23 kernel: Call Trace:
Jun 28 17:43:32 ip-10-66-2-23 kernel:  <TASK>
Jun 28 17:43:32 ip-10-66-2-23 kernel:  __schedule+0x2d7/0xfa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? _raw_spin_lock_irqsave+0x26/0x50
Jun 28 17:43:32 ip-10-66-2-23 kernel:  schedule+0x4e/0xc0
Jun 28 17:43:32 ip-10-66-2-23 kernel:
jbd2_journal_commit_transaction+0x314/0x1bd0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? cpuacct_charge+0x2e/0x50
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? _raw_spin_unlock+0x16/0x30
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? do_wait_intr_irq+0xa0/0xa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? preempt_count_add+0x68/0xa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  kjournald2+0x9f/0x260
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? do_wait_intr_irq+0xa0/0xa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ?
jbd2_journal_release_jbd_inode+0x110/0x110
Jun 28 17:43:32 ip-10-66-2-23 kernel:  kthread+0x16b/0x190
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? set_kthread_struct+0x40/0x40
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ret_from_fork+0x22/0x30
Jun 28 17:43:32 ip-10-66-2-23 kernel:  </TASK>
Jun 28 17:43:32 ip-10-66-2-23 kernel: task:BackgrProcPool  state:D
stack:    0 pid:11757 ppid: 11488 flags:0x00000004
Jun 28 17:43:32 ip-10-66-2-23 kernel: Call Trace:
Jun 28 17:43:32 ip-10-66-2-23 kernel:  <TASK>
Jun 28 17:43:32 ip-10-66-2-23 kernel:  __schedule+0x2d7/0xfa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? ext4_match.part.0+0xbf/0x100
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? _raw_spin_lock_irqsave+0x26/0x50
Jun 28 17:43:32 ip-10-66-2-23 kernel:  schedule+0x4e/0xc0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  wait_transaction_locked+0x7a/0xa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? do_wait_intr_irq+0xa0/0xa0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  add_transaction_credits+0x10e/0x2a0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  start_this_handle+0xf1/0x4f0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? kmem_cache_alloc+0x16c/0x2d0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  jbd2__journal_start+0xf7/0x1f0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  __ext4_journal_start_sb+0xfe/0x110
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ext4_rename+0x617/0xb20
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? security_inode_permission+0x30/0x50
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? avc_has_perm_noaudit+0x7f/0xe0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  vfs_rename+0x9ca/0xd20
Jun 28 17:43:32 ip-10-66-2-23 kernel:  ? do_renameat2+0x4be/0x4f0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  do_renameat2+0x4be/0x4f0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  __x64_sys_rename+0x40/0x50
Jun 28 17:43:32 ip-10-66-2-23 kernel:  do_syscall_64+0x3b/0x90
Jun 28 17:43:32 ip-10-66-2-23 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Jun 28 17:43:32 ip-10-66-2-23 kernel: RIP: 0033:0x7f6507ffb00b
Jun 28 17:43:32 ip-10-66-2-23 kernel: RSP: 002b:00007f64ec9f9968
EFLAGS: 00000202 ORIG_RAX: 0000000000000052
Jun 28 17:43:32 ip-10-66-2-23 kernel: RAX: ffffffffffffffda RBX:
00007f64ec9f99a0 RCX: 00007f6507ffb00b
Jun 28 17:43:32 ip-10-66-2-23 kernel: RDX: 0000000000000031 RSI:
00007f64d98698b0 RDI: 00007f64edc154a0
Jun 28 17:43:32 ip-10-66-2-23 kernel: RBP: 00007f64eca28080 R08:
00007f64ec9ff700 R09: 0000000000000070
Jun 28 17:43:32 ip-10-66-2-23 kernel: R10: 00007f64edcfb190 R11:
0000000000000202 R12: 00007f64ec9f99a1
Jun 28 17:43:32 ip-10-66-2-23 kernel: R13: 0000000000000000 R14:
00007f64ec9f99b8 R15: 00007f64ec9f99c0
Jun 28 17:43:32 ip-10-66-2-23 kernel:  </TASK>

...

Jun 28 17:43:34 ip-10-66-2-23 kernel: task:SystemLogFlush  state:D
stack:    0 pid:11775 ppid: 11488 flags:0x00000004
Jun 28 17:43:34 ip-10-66-2-23 kernel: Call Trace:
Jun 28 17:43:34 ip-10-66-2-23 kernel:  <TASK>
Jun 28 17:43:34 ip-10-66-2-23 kernel:  __schedule+0x2d7/0xfa0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? avc_has_perm_noaudit+0x7f/0xe0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? avc_has_perm_noaudit+0x7f/0xe0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  schedule+0x4e/0xc0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  rwsem_down_read_slowpath+0x310/0x350
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? lookup_fast+0xce/0x130
Jun 28 17:43:35 ip-10-66-2-23 kernel:  walk_component+0x10c/0x190
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? path_init+0x2c1/0x3f0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  path_lookupat+0x6e/0x1b0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  filename_lookup+0xbc/0x1a0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? __check_object_size+0x136/0x150
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? strncpy_from_user+0x3f/0x130
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Jun 28 17:43:35 ip-10-66-2-23 kernel:  user_path_at_empty+0x3a/0x50
Jun 28 17:43:35 ip-10-66-2-23 kernel:  vfs_statx+0x64/0x100
Jun 28 17:43:35 ip-10-66-2-23 kernel:  __do_sys_newstat+0x26/0x40
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ? __do_sys_statfs+0x27/0x30
Jun 28 17:43:35 ip-10-66-2-23 kernel:  ?
syscall_trace_enter.constprop.0+0x13d/0x1d0
Jun 28 17:43:35 ip-10-66-2-23 kernel:  do_syscall_64+0x3b/0x90
Jun 28 17:43:35 ip-10-66-2-23 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Jun 28 17:43:35 ip-10-66-2-23 kernel: RIP: 0033:0x7f65080a562a
Jun 28 17:43:35 ip-10-66-2-23 kernel: RSP: 002b:00007f64e29f5e48
EFLAGS: 00000246 ORIG_RAX: 0000000000000004
Jun 28 17:43:35 ip-10-66-2-23 kernel: RAX: ffffffffffffffda RBX:
00007f64e29f5e78 RCX: 00007f65080a562a
Jun 28 17:43:35 ip-10-66-2-23 kernel: RDX: 00007f64e29f5e90 RSI:
00007f64e29f5e90 RDI: 00007f64edcabb50
Jun 28 17:43:35 ip-10-66-2-23 kernel: RBP: 0000000000000000 R08:
0000000000000001 R09: 0000000000000070
Jun 28 17:43:35 ip-10-66-2-23 kernel: R10: 00007f64ede45d00 R11:
0000000000000246 R12: 00007f64e29f6300
Jun 28 17:43:35 ip-10-66-2-23 kernel: R13: 00007f6507a34700 R14:
00007f6507a34bc8 R15: 00007f64ec11ea18
Jun 28 17:43:35 ip-10-66-2-23 kernel:  </TASK>

...

Jun 28 17:43:36 ip-10-66-2-23 kernel: task:HTTPHandler     state:D
stack:    0 pid:11809 ppid: 11488 flags:0x00000004
Jun 28 17:43:36 ip-10-66-2-23 kernel: Call Trace:
Jun 28 17:43:36 ip-10-66-2-23 kernel:  <TASK>
Jun 28 17:43:36 ip-10-66-2-23 kernel:  __schedule+0x2d7/0xfa0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? avc_has_perm_noaudit+0x7f/0xe0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? avc_has_perm_noaudit+0x7f/0xe0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  schedule+0x4e/0xc0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  rwsem_down_read_slowpath+0x310/0x350
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? lookup_fast+0xce/0x130
Jun 28 17:43:36 ip-10-66-2-23 kernel:  walk_component+0x10c/0x190
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? path_init+0x2c1/0x3f0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  path_lookupat+0x6e/0x1b0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  filename_lookup+0xbc/0x1a0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? __check_object_size+0x136/0x150
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? strncpy_from_user+0x3f/0x130
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Jun 28 17:43:36 ip-10-66-2-23 kernel:  user_path_at_empty+0x3a/0x50
Jun 28 17:43:36 ip-10-66-2-23 kernel:  vfs_statx+0x64/0x100
Jun 28 17:43:36 ip-10-66-2-23 kernel:  __do_sys_newstat+0x26/0x40
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ? __do_sys_statfs+0x27/0x30
Jun 28 17:43:36 ip-10-66-2-23 kernel:  ?
syscall_trace_enter.constprop.0+0x13d/0x1d0
Jun 28 17:43:36 ip-10-66-2-23 kernel:  do_syscall_64+0x3b/0x90
Jun 28 17:43:36 ip-10-66-2-23 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Jun 28 17:43:36 ip-10-66-2-23 kernel: RIP: 0033:0x7f65080a562a
Jun 28 17:43:36 ip-10-66-2-23 kernel: RSP: 002b:00007f64cf7d2f78
EFLAGS: 00000246 ORIG_RAX: 0000000000000004
Jun 28 17:43:36 ip-10-66-2-23 kernel: RAX: ffffffffffffffda RBX:
00007f64cf7d2fa8 RCX: 00007f65080a562a
Jun 28 17:43:36 ip-10-66-2-23 kernel: RDX: 00007f64cf7d2fc0 RSI:
00007f64cf7d2fc0 RDI: 00007f64e909b5b0
Jun 28 17:43:36 ip-10-66-2-23 kernel: RBP: 0000000000000000 R08:
0000000000000001 R09: 0000000000000070
Jun 28 17:43:36 ip-10-66-2-23 kernel: R10: 000000000000002b R11:
0000000000000246 R12: 00007f64cf7d34f0
Jun 28 17:43:36 ip-10-66-2-23 kernel: R13: 00007f65072ffc00 R14:
00007f6507300130 R15: 00007f64cb671218
Jun 28 17:43:36 ip-10-66-2-23 kernel:  </TASK>

The issue seems to pop up after a few hours consistently and after
downgrade back to 5.14 it is gone. I've looked through 'ext:' commits
for v5.14..v5.16 but don't see a smoking gun (not an expert though).
Any suggestions to debug this further (perhaps an issue in nvme/block
subsystems) or any other pointers would be much appreciated!

Thanks,
-Dmitry

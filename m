Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004621200C4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2019 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLPJPT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Dec 2019 04:15:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40226 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPJPT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Dec 2019 04:15:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so3646650lfo.7
        for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2019 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rj0lGpd3yaUxGRTGZvxPWnnnjGnW8gKPN7KeoAgqNTM=;
        b=P4hSaHlupp/IyXcENyYnh8QhbcDUnjZCPsS7UfzRTZcDn018IUlCkE/RwisPdi8uZ5
         UfSzV4BFjxT/FxmHdxbufulAVu6NMkkXCKiYkG9hIBnzRtFtAB+6zCdGjXdREzWkCLGn
         LB/5EY3fZsnGIYRpykQ4PLkYKSNz4EnlaYKEjRwqcahkYmxHdciurF/0JDsR4929Sbfp
         rAz1WwzDVPd+l4pIIRB1Wx3Jxbz0K+bgG4KxCvEusA/MuNnFeq4GaANstyVN47kOxAQY
         AzLfjamjN0QGvWAmP6x8Se3MTCiAS1iKRSGIUicwNzhL6U8yIwJkjOVIgmxNOiryQCXs
         i3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rj0lGpd3yaUxGRTGZvxPWnnnjGnW8gKPN7KeoAgqNTM=;
        b=W/aP1omjxZkVkNhnxxRI7bQAchDjh/6jJ3W78Ax9d2WMNYTe3eu/+28P5nY0MSLlNp
         4o6sfg72TcHmnIg0KREbRyzdUWdlIFG+qCZalecDZJTOEEE+DclXNZtAFsZyISZ7Pqsb
         fduAZm3iOA812izt7KONWS4FdTaw8HOCPrFWGatqwgWloBQPfz4vxYBMUKOwqaUKNsPm
         jSybDXmg5VQAAo6BGrKU84CjP5NFladYmxL1eWOkTw/f/elTekxf3E9e63fJe82pPITj
         +5yl0Nzq425V9ztUfo8kL2+YpTMkpRNiQsRnEepq54PlbLy4TcBi2bRkuYXdQr72fBTL
         5zag==
X-Gm-Message-State: APjAAAWlbfEvUma7PV0sR2zkFfLRRtdvCWB0DlbwMCbGo7MD0IutO9Hi
        z/Q3H0jxynhHAkyDOpEZNCfOz+mxtZLZ0ejSfoJIaw==
X-Google-Smtp-Source: APXvYqyehN/Xs5RL2OuF672CaHnDupDsIMF34lzkZlx71dQkwBQRLFaLmkgEdHVRSAhH6YE5de5QGFBuVLBhGSvxTEo=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr16281646lfk.67.1576487715866;
 Mon, 16 Dec 2019 01:15:15 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 Dec 2019 14:45:04 +0530
Message-ID: <CA+G9fYuO7vMjsqkyXHZSU-pKEk0L0t9kQTfnd5xopVADyGwprw@mail.gmail.com>
Subject: mainline-5.5.0-rc1: do_mount_root+0x6c/0x10d - kernel crash while
 mounting rootfs
To:     kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        Paolo Bonzini <pbonzini@redhat.com>, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following kernel crash reported on qemu_x86_64 boot running
5.5.0-rc1 mainline kernel.

Regressions detected on arm64, arm, qemu_x86_64, and qemu_i386.
Where as x86_64 and i386 boot pass on devices.

qemu_x86_64 kernel crash log,
-------------------------------------------
[    1.680229] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.681148] #PF: supervisor read access in kernel mode
[    1.681150] #PF: error_code(0x0000) - not-present page
[    1.681150] PGD 0 P4D 0
[    1.681150] Oops: 0000 [#1] SMP NOPTI
[    1.681150] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1 #1
[    1.681150] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    1.681150] RIP: 0010:strncpy+0x12/0x30
[    1.681150] Code: 89 e5 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9
88 4a ff 75 ed 5d c3 90 55 48 85 d2 48 89 f8 48 89 e5 74 1e 48 01 fa
48 89 f9 <44> 0f b6 06 41 80 f8 01 44 88 01 48 83 de ff 48 83 c1 01 48
39 d1
[    1.681150] RSP: 0018:ffffacea40013e00 EFLAGS: 00010286
[    1.681150] RAX: ffff9eff78f4f000 RBX: ffffd91104e3d3c0 RCX: ffff9eff78f4f000
[    1.681150] RDX: ffff9eff78f4ffff RSI: 0000000000000000 RDI: ffff9eff78f4f000
[    1.681150] RBP: ffffacea40013e00 R08: ffff9eff78f4f000 R09: 0000000000000000
[    1.681150] R10: ffffd91104e3d3c0 R11: 0000000000000000 R12: 0000000000008001
[    1.681150] R13: 00000000fffffff4 R14: ffffffffa5d9aa89 R15: ffff9eff78f4e000
[    1.681150] FS:  0000000000000000(0000) GS:ffff9eff7bc00000(0000)
knlGS:0000000000000000
[    1.681150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.681150] CR2: 0000000000000000 CR3: 0000000113010000 CR4: 00000000003406f0
[    1.681150] Call Trace:
[    1.681150]  do_mount_root+0x6c/0x10d
[    1.681150]  mount_block_root+0x103/0x226
[    1.681150]  ? do_mknodat+0x16e/0x200
[    1.681150]  ? set_debug_rodata+0x17/0x17
[    1.681150]  mount_root+0x114/0x133
[    1.681150]  prepare_namespace+0x139/0x16a
[    1.681150]  kernel_init_freeable+0x21b/0x22f
[    1.681150]  ? rest_init+0x250/0x250
[    1.681150]  kernel_init+0xe/0x110
[    1.681150]  ret_from_fork+0x27/0x50
[    1.681150] Modules linked in:
[    1.681150] CR2: 0000000000000000
[    1.681150] ---[ end trace d7ad8453a7546454 ]---
[    1.681150] RIP: 0010:strncpy+0x12/0x30
[    1.681150] Code: 89 e5 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9
88 4a ff 75 ed 5d c3 90 55 48 85 d2 48 89 f8 48 89 e5 74 1e 48 01 fa
48 89 f9 <44> 0f b6 06 41 80 f8 01 44 88 01 48 83 de ff 48 83 c1 01 48
39 d1
[    1.681150] RSP: 0018:ffffacea40013e00 EFLAGS: 00010286
[    1.681150] RAX: ffff9eff78f4f000 RBX: ffffd91104e3d3c0 RCX: ffff9eff78f4f000
[    1.681150] RDX: ffff9eff78f4ffff RSI: 0000000000000000 RDI: ffff9eff78f4f000
[    1.681150] RBP: ffffacea40013e00 R08: ffff9eff78f4f000 R09: 0000000000000000
[    1.681150] R10: ffffd91104e3d3c0 R11: 0000000000000000 R12: 0000000000008001
[    1.681150] R13: 00000000fffffff4 R14: ffffffffa5d9aa89 R15: ffff9eff78f4e000
[    1.681150] FS:  0000000000000000(0000) GS:ffff9eff7bc00000(0000)
knlGS:0000000000000000
[    1.681150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.681150] CR2: 0000000000000000 CR3: 0000000113010000 CR4: 00000000003406f0
[    1.681150] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:38
[    1.681150] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
1, name: swapper/0
[    1.681150] INFO: lockdep is turned off.
[    1.681150] irq event stamp: 2360074
[    1.681150] hardirqs last  enabled at (2360073):
[<ffffffffa48f4c8c>] get_page_from_freelist+0x21c/0x1430
[    1.681150] hardirqs last disabled at (2360074):
[<ffffffffa4601eab>] trace_hardirqs_off_thunk+0x1a/0x1c
[    1.681150] softirqs last  enabled at (2359990):
[<ffffffffa5800338>] __do_softirq+0x338/0x43a
[    1.681150] softirqs last disabled at (2359975):
[<ffffffffa4701828>] irq_exit+0xb8/0xc0
[    1.681150] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D
  5.5.0-rc1 #1
[    1.681150] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    1.681150] Call Trace:
[    1.681150]  dump_stack+0x7a/0xa5
[    1.681150]  ___might_sleep+0x163/0x250
[    1.681150]  __might_sleep+0x4a/0x80
[    1.681150]  exit_signals+0x33/0x2d0
[    1.681150]  do_exit+0xb6/0xcd0
[    1.681150]  ? prepare_namespace+0x139/0x16a
[    1.681150]  ? kernel_init_freeable+0x21b/0x22f
[    1.681150]  ? rest_init+0x250/0x250
[    1.681150]  rewind_stack_do_exit+0x17/0x20
[    1.736632] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
[    1.737579] Kernel Offset: 0x23600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Full log,
qemu_x86_64,
https://lkft.validation.linaro.org/scheduler/job/1054430#L573
qemu_i386:
https://lkft.validation.linaro.org/scheduler/job/1054335#L571

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: 9603e22104439ddfa6a077f1a0e5d8c662beec6c
  git describe: v5.5-rc1-308-g9603e2210443
  make_kernelversion: 5.5.0-rc1
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-mainline/2325/config
  build-url: https://ci.linaro.org/job/openembedded-lkft-linux-mainline/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/2325/
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-mainline/2325

--
Linaro LKFT
https://lkft.linaro.org

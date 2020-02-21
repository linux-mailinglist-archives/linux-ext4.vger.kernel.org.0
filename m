Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2683C167F7C
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBUOCU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 09:02:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40398 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUOCU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 09:02:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so1863162qkl.7
        for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2020 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=um7lPv1LBuljpLOpMyjT5ZneVfeO3QkKMUB6cOndnuQ=;
        b=ChuJyHRXyH3flsI5UN1z87G6eQPboOvCzxauNP6FALrl1bv/3YlwItsUTP82UaeUyg
         SchWXMpwLkev9rsHZlCkn3i3uqH46JIbrIXUKFxqm59S9Ea09tvizc5EnACUJd2Aoixj
         YYLSQQc9le19lKvbhs64Bjqo+meXy4IrypkSQO9OVc4gQ7TrLs81b/ExB6wcs5sn+ER2
         ZZxeWCkzdpDY3dNchlY5WnKsVf7EqhbYIVquxJw1tcQbsXGdgr3LH+vLTLA72h0GGDMj
         bdMCiGnS4jyriP3/GH4kPrL5wAZUgS45o0styIEPmITWh48dQ86L1ZFOiQZss8gbZhTv
         NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=um7lPv1LBuljpLOpMyjT5ZneVfeO3QkKMUB6cOndnuQ=;
        b=gEWGyyKf+cwetVBg72zu/iXDMCk62KS+S7j9aNbaSyi+RKZIiUjkA+OzXiWs8/k4M4
         l1WQUaCbN6gJBwGxdeHkdlWj3l9yL1nN8rZvbQRXtwfxBuVafTiA0LYxsDKQGBPOu+IN
         D9ZIQ3if3WzadUefhT+V14WcbIFnYUFoHTjDJnpxtjE/aPmvoRi5Vou4ZdrpngRmiENY
         DqHX9kpnKS4HhFPIgpOO836LGJ7QU/JiHys9WnkzAQcY3XdOxkjaR6wb0BcDsKBhZUHF
         JmMFgyP+Lf90y7S6+Ql0p2iPx9Losf/jlgFRzroia7mjjQ8UnJb+LjmXjVfEvKlY7x7H
         esIQ==
X-Gm-Message-State: APjAAAVYjxk3vTi3gALX+Bm5mN0mX1yE9dbSFmtvdYc8E5WVNY+1ZCDH
        W/Y4aOjPATEfiMoEjqtWiJepHA==
X-Google-Smtp-Source: APXvYqyZhz/RTvUFbeSCO+KFDnu274Z34j27ek5TIvQ0LS92vFGB62oipCzVNRKI0BXZwC3yPZWC5Q==
X-Received: by 2002:a37:40c:: with SMTP id 12mr33826279qke.212.1582293738911;
        Fri, 21 Feb 2020 06:02:18 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m204sm1586426qke.35.2020.02.21.06.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 06:02:18 -0800 (PST)
Message-ID: <1582293736.7365.109.camel@lca.pw>
Subject: null-ptr-deref due to "ext4: fix potential race between online
 resizing and write operations"
From:   Qian Cai <cai@lca.pw>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Fri, 21 Feb 2020 09:02:16 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reverted the linux-next commit c20bac9bf82c ("ext4: fix potential race between
s_flex_groups online resizing and access") fixed the crash below (with line
numbers),

struct flex_groups *flex_group = sbi_array_rcu_deref(EXT4_SB(sb),
                                                     s_flex_groups, g);

[  575.924527][T13183] LTP: starting fanotify13
[  576.010554][T31835] /dev/zero: Can't open blockdev
[  576.867392][T31835] EXT4-fs (loop0): mounting ext3 file system using the ext4
subsystem
[  576.919604][T31835] EXT4-fs (loop0): mounted filesystem with ordered data
mode. Opts: (null)
[  576.920112][T31835] ext3 filesystem being mounted at /tmp/ltp-
ZMONVGlgwi/o0A0RE/mntpoint supports timestamps until 2038 (0x7fffffff)
[  576.948501][T31854] BUG: Kernel NULL pointer dereference on read at
0x00000070
[  576.948550][T31854] Faulting instruction address: 0xc008000010501bfc
[  576.948573][T31854] Oops: Kernel access of bad area, sig: 11 [#1]
[  576.948575][    C2] irq event stamp: 107073312
[  576.948583][    C2] hardirqs last  enabled at (107073312):
[<c00000000099a174>] _raw_spin_unlock_irqrestore+0x94/0xd0
[  576.948595][T31854] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
DEBUG_PAGEALLOC NUMA PowerNV
[  576.948598][T31854] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy
firmware_class dm_mirror dm_region_hash dm_log dm_mod
[  576.948614][    C2] hardirqs last disabled at (107073311):
[<c000000000999e0c>] _raw_spin_lock_irqsave+0x3c/0xa0
[  576.948646][T31854] CPU: 52 PID: 31854 Comm: fanotify13 Not tainted 5.6.0-
rc2-next-20200221 #7
[  576.948689][    C2] softirqs last  enabled at (107073296):
[<c000000000113b3c>] irq_enter+0x8c/0xc0
[  576.948693][    C2] softirqs last disabled at (107073297):
[<c000000000113cdc>] irq_exit+0x16c/0x1d0
[  576.948754][T31854] NIP:  c008000010501bfc LR: c008000010501d94 CTR:
c0000000001f1e30
[  576.948758][T31854] REGS: c00000129f56f700 TRAP: 0300   Not tainted  (5.6.0-
rc2-next-20200221)
[  576.948945][T31854] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
24004224  XER: 20040000
[  576.948982][T31854] CFAR: c008000010501d9c DAR: 0000000000000070 DSISR:
40000000 IRQMASK: 0 
[  576.948982][T31854] GPR00: c008000010501d94 c00000129f56f990 c0080000105c1600
0000000000000001 
[  576.948982][T31854] GPR04: c000000001510808 0000000000000008 0000000005cf0ca2
fffffffe5ca98558 
[  576.948982][T31854] GPR08: 0000000000000001 0000000000000070 0000000000000000
c00800001057b690 
[  576.948982][T31854] GPR12: c0000000001f1e30 c000001ffffd5600 000000000000000e
00000000000007ff 
[  576.948982][T31854] GPR16: c00000129f56fa20 000000000000fff5 0000000000000001
0000000000001dbc 
[  576.948982][T31854] GPR20: 0000000000000000 000000000000002e 0000000000000800
0000000000000020 
[  576.948982][T31854] GPR24: 000000000000000e 0000000000000000 0000000000000000
c000000001510808 
[  576.948982][T31854] GPR28: c000001206b8d000 c0080000105d8227 c00000129f56fa20
0000000000000001 
[  576.949200][T31854] NIP [c008000010501bfc] get_orlov_stats+0x114/0x390 [ext4]
get_orlov_stats at fs/ext4/ialloc.c:373 (discriminator 11)
[  576.949232][T31854] LR [c008000010501d94] get_orlov_stats+0x2ac/0x390 [ext4]
[  576.949243][T31854] Call Trace:
[  576.949260][T31854] [c00000129f56f990] [c008000010501d94]
get_orlov_stats+0x2ac/0x390 [ext4] (unreliable)
get_orlov_stats at fs/ext4/ialloc.c:373 (discriminator 11)
[  576.949301][T31854] [c00000129f56f9f0] [c00800001050231c]
find_group_orlov+0x4a4/0x6b0 [ext4]
find_group_orlov at fs/ext4/ialloc.c:467
[  576.949334][T31854] [c00000129f56fae0] [c0080000105055c8]
__ext4_new_inode+0x1450/0x23c0 [ext4]
[  576.949367][T31854] [c00000129f56fc50] [c008000010547f2c]
ext4_mkdir+0x104/0x590 [ext4]
[  576.949399][T31854] [c00000129f56fd60] [c0000000004cbc64]
vfs_mkdir+0x114/0x210
[  576.949432][T31854] [c00000129f56fda0] [c0000000004d1a70]
do_mkdirat+0xb0/0x1a0
[  576.949454][T31854] [c00000129f56fe20] [c00000000000b378]
system_call+0x5c/0x68
[  576.949465][T31854] Instruction dump:
[  576.949473][T31854] 3c620000 e8638730 7f44d378 38630068 48078ccd e8410018
60000000 60000000 
[  576.949497][T31854] 60000000 73490001 4182019c 7b091f24 <7f59482a> 4807a0d1
e8410018 2fa30000 
[  576.949522][T31854] ---[ end trace de4acb29e0d7791c ]---
[  577.200573][T31854] 
[  578.200652][T31854] Kernel panic - not syncing: Fatal exception
[  579

Return-Path: <linux-ext4+bounces-4259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3397E155
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74ADA281296
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F0193402;
	Sun, 22 Sep 2024 11:43:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D213C9C7
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727005385; cv=none; b=H7Z4IujK0U6h763n2cHB0Q5O+afLF/uiqEMJLTHtY0AeYKFOfk73UwKNq9Sjqkpmov9H4jhSDqWdMnG60x8YfNaO7M/e6Xl6xVWu725XJCBkuyqEIr9X0RCIzILx1zX9erszr4vCkuEKBulABIxgxV58tE7P4CqetWhqebcJxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727005385; c=relaxed/simple;
	bh=EPf0nnywD0niFpTQOXAPIemPZxBmfJ1AMrM99RvGy4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t3RmgZjMVAOVBr4oy/mzVUHGXgjspYTAjA9E8ubEbI1W8ceySf8VYQaNUdiadOrfwp5htbTQArE0qfobXVSfIiLklGs4fISIp2Stp2zvrWko/f4FAm1XO03EXa11HWlY4MFu0BxgzMC560JmBSQ7am1SQri3rmnQHdtBiyexEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so530461239f.3
        for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 04:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727005383; x=1727610183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLi2ud1YrNOTbnPgH971uSVNjS9RgWm0J+mPsuQ1+ec=;
        b=QS4J0vkmRxkm2Hr9FDw4Mv3j9awcTh9J8qWfk3wfnxK1HfQOSUwmzVcWbzPHmoxIOf
         zTY1sOilPHdJ8zvr3J6wFL0CVuyCKe/LoHAiIODYegQIFKUT9/diz0moa4KSCCAgjZ7q
         GWESm1ISLCAKLGBuEgegWgHHpf5zPD9a2ZDFWntPg/5MroNLdKUy7gPZJHRZKvv2ywSf
         fc4aGGUP/sj0KNaQwwzi/8vfliUn77fjchUsQulyTIummZSxEDrwgjrliCf2kSOUL+Nc
         UM8vC8Pfk5xkVkYmHMzB9WW1ErU/6v8JNjFV2HtcLHt4OXIw2rVj2rGKdnceS3G/Y5mu
         Q43g==
X-Forwarded-Encrypted: i=1; AJvYcCX+wWXCV7aNXLzNKnPPWPjZ9zc1YhVwqGcs+I79cD23PZNeSMe0ApFq6ieOWFmYBTwfS5L3DVmNOyab@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0AM6+RLPkyG7bl2j6u27nKVFkEGZUNtFVPKuImiV5yHGQuxc
	+cbA1OMpELksNWY//mSTqUVL0oMDXX89cNJz8XX+vMNBCpu6x43Vql1DGHn/SREot/DmAliNXed
	DqXa2WZ07/T7uorzniFFYE1/hvlz2tQ9OY0Ta2eKjfbITycx9fhy2CZI=
X-Google-Smtp-Source: AGHT+IFM9ZEuGEIuZuX40SVqB5D8L7YbOd0D9A7KP1xYu9BCfF+DFyvYhUywTy5gw8yKDXxur34NDfiws80782ihXI+Y6OABNnb2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3a0:911d:c277 with SMTP id
 e9e14a558f8ab-3a0c8c6a282mr78314455ab.5.1727005383062; Sun, 22 Sep 2024
 04:43:03 -0700 (PDT)
Date: Sun, 22 Sep 2024 04:43:03 -0700
In-Reply-To: <tencent_AC4A33669E2C1B724B1C1BCA2552BA67BB08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f002c7.050a0220.1b7b75.0002.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] [ext4?] possible deadlock in
 keyring_clear (2)
From: syzbot <syzbot+1b2d1134e0b675176a15@syzkaller.appspotmail.com>
To: dhowells@redhat.com, eadavis@qq.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in keyring_clear

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-08481-g88264981f208-dirty #0 Not tainted
------------------------------------------------------
kswapd0/79 is trying to acquire lock:
ffff888000b01258 (&type->lock_class){+.+.}-{3:3}, at: keyring_clear+0xb2/0x350 security/keys/keyring.c:1655

but task is already holding lock:
ffffffff8ea36740 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
ffffffff8ea36740 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3848
       might_alloc include/linux/sched/mm.h:327 [inline]
       slab_pre_alloc_hook mm/slub.c:4037 [inline]
       slab_alloc_node mm/slub.c:4115 [inline]
       __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4291
       kmalloc_noprof include/linux/slab.h:878 [inline]
       kzalloc_noprof include/linux/slab.h:1014 [inline]
       assoc_array_insert_in_empty_tree lib/assoc_array.c:457 [inline]
       assoc_array_insert+0x52c/0x33e0 lib/assoc_array.c:991
       __key_link_begin+0xe5/0x1f0 security/keys/keyring.c:1314
       __key_create_or_update+0x570/0xc70 security/keys/key.c:874
       key_create_or_update+0x42/0x60 security/keys/key.c:1018
       x509_load_certificate_list+0x149/0x270 crypto/asymmetric_keys/x509_loader.c:31
       do_one_initcall+0x248/0x880 init/main.c:1269
       do_initcall_level+0x157/0x210 init/main.c:1331
       do_initcalls+0x3f/0x80 init/main.c:1347
       kernel_init_freeable+0x435/0x5d0 init/main.c:1580
       kernel_init+0x1d/0x2b0 init/main.c:1469
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&type->lock_class){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
       fscrypt_put_master_key+0xc8/0x190 fs/crypto/keyring.c:79
       put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
       fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
       ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1525
       ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:323
       evict+0x4e8/0x9b0 fs/inode.c:731
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0x878/0x14d0 mm/shrinker.c:626
       shrink_one+0x43b/0x850 mm/vmscan.c:4818
       shrink_many mm/vmscan.c:4879 [inline]
       lru_gen_shrink_node mm/vmscan.c:4957 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
       kswapd_shrink_node mm/vmscan.c:6765 [inline]
       balance_pgdat mm/vmscan.c:6957 [inline]
       kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&type->lock_class);
                               lock(fs_reclaim);
  lock(&type->lock_class);

 *** DEADLOCK ***

2 locks held by kswapd0/79:
 #0: ffffffff8ea36740 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
 #0: ffffffff8ea36740 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7226
 #1: ffff888035f440e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff888035f440e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 79 Comm: kswapd0 Not tainted 6.11.0-syzkaller-08481-g88264981f208-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
 fscrypt_put_master_key+0xc8/0x190 fs/crypto/keyring.c:79
 put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
 fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
 ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1525
 ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:323
 evict+0x4e8/0x9b0 fs/inode.c:731
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x878/0x14d0 mm/shrinker.c:626
 shrink_one+0x43b/0x850 mm/vmscan.c:4818
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ee4e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2d1134e0b675176a15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174eec27980000



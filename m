Return-Path: <linux-ext4+bounces-1905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59A89A454
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 20:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26741C22488
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799E17334F;
	Fri,  5 Apr 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgcQ26Xe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C517278E;
	Fri,  5 Apr 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342469; cv=none; b=D45fagc6O+iRTcgEY1xczqb4kRCWXE3U6bogsPNBWZiqhv+Rdnmh+qalgbD8wi0dobf7PDYI87TJjUVoB9Rwz8MRHC3txgfCQ+SRoVajMclxQUN1n/FaCc+cXW1D65QnHzciDatfBmlL9CvBky9Rv2YiuibMAoaMHpZXcSpYR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342469; c=relaxed/simple;
	bh=gInCOA+sfPewoaseFEvU8tzLuv1U9E3UhaEqPuZNAw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpyJrN5S8dWy/MXIP8Pm6NpK0QPYAgLWfonP9+Il8Oww3whd3feExCE8fUSfnb/4KNnQ0e6LfeEvhWaoz4YqfkZZFc6aD1XkYQG4yf59o37JiZ/YdBI/jKl4rTHc2w/A5XscM5myumpEYWBlsy8WT1v3XbRtJy1RhltL36jhW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgcQ26Xe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8129797fcso32652371fa.1;
        Fri, 05 Apr 2024 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712342466; x=1712947266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVlxOZUtKUrfgHZukB+ngKkuy1iBG6tY8rl6phcN1Bo=;
        b=UgcQ26XeP3BsHY3BHV7bXxCGW+e4FV2KC3+fHgSFbXyelB7ha99dgP8HhlHrsni3Oi
         Dz1lP5HX1tfB6HuHKV7tIBEn7TZHgCcOHpScsgvVo8C3kJiOUDqMAs4xX42w/h2KkVAR
         Kq6Iy612NWyS0Wq0SxwPSvQhTFPls6ATZRlTcYmayi+utl8knLeU2FcdL70PDIznpvoj
         1e3giabiUotdP8VnOhjxHQ8sI8wFpziqpLwn3mI90ZPCFfIiOMKHOfz+cRPTyMMmXh8m
         3nT2KL/KD6HAuQOOsL+QsxFPsUm2zOv0x4dFVmLvkrlKAsgkzXiz57+j4WMrJVkDydbc
         ervA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342466; x=1712947266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVlxOZUtKUrfgHZukB+ngKkuy1iBG6tY8rl6phcN1Bo=;
        b=fmQMxyGvP+llQVowXdY61J3SSrWModa46D1aj4J8GRD1McVbeuh0yAlNVSx+t0s7rw
         /V4Liv/cHnJSG+X0x/Ej48gsev5teA7jdVVkLqf8yzEfEmKRmaSrvwQm3tl9tqpbXXyO
         0EIXMPNexLIW7MBMRXMM/1cF5evLCDlnKid4tl+n9dg13fLosj0Vzt432Y6yf19MrVit
         PhYYoUmNA93w33VnWtABkiYqc+Csivu7Ia/N2iv+2sbaPcVYTJexb3MLyQ1A3jeGaWp0
         8DO5x+iu1QDX0iN88kgHT1rAMxvmOPjjpiXyLG2Lct6eX+AQCyb7cDRVkWj43kmlfbaN
         RU6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtkAnYwWu86baireE0AWEMjJuQg2RRt3Okl7Ap+9HlFU+w62ZMXt9biHBsk8YbOp5K+mwAueRWc0z5SMxfthxyfiLW8+kdpnNKCWPMStT4mJIUkcwd+mdRpqLi6EZN17mL3pfwxBsX8g==
X-Gm-Message-State: AOJu0YzMuV2PB1IQ0GboMBllEveatW78BioM7mDS0JdgV+Aed/queUUw
	lMEPC54KDZWSZDaATeUf40rUFeEIx0yjQpc1hUHIwHqd4UepEmEn
X-Google-Smtp-Source: AGHT+IGBcuQYWYXn+Fnf2i2A3BrvKvhz1jRcgJNoH2q9Bcwfs3czJqByLoIPjxPS3JpVqjT9jyUr7A==
X-Received: by 2002:a2e:3210:0:b0:2d7:aaf:54ab with SMTP id y16-20020a2e3210000000b002d70aaf54abmr1809661ljy.38.1712342465860;
        Fri, 05 Apr 2024 11:41:05 -0700 (PDT)
Received: from cherry.localnet ([178.69.224.101])
        by smtp.gmail.com with ESMTPSA id c12-20020a05651c014c00b002d80a2da6d2sm236545ljd.129.2024.04.05.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 11:41:05 -0700 (PDT)
From: Artem Sadovnikov <ancowi69@gmail.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michail Ivanov <iwanov-23@bk.ru>, Pavel Koshutin <koshutin.pavel@yandex.ru>,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri, 05 Apr 2024 21:40:14 +0300
Message-ID: <1845977.e0hk0VWMCB@cherry>
In-Reply-To: <20240405022651.GB13376@mit.edu>
References:
 <20240404095000.5872-1-mish.uxin2012@yandex.ru>
 <20240405022651.GB13376@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, April 5, 2024 5:26:51=E2=80=AFAM MSK Theodore Ts'o wrote:
>=20
> This doesn't make any sense.  Lock order matters; the order in which
> you unlock shouldn't (and doesn't) make a difference.  This is also
> something which lockdep doesn't complain about --- because it's not a
> problem.
>=20
> So how was this "found by syzkaller"?
>=20
> 					- Ted

This issue only occurs when CONFIG_PROVE_LOCKING is set, in which case=20
jbd2_might_wait_for_commit macro will lock jbd2_handle in jbd2_journal_stop=
=20
function, which, while i_data_sem is locked, will trigger lockdep, because=
=20
jbd2_journal_start function might also lock on same jbd2_handle at the same=
=20
time

Without CONFIG_PROVE_LOCKING this issue is not possible because=20
jbd2_journal_stop never calls jbd2_might_wait_for_commit

Since syzkaller report was local and wasn't inserted in initial patch messa=
ge,=20
I will put it in this message
It wasn't been able to create a reproducer for that problem, so there's onl=
y a=20
crash report

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.10.208-syzkaller #0 Not tainted
=2D-----------------------------------------------------
syz-fuzzer/1080 is trying to acquire lock:
ffff88810b09e8e0 (jbd2_handle){++++}-{0:0}, at: jbd2_log_wait_commit+0x142/=
0x430=20
fs/jbd2/journal.c:693

but task is already holding lock:
ffff88805eec5c78 (&ei->i_data_sem){++++}-{3:3}, at: ext4_ind_migrate+0x2fe/=
0x840=20
fs/ext4/migrate.c:633

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

=2D> #1 (&ei->i_data_sem){++++}-{3:3}:
       down_read+0x96/0x420 kernel/locking/rwsem.c:1504
       ext4_da_map_blocks fs/ext4/inode.c:1776 [inline]
       ext4_da_get_block_prep+0x5b4/0x11a0 fs/ext4/inode.c:1857
       ext4_block_write_begin+0x479/0x1230 fs/ext4/inode.c:1076
       ext4_da_write_begin+0x3ca/0x1060 fs/ext4/inode.c:3063
       generic_perform_write+0x210/0x500 mm/filemap.c:3336
       ext4_buffered_write_iter+0x232/0x4a0 fs/ext4/file.c:269
       ext4_file_write_iter+0x429/0x1420 fs/ext4/file.c:683
       call_write_iter include/linux/fs.h:1962 [inline]
       new_sync_write+0x427/0x660 fs/read_write.c:518
       vfs_write+0x774/0xab0 fs/read_write.c:605
       ksys_write+0x12d/0x260 fs/read_write.c:658
       do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x62/0xc7

=2D> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2988 [inline]
       check_prevs_add kernel/locking/lockdep.c:3113 [inline]
       validate_chain kernel/locking/lockdep.c:3729 [inline]
       __lock_acquire+0x29c4/0x53c0 kernel/locking/lockdep.c:4955
       lock_acquire kernel/locking/lockdep.c:5566 [inline]
       lock_acquire+0x19f/0x4a0 kernel/locking/lockdep.c:5531
       jbd2_log_wait_commit+0x177/0x430 fs/jbd2/journal.c:696
       jbd2_journal_stop+0x5b0/0xde0 fs/jbd2/transaction.c:1933
       __ext4_journal_stop+0xde/0x1f0 fs/ext4/ext4_jbd2.c:127
       ext4_ind_migrate+0x402/0x840 fs/ext4/migrate.c:666
       ext4_ioctl_setflags+0xaef/0xc70 fs/ext4/ioctl.c:459
       __ext4_ioctl+0x3742/0x4e20 fs/ext4/ioctl.c:870
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:739
       do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x62/0xc7

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem);
                               lock(jbd2_handle);
                               lock(&ei->i_data_sem);
  lock(jbd2_handle);

 *** DEADLOCK ***

4 locks held by syz-fuzzer/1080:
 #0: ffff88810bc42460 (sb_writers#4){.+.+}-{0:0}, at: __ext4_ioctl+0x76a/0x=
4e20=20
fs/ext4/ioctl.c:861
 #1: ffff88805eec5e88 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_loc=
k=20
include/linux/fs.h:774 [inline]
 #1: ffff88805eec5e88 (&type->i_mutex_dir_key#3){++++}-{3:3}, at:=20
__ext4_ioctl+0x799/0x4e20 fs/ext4/ioctl.c:865
 #2: ffff88810bc44ac0 (&sbi->s_writepages_rwsem){++++}-{0:0}, at:=20
ext4_ind_migrate+0x237/0x840 fs/ext4/migrate.c:625
 #3: ffff88805eec5c78 (&ei->i_data_sem){++++}-{3:3}, at: ext4_ind_migrate+0=
x2fe/
0x840 fs/ext4/migrate.c:633

stack backtrace:
CPU: 0 PID: 1080 Comm: syz-fuzzer Not tainted 5.10.208-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1=20
04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x167 lib/dump_stack.c:118
 check_noncircular+0x26c/0x320 kernel/locking/lockdep.c:2123
 check_prev_add kernel/locking/lockdep.c:2988 [inline]
 check_prevs_add kernel/locking/lockdep.c:3113 [inline]
 validate_chain kernel/locking/lockdep.c:3729 [inline]
 __lock_acquire+0x29c4/0x53c0 kernel/locking/lockdep.c:4955
 lock_acquire kernel/locking/lockdep.c:5566 [inline]
 lock_acquire+0x19f/0x4a0 kernel/locking/lockdep.c:5531
 jbd2_log_wait_commit+0x177/0x430 fs/jbd2/journal.c:696
 jbd2_journal_stop+0x5b0/0xde0 fs/jbd2/transaction.c:1933
 __ext4_journal_stop+0xde/0x1f0 fs/ext4/ext4_jbd2.c:127
 ext4_ind_migrate+0x402/0x840 fs/ext4/migrate.c:666
 ext4_ioctl_setflags+0xaef/0xc70 fs/ext4/ioctl.c:459
 __ext4_ioctl+0x3742/0x4e20 fs/ext4/ioctl.c:870
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:739
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
RIP: 0033:0x49e0bb
Code: e8 0a 4b fc ff eb 88 cc cc cc cc cc cc cc cc e8 1b 8f fc ff 48 8b 7c =
24 10=20
48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 2=
0 48=20
c7 44 24 28 ff ff ff ff 48 c7 44 24 30
RSP: 002b:000000c002b65ae8 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000c000025000 RCX: 000000000049e0bb
RDX: 000000c002b65b64 RSI: 0000000040086602 RDI: 000000000000001b
RBP: 000000c002b65b28 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 000000c02b38c840
R13: 0000000000000001 R14: 000000c018a321a0 R15: ffffffffffffffff




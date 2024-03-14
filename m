Return-Path: <linux-ext4+bounces-1621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8687B825
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44BE1C22B23
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F77483;
	Thu, 14 Mar 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuDaChnW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A35664;
	Thu, 14 Mar 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399499; cv=none; b=p6ZUvfjWAzqRV/GGyZ4yHbeRoaeXWVMh8SIE/MK87HHTQJGMpvmkQ3u/c2dYfLRaJAFRcZ36dpdEv2GQWpFp9iCbqYoFw13WyVhSIAMXtF2ynDVFJPpvPUDLvgD8EQUIifgpKVFGEccVCOHCzhJoRJLyWzLyx9FtPP9JZyQHJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399499; c=relaxed/simple;
	bh=2hbTNV/5TvtblKwtMXwvzQguisFt/r+armRXGnDKz2g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oTQcdQElFc5J/11FlOwIB9hR8us3ZQsXowXkq6qPRrWsW0DqFZPTfFBXhERRzL8flwLb0tBgByG+4/OXYUm1kOBKKxPZtoEPNgbqmZtuOXhu4UzmDm2OncM9zABMndSBI7fGohCMGGY/khVCJtU+akQH2sZZ79vuq0SeT4MG+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuDaChnW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4663b29334so77587166b.0;
        Wed, 13 Mar 2024 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710399496; x=1711004296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uK7R6IMh4K5SH8t6Y4GtQF/Ru1BA8tcfLnJueFyG1X0=;
        b=EuDaChnWiw4ZUDz1xh4o6s7LIwft/s+bWGXLiKi41zn2oCdB8cg0tWpVE1MlF3L+pw
         5gsrsYHUEooNWfeElNvjW8fnRSX/SdpPmklRolGY56L4MHsyDfBr/eL3y/cNjIuN823j
         eMCvc6WMcDPE0/e+H3hoAx3fH6s/RveIffiL9TcWCJkDK9zODOrT7QJrBl9/Hc/C0xkf
         sBPZvM+ehc3IgLWarNyB9jd0tIOncTMH0WXObJEDjyfp+ezLEnxoL8ilz0756Fs9A+mk
         908BMY934lBBLFmwYkpAOXurLo2w0QUJbLGVS4ttkIBHHxD1l24Ur2eAooVQDod+WBas
         5Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399496; x=1711004296;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uK7R6IMh4K5SH8t6Y4GtQF/Ru1BA8tcfLnJueFyG1X0=;
        b=nUro6ikm46AYQtQ4Sxd1NteEJbuyh3dPnlxNqcOkHrAKeqxY/iQndXvQ0NEDIQ33Ui
         w0p2s94X56bPBtNTHyd5VeZs5Ps5wEzZa6L+uRsp2VC1GXonUnQ/IohJTHW5kSpExxSi
         IjBrZS7fgAGQNNOut4Aia6RnjpYLbOD8Dtm2v6sW40+GCu3MBUvwltS20Wos7geHET2V
         bJWC4njL0jkRc1F/hb+QDBSVD6ANHmG200Ujv3FKMD077kn5rF0Lba1NRAjuv00c1MkN
         67jXQY+XJBnXj88Z2KWhF0tVFETDT1uGE37iXxPsn3Ke1V7YtkQGVU/3+KIpjEATlPBc
         aBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBv0LfHTHcWZlykG/JfNT9M/R2fLxQsW1UfIbNfi1WoasWl0VGPlssbkVViojVDeWrBtWJmbkqol6cLJXJWtWkAmSjKtZCj6WppKLN
X-Gm-Message-State: AOJu0YwjhmcxbBZlGcKHLVEoMdut1+3fq+Pdy/snekZzLluPeqkWLjr2
	1vMycLEyZ3Htw9JBGgC76ZYEyonjsHePzD7DhOXqmytu8VxA1xmBMxY5FUvyFuqsFTzLNeNF0CT
	SX97ZJHvKalu+5xaY7IKqkuLy2XwZR+RJSVZ/Fg==
X-Google-Smtp-Source: AGHT+IEw19muaeHHMxKaLD2OH1IXR23BE4sOVyWaMGVV43bclBS3JS5qh+xwkPYMSJodQe+qwlkmSXR2NyqDRSQ2wQ8=
X-Received: by 2002:a17:906:4a86:b0:a46:1a14:356a with SMTP id
 x6-20020a1709064a8600b00a461a14356amr488592eju.53.1710399495749; Wed, 13 Mar
 2024 23:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Thu, 14 Mar 2024 14:58:04 +0800
Message-ID: <CAKHoSAu2+dDCR9Dgd4PGYJg2qBqKO+kNThaoFdfVi-AheS3S7w@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in ext4_find_extent
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)

git tree: upstream

console output: https://pastebin.com/raw/YBKrQHxW

kernel config: https://pastebin.com/raw/SJFReJfc

C reproducer: https://pastebin.com/raw/GUVzwEmx

Syzlang reproducer: https://pastebin.com/raw/9KqQRP2e

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:3180!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 267 Comm: syz-executor349 Tainted: G    B              6.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:ext4_split_extent_at+0x8bf/0xdb0 fs/ext4/extents.c:3180
Code: 25 28 00 00 00 0f 85 68 04 00 00 48 81 c4 d8 00 00 00 44 89 e8
5b 5d 41 5c 41 5d 41 5e 41 5f e9 02 78 90 02 e8 22 9c a6 ff 90 <0f> 0b
e8 1a 9c a6 ff 48 8b 5c 24 28 8b 6c 24 30 48 b8 00 00 00 00
RSP: 0018:ffff88810e12f720 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000001ff7fdfd RCX: ffffffffb0dfc90e
RDX: ffff88810ea54400 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000050000028
R10: 000000001ff7fdfd R11: 6e696c6261736944 R12: ffff8881031efff8
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c226980
FS:  00005555561ad3c0(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d9033a180 CR3: 000000010e0b2001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ext4_force_split_extent_at fs/ext4/extents.c:338 [inline]
 ext4_ext_remove_space+0x283d/0x3ba0 fs/ext4/extents.c:2875
 ext4_punch_hole+0xce0/0xfa0 fs/ext4/inode.c:3994
 ext4_fallocate+0xd02/0x3760 fs/ext4/extents.c:4741
 vfs_fallocate+0x4a1/0xd00 fs/open.c:328
 ioctl_preallocate+0x192/0x210 fs/ioctl.c:291
 file_ioctl fs/ioctl.c:334 [inline]
 do_vfs_ioctl+0x1262/0x15b0 fs/ioctl.c:850
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x110/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fd0ed76317d
Code: c3 e8 d7 21 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd48ca3738 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd0ed76317d
RDX: 0000000020000080 RSI: 0000000040305829 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007ffd48ca3938 R09: 00007ffd48ca3938
R10: 00007ffd48ca3938 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd48ca3928 R14: 00007fd0ed7e2530 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_split_extent_at+0x8bf/0xdb0 fs/ext4/extents.c:3180
Code: 25 28 00 00 00 0f 85 68 04 00 00 48 81 c4 d8 00 00 00 44 89 e8
5b 5d 41 5c 41 5d 41 5e 41 5f e9 02 78 90 02 e8 22 9c a6 ff 90 <0f> 0b
e8 1a 9c a6 ff 48 8b 5c 24 28 8b 6c 24 30 48 b8 00 00 00 00
RSP: 0018:ffff88810e12f720 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000001ff7fdfd RCX: ffffffffb0dfc90e
RDX: ffff88810ea54400 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000050000028
R10: 000000001ff7fdfd R11: 6e696c6261736944 R12: ffff8881031efff8
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c226980
FS:  00005555561ad3c0(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0d9033a180 CR3: 000000010e0b2001 CR4: 0000000000770ef0
PKRU: 55555554


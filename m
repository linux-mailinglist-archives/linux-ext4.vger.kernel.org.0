Return-Path: <linux-ext4+bounces-5867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF594A00500
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A33A3E46
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3381CB31D;
	Fri,  3 Jan 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbh5XeDN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2C157A67;
	Fri,  3 Jan 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889485; cv=none; b=kkUWPCpPB1M5xqpM796Lk5B4sPESJejN8ie4XT0w3SSgmr1l2YKnmzAXjhQ2GhRJ0lv1/WsqC3fB8THwQo6cwEPaIXt3SyqRjAsNXuzN32N0By6v8TDlUK7aoR18T12PKRrA+fQcq2+7YACqMfD1Yp0UN3wx2/CDK0XenuDbORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889485; c=relaxed/simple;
	bh=GOd2yJSG7EAgV7JqP/Lfz2ha42gAWZAaYr26OZeCYSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jakWgglK0A/yYXpBTdLhnDAiM+CvODUTTJw68fl6Ctx+oqCAsP+bkeSTS3hwMbax4cKS6qvE1InTVoxWMfx7dMTx/z+uRIbLyG4j0JFWQvRk2h6Y20UmbRgeVfigaYra7RWA1mP5xkEW5wjFn8O9qeN3xGiY98L40iwmeA01WTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbh5XeDN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1324590566b.1;
        Thu, 02 Jan 2025 23:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735889480; x=1736494280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOd2yJSG7EAgV7JqP/Lfz2ha42gAWZAaYr26OZeCYSM=;
        b=Vbh5XeDN6dlvBeyQpJZsIsc6N2Zd8x2VlJk5pYRMnuccYYdhXQpW5nHP3LCokDkLpB
         GPzdxfBDf19ZY5zmGq//NWYp52EiMrrXXXZ/J+lYmlb3NZPuAIn1/VRA36Bxhb2t8HsL
         pjf342h/+BZpBf9l1CLrLG4O0zAhWXeS+rGALwFK+n3w57/tvROdQ7NRm5r6nerUtURb
         DNznAZsXms/OuUjut9YbNLNTFCgztC5GrYg+3TnrDxdO2y2OWlKOB/QGISoGjNfrKoyp
         +bPL3U+poQHnsbf6KkxR6OIbnFP57iF1eWHLngqCCmHphs0aFiX6Inrn8wa0NOE9vsac
         2n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735889480; x=1736494280;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOd2yJSG7EAgV7JqP/Lfz2ha42gAWZAaYr26OZeCYSM=;
        b=V04064H+94iaDVXkfhgJzKLWdrTDNec3g+8U54JvwPeJfgkeNQwQz4/mxlHCHO08Fz
         D9fmn+7B+8nVk/3Jsn6IxCU+uIQg84+aSgN4t4s7dIR8jXNCF8wamu8GyQR5oRI+bzfE
         tRpqV4xpIuM3ot8xi9tFZAemjIu2/8dJiIN8k+1jXL2WeTV5i3tRLwbpEZSENH3/hhpQ
         i7CbD4KnbDoIfC+95b2lGSGTWcHnqkqBxWasQZiEIIq7VzFzd88ppVB6PWk6ruZco43J
         wRkaGTplplVrSqwkM+TtIn93mfBzw0JLe1OKS07xkWmGNo3HiEu0katTgrkASuI/yRqr
         Exlw==
X-Forwarded-Encrypted: i=1; AJvYcCWHjrgkk4W4uWbmLMQIs7mar906Ankkh7P4o43w4O3tDUJNC5UXmncERYn+h2javPqkom41eu+ULgaFfMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OvthTuaIhpiwNKiErPz0c1bBWTUCkxEiqcws/s+9HsVq9M3y
	7WLa7Hsun6E7yVh6F6NVqQ2dJ2AZCPB6ZjSJ9/Iy1i4ePeYWH04K/u2HPNIOyGh+SodFk1r9HlV
	A4DIetRm0Od/JdCTxOryRcdn1Wa9XhCDu
X-Gm-Gg: ASbGncsMusn7IcNBl1UmOR/tdo6ToXVlsXQrjE8Xw6fVP/vSLKshtg+MR2cM2WgN7Ac
	rNcVQWacOGCOrgnrPOV6+DciiWLEQnkBJWIIDBuo=
X-Google-Smtp-Source: AGHT+IHp+eorGXIO0qzqgnPX7zaA92A95C3fj/UsCgg1/FPWZMowPimsEAOGKrX4qg8MR0G7ky5b9ZozqBkskgTBaPs=
X-Received: by 2002:a17:907:6ea7:b0:aa6:8a1b:8b84 with SMTP id
 a640c23a62f3a-aac345f5b92mr4990312666b.57.1735889479611; Thu, 02 Jan 2025
 23:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:31:01 +0800
Message-ID: <CAKHoSAsWa2fNFUTSy=vmFFWeAMiYgdtTuZX5OP2xtVu5WQhd3Q@mail.gmail.com>
Subject: "kernel BUG corrupted in ext4_writepages" in Linux kernel version 6.13.0-rc2
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Affected File: fs/ext4/inode.c

File: fs/ext4/inode.c

Function: ext4_writepages

Detailed Call Stack:

------------[ cut here begin]------------

kernel BUG at fs/ext4/inode.c:2732!
invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 2 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.169 #1
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:5)
RIP: 0010:ext4_writepages+0x2832/0x32f0 fs/ext4/inode.c:2732
Code: d1 ff e9 cd e6 ff ff e8 6c c0 a2 ff 0f 0b 8b 84 24 bc 00 00 00
4c 8b 74 24 38 31 db 89 44 24 18 e9 5b fa ff ff e8 4e c0 a2 ff <0f> 0b
e8 47 c0 a2 ff 0f b6 ac 24 0b 01 00 00 89 5c 24 18 e9 2a ea
RSP: 0018:ffff8881009773f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff819f9669
RDX: ffff888100968000 RSI: ffffffff819faf02 RDI: 0000000000000007
RBP: ffff888007c458a0 R08: 0000000000000000 R09: ffff888007c458a7
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888101d08000 R14: ffff888007c45af0 R15: 00000000000000bc
FS: 0000000000000000(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffca25eaff8 CR3: 0000000021b40000 CR4: 0000000000350ee0
9pnet: p9_fd_create_tcp (13248): problem connecting socket to 127.0.0.1
Call Trace:
<TASK>
do_writepages+0x22a/0x770 mm/page-writeback.c:2386
__writeback_single_inode+0x10a/0xae0 fs/fs-writeback.c:1647
writeback_sb_inodes+0x566/0xfd0 fs/fs-writeback.c:1930
wb_writeback+0x281/0x920 fs/fs-writeback.c:2104
wb_do_writeback fs/fs-writeback.c:2247 [inline]
wb_workfn+0x1a4/0xeb0 fs/fs-writeback.c:2288
process_one_work+0xa3d/0x15a0 kernel/workqueue.c:2310
worker_thread+0x62e/0x1330 kernel/workqueue.c:2457
kthread+0x3c3/0x4a0 kernel/kthread.c:334
ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:287
</TASK>

------------[ cut here end]------------

Root Cause:

The crash is triggered by a kernel bug within the Ext4 filesystem's
inode handling, specifically at line 2732 in fs/ext4/inode.c. The
ext4_writepages function attempts to execute an invalid opcode
(0x0000), which is indicative of corrupted or uninitialized code. This
invalid opcode likely results from memory corruption or improper
handling of inode structures during the writeback process. The
KernelAddressSANitizer (KASAN) has detected a null pointer dereference
in the range [0x40-0x47], suggesting that a critical pointer within
the Ext4 inode or related structures was either not properly
initialized or was corrupted before the write operation. The issue
manifests during the writeback workqueue (wb_workfn), where the kernel
attempts to flush inodes to disk. Additionally, the presence of a
message related to 9pnet: p9_fd_create_tcp indicates potential
interactions with network filesystem operations, which might
exacerbate or contribute to the memory corruption. Consequently, when
the Ext4 subsystem tries to process these corrupted inodes, it
executes invalid instructions, leading to a kernel panic and system
crash. This highlights a serious flaw in the Ext4 writeback mechanism,
potentially caused by concurrent operations, faulty memory management,
or bugs in related filesystem interactions.

Thank you for your time and attention.

Best regards

Wall


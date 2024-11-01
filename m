Return-Path: <linux-ext4+bounces-4878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7B9B883C
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 02:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0271C2151A
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD694436E;
	Fri,  1 Nov 2024 01:18:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E461125D5
	for <linux-ext4@vger.kernel.org>; Fri,  1 Nov 2024 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423907; cv=none; b=rIXug1O/4ctsk893LSv1t0fPKRUUe6RcEwBcpUifHvRr8NSf9FaTlOY7MG79PQk88ESL+dIScUseHGt4AYkEE+H0n56mxVC9/FUwV3g4o5yIXTd5jLS3+XPcmTHly2zI0mgp5R0jgnUqWpv+l+AGHqI2oAUY83Xubaf2loX9dyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423907; c=relaxed/simple;
	bh=PEfDXTPYz4GSXCQlBXUChqsEd3hsSlOQwANs8jdBo6w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YMc71vaeZEP5XGiw0GGMsi7YUVbqrn/tJfuxwaVMrTO6Zryll+Ru8kGimsfmR9M+XvswYhdbreovAO2Nfdw1nO0l6caUTClyJvC45/zWirRMDTZoTcN9eV0dUHF2/HFkA9EWtovoBQZZ/4PCziMJqlGQVq5j32CxkYmQenmJSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so15635125ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 18:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730423900; x=1731028700;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wwl7sozJ8hPrF17Op6Uo3CgwBAyeeQhamMLU82keVE=;
        b=pEMpFtHV+j+mPAH7sXBpbtADvQ92QDNy1O3YuwgV9hfD8/qBR98mcIYoPBh4nOJwA+
         MAh9PORojzIODiGcuo2AnsKm5mR9j8+aindHOcIN08DsWqBOdWRO4Mcy6K39o8qsvOtH
         +ByMCcatTp9X7fy+vA/zw9k9fAmoBmL6c3nwHcSz9XAlEK3iN7oevCKdBYx4tkLrsuJ2
         Q05QbP768CH2o9AJRyL6XKfTPrLMS54Zt++0ZxRAD+WJAaxwwjKUuxntuTHtbLyFfllf
         YQVIbhfqQoaYTfUyrFlSkRR4KVFz5Iy4g0OBQixtRMo2/wqjrPEPNk/TfOlJcAGvZp/z
         Z2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCX8WypvOAYKXqqGwX0ZJkGgc8x5DvPW065gKVKLUhpyiFngUcCY46gqS4EZlYsuOnDaiFooYxRwK/jO@vger.kernel.org
X-Gm-Message-State: AOJu0YySWQ9Sh5ckfbcU7bVjq8Yb+knJReV6ZuwbLwnus0v5HyqWb1wg
	isO90JSKFxgaIg3P1IiH2YGCbEY+jqnVd1v2h9ilCmjAa+vutwSLWS9fohY076wRGR3I35qE1wx
	7SrpfJpmJ8Lq6dwNxIcnIL/sh2gorteKrjGfcfCvAflQ2mIdgCHDhrQg=
X-Google-Smtp-Source: AGHT+IHHn3xPzT2fQIWLfASb6cJq39Sz6JSTeiH7NnohFH0vSjim0hmEeEwuEirM2GjR40ZTerOomoEuWaAemCvCj2v+Xtt0w/QY
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr79893415ab.10.1730423900451; Thu, 31 Oct 2024
 18:18:20 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:18:20 -0700
In-Reply-To: <67237956.050a0220.35b515.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67242c5c.050a0220.529b6.005d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (3)
From: syzbot <syzbot+626aa13bf52efc3aa86e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0fc810ae3ae1 x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1684155f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13742ac59dd3e298
dashboard link: https://syzkaller.appspot.com/bug?extid=626aa13bf52efc3aa86e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178a32a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bc6630580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce34c79f0f6a/disk-0fc810ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/873282a313a5/vmlinux-0fc810ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/027f191557a6/bzImage-0fc810ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40461e1b126f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+626aa13bf52efc3aa86e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5823 at fs/ext4/inode.c:3389 ext4_iomap_begin+0xaa2/0xd30 fs/ext4/inode.c:3389
Modules linked in:
CPU: 0 UID: 0 PID: 5823 Comm: syz-executor562 Not tainted 6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ext4_iomap_begin+0xaa2/0xd30 fs/ext4/inode.c:3389
Code: 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 48 f2 37 ff 49 be 00 00 00 00 00 fc ff df 48 8b 5c 24 48 e9 61 ff ff ff e8 2f f2 37 ff 90 <0f> 0b 90 41 bc de ff ff ff e9 87 f6 ff ff 89 d9 80 e1 07 38 c1 0f
RSP: 0018:ffffc90003ee7560 EFLAGS: 00010293
RAX: ffffffff825ce791 RBX: 0000000010000000 RCX: ffff888031505a00
RDX: 0000000000000000 RSI: 00000000000000d4 RDI: 0000000000000000
RBP: ffffc90003ee76d0 R08: ffffffff825cded8 R09: 1ffff1100f18b778
R10: dffffc0000000000 R11: ffffed100f18b779 R12: 00000000000000d4
R13: 1ffff1100f18b7dc R14: 000000000000000a R15: 0000000000000000
FS:  00007f00ef14c6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000077f60000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdea/0x2370 fs/iomap/direct-io.c:677
 iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:767
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x15f0/0x1a20 fs/ext4/file.c:696
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00ef195cb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f00ef14c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f00ef21e608 RCX: 00007f00ef195cb9
RDX: 0000000000001006 RSI: 0000000020006c00 RDI: 0000000000000004
RBP: 00007f00ef21e600 R08: 00007f00ef14c6c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f00ef21e60c
R13: 0000000000000006 R14: 00007ffee8483890 R15: 00007ffee8483978
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


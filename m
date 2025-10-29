Return-Path: <linux-ext4+bounces-11331-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B248FC19510
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 10:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF026563618
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D336F2EB5D4;
	Wed, 29 Oct 2025 09:02:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F92E2663
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728551; cv=none; b=XxDdcl4FqjNMLEn/T1PoIPNluZw3eoXTIzuEYHWEt7ykbDBGfS3kYUCAwygp92Cm9N4vo6EXtU8B3r2BgOKAbT8t6jGHrXoaTXZJxHpfY4t4AfzBu0XFj7XMm3f3OUKfLYyjcn+yypfQ1CERsnkKcxq6Y+vyBcy8YvQdUqos6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728551; c=relaxed/simple;
	bh=IGp//apSYf3xJnXNtYFq4vgpO8WzhcHSiGUA4uYI5VA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eaxPvrjaftxc9xNAtirX7wWZHsJB5uJppyYP0Yf3VBmDrbKHmav8PrfXA2GHO73YvkPenqeXS3wzOU+PpNUbCq+yH8fbkIA4GYPEIkysW06NBQBkiBxEMva0dbgdhXhpcFZCLLHVm0cIDkqXz9qVy8iAsS28wcMCT4YI333b3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e8db8badeso753054339f.3
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728549; x=1762333349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDiNn0o0Y3/3Q2x+pgZ37f8gFa+KMWmtZRIWR8KSINE=;
        b=uz3jp3gVc8n0hHzno3FV5KJpGKfgSAEPh26fEYEbASPq5aSVOJVqlqyHW4BjXHaLsg
         873DvGYr6ezSFrg0xYmBltOZ9ayOX6jAYjaJSrCH5goSBh2eLMM3xq8+O0pnE6rVR+oY
         vI/lXic2O05O1gB0lpzdXxEHJ1zBF9qApCV9GHDRUJnd86KLz1CNm1xuMEucW02SGw8W
         Epn041E+eO1G8dSeo+MHWwJD9Z8DW8sPuhfgRrw6aUCQh1b6KlHgej04afmyny5KzPmC
         7iVUTopCApZVLQCYzCJdY/FaZb7+Xi5iEPFQ59c3eVSRTLvgW7WyHYk3uWEpLItmsvBO
         C3CQ==
X-Gm-Message-State: AOJu0YxwkiVOTBjbI04FVT/OkevBE0uPmWSpG5q36AiM9R5+0qxWHQwY
	49v/VoOP3EDlZdUM5MAtBEiJ74FYfbad+wjCIWV2QVJt0XM52Vb6c5lw1RTgkAt3+UGVTnv3Pfe
	ca9fkViFzYUbmOyxEwHu6BthbXyguf9vPnH8IKVdgKuTFLPzbpt3a98ah6V0=
X-Google-Smtp-Source: AGHT+IEAk6pcodBPz7ol+NODHQ4h/HlMF+kCyIxpEZYFrncWqLRSijkd27y8TIFm9PoYsp2YosgHUZhH84YW9v5Ym4dXM91SidPB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-432f9044a31mr25339495ab.22.1761728549311; Wed, 29 Oct 2025
 02:02:29 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:02:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d825.050a0220.32483.0205.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Oct 2025)
From: syzbot <syzbot+listc16d6233751953300e09@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 3 new issues were detected and 1 were fixed.
In total, 50 issues are still open and 163 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3903    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<2>  2813    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<3>  2779    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  989     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<5>  572     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<6>  493     Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<7>  269     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<8>  266     Yes   possible deadlock in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9
<9>  168     Yes   kernel BUG in ext4_mb_use_inode_pa (2)
                   https://syzkaller.appspot.com/bug?extid=d79019213609e7056a19
<10> 140     Yes   KASAN: use-after-free Read in ext4_find_extent (4)
                   https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


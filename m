Return-Path: <linux-ext4+bounces-12068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5CC932F0
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 22:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B11334BDAA
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7E2DAFCB;
	Fri, 28 Nov 2025 21:21:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FE284889
	for <linux-ext4@vger.kernel.org>; Fri, 28 Nov 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364891; cv=none; b=hZ28yjVzCxC9KSdJpykGQY2X+rhK0bpaQYYusJk4S5ncjII7e162IYpkjBCxHvHcAKDQsO8ppnSFTOZYtE/gAgZ/CFQ+dXmAC0UThzOIHN2WnXGQ4SMbUzLeE6OQK8bOM/RsNKc59iUuVhbQ/O6p4Zvgts8vxL26DT1PwXrPdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364891; c=relaxed/simple;
	bh=kNzJXuBIGFooK7Srky3cc5zgWDVrNxYsqF8D/wyj1Lo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p0WiGbRRQvwK1XkF5GwB/Wxu45xbGKCPdJVLVjlj3h03dmlMSGsPudE+lFUUfY4lwgY3XZdG3RLxWWo+jj4Mzw4qaBxh+Rgl2bGvl1cRCqd0OVVT8UJvX/kqdzn2yqPZfTjNJsZ8V92Au+Egbd2gzbFs+kXsXH33YNjki31Qf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43376637642so16162575ab.2
        for <linux-ext4@vger.kernel.org>; Fri, 28 Nov 2025 13:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764364889; x=1764969689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8j/ocDaSnqoVH1Ds2ZGTi/QVUG+TcDyQCcs6zoz1V0=;
        b=AbiMw6Su2Dxqnfst8kQrWlT4pWwcSDkiMxBB2w5BZF7ieRlf4wAmoaLk3nTG+G0F3m
         odX2gqBWg2uG5zzkv0/izAz97G2Zvpyw8fkO2Fqkn6cshfyF3YbG3oahEMgWe3AOtwzi
         HZluoskhFNtEGK/PN6AgHY1kfw7gHW4eCbdEvg1OOs0uK95xKv+5vz79iOdqtJ4iRkg/
         tm4ExCMOpndPqdDO5wK/1RJG6VTN1GkxiVC5cCvey3B2KP7vRZAzwPWVoSUk3ATswrWh
         a2uM+Ro+IKr9NVW7ldJOpDoqVZ49ahhZRynSmRY65zvGJR9Xdj+w1Aahmcs1+DPH4YwF
         l2jw==
X-Gm-Message-State: AOJu0YzX380iHtdDIyq4gbukYENsC3MF8GkjR9lm1c133YNKbhUr7IwH
	y1x9UIkB+rd2LKXrMWkBQfOOGoWs1+JxKeBYCeV+8ecCDAY5eO4YoBsw13/V3kF/HNJJYIt586g
	LYI1IgBcMJ8YtR8aWjh5H/juM11Uk2DgCm9xwQb4X20ONHJZxnVhPXA1rt+0=
X-Google-Smtp-Source: AGHT+IHx2Dxl7NXiBixcP7I/5nBWSLW5R4Na9iWp4P+k39VeJlOyxKki4Ra27zAx1vJKwfK42LLIvgsnHH8m1gY7f6dJ1SRhQ++n
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:434:96ea:ff51 with SMTP id
 e9e14a558f8ab-435b98d7a3emr259763645ab.34.1764364889214; Fri, 28 Nov 2025
 13:21:29 -0800 (PST)
Date: Fri, 28 Nov 2025 13:21:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692a1259.a70a0220.d98e3.014d.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Nov 2025)
From: syzbot <syzbot+list3f074455b722999fe7b1@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 163 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4656    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<2>  2848    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<3>  2818    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  2141    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  1317    Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<6>  1083    Yes   WARNING in ext4_xattr_inode_update_ref (2)
                   https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
<7>  989     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<8>  635     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<9>  448     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<10> 277     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


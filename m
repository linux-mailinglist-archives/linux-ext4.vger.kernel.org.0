Return-Path: <linux-ext4+bounces-10461-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB6BA6357
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 22:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E217A193F
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70981239581;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90586227BB5
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=GaDxaj8S+2gRog7VuDSW/RDSnVdtO3Oy97SAx7KResPlKtC0f/UwxAZxRAJ7nUs7RLXRmXHZhAB4KN1yW4jXHZzU7onRppg6S5+R1yVz5Ae/qz76m5XZgBKj+UusERROpH2u3L1UNOi//3nJL5LgCbimPLA0xOtAKJFAWJ3Dsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=+zBwl+AaCTW8x+wT7SJDgTHPGLokFyp9NLVhlzcNNWs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SHfH6rO0oOZPtV1KjlyZ+/91Zf4Ury9hu8fAKe+kUOHGAAWWYn0QGg6phJDTm3Qf//w1IboxjjGOhY8Sd9AVndl1S2MyBb/w+3rOPHeP1uWYHpTqF2XkGny89nu0BzV31W4UDKoELBYvdOILdfnGxgsvonVFsEHA/nNx2o8ql4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8e621d97671so894481939f.1
        for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IJzRXNDU0fTBONuizMH8e1/qcYWtZeMXcQ2P5h9DO8=;
        b=f+OgoaeifymoZ190f4iP+KNp96H9Ez6tL+84xy+RoMl10Zc4bxjNAFZpWVFhVJ9uRB
         w2h4SPd6G3XeR71dGy0eaoK/lHDWL3CwvCnkAWORXbQdB+niRg+4RZhXWLlpxCt8Cpnp
         KYKDqGTDw+9JdSYsqarXfK4kKb1dM0DoF/DKlx4ce6ctRjUp1CgcMeCjMTxBJT1GJc6w
         t488AFkgQ7182qDkIL2bnpF+jnLeNcd4wZcSLhnjCbDunmCIWHuLL0b1RaAmRPJv988p
         1sT6YzOtw55NNyp5QawZsjdD3LuA1PueS6KUNkDmks3D+9FQc+clpliLQae3wu8Tx6AJ
         Ub3Q==
X-Gm-Message-State: AOJu0YzapoaKg8C992CwahnNfDS4yRZJVNh9/IkHmyBA48RWxmKgE+HG
	Vim2zBF0mwn15JIhHxqlV/BR5fKOHzfMyNGWxQ+gsVkNwX9iy7wNmkGboWBERjkVFe6GWqdCck7
	PVx4iQ5SaVhY6VanjseCwSx4Si8U8A1NUPHvjMQQ82Elb7gOjera+u2888fc=
X-Google-Smtp-Source: AGHT+IFISyl9T2WFKDQqKejuvIkXatZetfyZ52hAD92JaH80dTMh9oUTLHxhPbIcF4DnX7OLfvpMK0bk+NyVmzyWsDqWkA8Gw15y
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:428:141a:2e8b with SMTP id
 e9e14a558f8ab-428141a3155mr92231455ab.25.1759005811799; Sat, 27 Sep 2025
 13:43:31 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c73.a00a0220.102ee.001b.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Sep 2025)
From: syzbot <syzbot+lista5389d1222554d2b11ca@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 157 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  83027   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  3308    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<3>  2750    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  2705    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  2137    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  1677    Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<7>  986     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<8>  524     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<9>  445     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<10> 266     Yes   possible deadlock in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


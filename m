Return-Path: <linux-ext4+bounces-6970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A558A6E2CD
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515BF18921F8
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4726738F;
	Mon, 24 Mar 2025 18:56:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A572266F0F
	for <linux-ext4@vger.kernel.org>; Mon, 24 Mar 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842592; cv=none; b=HH0Uog8f6aw/3g7T3CCkwfL5166IXTt8YETn/NUogni7x/E9SzCD2R8uZMbwYtq1JOdB9mgp3Qu6+YedjN8p68s1ZKp6bEqVbIUjy2o7zDSZkSBx3bH25EzKxQphdCJJ5E+dkurKmgmmFZHjJV+rzu/B9SxsxYOmO2xMHPR4YPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842592; c=relaxed/simple;
	bh=4N83Lv/dJjTbxIJ6UW4GnzSJqjXzRnH7BxrEt4Md1nM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dv5r/GzcQv5HNLbAgHlqnTWxyOJXaF4s1EMCF+AsWe8ZWBCsa+Cw/jVYhcitm77GbvYSSqpmowqyGK7fvoEUWerpskzcpecJcmSTaKBR5BDJMn4Td+P/SX2WRHMfXJ9MXsRIh6dlAN/9ZPHnIGo+e1q2IUrp9MCFH0w11V+QugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so491470439f.0
        for <linux-ext4@vger.kernel.org>; Mon, 24 Mar 2025 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842589; x=1743447389;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6x8ZDgndIipZ3DDy99jzbvkLrPvBM8PEqSlHKbromLk=;
        b=ETyb3jWDeFjIQGCBdKBEdH24aaHviBerft9SDQKxrltsxFv4p8ngkmcnOsznPJjfMj
         R8HrSD+aipvvDnZXWGKElAZbQ8uY1ZgOafnz/s74vHrmlAy11kW3QSj1MTN4t+BeZn0U
         GnifT8LGG+zhSqmOISvfP1t68wmTLd5Td/vBsfns2McL45FUTadWMXr67eNksbVU0CwS
         dbcrpxzK5iB/R6YozAu9fg7IDz4m38Jtik6tYM43mjKgCVKDF8si28jp7dk2IIJiBzQe
         mpqiL5BpNhzokKXB2UruRQBItEsgX6TpUqho/C8jGcmt3/05k+4Q7Y77DpKNxtIF+vD+
         cgFg==
X-Gm-Message-State: AOJu0Yxu71vvrsY3kJ7ANAboG9LXhswMc/yDWX/KG+/V3NGg8kZmtIjp
	6Wg8R1ymbitrBR+PEUcHckC6ejxtDj+0YkxjNDTgzjESLaGN7ZNB4HZfpLXxDpO/0QR3vRU/FqD
	aM4GwUgOIZVWywuP6UzEb0V5zzbrGSVxj+qTPdvHedMJEVEo09XT7yjg=
X-Google-Smtp-Source: AGHT+IHWM+5Paj9CM0S3LiB14mk2myB2cwnVTiBAqyY0LO/MLem87joVtRO/3gGg2+NzkK5zR/d0eMomyh6FFV3iFR5HBR+oD5FJ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370c:b0:3d3:e284:afbb with SMTP id
 e9e14a558f8ab-3d596118403mr135061415ab.11.1742842589478; Mon, 24 Mar 2025
 11:56:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:56:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1aadd.050a0220.a7ebc.002e.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Mar 2025)
From: syzbot <syzbot+lista0009dd96368e51bfdc6@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 2 new issues were detected and 0 were fixed.
In total, 57 issues are still open and 148 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  72595   Yes   WARNING in inode_set_cached_link
                   https://syzkaller.appspot.com/bug?extid=2cca5ef7e5ed862c0799
<2>  41454   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<3>  4909    Yes   WARNING in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=2ff67872645e5b5ebdd5
<4>  2297    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5>  2060    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<6>  1944    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<7>  1226    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<8>  243     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<9>  183     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<10> 132     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


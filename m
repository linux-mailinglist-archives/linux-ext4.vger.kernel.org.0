Return-Path: <linux-ext4+bounces-352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6980BA16
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Dec 2023 11:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18B3B209D4
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Dec 2023 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AC8466;
	Sun, 10 Dec 2023 10:05:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A8107
	for <linux-ext4@vger.kernel.org>; Sun, 10 Dec 2023 02:05:22 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58a21120248so3591766eaf.0
        for <linux-ext4@vger.kernel.org>; Sun, 10 Dec 2023 02:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202722; x=1702807522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKXFc2v7t4kCPe8Iesh8qQND7OzFTIcop0B/KSdXasE=;
        b=C5VALFxQ/08p4I5bXycVnDgy84FYSbZVXjOThCRbYChUwwltNenLbuBpDUitVBLLEF
         r17ukOTnRg3wOOWzdCBdnVtF/n5UjdknCQXhy60o1S9x1PicXCUSUEChMhZ2HTN73n2j
         psZjrKftkOXwtHlwb02bzaqxDP0FXicBEXj7ZeA8tVudpqOWeLPYZgBWJT3B1VSGcPQy
         huXWhHxDpMXcKRtRayl1UEXFAeu88uw+2aiGYEKnfPRU7XWhK2Fo5+34Es9kKTgGT+uz
         b+gnT0zmPonsGZIZOZQgw+JVwCyzW+wOGQfuim08xNooK+j68bk55koQDWXP1RKZbO4q
         Ysug==
X-Gm-Message-State: AOJu0Yy6fkpX7w+K7Nf7QAg/PePZbCfgwUou5hg/Es145Tnl4p2zqzjj
	7YoObIWigDgc4TmRDFE6hhq7E/VBTr8sksrS8qLC5EF2YVkw
X-Google-Smtp-Source: AGHT+IF3qDImtqdycyGXN44w/tJpzNdjGEYlzQeJZKDWqiMw1vFKoS5HQnUnTIZ/28zH/2VGVNvWbF/e0jMYVfkJJJfj3oBV+Py7
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:96a1:b0:1e1:2ebc:b636 with SMTP id
 o33-20020a05687096a100b001e12ebcb636mr3312255oaq.4.1702202722216; Sun, 10 Dec
 2023 02:05:22 -0800 (PST)
Date: Sun, 10 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ef5d060c24f422@google.com>
Subject: [syzbot] Monthly ext4 report (Dec 2023)
From: syzbot <syzbot+list52026f6b95687b491ce2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 61 issues are still open and 115 have been fixed so far.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  51616   Yes   possible deadlock in console_flush_all (2)
                   https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2>  6748    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<3>  546     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<4>  247     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  152     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  115     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<7>  47      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<8>  32      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<9>  16      Yes   possible deadlock in ext4_xattr_inode_iget (2)
                   https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
<10> 13      Yes   kernel BUG in ext4_enable_quotas
                   https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-ext4+bounces-758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F7828C6E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1028CFF4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2413D0D9;
	Tue,  9 Jan 2024 18:20:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4763C092
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3606b8d9c64so28288485ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jan 2024 10:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824431; x=1705429231;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J70jJVi/+Y+keEkrfKVYDadyIqz0xF8h9WQxMmW5dyY=;
        b=uGdd6q13IbI2F1YU3V9uuaiSK5jm+EB9sdz8kcXULVvmnhRPwHGdcKDR//93+ZYv21
         fWlbaJzqa9uyfllpbxO/vDxqtL0FnE7YRPpLVCDhud1NY3orEIoIEuLU8MQJEipB2RI4
         5aocpM/lRJ1utzahcrLucsi1tyeMwMrtSqt2bErBGReaUuYoSGaD3fmbAf8ShTWbYF72
         /OxqsS6Vv4/zozKwt0KlH9qwC9VarudNXHxfTwS31uaaki+Vdx3ooh4uSbfZKEQYBW9f
         VR98w7DXCBb07DWsWvPakMSy6PFYTnOKP5UEwhmS//wBoXoHpbbmKMuFB3utO97USdqV
         VFNw==
X-Gm-Message-State: AOJu0YwcnmgdFBE+cuf9Xjd8l6iGL4DaiQSmfQUzT84xZKuQAhjmrbXr
	xT0enkUKc/fEZvVrgW5w4iHt5lzQXmRSHLZXTVEWPLvEM0Z8
X-Google-Smtp-Source: AGHT+IG/COheHNYeBQtfOtXP9dCRJQZnibbLZJu1agfESiN8WjSdJtg42/URP9tkcKLI2Bea6eApoJIUAV0kqD5YFYVCd1jmz/HV
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2191:b0:35f:cd35:f07e with SMTP id
 j17-20020a056e02219100b0035fcd35f07emr693570ila.6.1704824431598; Tue, 09 Jan
 2024 10:20:31 -0800 (PST)
Date: Tue, 09 Jan 2024 10:20:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a662b7060e875ef7@google.com>
Subject: [syzbot] Monthly ext4 report (Jan 2024)
From: syzbot <syzbot+list33d242e0a922ac751421@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 1 new issues were detected and 0 were fixed.
In total, 35 issues are still open and 116 have been fixed so far.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7311    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  597     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  293     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  155     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5>  132     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6>  78      Yes   INFO: rcu detected stall in clock_adjtime (2)
                   https://syzkaller.appspot.com/bug?extid=628d3507228ad7472be1
<7>  22      Yes   possible deadlock in ext4_xattr_inode_iget (2)
                   https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
<8>  17      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<9>  17      Yes   kernel BUG in __ext4_journal_stop
                   https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
<10> 16      Yes   kernel BUG in ext4_enable_quotas
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


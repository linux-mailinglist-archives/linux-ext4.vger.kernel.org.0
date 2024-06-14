Return-Path: <linux-ext4+bounces-2880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B89085E7
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 10:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719871C21FAF
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13E1836F9;
	Fri, 14 Jun 2024 08:14:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB018145A05
	for <linux-ext4@vger.kernel.org>; Fri, 14 Jun 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352862; cv=none; b=sOAwv4V0AMg4exg10H138JCxgNqpu0gI6YNqLuNvFsxTxgJZk0v6R5VZ32goDYD7lchzdPRf9D33/ZoQZnifK/m/ZHqk1JBr6GulV9ndZITXmgq1oSy0KJv+mxsMNNZoG5gFmJfMUT73LLRElRNQs6MuWB4Pd3Uk9D4qN2J/CVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352862; c=relaxed/simple;
	bh=yLqAfftgtIHGKZn0iE5v48D5mADBsgNfgWxlFY1CiL0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qqbZJm5w9BLYY5TPkzTpplHVtlA+Ufh/GRUipKSUvWWAo+o8LtVNsTVwgYr8cZVHtMZMDOcDImQdo6cwDS9q6/Z/kufAN8H7uimLOuEWyZ/pSBAsYErbaIF9817TfSn4mTEWNEltra1LMeXWGM/FprOMH9Z1PUxjx8TJXqT3sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375e4d55457so3911135ab.0
        for <linux-ext4@vger.kernel.org>; Fri, 14 Jun 2024 01:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352860; x=1718957660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adMNGI81LfgdnwJM9zYhmP2IG5H/7LSnDJYwFF5kkRI=;
        b=k7WuZ6Si8A6XhgjXLMHQmV2C98X0eOkCpMqpxtGV1+mN0DLmkI3PtZmsxuugPsFTzY
         /KaHnnNcELEtIVq1m1FxJEuBAxueue6KNF3ibBvuNybT/lAWZ483oKw+GbtkMabkbOVA
         70lh4NWOU/v2hzriPWzjcSDdakrmjZ++3za863FQpAhbko5gq3dKzd/Wv7/3feSFwySn
         b4qQcuZa8xOe8KMJmXI73TdrHNWnGAqpt+WO/WcjlUnZEIK43ZRQ9bTAe7UzSbWySAby
         I6xA771FLa6wvehE5DMsTIwDTF+JKNjgD/s1sDufQY33PMTOJ8NIIej1FcyWEfuXixyv
         Q9fw==
X-Gm-Message-State: AOJu0YwkEjskpk/2N5cFCCKm9Kko7+f/tEdh+QQ4CfQbCHc9B4h7lmRz
	RGsw9pGcVifo4f5ckBHOjkpaaxTN8l3ocyIHvqLf5xURPf56dXeEEY2PBdcRlxsrN5uS44OwPz7
	ZF0so5UpAJaf4noXZMW0V/PY4Sk07cd9W6uT3MjbBG/AE33e/phfU84Q=
X-Google-Smtp-Source: AGHT+IHbO4SJ4CladRVzwUwIWOBRY0asH+KlStwnD45lqOeoOzdgMkj/jdrOgL81L8pRX+dUYkIdMPK40jNAei0KmS3aKEJA/C1Y
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-375e1053484mr1184695ab.4.1718352860205; Fri, 14 Jun 2024
 01:14:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e4a1061ad53398@google.com>
Subject: [syzbot] Monthly ext4 report (Jun 2024)
From: syzbot <syzbot+list89334176c7333521aa2c@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 134 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9744    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  767     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  547     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  491     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5>  452     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  265     Yes   KMSAN: uninit-value in ext4_inlinedir_to_tree
                   https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
<7>  248     Yes   WARNING in __fortify_report
                   https://syzkaller.appspot.com/bug?extid=50835f73143cc2905b9e
<8>  226     No    possible deadlock in __ext4_mark_inode_dirty (3)
                   https://syzkaller.appspot.com/bug?extid=72c7e5a0d9f5901e864e
<9>  155     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<10> 32      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


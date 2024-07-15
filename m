Return-Path: <linux-ext4+bounces-3278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C5931659
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997611F2255E
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F818EA83;
	Mon, 15 Jul 2024 14:03:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE918E774
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052210; cv=none; b=uCxCx8RcSzaILv5yl4bLWjcK0CQ7mP7CwiVnVtIZeP3E6YywudrFsLZN9K2p/4N7vJ5y3xfophrscdakCJM14rNx1++6zYW/WiUwTriQxKI7qCZqGpz4w4T2D6OhW9IDYEoSSepz55wuEinRwYuWcTuP65ZXRC057Qf4mZ6umVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052210; c=relaxed/simple;
	bh=C+gRiq69F4ISt6vvxd9tUTsZhvSX+XhIhoiPKht+0Vk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ro84hVaFmC3mKH4KAYDNBwPZNsEH2iC81CC/re5uKS00Sro0jXOe60d6Y4l48rNZvLVy3xMTsSxND8Rh21SMKfKlOFTdBaPZRUi+yDIVd3XSgPZMDVyfX4UV/bwvUZkUZmVRXpUOFKTrya9L9f9u0DfqC8l5dQ1ief2V+AiDdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8152f0c4837so1295839f.0
        for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 07:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052208; x=1721657008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1lNj/oSeYXzBUdR6uxjHpRPfChohFUFqZTmJEjOkYE=;
        b=Cr72SKgKIXm+kNwJHM2poBedDM/njaUErPMA1KTpRdqphc/cyLmgDyA5+42Cyak/7P
         AjIB+c0Fj/fq4GKz0f2v/WkmmkEt+DbdNGzJBBwEjkeZqV5gdHjayqo0Vft+H9df2pS/
         pgLWo0M6rNez4EVkN1sWxd93kttwIhAhxeo1xLoZFCaFjllYMpQoZjeykGbus6svafsa
         KJfe/ItpJjnNLALaxVIE99ih1Z3oDds3LJUAmQ4oNaTKuWNXS+oDkipmqHz3YLHCfR04
         6x5x3R+2DKd+9WHfbV9waJRQp8GRdmjMsl4CVL84LKHa1Y/xlBVK04ueo6R0TxGBubyn
         RX1g==
X-Gm-Message-State: AOJu0YzqCHHCh+StYjkz0mxHp8oH28RF3QAEqFNHzzKrVIBsDCwFSAAU
	1i0GttSkfFAM997Y2SzuiitC9NNEQdJ/bmy8TR6cWaREVm014Uu/L6LlR2NyuwNynhRtiekCDG4
	edm93LiHdwfASrCiEAnZ7ANAU3kUvFaEACC2ZvceG/ZP0scjrGJjFBuI=
X-Google-Smtp-Source: AGHT+IGZKMBcCYlEDP31jz9E4gHrPb9JJsJPbCjKFqlG0rQxOeHTaUxB8iufAyylTONKJLMyslc4OwLTjoP2Tbvlx5LYLJSk1SLo
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4c0b2b907f6mr1432835173.6.1721052208085; Mon, 15 Jul 2024
 07:03:28 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:03:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080c9c5061d49b1d4@google.com>
Subject: [syzbot] Monthly ext4 report (Jul 2024)
From: syzbot <syzbot+list2032c8f48b9cdc43ce58@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 134 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  893     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<2>  784     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  595     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  237     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  120     No    WARNING in ext4_fileattr_get
                   https://syzkaller.appspot.com/bug?extid=d6a7a43c85606b87babd
<6>  111     Yes   possible deadlock in ext4_xattr_inode_iget (3)
                   https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
<7>  66      No    INFO: task hung in ext4_stop_mmpd
                   https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
<8>  47      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<9>  31      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<10> 30      Yes   WARNING in fscrypt_fname_siphash
                   https://syzkaller.appspot.com/bug?extid=340581ba9dceb7e06fb3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-ext4+bounces-1189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19084FE03
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 21:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CB31C22166
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F137A16410;
	Fri,  9 Feb 2024 20:57:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF1DF4F
	for <linux-ext4@vger.kernel.org>; Fri,  9 Feb 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512246; cv=none; b=Ac7wshKoybTQPrkqQ16LSsNKCfZme45ngnwbg0/UxhomVh649KwXcWrWfKGstdY4jdzO0vZFeLt7ldHJCey4WaleO2SblWX+0nMtejtzeH6c3i7/sLNJwr4fV+GsLRZji008cFudiYWmzlKTz5pcq+5M8aIvaS0cv8Hjqa8Nhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512246; c=relaxed/simple;
	bh=+dMAMw2dcfKDAd2+MvSLxA08RleTfIVCrxnfRUmLKyY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aBVOCvNpODc5yGehy4l22FkyjddKMQQzJOOGIPKW4x2TFLz79MHD2Ed/RtNaAJmizjc5nI5mz1j0OKQE7VP8Wa1CbiZoQlPiu5EZCQ2BOXRvVwNmzLb9nPHpxPTPNncvU9GZYqtLkUs2Xtakm4sqNuc3b2wbYiEPETWNrisO8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b685b342so10393075ab.3
        for <linux-ext4@vger.kernel.org>; Fri, 09 Feb 2024 12:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512244; x=1708117044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFTg0K7lXY4y3frjmYpGnm3YS05WUyZS/wLOJo/jHGs=;
        b=d7/sqitEu4PzgOIZVb3MSXK49b3jU1FBVCL/zEjvae8t2FWNIp1p1ijbc97ZtpjlLZ
         18TQrGUYzGHlJ8ba34gDHvW4oW293f31z9JL6vqHR6FKU20eHVGNw6zuCM85zLMyOSaY
         U8Sa4owuARfQj0BwVLwQ/ntPqyC7bUFVddMq0CLEFsf9/lO3l6uGYVtdIVBaFn6kBEHN
         UZv2xMKpD2e+6EX3rhk1cziPLa5AHws1JgLZFtto0LS1jq6IdS3xww1zgFctS4iNJi9A
         xjN7ZO2dJtAELgwHW/sroxZ+sNSU2Est1+xjz6sqis5T8FQh4biu/vS/XDCsbkPAdL7O
         U0PQ==
X-Gm-Message-State: AOJu0YxvRvGYYi476QLbS2udGb2Ok4JulrGgAS3ck/QI+wIYCQpk7PDf
	HK9s+nLR+xhBgDhlButsmrH+rKZOmGxApjCEE7moq0oM18+8T+zoi4swOIplolUsjq0xc4zNz/W
	SyYsx7G1OwQo6hGfIWrmLk524J33uLkvFuxr3l+YPhaNO7G/8I8JcXpI=
X-Google-Smtp-Source: AGHT+IGdLeGONIs7F845XOWHNTzI5KK9bNltWIUcbWbeIyhjIScRgujk4YF77nhFrcYY3T/XezYbRVoQw/mLnV1uEiSZUwN6cKez
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:363:8f06:80b7 with SMTP id
 i1-20020a056e02152100b003638f0680b7mr24487ilu.2.1707512244450; Fri, 09 Feb
 2024 12:57:24 -0800 (PST)
Date: Fri, 09 Feb 2024 12:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7be4b0610f92ce9@google.com>
Subject: [syzbot] Monthly ext4 report (Feb 2024)
From: syzbot <syzbot+listd3850c3d2bbdc5fbcb45@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 4 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 122 have been fixed so far.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7985    Yes   WARNING: locking bug in ext4_move_extents
                  https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2> 664     Yes   WARNING: locking bug in __ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3> 346     Yes   WARNING: locking bug in ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4> 166     No    possible deadlock in evict (3)
                  https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5> 148     Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6> 69      No    WARNING in ext4_write_inode (2)
                  https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<7> 19      No    possible deadlock in start_this_handle (4)
                  https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<8> 18      No    possible deadlock in ext4_da_get_block_prep
                  https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
<9> 1       Yes   kernel BUG in set_blocksize
                  https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


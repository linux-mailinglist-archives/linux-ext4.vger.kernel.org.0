Return-Path: <linux-ext4+bounces-8650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC2AE9535
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 07:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915475A0EAA
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3A218592;
	Thu, 26 Jun 2025 05:37:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453E17BA5
	for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916250; cv=none; b=mDo9q8cP9w9vmfbYVnFwBopA0reLeb3MNrjHEw25TyEQXqCz5+vq0dFW1VBQ+ZnjEX3o0IEhADOb+rkQYQ3PjTP60RuKnHXIk9BqlQXtWDhsBeuaVKM3OHDMwXsyYn8Y0wtTzUJx9U+MqXqvJsPiNXlqsMLrdZP2cdlI5+s+qZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916250; c=relaxed/simple;
	bh=c89ouZb/gFQnniB4gI48y61bpmeivGZYeXzu1bAVQYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SJ7bPgEv/amicUIJ+eogvzXxpoBgEvlDlnC+V3tRPeGEM2qRpdXOleNXtsXnSFRKCr6gP+iFMI1TNEbij0HeMx/As088yE238MKDqOnalfaQBLOELoyv7Mj44x2ERHFV2S5fw600TtbIHc/eaZ1I6o3FzsUP7XeEVn8XdHVdZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126265baso59958839f.0
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 22:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916248; x=1751521048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6zr5gMOE1PZ0VHYXVu3KIirtRmXbIGkumUQbMXz60U=;
        b=jUFbGx50xJ/ugCKZ8/C80jROtW29uVjmoc9VIXDrUStvgOqbRU2U2oOz+5hcDBj1YV
         L2jVgczaokud3uMOFq528BPHx+asvRWJ67tO48ciK/RTVDSHR+nTRPAtsVuPv2zOPH/l
         i4SexlaJm38a4393IAk85xkiTES+O1NJzjXKO0WNxT4l8V+T1ejqb/88v4xLC/XNcjJ2
         042LQIz6lMlj2xP6zaZRnxftW2pxOs0FTA9dW6B5JONa9mW9PTGI2XClQkmjAmyd290b
         YTJbVMfCrFvomasdGj30U7d6EuswiEUnd90sH2DJS9BPZO7tY0rCCna/lr62KjeJOMTo
         1pQQ==
X-Gm-Message-State: AOJu0YzsomJe/p5wRthERIhWFo66g7Ak4pQUxvRIIJ7f+9UlbAxB8tmH
	Ou3xJXxe1QT5biyoDQ0fb2w4+UlMMqYm78eRJV4gl4eSA52XHJq8ey4Dm4p19WwUlcw0AfzpjA0
	WM8cSCa0QadmyDGxmRnG3tIWytnl4USQbG2xI9dFZsVqqf+iDVvG1M/fmjAQ=
X-Google-Smtp-Source: AGHT+IFyi6ez7dB3D8CQcY2GDyEDTxkkHDv12ke+AZ5tPyp8vSrRiHRYIaR8ayGCeZ+LZZhxpFBUmoxe/0UgPqMtd6NPNe9LH+NM
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3df32936b14mr78743225ab.12.1750916248032; Wed, 25 Jun 2025
 22:37:28 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685cdc98.a00a0220.2e5631.01f8.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Jun 2025)
From: syzbot <syzbot+listb7f719281e6c9361aeac@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 2 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 153 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  63794   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2420    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  2352    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  2134    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<5>  439     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<6>  362     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<7>  336     Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<8>  277     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<9>  232     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<10> 198     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


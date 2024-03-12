Return-Path: <linux-ext4+bounces-1602-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3B8790FB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537FC1F22E28
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CDD78280;
	Tue, 12 Mar 2024 09:29:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09078288
	for <linux-ext4@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235771; cv=none; b=PGcthl/cMbMwv4HpT8kz2KeQA/ggIvOOfza52RzmMqFqcqQc3bo1O70ugDPl+Dqa5ePawiCVoFI97BrgU74S7yuV0fZHZ2RyOtGPVugOPeV/Z3Vpy4A7AEOneD/8Lvw/9dGG+nINPNnZxvlU6vBZ1arYgsyB4t7SDlm2gDdNhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235771; c=relaxed/simple;
	bh=ehWpkfkMr4Exik6vYYe2yGX8sbZqG5YleARftCleK0U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nmH2oR3vOFaiZ9qx/32IBpBSsCUM62hpBUzImS11Bd3HqyNJ5ZqLd5u6+zhhQ0Y1+AKtV/wPBH2pl+aE9iDHbTalc16Oum3kMJNw71oCwVYWawzRBRmE1OgKFT65etrcJtlIuzcFhUcs4hT+GYED9Ny53g0O38uZPLqfQmk+GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so236741139f.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235769; x=1710840569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFetsjEr0kUioGW5XrIiMJoGBxEPtRzAwYLRDfXTaMY=;
        b=IgXwvYtwhxn3D0LdQ5o2tR+01zOT6askq3iGv8Cih91sxdj+0OQBU704k30zW4qCxp
         nMWtBOE6rgGPGs6mSphbUKhU8vmmPjqguCHDu4bGSGLU1GH/a1IrD4kDNZE6LwftQ0G5
         4PMlvYnXjorhmtlNhYVsPoewbahNmR+yQHU4jyjEgu4CwLVWieilGYLlR6mAmv43Tdf8
         cJVuFyOgKQXDoikJLoI/XeUPA+TMan7QLpFqK/BMS2KXWy21SOHjRtJpLD7Poy08cysf
         vujbEsNwnRRwt+q3+Lkk/IVqmbM31LnAwatxoH9ng6qR2qdJgatHPOpLQO2njsln55WL
         DpJw==
X-Forwarded-Encrypted: i=1; AJvYcCXPObZAuEky3hB+ZA1lEkFHcr8hNLRzmG5AQV8QNXxsXwtD29ODDI0HqTS1EPaYOm+XPNi8p1QapJ2OIpVGSrmeLbR3By7pd8RhUg==
X-Gm-Message-State: AOJu0YzlVwMjuPywqmlDV0rTRnDf7t0jqFLNUcGDjuAH+ARCeXsDcDtH
	QjFh/8HhvnxZf54L+mqW2ge6jhIcxWtxj8vnTHLlO5Ul08yvUfc9w4mO9gF4R9rAdaAL/Y3qHq1
	z04A+8/wliH7FRt2adb2JvuXtaFi45bG4LGk+TWpjQL5mJs74SZXXliA=
X-Google-Smtp-Source: AGHT+IHhz/Axrt0zZCKf3PniY1Mh1aydPtxkbDwqNPaTDtF0sB8pBoy7STMPAKzoXmjYPCvamqPfzoT6Mma8+3/tz7bzOG/dk9wy
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1506:b0:476:d5dc:b729 with SMTP id
 b6-20020a056638150600b00476d5dcb729mr93611jat.4.1710235768831; Tue, 12 Mar
 2024 02:29:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bfda60613734bdf@google.com>
Subject: [syzbot] Monthly ext4 report (Mar 2024)
From: syzbot <syzbot+list9a35871b40c53fa1b44b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 130 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8629    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  697     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  401     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  173     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5>  81      No    WARNING in ext4_write_inode (2)
                   https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<6>  23      No    possible deadlock in ext4_da_get_block_prep
                   https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
<7>  22      No    possible deadlock in start_this_handle (4)
                   https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<8>  18      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<9>  18      Yes   kernel BUG in __ext4_journal_stop
                   https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
<10> 7       Yes   kernel BUG in ext4_write_inline_data_end (2)
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


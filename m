Return-Path: <linux-ext4+bounces-12530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54ACE9457
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Dec 2025 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDAB3011F90
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Dec 2025 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2C2D8370;
	Tue, 30 Dec 2025 09:52:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FEA2C235D
	for <linux-ext4@vger.kernel.org>; Tue, 30 Dec 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088351; cv=none; b=N2vI7c/drqEUGJZEwx5Y2a+9Lm1Y+nZQZuR4HrU7BAiSwtLheYJerzN/Ek58Kj+bFo/jms5DN6E7aRXxsx01cMKPT/U/AjOREJ+9YjCobvfT4tIOy/vdGjG0LVBR7vCdAbeoptBE8C9Ztj29qJ+NXlTbJPqNWyko/SwFg3LQug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088351; c=relaxed/simple;
	bh=D8uqlwwBNOXH+X+QkO+ZHqcCzeD5V8VgkGv62xd8ID4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvvV+x6vCJhK7zv+gOgzXC5u7K1+jRHn5n57QeeRSbn9QVxDJdF+Bx5u6NjIUPHT2wd1RMt/e2s9Xe8PVoE6U4jEEL4rsE2X/GkK7DotO83akEDjx0t66C1nSJ6AET8TYlEO3ueQVdXqWModF+hSS5znfQSkGsdHYlXofgUF6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-453109b60a5so6778367b6e.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Dec 2025 01:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088348; x=1767693148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lZ285r7BIURCAQMfiYh+cXAdYu7GLfqweqFjNkAd0g=;
        b=a17LiGhw+Gph7G84PiNlY7pp+PJRVwk/pRtno6Txk3wSNcKa/Qo5amcNc+hpXXvCb9
         4eAoIdcTmTc/yRQ8x/C9iD5uBj55388MKrmD9TzbtDWeDBb219WnjRq9gZTk9rngZObY
         KtUdS2GtJW3suDTq6Jyk8YP26KiPtj0c0hs1sxFEBqNzX+80l+ppIrK7Kee/ZYLFgU39
         Ctnxb6wEJcVORTQKHvpILT2jB4PA3qmXO/sXo/vu2xHEZeca57DE6jr7wrrFY9Zm86Bl
         cP7zc9k9dxOB/tcYAHyW1AHwDHpXJgAOyFslbteqJ5tZodYws695A9X17hUrjL1t9fJM
         Fa1Q==
X-Gm-Message-State: AOJu0YwfW00cNEamuCtVnTBIWZH1F0KRZQFYrAswcnVO2g09RZ9oMjpU
	IpQ4zrb8vmXdBnFpxBx6T8zdbXGJmUUoFGub4ha6fsMBoQHpHXTbazTDlOQW1kjHAjJ8XRcTRtK
	SYYxUJ8YDPlmmoaZMGYs1k3M+yo8yCmuI9M37u5eW9E9/BIeX2TQ1y4W4epQ=
X-Google-Smtp-Source: AGHT+IFsZnj5KEpA0GX20v49K+7NPTCWMkVy+T8rwPubZ3M3zVNq1IqvAHL3qWeCj1KPCqoHZU/0NVLDg41eXxg89EygG9Y3DKDT
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e1d8:0:b0:65c:f991:e7fe with SMTP id
 006d021491bc7-65d0e922f95mr10269034eaf.6.1767088348621; Tue, 30 Dec 2025
 01:52:28 -0800 (PST)
Date: Tue, 30 Dec 2025 01:52:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953a0dc.050a0220.329c0f.0570.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Dec 2025)
From: syzbot <syzbot+list823c57dec607e47f3726@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 2 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 166 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2913    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<2>  2916    Yes   WARNING in ext4_xattr_inode_update_ref (2)
                   https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
<3>  2889    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  2588    Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<5>  2150    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  992     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<7>  535     Yes   possible deadlock in ext4_destroy_inline_data (2)
                   https://syzkaller.appspot.com/bug?extid=bb2455d02bda0b5701e3
<8>  451     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<9>  420     Yes   possible deadlock in do_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=756f498a88797cda9299
<10> 268     Yes   possible deadlock in ext4_xattr_inode_lookup_create
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


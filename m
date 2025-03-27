Return-Path: <linux-ext4+bounces-7000-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2569A74190
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBDD18919E7
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328A1E51FC;
	Thu, 27 Mar 2025 23:44:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11091B043F
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743119046; cv=none; b=nanuS8UOdkcNYHSRsbWtpJqtS6pKQ/vJH1FW3xm9y5CRu2btN291HsciOYgGc6T3AyvIWZ8xXJSQZ3Bcd6ISF7emPQdHf9bopXfFgvMrjvFTi6RhAjLryfS5577pNLWDhRpIxlkFixhaqsvtlr4mVaSe+jqTWSz3NXEoX+5K1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743119046; c=relaxed/simple;
	bh=zJfe+ntDz0a5gqUOPpRgPJsQIkqcEFey64SoptgS/Iw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=do0tXDAkNOVSD/djUJ39itc866pcnZZapDFo1hjHdz5TK29g3hCD0ZwWYzrA+GyrdILicBZCTYF3ySMRBh5QInsxLUk0vyPpvT3g0L0nOXLJiocSHk3SJxZfIGmeF/nIGIYuk0ardpejU3bxfDD7v6OzlBKGyee/pjDz+k6OIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so33256465ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 16:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743119044; x=1743723844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HyMx14slmZO48hXwKrnjOU7rwzYOFJJ2XuwciiG24c=;
        b=bc5TXIa0+wniIub2tYq+Zzm0L8H/wfFMxEqYS9UzQF3QSrMD6ATfXpR+X14eynV7zy
         eazN/MZVQ79hYPzHVw8C4I8Un8WuDjnYuowWijJsUiYrpdPN/SEsbVp00cWkPHnubYNi
         yNSfdsT+CYb2/+EVabcu6uWXmwsu01sxe8/sc/e7AP98IkQGOiZUJNRb+jwPRadRqvyO
         nx0Oxdy0fpXrH5aq2T034hYICRcpK653u6eNZOAnH5XCtGwOXbyIt3F1VLXoJ1fLseZp
         aTWCagrpxNE8E0mhX+BNTKC1eJchnK8FyCSpg0Sz3756TEMMGkRcTN6wYEwbifQUJ0VA
         J1PA==
X-Forwarded-Encrypted: i=1; AJvYcCU5qqZoNAEE1cCTgbOl5Q95A8q5UsiqWbBJ5vVZQx5hq1dpkVjHaQhELlOCVjM4djhQyuI5Y8d0aFcT@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVsD2BH1HsuIMrJ+ylaH3QB9HSN+8yS4S5Z0Xu0x9gMQ4O2rh
	0A53lHMD35huyyTZ0lU9aMuZQkpTLGs50jXUUg1SvDlSyBi/wzIc4bivnlz91gBT+j6LggzfgGl
	N9hBlLESRAMIhgUMvmZIVbxeZRvzFV4BXS2GmoBx2XJYOPhV1yv4LM0g=
X-Google-Smtp-Source: AGHT+IGP0KfS302a6JahnEaFSrCURrW/iARLg9wT0HWhuDbr6UaQ3NEOiHKp2eCied/LzPpIPMg8HST/OAGgBXsb5bJEocyXgbCb
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:3d3:f6ee:cc4c with SMTP id
 e9e14a558f8ab-3d5ccce76c2mr58974305ab.0.1743119043917; Thu, 27 Mar 2025
 16:44:03 -0700 (PDT)
Date: Thu, 27 Mar 2025 16:44:03 -0700
In-Reply-To: <6772fd43.050a0220.2f3838.04cd.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e5e2c3.050a0220.2f068f.0050.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent (4)
From: syzbot <syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 93cdf49f6eca5e23f6546b8f28457b2e6a6961d9
Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date:   Sat Mar 25 08:13:39 2023 +0000

    ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1566b43f980000
start commit:   1e1ba8d23dae Merge tag 'timers-clocksource-2025-03-26' of ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1766b43f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1366b43f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2edddb53537e0320
dashboard link: https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623343f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123343f980000

Reported-by: syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-ext4+bounces-5444-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8DE9DF76D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2024 00:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AC72815D5
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Dec 2024 23:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D61D90C9;
	Sun,  1 Dec 2024 23:16:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996833F6
	for <linux-ext4@vger.kernel.org>; Sun,  1 Dec 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733094965; cv=none; b=FMo3OrZNjvDkHFu1W9BVihfn2N6Ztz/pIfYBITBZ+4KH2JzrCkTpCSzVht4ODU7bZUQ1uIrDqQHWm57FaNYJ+vkgj0zi+Xz74xF2PabebBSG5vmAB6VnNyJRpz0TT0CFNcSAGPA/8tDCbsLMHK9a+aPK6XuMpU/C+9tDoM1VNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733094965; c=relaxed/simple;
	bh=DlLc6fUy24DJf1H/uIzTLvM87WU1gYL83V5YpszStak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bfN+eJFk7iWCedKb5oy/CR/JgJkDq65hFVBm2EFZt137Ct4SEtdJwnSKvFoeNfyZ6SJtYjXLR5iXWlIzsAT3WbweRE1YPRGRVplv6y8Z7fgqoG4PADr2KChA3MoOekwLxKEnNZL0udvmPGbhivNE4SLeTnLSm+IXrtn+oC/2HQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77fad574cso31824545ab.2
        for <linux-ext4@vger.kernel.org>; Sun, 01 Dec 2024 15:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733094963; x=1733699763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AspwrmyTLMd5jO7A9zmo1ZUVU6ElmhegbW1Cadgdee4=;
        b=VDGf1fTW0VnKlVUzQAAIJadNuyepKvGLoM4q6uKpfghf8Xjsk/BUCBt8wXEUDGpgrH
         /gyBSj7LwMXZRenNafvWTl/1CXfOtiC6xknaj3I5xZXYgEPVQt47J+hNiT/qGvgwHQVK
         e8vYUGLUEQMweTHIJINNYh+LbwAsjiCft7ET4tAp5DZjZT7rR2Rie78sMOeoKtDU0O5B
         T2cyCsF00ehXalF2ZA15klN1xQcBWjFfu7JsiB9x5a1x16QR/HJV4XdRcdOI3/aXoUB3
         KyFkyROITF/sDI1TDExm5qdXr2XYFpM4o/Ikef5z/3CtF0JR33mArR14EC6OG0Jk/ei8
         SU9g==
X-Forwarded-Encrypted: i=1; AJvYcCUGuX/s8wJeADMPIQ3MEEElWxZtr/LuMrhx5fmS7LbgC6ECuKghXns1o9x/6FJhNu/lS4VjDKPFcjR7@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyW0e8YhphGlvzzb9WcYfdRFG7IlZ8xGRC8KRosdpEIAgRKfK
	JzdV9/yEMIeWhqHcaQv+Y5IHRqVuKNL/S9FFDEapsSczMguoGQG+to2kbhFfjRIBImvxZCkaFnY
	kSUMPm3yvOg5bckVgMr1Z8bbaJU19+rHi8vF6ZOiLH9BWwOd9Rak5rSw=
X-Google-Smtp-Source: AGHT+IFdgO7VWoz1ICpvTp5NAPXlQj63DADp03XqbbCbV544dMEp769mRn76SvfLryXTJQSSxg1mJgMJMm+gMq0Zuy0YCzkdOexU
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3a7c5580ea4mr196802765ab.14.1733094963538; Sun, 01 Dec 2024
 15:16:03 -0800 (PST)
Date: Sun, 01 Dec 2024 15:16:03 -0800
In-Reply-To: <673913ac.050a0220.e8d8d.016b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674cee33.050a0220.48a03.0019.GAE@google.com>
Subject: Re: [syzbot] [batman?] [mm?] [ext4?] INFO: rcu detected stall in rescuer_thread
From: syzbot <syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, gregkh@linuxfoundation.org, horms@kernel.org, 
	kuba@kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, 
	oneukum@suse.com, pabeni@redhat.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10553d30580000
start commit:   cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12553d30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14553d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14486b5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112182e8580000

Reported-by: syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


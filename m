Return-Path: <linux-ext4+bounces-5714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546979F4DEA
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C10418933B0
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30851F5437;
	Tue, 17 Dec 2024 14:35:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA51F4E3E
	for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446104; cv=none; b=Y1T5iHeNMXSZnzvQTXDrMF03XBz2eKz9UkJ1AatCfCMK8nULE7I2D3tOaOgb5wi4uOIS56jWnnJYDgU8Cv3K3Rx6OeSx/DN0yvkBTqJb9jPaP0cE+CMO6qNfextcVppnUktkWdnmi4c7bmD1t5g4x92mmWVVJ4HP0tcj3148Xh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446104; c=relaxed/simple;
	bh=pJKKRQMMk6n5IDXs4b/KINw9ATda0wHsIoznO/vkOaw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=APO5sX49zh0rQMGyWLRHe5bgCYJfmJv87noanAPssTpSifF4D2ewfaH9b1hHhRd/7l0pO4hLTq+lYcaRQ/ramFRQACsjWRiKoN+yX/bc9NKnhBoYbphLzqjAYqUHX/uw4lAhWpBxGkamGOdRhnOlpmjawrUjxvsIyC57fng4AXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso52244505ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2024 06:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446102; x=1735050902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIeMy+hsZP73590GRiY4sQU2LODFp6EkvQJk4gt6eQM=;
        b=NX7ndHSUguds1mdStrghE8YARLw4Q7ZJ/Ik+Ml59dekXolUaslsIbCvzy5KK7nMhaE
         etGefkBn0dN0Omc2zEUh6GL6Cb2k/JPmEyhMOMLULzTyBzaDnaX/tVbWt2SXs8hMjI5l
         x5B5vGrbU6mumbRz1joDZGbVaL5yPqX7NiewBQpBA87aWNMnjrMj3UXxe0FGFHIUSLLM
         cYhqjoSEYVRhVA1JiH4z14LZ3WC5rdwu+ady6ZtjolxRy2phMSv+EDqJZFG8fFe1hr5X
         58Y9fU+N3ATdrfbJ74GoHvITBmcSpagB6FKgjWyPBVXm0F2C3NG9bBlKK/6vxbsm/mRD
         P7/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJJ/sL0r06tMyhhFBoJnHcdGXSZqUZbG6XLnlDv4PN1OY5zaH7LgnZEbY2Kn0FhnTuRx3Vf7Lvn7j8@vger.kernel.org
X-Gm-Message-State: AOJu0YykVkBjCipEKF2tsR46RExvAOCfD5h1t1fIi+IrefnezlNpqspU
	zOWrGj2dQFfY7l3++URzaCr1mLhFhZbWEf5wLxO6ws1v0x4JentkX79BlRLvarZ4ODwnJTxtNBN
	A3dzAi0GwBDQ3diAjxz3uqtUoyPJqSKU3eUuBA/wiP+o+JWgqttkMs60=
X-Google-Smtp-Source: AGHT+IHAEgscXePXWN79iyq6tD6Me7CrUi11jctcqyyCc1dUiPvYRvkB2f+WBDX0ToNEQXQblXMZ/o9M0zvckfQwqrSjgMsnRbcF
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3aff243f5acmr153137225ab.15.1734446102117; Tue, 17 Dec 2024
 06:35:02 -0800 (PST)
Date: Tue, 17 Dec 2024 06:35:02 -0800
In-Reply-To: <6741d52e.050a0220.1cc393.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67618c16.050a0220.37aaf.019c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __find_get_block (2)
From: syzbot <syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, brauner@kernel.org, daniel.palmer@sony.com, 
	hirofumi@mail.parknet.co.jp, jack@suse.com, jack@suse.cz, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8a3f5711ad74db9881b289a6e34d7f3b700df720
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Thu Sep 12 08:57:06 2024 +0000

    exfat: reduce FAT chain traversal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156b5730580000
start commit:   f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176b5730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=136b5730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e302df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1265b4f8580000

Reported-by: syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com
Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


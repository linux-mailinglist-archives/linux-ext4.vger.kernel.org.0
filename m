Return-Path: <linux-ext4+bounces-1655-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253187C6AE
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89C81C21413
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C2802;
	Fri, 15 Mar 2024 00:10:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F159635
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461418; cv=none; b=SUXb+FrQVGpWXVLPxDkqHcZaOP3orE/KigB53MNlVePvVJnVdpKE7QwuOllOXQCvipPHJlYTuaCFVj1n/5gNbJnHWRWdiglBZVzjBgf2N/UCyu198qP6czsTWyDhuWTB1IRpkDFyEmA7ysbnv56NDWHiBi1129hjqMPCHSujHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461418; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FlDWBGr3IktaFDSyb6XRbG4FVDH/Hey+yQ26GPPhcjZ0w8hGO9dYAfuz47qfIzX3oy1exNodgJKHP/E2H2hzaI+60+g37EVe8ILj+WvAczDeBbaqsn0ldqr6IbIklp0Tms1v0yhX/lk4XYIC63K5YHVdInnEECqx9M3ECXbqZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3667abe113fso19576995ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 17:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710461416; x=1711066216;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=LZN6NjwyvRsr1abYpMyRSm91MRc2b/T2PoGS1/TXGe/o143M7k8kU8k7fuPz2+r7r4
         QvKt+Q71fS2yZu645p/kPJDTJW0Au5MC30YcEtkIsmluGdyKpuTu+ZPjBB5WBJJjSpAZ
         vqgP9MpvkZ7DEsD+AF8wNRhIODZZu+q6lthzLQfKL7YV7M5/rslcUWdPfNkQN2Z0l7ei
         hMHbvGGXfjr8axBqUVz6oWMgT1rPSkT9PHQj1ccD0oZJOc9kczytSioz665o0BRstcu3
         2UPDnLQGM20dYncS3RLbyT8PyltNbg4gDac489TZV74Pqdv8/4yifbSQWP44hMoEPJBy
         GRjA==
X-Forwarded-Encrypted: i=1; AJvYcCUnVW3abXwzy6dvh2sYEaklPR/q58BBk9WvBidaOfrB0lWsI2pT1kPzEUXCBRGizMe7zLOH2E1UeESEEEXm75z/clR8Jx/i3HCxAw==
X-Gm-Message-State: AOJu0YxixnaRpiWySbTNa68iFpZ1MXZnYhP7Ed4y6/jkHWdbThc7re4c
	nK7njRxt8jxGyL8XmZt7dEdUDGR3IobUdYEZeCR4tCoFA6f2+NdaG7qs7Z5fiyXk79/CYb1oGP8
	2NuJi1GcH3hh2SBW7vdw4glCOfSiszAvDv0ygcNT9q72GruGIcbFo02A=
X-Google-Smtp-Source: AGHT+IEwia3UBhvywO+h+u2pfZqh0yKTnkD0W9jpgVSgia1FcpQaoAm3+nW32+O04ra6I7mwds9hpKK7s+2ic/riJCglBAUa7ZfJ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:366:7922:950e with SMTP id
 i22-20020a056e021d1600b003667922950emr87913ila.6.1710461415855; Thu, 14 Mar
 2024 17:10:15 -0700 (PDT)
Date: Thu, 14 Mar 2024 17:10:15 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000182dd10613a7d554@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos


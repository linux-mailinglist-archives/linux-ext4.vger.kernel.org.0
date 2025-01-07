Return-Path: <linux-ext4+bounces-5953-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BCA03901
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A2516505A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC21DFD99;
	Tue,  7 Jan 2025 07:48:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D118CBFC
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236087; cv=none; b=vDvDiQEXoIfUlR8isjhZrf9s9bg/1/sx8ynvUCSv05uvv/bZqN0rNgLsjIGhRoaBx7uMGmQv+JtT93ieanJj73XCCBC+PRR3+pNJUDdAZRm4q2HR3vwM7AXxJiwN4cCmRvYCq2PipA3+pL3NNWSxd0LF6D4kKEGzpAydZWKCGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236087; c=relaxed/simple;
	bh=uaVVdzHvimeT06a3yMQxd4H4JJ3bnfuSNFVWvQxNyo0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AW7WZnlgZCf4ELxl4U0bitTpKvGJ0mHRolDKAI6cN04PjVbvvWv+ZzCT7tlXiwme/oov+KW4yy/Vk7vbv2uwaMExSLSjL4fIw93Yk6BZZ5Oyrr97dRpxcM0mGw+zJraYexCpzs72brx0LfHhZ15ajw1jkUcdUYUW12ownnKagMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so321285725ab.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 23:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736236083; x=1736840883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0LRMsuN1s1WV9iFBr4RyKU3rvRdJKMKEAM5GaIKjUo=;
        b=TUVqTc+zQRYSNoP+c2RRpecFY/vkGozmIILuhkMmunudrioCXnhPWO+K/6kz6jdj/L
         SofjppWdkgwaD11/A04OSdJCQcYNiK6bMCkmSZsyeurkh6RJ2WW3a/mb2SZdOLsovUBc
         V2SIRpvfYm5Q9tt13lqPRs/HzEgY1HkJOxPYv4GzYqzoZZ8eAz0zzTl0lK48m2dBS3RG
         OdFZubZTMoLDFurIwlX5N9q1osNWToW4Rl9kN/n3i3uLAHllimC6GhaWeXeXMzjMPB6K
         0btiwHabf0uZtQxLzcF6RFEGKZKUZDbDMQZOhq6mMJyuADXyKuZ6B0Ldylc7isQHEUia
         dt7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQDfqVO+PLdbejDaAqiPeU+nla17GeW0RphLMA6uyx8uyg1P4DgcplKiFspuZ0ujUg4jFviiRos2Rq@vger.kernel.org
X-Gm-Message-State: AOJu0YytiqMsfE2MCbH5e24itdDSPv5tCBmQy3g4ggIYWVKFBRHpbDEv
	Tf5aGxDVBhM4m360Whi/J9HMv4LxuGnSbTNg580D/Q+vEnXRGMDonoWimz4M6nmv3U0GbUbTP7N
	eW73uquHJINIy0MMABDCzQF/j712r4WmSyhXocDbVhx9rt3dNklhypKI=
X-Google-Smtp-Source: AGHT+IHDptQRW0FdBNOP4RuSazmJVDi5pAb0YIRMujgxtO70akVi8BHtliImaXYT/qZJouOKonbPJH5Yoc43GUbFsaYWGkaL9Iai
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198d:b0:3a7:1bfc:97c6 with SMTP id
 e9e14a558f8ab-3c2d514f9bdmr460357485ab.16.1736236083179; Mon, 06 Jan 2025
 23:48:03 -0800 (PST)
Date: Mon, 06 Jan 2025 23:48:03 -0800
In-Reply-To: <000000000000d1149605fd5b0c0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677cdc33.050a0220.a40f5.0019.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_ioctl
From: syzbot <syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, bottaawesome633@gmail.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org, rbrasga@uci.edu, 
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d7fe143cb115076fed0126ad8cf5ba6c3e575e43
Author: Ahmed Ehab <bottaawesome633@gmail.com>
Date:   Sat Aug 24 22:10:30 2024 +0000

    locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c9ffd8580000
start commit:   e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123fef57980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1598eebb980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-ext4+bounces-3724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC29511AE
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C466F1C2353A
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 01:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A447317C68;
	Wed, 14 Aug 2024 01:52:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7A10FA
	for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600325; cv=none; b=guhiFcfICRQDfFbTR/n/Nb2tcdyqB+h7cMzOkIedQH2fheQedQDGHc0Sk4hYSXzv607AT1UFjjcADybCKYfhgMMXFiqL7obr2XNJwuau+Ce4MHYSbSjluhcbUwVNNrMHx3tqZixnlBE3hSV9OZ5hdmFs0uYBWbXQOKE7tA2fxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600325; c=relaxed/simple;
	bh=XS64JM0hwmruJ5LzbhBhtv42zVcLYE4v1woMxuH4eBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgIVgDWJbdNPacTXJbMyEae8oBg/eDpTAyPMB8hg4W662UvdijEywHKHlwGyxmlifdC/ydShtnGGX9RAVCTg9oTUzMIM2WCIq4RwJk8N4A1vk0xzGbYh4ivX8XN3Y7f/R/ko0VI1xUMh/h6AC0fQm5VsoI9GCHzWJCCs4SlPZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a143db6c4so62348825ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2024 18:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600323; x=1724205123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1FQrSlLyHIR7bKJ+Sj2PnGw3Onv4oXfRLT0nBQKHc=;
        b=t+OYjXetm+dQwNx+n7kzuMbjPGDCk47GTU0bcQ4Ini+HSUOJ0pJIq1xm+uwG0KQQAC
         Dlyv47ufjpWp6S2rmNymAxCCWJba1g49LZkHfEc/hW3wAZZVPwe1oAQjqQd5ne1N2Z2n
         dpZrsTr+yQOIv15WCXLQDsawLilqwjYvQEyifmVEGhPaQjC8zb8GpmzC0VEFD0ktuHCt
         BrK9ZJruEzsFKThz1zZMbvNAaQqjTwvh2uEw8jizyZHf7r9QNrHciSj+9xQftem/Rrpy
         p2lDseP5P3AviPjV65IOvI+PNx40NjHFTDaRHYzk2MBzl+62onrSzMxKPe+33T+vtHn5
         uMaA==
X-Forwarded-Encrypted: i=1; AJvYcCWwx0y0r12e+Ee6nWVBlxpUsjaO/iyg21sFYo4Ht1p2cBxxuJiDEV5zm3wr+MZh1RfgXQnT/VJ60/BIFKga5RxfaUyF2sqO4eYphw==
X-Gm-Message-State: AOJu0YwvnZG0xZ5A8PAsO74DH0SHIOTMV/MqK8LA0Iw3IMT5/LpaLKL8
	orceX0CG+DBPW1v7ZAzwbs36ZQYAUbZGF+2YVOOsGlI1b2r79dayQpDqow2q9imJbM0pfY5VPYv
	Sp3o0sR6p5+egokOkGrv5TvJ9SR8FqlWolUUIrPWce/TaZvz7Iu4glGA=
X-Google-Smtp-Source: AGHT+IHqA7pQnyMrXho0mD+TUeP2QWjKbV97KrYXUIJ4iXmGLDZf88mj/5QXqkKGVrs9YdSyU79x/lDrUXmH2JEGZiTj/x3sLYfc
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:398:36c0:796e with SMTP id
 e9e14a558f8ab-39d124564a7mr1332345ab.1.1723600322958; Tue, 13 Aug 2024
 18:52:02 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:52:02 -0700
In-Reply-To: <tencent_0F27C706CC52D386584988EECBEEC0CCA206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc26b3061f9af819@google.com>
Subject: Re: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
From: syzbot <syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com

Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12dedb5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fd71ed980000

Note: testing is done by a robot and is best-effort only.


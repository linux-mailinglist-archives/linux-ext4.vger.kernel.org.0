Return-Path: <linux-ext4+bounces-2643-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9D8CDED3
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2024 02:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CF41C20DF4
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132231EEE6;
	Fri, 24 May 2024 00:14:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2F81F
	for <linux-ext4@vger.kernel.org>; Fri, 24 May 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509661; cv=none; b=efp7zVP8z7syTv8EVdmsfOsvH95SnhsarJLnKC2JoDAaoXHP+nqWXa9uNhRfWg2sZsfliUAHp58BiahGIpBoeEnuGMUzXsHi/QmPGKw2cnhiC/rSM0mQw3+Bw5Bc39Aizto1jjYqvvm4ZdbWQk4m4louARUXk1avoHscz7wHZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509661; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u3QAPRMduHUsLzWPc+fWM/eSwgUgVb69NCmTcoqMa5t2nzuJuzOWJme9fvCDOo5eYtOqzWeTpDpes5HpziH3fWfuWPjD9QCYcNyz5SIZcW1Yocv5zK43LoQpnfctVY3PH0wTa47LYsrTK8uDDhFdAG+http2sRb1P05yzWAWAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso232488039f.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 17:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716509659; x=1717114459;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=JEwwyZUYGd8C4HJ1iTGyhdcCAsQekZGJ7u0+bjAXVjsOOou16CAnOwGZrKWVNhuRVz
         Lkt+HSRlmff2tmYvGtL7sxNfM/K0VJJty6YZJQ9Xwxiu3doewIp93R+JGHjW3cyU4Rgj
         xOHd+rwvfSMAaCE+jHnLN8hCU1l1JIW2EG+EfOr2WL7AD13++HPCI80aRKHxOUvsqFzr
         puqrjHYOx9ScZ5dU/tJuny5MGw4avk3a8HAHQu2L3fGYaLPnxhLLdNI5mZDAbzV1Ayo+
         KwXNemvX7CjnjzOqD+MsA7RO8Tjzk0qZG7e8FbsZa7yaWt4sBhFyTkIaMtKJIvDUhvau
         0JPw==
X-Forwarded-Encrypted: i=1; AJvYcCWq58CjXYTFQg/WbgnOd010MPhKQl5uNn2CTR3QZDIm0019MLv5Q6ol8/JZ2J8vK7+WXIvIThJalxOvEnDguWqK49jnw7i5yHWPQQ==
X-Gm-Message-State: AOJu0YxHgin2nTCKfpmJIxDTe6A8hcU5GQBKHWJVMfqylXeGkVgl/B4I
	Oym30/AZzKNAmC8mS4TyOoLveC39lNFFMcfn/5HyisYNBPsdh2k0sZXXh8Y5+T2Vjd+VYXV+Cwp
	nw+VhPrKSbAujBOS665l3/RYbP84ulUkibWSDLc6tRDZ9/Y/oCiTfd+s=
X-Google-Smtp-Source: AGHT+IHbMNv4QrOVDaPbt0DMHRVnsIeb7pwVv/vXpXSR1EvGYuLgqGIPPSr+J8t+usGOEUQRDrWUJM7L3Ss9ZVQi6jn3N8DgkSy+
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd0a:0:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4b03f520d78mr13470173.1.1716509659531; Thu, 23 May 2024
 17:14:19 -0700 (PDT)
Date: Thu, 23 May 2024 17:14:19 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000829fbc0619280c85@google.com>
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


Return-Path: <linux-ext4+bounces-4384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D9989DEC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB981C20970
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA92186616;
	Mon, 30 Sep 2024 09:21:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C613C9C4
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688064; cv=none; b=t5cOy+hBqSPiup0Yv20VQg3syWDyHQY8QVteKlp6NBAGxbQ5/60l/uw0mHPdfcmIsmgI8OHGpXXlwwkdz8RrYncM+yE4JCwtmvELoN4x8iNvVOA+VOoGX5e/yVC8dQGBvfGNU3CWdrstuJ6uAyal0kdfPzksW2XWSQPwf2Xxw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688064; c=relaxed/simple;
	bh=SLJ+RRSfxIzeKlGc2Ua7t5UNFnR8HkkmUgO8NEber54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=be+FFdfJWMQ6WR01Uai0J52q7dLgxAeKUPw9N4MiZ3RQi1HqbrgC3jdAQBAgMXAdDrDpb7xEMZf0dtoLEjTTEsj6tYmSTJ+crSfgRqw5RNZIOu3X5oGqhm43l2fmEp4K2UHvHl43mNVifEHdF/3W9L4MBqCOyoQBojbEx6dotEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3479460f4so26396385ab.2
        for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688062; x=1728292862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w24/xfJIXAOeOh8EjVG7NPTqFUC9dPWQKNVHk8S2gA=;
        b=d8JasVfpRVNXTi7Zj3E85TSbGrqao6mHMFQ00bfCs2enNgoY9h0iIC10KoKhCn1m6i
         zCNck92eV2LviC5aKNQsyVQwtPV/+Fh34VRE8Yh/8ZT3XSgNnEc73kgYKO+Cex/y/XKJ
         nE59RfKtWSt7OfWe4fdV/9LmZeu6S44LnseufqFqoNYOflAe+JdG9bX8oB3owamb5yzh
         nmBzEmSYSgmLguWe9qw1J7j1iHellksSUpbXy7yC2AqfUSp6MkGQ+8ZUc9qdrWjv53Gc
         LRqQn4m5Zb3i4gc57Bfj1Dy6108cKbF0jgus1ojL9LdPpbcTRZYAUJnfSeo0RI/7moVT
         3qQA==
X-Forwarded-Encrypted: i=1; AJvYcCXkwkrRvu5Fl+opJsy9obPcOYxRiojOwC4iokJfxuDRWfgadLa1jBYmn75SrdN0VzXST8K73SW65gcC@vger.kernel.org
X-Gm-Message-State: AOJu0YxIP15K8vXwS0kIfX9V40UALON/LGswesKOhgysKNZexl/uWXPT
	wxpMzGt6QeEa2zBrSHkBO0bUlEt5MJqxBNYGf50LJ3v9lPzZEhJdOsB6gXF7Hgt0CVrl+EVcZk5
	+PI51Rgu1hRWKvx77d6wL3hHkCGEaKB4eHHb1k5TFD9R8gSUKTbFFQyQ=
X-Google-Smtp-Source: AGHT+IHH8uXRWjljiT7eyFQ5CxacmjCY1B/aC0aedcxVKrWCaeSzkIO4TAGOGZeRgl02hLHY83gIVx/VR6UdGQjARThBbsQYiUUG
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1564:b0:3a0:4df2:52e2 with SMTP id
 e9e14a558f8ab-3a34515ca34mr92890105ab.4.1727688061860; Mon, 30 Sep 2024
 02:21:01 -0700 (PDT)
Date: Mon, 30 Sep 2024 02:21:01 -0700
In-Reply-To: <20240930090009.174420-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa6d7d.050a0220.aab67.002f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] WARNING in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+96ee12698391289383dd@syzkaller.appspotmail.com
Tested-by: syzbot+96ee12698391289383dd@syzkaller.appspotmail.com

Tested on:

commit:         9852d85e Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d33d07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e38805c95ef88a95
dashboard link: https://syzkaller.appspot.com/bug?extid=96ee12698391289383dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e36980580000

Note: testing is done by a robot and is best-effort only.


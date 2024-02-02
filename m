Return-Path: <linux-ext4+bounces-1062-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66A8464E5
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 01:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9108B286594
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A715C4;
	Fri,  2 Feb 2024 00:08:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67924628
	for <linux-ext4@vger.kernel.org>; Fri,  2 Feb 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832500; cv=none; b=K9fUkf5elJsw/4S47AK36XWKTcPL4sT4qqVFKzqqU6wkoTpC85oquaBlqBwM1v6ifFc/ybJzJTsmG0DF0yJETmFWtzZmMr41e3o/94oN4LLrZnokD98Vt4BjS5EfeVqrbccd73vP3Y8CTK7fRbBqOJ4zw0Fl67t0XFt2eOM8Yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832500; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dNQdVhXkIdULzjkGv1xhavfj9WjyYR2GZfhu+DhAYYHWcag5UEUDr3pSvQD3IY4iRFtmry+K/fcxlVSHBfkwa3EXnNKxPm+kdAkyS78DjfVsHEktENKAv6KOd3e08+6VTw2LvW1CciSibk4whX0lMKDRqmk+vX9jLQGb0j1eskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363779f3989so11971925ab.3
        for <linux-ext4@vger.kernel.org>; Thu, 01 Feb 2024 16:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832497; x=1707437297;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=G4mzgosjtwu3nuWmbPjr3bVmfm9tkXjCP6x9nYO9HqS8/GIUjwqiTWRccWOEJfjRLt
         gF3epgAHJdJONocSFzBjFyku7fIr6RkP4WUvpR0+IL35YMBSzWpoLnJvHY2jWnz3+Bcy
         LOt9utH+S/JCU1mbvCVlmkmpdxLj4FB0DWRqXTEmtqfjD7mY3K1lUgBChuV2WMxslG7Y
         oju/jgZEM350WwPWlgpiUIKCzxkUPA3iUkWfgFGXGZN9yBYcKsJUOYQWzK6oyCOJPYsE
         0HJGhhXXFY4G5s/2/2dBFhoRsIfgzMWTGz403uBUj14azSIFOpAFmaJsJ/lq9MCMIcxE
         sKWw==
X-Gm-Message-State: AOJu0Yxq4E2su+znvAqJrJWWBEWYi7HNjfikVJA2xF3l4yGZMW9ogvKx
	80O8l2Y9WuzMQPcXoD4D8g438mBKD78IOLWYOFIJ+qBv5rRIq8x6l/oxtHL5auRfvfQgTTCYN1Y
	6O6JIz+KQct8By4b8J+kbPjJTANbpH8UyZYPaO4PyRcNn20wrj7Q84sw=
X-Google-Smtp-Source: AGHT+IFh6rPkpvnTpkhqIyzh88eiONvMoSw2oblVG+U294VcHimyqA5qNFoUju+wCc6Nbr6ALRpN/ya37moEeFn4cz4w5BNo8Dox
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:361:a961:b31a with SMTP id
 x13-20020a056e021cad00b00361a961b31amr572373ill.5.1706832497612; Thu, 01 Feb
 2024 16:08:17 -0800 (PST)
Date: Thu, 01 Feb 2024 16:08:17 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b61df306105ae8ac@google.com>
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


Return-Path: <linux-ext4+bounces-4536-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E93996A11
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA70FB23041
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1419342A;
	Wed,  9 Oct 2024 12:32:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C1191F89
	for <linux-ext4@vger.kernel.org>; Wed,  9 Oct 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477125; cv=none; b=L0L7YHl4MyAznybR9ZC9SmzVlJVhi3VLadycK8+Pf22uHaBU66DwA+fP9v38B7Psg8+H2aiOnn7gUtOZN2OttrzzBigffeZ9FzFACQQtPp/uysvuu6RQoK5732XGw2L/BO7Gilm8LojEFlX1R0ec9geD/8zYKpNXUU4KZfpoY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477125; c=relaxed/simple;
	bh=lfXEWTajvrvkCCH7NIIw3Dpjl02gTiHWFvvJkaWjYc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KCx906Gh9fEQAE8IkUjqHRifyJj+vy9hURq/UD7l1fqdhMlleqilyJ150Zeiag3esYHyBZteUJ9qHolhqWf/H4Xj4utoQ0J5VTDxI0BSxHsQTWmXez+VZkd9iREUd1MIaXD2v9bdff5t75G0s3tL9DPxZqjWLGTG2U1zv4DinzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3479460f4so55756885ab.2
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2024 05:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477123; x=1729081923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XEtDE41DijOlaDO108xIbZtcFN+7xIdjs3DBklT5+A=;
        b=lsyu7WYQO1/HnCI5mLs4XZws9mQNIrUYHyOTdKYJPMFMv+nGw1iiBfVxUe1X2UH8l/
         NgQO8r/8OaHSoBGGAawAuGnsqKZflIoSpPr8rjREiTLatqoNayQtbZDtxWlymQlHROfl
         nGskgT5nBWj9bbbRypP1dQip2SxCvbxQNk3fbhHFav6rGsuF999Q1Z0VOHr7i6KRqiqr
         BwBquWAfKkU0D7ncafepeA42frXx1jLtDL4dMQYmvG9NN2cF2twxI8pJREdmJC9OXNBG
         4gLVVnjZSrBUtna58vtni2X+7U568Pt0eLrqpJ6QxgV9Afh0yUwBkoTropYQDDphrV3x
         wM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn6dphdp6Eq6MskjZToEsygMZRAno9MPyujK2zoqhH2OF0sVPIK/WZK7rJwVqslwP4etxFQ+5/EvQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJuaSsZEQe15egqRipPu0mZYU7YolcDWPxhZUyKijI29WLM+q
	pbvvozBMSWIO8uvo+VEOxpSAZGzY8UVnaS0plCq31qKbna/1ElwrRZZYC3WmXjECfcP+dQKHqpf
	oCOtLM7SEQF5nbPHmHFBUlWeZreY1DaPNnncQmgoNhFOuMrjcWB4eNWg=
X-Google-Smtp-Source: AGHT+IFKLroh4TrPfI9wLSsRGzIh2g3eqt4u64q7LcQxlgGxukn09r3sqZ7xI16ZY2QabrRcR0rHh5PErHqjywTMtDD+eCwIu78h
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:39f:51b8:5e05 with SMTP id
 e9e14a558f8ab-3a397d106bcmr18298975ab.16.1728477122970; Wed, 09 Oct 2024
 05:32:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 05:32:02 -0700
In-Reply-To: <66f98a80.050a0220.6bad9.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670677c2.050a0220.4029f.0000.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] WARNING in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	li.kai4@h3c.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a09decff5c32060639a685581c380f51b14e1fc2
Author: Kai Li <li.kai4@h3c.com>
Date:   Sat Jan 11 02:25:42 2020 +0000

    jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166bd7d0580000
start commit:   5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156bd7d0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=116bd7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=96ee12698391289383dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d0d7d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14351f9f980000

Reported-by: syzbot+96ee12698391289383dd@syzkaller.appspotmail.com
Fixes: a09decff5c32 ("jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


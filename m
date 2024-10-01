Return-Path: <linux-ext4+bounces-4431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3059C98C128
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D614D1F2460C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D31CB33D;
	Tue,  1 Oct 2024 15:05:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5491C9EB5
	for <linux-ext4@vger.kernel.org>; Tue,  1 Oct 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795107; cv=none; b=sgEvA0WvXWp4WQ4mAcYslkJHb5E2n45lvW0RjMifGI0Ypf0QAIlAWFlNfMA7BafO7FtsVmioyRBMyscPJ6S3Qoxwa/l0d2P8zoEzaGj6/FxgbPkmKgU/uAYbynEldXaLILoFrobWH2tPXRaC9zvQrNaB/dSb+NxB1p3lwbnjBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795107; c=relaxed/simple;
	bh=70tW3FtIReGlZa0x68B7CXkkbmMZWMsi23kXqDI9ll0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9yOnA5GZ7KG8s157975xZ5ruL1x4V66vXObdT3XY9qqAoU1HACthoo4c0NZNZC5D8g3epp61ssAD0/ixkpsN23WBnqx/F79vFde2itwR2KRXG7r9cguarWdkwW8wIJneuzyVtSe0BmK+PfIK76vMsYhH0qUGXgeqwJVffQYwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19665ed40so46622715ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2024 08:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795105; x=1728399905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQnQdezqQV4C6xTbEprcKjm4Qf25wBlX7fwBiWWz5wk=;
        b=oy0VB08+b0OD65o8vNCUZXkmrn8PEVTMrLydqlXFFdGXSZjIbK0Fsk5zCDC+3quGE/
         lyA66dj5iMYxyLsgJ/m4H8D1ueUpvgEsDV+/dfSiPBilkNhCMDdwn+QWlGf3f/oknYFe
         lAe/QKpV4SO3Z2cd9K1ZpDGj1Thnzf7AgKGLttuZPtPHqKcxQ4+k9oalY2HrwG0clhg+
         qufjwyyN8PRc+k7TPRaZkOX2087kV491Lnfe9EPfQm/QGGTj90hBosHUFj1TwvPuxh4D
         FDcmBbIFi60VFlh4u8xjBpB++ujcTJo2bpqDtYe5+d2Wt0BOO7VZnAC5fiqNqVRgyHLt
         0AkA==
X-Forwarded-Encrypted: i=1; AJvYcCXc+kUmIuVDGAM4n6ZTV655OHrkr3e68fhjY1jL+QiG9Jiyw9r/8X3xyYP0c2qRd/YEKIGeZnWI918f@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfrFRMUzoUwiOtTqbbOMDc1+qdh3nbvX6PO+kehkCE3MXDoW/
	fBzRf6LMAr5lkKeRmM/Y8mogLas6kTUZE/RIV7/hY3vjpeFXMqCT2fSrEMc2ss1jiF7nVowzLRi
	zylkqY5meSFR4Ku1WIP2sdB6zr2qo9590abcgJPxpe34pAj8ZMeX1VNs=
X-Google-Smtp-Source: AGHT+IHOxnv+tRIgSwDxvXyPvoS/LMyAOoq9O7ypD4JCM4wibvhPAflAPZZI/3cGFUBvxXrZFNB5E5A0agdx5xhHOTym2FVHZ3zQ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d10:b0:3a2:463f:fd86 with SMTP id
 e9e14a558f8ab-3a35eb0db11mr24180095ab.4.1727795104695; Tue, 01 Oct 2024
 08:05:04 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:05:04 -0700
In-Reply-To: <00000000000032fa460619a3725d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc0fa0.050a0220.f28ec.04ab.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [mm?] INFO: rcu detected stall in
 ext4_release_file (2)
From: syzbot <syzbot+9c703233282a4a1a6749@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, andreyknvl@gmail.com, dvyukov@google.com, 
	elver@google.com, glider@google.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ae94b263f5f69c180347e795fbefa051b65aacc3
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Tue Jun 11 07:50:33 2024 +0000

    x86: Ignore stack unwinding in KCOV

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17353dd0580000
start commit:   56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=966dbeb548ca6926
dashboard link: https://syzkaller.appspot.com/bug?extid=9c703233282a4a1a6749
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7abe0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b23f6c980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: Ignore stack unwinding in KCOV

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


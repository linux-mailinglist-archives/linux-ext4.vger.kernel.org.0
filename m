Return-Path: <linux-ext4+bounces-8201-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E947AC41D6
	for <lists+linux-ext4@lfdr.de>; Mon, 26 May 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F157A230A
	for <lists+linux-ext4@lfdr.de>; Mon, 26 May 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837620E710;
	Mon, 26 May 2025 14:53:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F220C47B
	for <linux-ext4@vger.kernel.org>; Mon, 26 May 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271185; cv=none; b=st7EM3mhU5vn4e/73Z2iA21smFKXe5aooN/Lw9YwfT8EfFwFQgbkQ5ufHu9qb7i3TcSHxllJ6ncDU0kJ/61h11pGu79VwMp7zkuaHeLW4Pxkok7zw6zXSEMpEskqJ7GQUVihDwPQEuZe8mJGrBHsz+43fVeeBZ4UfF213KzZEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271185; c=relaxed/simple;
	bh=rX//ZnAs4/gDdkckX/oa5gGporeBmWQngj8pvXA3luw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZYKwagy9u8O2gIf0Oer8qWiqk/Or3yr0WtaMtig34c0C+opi16VVsPRTP0RJw8BjbnE1Gxwd3ylMaG7WXYh2oPskuuFA9cLhlGDikkH1/2Nr7RCZ5u6bJzvtdSdCnF3o9PrKDm/iWl++ZfdwHi4Uiybe5OrZMTvnQ59Z4RSfZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e7551197bso219055739f.0
        for <linux-ext4@vger.kernel.org>; Mon, 26 May 2025 07:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748271183; x=1748875983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWjmY8aMLm+qwl1GELp08QuU0WZDXapUCNerLSYq98Y=;
        b=g/lvI0fBOQSVJnOHAJce+47Jq/Lol2QiBLWRAHtA1WuCrcElO8ObXghaybhlYDMhBW
         X6+nE6YeqdZVBqIGRNRR7ZcexAb+7JST57trAlSBQEGDt0N20EBDt3StZLo8X/PpsJt5
         r6B0FkscZbem6frXBYSDG/tClUPPdyPfo5ghKlXDJZRGbJcn4xHwbJY8vXb5u3MZ+ZJL
         tFpaqq6KilU3Pe2lMYdh3b33IjkcerC0tcvoSZY/wVhaVXKpRWOVGwFaVuKAYXxpSZ+0
         oy8cpd4ovv6M+dhBTJoT+HtdCRKtW8B01UKaAmHV9juJwdAXwQn6U8j0fS+LWalaymxe
         LxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMnsPmZ/PF3R5OAAC9PT9KnW90UweMO3gKV6i+x48nuT5MDrnhXqohNb1Ni4voJDYcL1QT2ZAUDba+@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbRgqGV8/JlHJ4ECqtVxnRnIQNbCUupXEfcUefDYpJjiCky3J
	oTxWCr2vxKK1N5lG5a5N40REIr9gXfhlsl5ckhhYBl71BAplr5PLHlj8Mr0NmHtoO5mE+ylLX/1
	W1T78h1fl45mNbVtcXy8XoLHv9BO8v9ZH48tuTF7YFXUDatCcuTVTxtYnpIw=
X-Google-Smtp-Source: AGHT+IGfFM0VmJSiEl0hrfNOjF6WtTqtIlhLZ+/eBkY7mYSTPlJ9CVCTEW3f52OL2Z0rgZuHbBmZk1JpddObrgQyRrcEkS6I69Zv
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8e14:0:b0:85e:d0ca:b635 with SMTP id
 ca18e2360f4ac-86cadb95446mr1005245339f.2.1748271183134; Mon, 26 May 2025
 07:53:03 -0700 (PDT)
Date: Mon, 26 May 2025 07:53:03 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834804f.a70a0220.1765ec.016b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 665575cff098b696995ddaddf4646a4099941f5e
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri Feb 28 20:37:22 2025 +0000

    filemap: move prefaulting out of hot write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14435170580000
start commit:   d0c22de9995b Merge tag 'input-for-v6.15-rc7' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16435170580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12435170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1de0d8596cea805
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16931170580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14683ad4580000

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


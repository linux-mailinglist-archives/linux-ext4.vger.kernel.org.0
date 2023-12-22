Return-Path: <linux-ext4+bounces-541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A481C233
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Dec 2023 01:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3431F2585D
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Dec 2023 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279338D;
	Fri, 22 Dec 2023 00:07:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8391873
	for <linux-ext4@vger.kernel.org>; Fri, 22 Dec 2023 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fcbbd1dbaso13009075ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Dec 2023 16:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703203633; x=1703808433;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=EZjLHlppna34bGdJ7GacstItNLYxZcGvYULj+vJ1Lr9WgtFBlTbVr+v32I2EnTiSEf
         hJjytBVvr8kV/wjSZArnLYYABmRckU7RtJBkc46RFO1XMo+R0O8WNAg6tJwIBeSExb3h
         C9UQJshcPaSugM7XwQHUCLs3L2G5OaNT5DNRmS5rsJnesAPDC3795yzhmaOKQLqCoIpT
         mwoUaX0lfIOZ2Pbr5t1O8cPY+OSUmIE14I8dbr/xLnUbJQFhhxro7wU0/M1MHenS+ZcA
         SXEmIiXLDUE62/ZXfwxLmXZNgmDzzMBfXRLIaBbOcf5LKN8QfGHqx5+Tz+mySd7XRiIb
         Op2g==
X-Gm-Message-State: AOJu0Yw8dE/cmBXQv4HP3OTUfs1COMahE+oFm2uZW3+rkGYnEv5lP8lD
	V/NEhEbgfoiZIa/QmYa0rOn4JCSCnOBXCGDs83waRVzPTN9H
X-Google-Smtp-Source: AGHT+IGp4EqZUrHByv3JGf43xAerJwTcxk7SI0VR2iqYxAwG4CXwcStL3oz6hWVlRYsEgalewjyBe1u+W1Enno9VvFUHqbv56nQK
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:d4dc:1b1e with SMTP id
 i12-20020a056e021d0c00b0035fd4dc1b1emr54224ila.5.1703203633408; Thu, 21 Dec
 2023 16:07:13 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:13 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cb1ee060d0dffa7@google.com>
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


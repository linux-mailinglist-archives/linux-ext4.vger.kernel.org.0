Return-Path: <linux-ext4+bounces-136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85087F69AA
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Nov 2023 01:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E72B20DE6
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Nov 2023 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2319C;
	Fri, 24 Nov 2023 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7282D10DC
	for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 16:06:12 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-285659dcba9so1016434a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 16:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700784372; x=1701389172;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=ZuNkOs4ZIPNucbEMYW1920zPCzvuN302kFjBel6xx9V6JcxzLjXiTxC5Q9cNgtr7Uf
         0PAkbs4bIwB0KvLCSK5iS8O3rMtAiyFSnqMBl7RzscvL/dZlvy2Lb52b9DBQaFta9Lyp
         vWRo2zOfPMJqyjY7fbzdzQ9GAkHBwuVzUr9ceo+b9U1jSJrnDRtHvSMydHkwa3tfau8+
         SGasifm0vflNQXp3dkTeq2LoWazQmkgj/R+VflJwmTkR0UHoYcnwE28q+mvTSpHg6YmD
         PaRoNxS526wjyoQcNVqPSsaY0MoXDPZUk/5ZuZ/3AJpIX2Uw5RcgR0TACAIlC6XqB3py
         U7XA==
X-Gm-Message-State: AOJu0Yx7HgVghFx7WDRmaEEs23HcZmzYi0nKd7gsgpEj/n1ZrH74T1z0
	1+byAQ923nl9WoW3IYg1ONyPunq0iOiuCGfBeYSv2jjmIfm9
X-Google-Smtp-Source: AGHT+IH4WTBky6ydAmsIf8sWYpziUR2At8/kwEH+H4BuxT4x7gw6xHBkO6awptlXoHP15FAo0eZsGGO3X6iZK+6d7mdP0LEzTNDv
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4a84:b0:27d:9f7:74ba with SMTP id
 lp4-20020a17090b4a8400b0027d09f774bamr252386pjb.0.1700784371825; Thu, 23 Nov
 2023 16:06:11 -0800 (PST)
Date: Thu, 23 Nov 2023 16:06:11 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000528278060adab82b@google.com>
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


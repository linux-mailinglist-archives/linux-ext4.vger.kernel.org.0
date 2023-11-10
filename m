Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190D7E75B0
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Nov 2023 01:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbjKJAKd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Nov 2023 19:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjKJAKQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Nov 2023 19:10:16 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9115BA6
        for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 16:05:16 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3130ba31so14130195ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Nov 2023 16:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574716; x=1700179516;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=YBIr+aFW1I8PusbDs0gxYgrOd/x3pQtda1fZ3tnQFlMemXkhiqOdoeLCXHL5UynQNw
         BYDc8amvu49gHcyaB9qjTexKC4Ro+k/3mT9XAQVqAhNfgtofBdy9u+z4qSrlSLZq73YP
         YX/2eqQi1ZuXxRdoT55z8cu/2TaswnmMzNLEwEhCnFhaQ8F2Kg4rplK6QQUPD4YWf9m3
         bcrlurFk3/bNQIUQg+uuEiKVQyuBithKbAIzf6WMLvyz34wv6FQY6sGen3JpbHf2n2Ud
         DX0uTa6urAVOojko76ZVdtvYABsS2F9SUU9RFw5hkHRrpD40epeVwgXu7oOX712aC4t3
         ZMXA==
X-Gm-Message-State: AOJu0Yxim4zbIgM3U3eXlwekHL2YIKMbr13B0fPBPFC+KiPG8H131qfk
        lWwm7onwffHS4kWepX7RF2+IdabUqPVomZICiFLbvPIPxHel
X-Google-Smtp-Source: AGHT+IGBM631v2Yb6l2C+McH1ynCRRYuc7oa7oAxmdY4RNSzMJmzHuzcOz0wVp6GO8A8ZVsQ0c0i4TnbqXvI2OKV9vPysAKg1WeY
MIME-Version: 1.0
X-Received: by 2002:a17:902:f541:b0:1ca:8e79:53b7 with SMTP id
 h1-20020a170902f54100b001ca8e7953b7mr994032plf.9.1699574716092; Thu, 09 Nov
 2023 16:05:16 -0800 (PST)
Date:   Thu, 09 Nov 2023 16:05:15 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003900b50609c113c5@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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

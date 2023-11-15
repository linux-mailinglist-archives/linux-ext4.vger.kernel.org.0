Return-Path: <linux-ext4+bounces-15-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700517EBED4
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265E81F24811
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C2522D;
	Wed, 15 Nov 2023 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31E7E
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 08:50:15 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876510D
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be09b7d01fso6326210a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700038214; x=1700643014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=ckRW1eSDl/Wvs8aT5ulKbDcF6RPPl++AFSzPMb/I/IKuujnTGfbuTEW8rcrY01EBl+
         O+YdqndGROKM/+Y8AxOYBLxvKLoJP2Hw7ejXYd2cQ/ggNHmwKNLVWqGK1OIgFHwIRw74
         94bSMsBrchetlTMlDbFAybk8OR6PDIBus8i/NUZ7919iMhxRQMNFcsctmRrJYPQaUTv1
         yAcQZY6QtKHs4YOGeVZhCNiOYmEt7uc9jJVXzBTn49f8i+5Jut65x+24dZpFXK90NWRN
         i6tILeSDfEV/JkYmrvI8p1S21Rpxb9yvCG9wr4DhljWOmParMNuH37NopRewdod1kFXx
         27zg==
X-Gm-Message-State: AOJu0Yy9uF62XyYI6/c5wzJi1u4GGAvaMO2LPTGy9t2xFeImuVaC9Fi/
	KZmuZVvxZvRsoMUiNS5tyA0E7t0XTvDrpIeMvrcCj9XddwdM
X-Google-Smtp-Source: AGHT+IFUJ+Vym4OCXmONbmxagAntdPkW/KmU7Wvov6LOO01+7a6hUu2vKKARqr9sXhI//jw8FapxCsgSNNL1ljrINCH0MWGV4VRs
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:2022:0:b0:5bd:9cac:f993 with SMTP id
 g34-20020a632022000000b005bd9cacf993mr1135510pgg.5.1700038214642; Wed, 15 Nov
 2023 00:50:14 -0800 (PST)
Date: Wed, 15 Nov 2023 00:50:14 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e375e0060a2cfd2b@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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


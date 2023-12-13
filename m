Return-Path: <linux-ext4+bounces-426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EF810CCC
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 09:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536941C20981
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05271EB53;
	Wed, 13 Dec 2023 08:52:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F732AD
	for <linux-ext4@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20329a8f16bso182914fac.2
        for <linux-ext4@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457537; x=1703062337;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=WPZq+OIEEFTX4bUJQnKfnOKPNI4qnWToRixY61oCYL7ijY/7iga+2izw60vBh434JT
         fVZkv+lvymwwIPn0jybylfIfx8EOSh0eX/TvB8pIOq7BN6jgMEXZ3hcvrFCHq1qE7S1o
         ppaI9a+i/5k5N7znoQM4/vifJEMN3tlTH0hypRYR1CCPSjPTFLZY0xelaM7NrUXI28fe
         RY4tLfRXbXzAMmj7GObbjv2NnC/e8uoYwkuyjIm5fGEAIEuUf8lfMgCAlhlJ770WJFFc
         SHRU+flHKDSnKoV7rlKLVfSdGMSDiA1/0nQPk4hCvB8yamc4H/mXDC2PAIBkIrgQovM/
         DYwg==
X-Gm-Message-State: AOJu0Yz4JY5mW4zBX47rcoC+pq/FGOEdQ2batOoqcaQxuFI7wKX7/cIf
	2Hjx/ap0T0Oc6Q4Pz6COg1UgI3bd8dGeHVM+bmUsmSs8HerZ
X-Google-Smtp-Source: AGHT+IGzn1vWQRWy4hNK47/fXNETo9pMF7OxRmF3w0I7jOqcRkx6dD72V7r0g1rmfo1M2lvpFsx36btyv4fDVet8vGSK7FV4vEgC
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5b05:b0:1fa:e120:4c64 with SMTP id
 op5-20020a0568715b0500b001fae1204c64mr8088036oac.10.1702457536123; Wed, 13
 Dec 2023 00:52:16 -0800 (PST)
Date: Wed, 13 Dec 2023 00:52:16 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af990e060c604832@google.com>
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


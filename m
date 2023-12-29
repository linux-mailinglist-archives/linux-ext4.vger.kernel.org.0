Return-Path: <linux-ext4+bounces-576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36181FCD9
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 04:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8D1F249DD
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E1FC9;
	Fri, 29 Dec 2023 03:40:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75417E2
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7fdde8b58so915588239f.1
        for <linux-ext4@vger.kernel.org>; Thu, 28 Dec 2023 19:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703821214; x=1704426014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=hy/qMd6KVftyG8CiSDlRPHUBi329+axg6I3fUsShbPx+EP4vFLYTRnc16O/vnyEb4M
         Pb9pr0mBiIJuJYs3VRUd4W3u3E37mT4L3hY7FiA14ESU6tnCp2QQydfYufsyJGOZXdOR
         dR78gNKR6Uku0cEc/40nSdTPO+BJTlUaTMuT8nH3EDPl64/Y1jgRTIou3RFsYgBzTiL0
         JuixbwIOI0VsjruMyTXtrN+qZpY0ZLolv55Ouw45v2os2muxXk816AqYgkA36KC38GzP
         Y7mI3htGPkCzogux000Whw8BCnT7N47pNGh2QM3VcXmrF02tQIJPVieZwr7gAU4eMRy6
         44oQ==
X-Gm-Message-State: AOJu0YxV3yJLpQIQQP+0Dsa2i1EpA8maEOojgUpJkeJiuGA6f1Llu7Sq
	HWL8iB22fegEC3CsXaD4BpX05H0Gsn+nj+kwxU9LXfoL5+pa
X-Google-Smtp-Source: AGHT+IEkAGjwi+IkyhqrzNDOTpnjqIEIdvqSb/HQ56k/Ws0Mj7r3H0FCFiYVeWjl4P/gSUkbHvnRxME/4WghGDJY9dzzc5Q4cfEE
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2708:b0:46b:719a:62d0 with SMTP id
 m8-20020a056638270800b0046b719a62d0mr434473jav.5.1703821214020; Thu, 28 Dec
 2023 19:40:14 -0800 (PST)
Date: Thu, 28 Dec 2023 19:40:14 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038f8c3060d9dca3d@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
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


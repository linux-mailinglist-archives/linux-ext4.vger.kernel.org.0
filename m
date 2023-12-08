Return-Path: <linux-ext4+bounces-345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6278096E8
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Dec 2023 01:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02A31C20C40
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Dec 2023 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30855643;
	Fri,  8 Dec 2023 00:06:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0311984
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 16:06:16 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9decbc5d7so1172836a34.2
        for <linux-ext4@vger.kernel.org>; Thu, 07 Dec 2023 16:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993975; x=1702598775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=fGh4owF3kJwJ+VSF7trAHt0DXH+v1a1WbVNLUvJWWkp6KV5h0O8mOxI8gzYKwZ3XI3
         s5Pe6bgS/Ut0G6z30xWjKc4zhJR6oAhjhpxPVOIEPTBndAvNIwcIsoUczR5qfQf29bMS
         R9XCXn+Qxo+Iv81FnIhn1bLkddv/FczJCDuGsx3YgQOXlfyv4slwtGjABKayKl9oFqd1
         tf+hHKp4/2Sf25OCDwl23GRPEqg8AAT/iemN+vueGfzdOv5uYLFI/nefR3YTBO3xVBOG
         YPi9cymA2hctW0nw2aZZoic6/k2sexIGP7Cc9jE4uGiYBn5vVLvRWb9uuJXL2lYprrhL
         xH3A==
X-Gm-Message-State: AOJu0Yya+tk/+8H1sy24HT6tM83c4OJ+Gk+/MIRkrzcZyRM4yHF37LbO
	ul+2SDQT/YQFitUGmDK7hrrnjiIS9jFrzYx9Je7Lw1+CJ+H1
X-Google-Smtp-Source: AGHT+IGWxJ5jW+luuxEuFZEbdM0vgHtDD5vlSaULaFryrlciMSxtVxHr6p4K1syh1eOgtuEsqIoGvQAA/sWnkA5DO2Ja+joiDA1J
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:6015:0:b0:6d9:da80:7f38 with SMTP id
 h21-20020a9d6015000000b006d9da807f38mr1315510otj.5.1701993975545; Thu, 07 Dec
 2023 16:06:15 -0800 (PST)
Date: Thu, 07 Dec 2023 16:06:15 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000528587060bf45af6@google.com>
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


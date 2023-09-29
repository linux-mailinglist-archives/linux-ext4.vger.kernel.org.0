Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A27B2944
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjI2ADg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 20:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjI2ADf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 20:03:35 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D61B7
        for <linux-ext4@vger.kernel.org>; Thu, 28 Sep 2023 17:03:30 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1dcf6a4378bso22273969fac.3
        for <linux-ext4@vger.kernel.org>; Thu, 28 Sep 2023 17:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695945809; x=1696550609;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=mfS4eVfVTNwEZuINQXPx9eKVkUMf1oMyV8G0Mm/Ivh6xmEFFfz63EPdXkincRfyf8g
         3zT1NVm7t3sg/ellDS2UOv31SSNFNEdRXWj8ludMYlTfFDQpJjbgDcK7qZXFUyIUN/bm
         ArAGLqL/XRAUL++O1pfA2F/EBIkppAYAEBiyZxGJATxDYRAQnHc0HQmqY80reoeszz9m
         JX6cclJhQQPA4SHvSLJ/XTCdXasmdXOpkhEehbznLr4Y+7jcWq7e/yvDEvWEKRJq3BQ8
         ExL/TGgS8PhAOwC2SqqOw1Aynb2NUsT95OJjh/CQShxDsoniaU4vzMQ8+znhCOHQZbNK
         9twg==
X-Gm-Message-State: AOJu0Yy93hpQlPxghYO46aJFr3pOUyEXGAgh8lZe4oLPspn6DSNVlXKq
        45+embvqfL9GxLSXA0oS+A+asoGD64dl4x6VSkd3PF/o3kZb
X-Google-Smtp-Source: AGHT+IERkTanYl+6i8fZvmZqLio7FhKCgtIxa/JJCK2qCyQ3t0AROlbj5TW0NkJARvOIfScURyDm0HR0Tb/tFCcbx/PNb9gtLLgs
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c784:b0:1dc:27f6:7a10 with SMTP id
 dy4-20020a056870c78400b001dc27f67a10mr1206014oab.10.1695945809369; Thu, 28
 Sep 2023 17:03:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:03:29 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086a1dc0606742727@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

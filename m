Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC87C7AB3
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJMADl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 20:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjJMADl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 20:03:41 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE5CC
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 17:03:39 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e9c1e06ce9so1213085fac.2
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 17:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155419; x=1697760219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=ejmbYMpOB21wRcTff6IC5A1T02ZS7MmA3ebrDhlTJCt5tc3dJd2VLipwk08YPwBbdb
         9nOpo2D+kKBFA29dR02nr1d33d5AcjUmnjBkXYd+QbOyPrQ1860BNrUSEaXyBcptDJ1q
         57VTKfC3Ce7RPY7ZTKkeiiPUOvhmJH2+kAR6KV4Y9m6iUg2BFqBJgKSFVbSCD6nIYmll
         NhoErgeC5MuBsrIoXKmgyv96px3CPcGnzPs8tdSXrDjx31OKZQ5gMpnN2wFp0fvZoXYh
         7l+YHuzwOVWwpUtSUosq1jFVhQidAAFbGgzUf8PLPm07Pj+shPF525INeQUdNw+c5k1S
         dzmA==
X-Gm-Message-State: AOJu0YwDcpCUpYBGXEbsSUWm3vdh9RJyFKrKM3pDI4fEu5qTw45S7ezD
        HwFghnGvAUvrHjAkfx5ShaqhLf+JdsK4vxB304SKAQZCVDgT
X-Google-Smtp-Source: AGHT+IGzSVQJ+ozrCG0Xql4kBRPtscZoHslOm7gEpv+z9XZ2YfZW4WdjRmOCzvr9TfGSttnXEXH2buHPBtCtDBErAaknJ0nbbAIO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:718f:b0:1e9:c362:a397 with SMTP id
 d15-20020a056870718f00b001e9c362a397mr910277oah.10.1697155419207; Thu, 12 Oct
 2023 17:03:39 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:03:39 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3fc6906078dc931@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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

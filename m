Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF97AF5C9
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIKG1K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 02:27:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42763 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKG1K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 02:27:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so600806lfg.9
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jxfAkY1Yh82ZE6CShCH+p2fzra92SVx1PyVHvRwzQ0Y=;
        b=X8ciRUMRFV3StqkFj3iD+p3+qABQ44RsG0Dx8hr97CBB6TpQmScL1VahZJPgi6gAHY
         0gQJL5HWp9kp9UsjC660auN7O8KDwuI4QImP341dRceso0bM4yGWp1zetfnnqXRLCcAv
         tLbqni202a8hW+qlVxcZdtgozOOzEeVeeSlEpiFdZJSuZu796yaqBrWjh96n626KXgeq
         syqJ1r7GfBE+ivcddCDq1PML2z1NiOB/VqKvbUmyiBDlSXAlAu6CeTL29w6tuY30Ntsm
         3L2E60+kOS2WfViwxdZvQixPJi9Sfa0L4MMWFiF2PFNssi4qvsayr3onBw9lTceXgx8d
         dHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jxfAkY1Yh82ZE6CShCH+p2fzra92SVx1PyVHvRwzQ0Y=;
        b=I8hTKbnk4Snqjz8CtfRQZutdsSKfNs1Cop8Co9n4aiHHJsHbT7AJJn/iILV/TwuZgl
         QE7AFIWO1ZWTjk+1m77kJs3RcXh6oRElm3/plpC7XXeekCikcG+zfodbP0yB8jSxcG5I
         eCkBCJ4ZyKstgermRUmaGCLkVKt4SH1MjpIggL+w31a8EpMTj6ZOYLbv81+5CH2aYSv2
         /Y28gzgRP1APVvDoXTZ8PdxJLH8uOl5S4UgUsdIe4O63nBeWy/DjRsfaDtsrCPn3DA/w
         ZxkQd6LEuaUJU3bKWFWMPTWBsVk1jDVvKwTRBGIDqwJ4lx+qw33Y46WmR5Ip2959oKgj
         1CTA==
X-Gm-Message-State: APjAAAXEELaI3MBN3r9IHL0h89iYNNCjNxwJSZgZ1rk9ElzZdnQ8iKg+
        OxNhllipsN3z75I+fXYJeDct+wdklmvMOAX21B163y1g
X-Google-Smtp-Source: APXvYqxeB9NpGeC6fMEsRHnHXzqtGFwx5nnC2fVDFFb1AZfq8K4Ig/d7qYsxn7Bm8LQkpxOmq35HTnM1SYDV25BpEk4=
X-Received: by 2002:a19:cc4f:: with SMTP id c76mr22662031lfg.117.1568183228233;
 Tue, 10 Sep 2019 23:27:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e00f:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 23:27:07
 -0700 (PDT)
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Wed, 11 Sep 2019 15:27:07 +0900
Message-ID: <CAARcW+qa7aRbh+BeFWTndGLC8owsy9VPUqcJ-BYN-Yw3jQM-_w@mail.gmail.com>
Subject: Why doesn't disk io occur to read file system metadata despite
 clearing dentry and inode with drop_cache command?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I am confused about "echo # >/proc/sys/vm/drop_caches" and blockdev --flushbufs.
According to OSStep book written by Remzi,If the target inodes are not
cached in memory, disk IO should be occur to readthe inode, which will
make a dentry data structure on memory.
To my knowledge, echo 3 >/proc/sys/vm/drop_caches is to drop(clear)
page cahche, inodes and dentry. I have experimented with blktrace to
figure out whether disk io is really occurring to read the inode.

1. echo 3 > /proc/sys/vm/drop_caches
However, there is no disk io to read inode. I can only see the disk io
to read 16KB data block.
2. echo 3 > /proc/sys/vm/drop_caches` and `blockdev --flushbufs
/dev/nvme0n1I found block access (+8(512*8=4KB)) to read inode.

A quick look at how blockdev --flushbufs works in the kernel code
shows that it clears the superblock.
Why doesn't disk io occur to read inodes with drop_cache alone?
The kernel book called ULK says that inodes and superblocks are cached
in buffer-cache.Is this the reason for this?
I infer as follows:Is the buffer_head data structure not flushed to
disk by drop_cache alone because the storage device is still mapped in
memory?

Thank you

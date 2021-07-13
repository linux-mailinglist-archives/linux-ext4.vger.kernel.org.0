Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACF3C6ACA
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 08:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhGMGzQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 02:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGMGzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 02:55:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3BC0613DD
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jul 2021 23:52:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g19so33133804ybe.11
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jul 2021 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p9jmLvhXyVcm9YMFLcoGeCzARhjBsMZGpuKosF1x3QY=;
        b=nrHkbJZjsF0KYd5HGKg4+ahnLQH+tn1E9EexFt9FpUjPvY7BfU/h4u5axqFxEPB8Nu
         h2F+LpK7uFCgQ/PXLF8yvyFwKilHAkFzJimvhqp5rSJx8eg5UrAtYq9HgCUh4PvWot0T
         InbCEaINHQVAHm2ZkXdI8h4I96Wn95Sle0LL5JL+b5QjCro6DMQRilzWt/Iyuc8sp+Ri
         urRx97Usl2tEn8ORVN91FUiE+MDS+veBLYVxBkEGROaIc70p2YiWRB2XVqUznt54+g2w
         R/QRtgxROzlK+IW8oayUv4UCEzWXLZm8zWF0KuXeLVCdYv+KF67QHYRYKdlF6EdKDkmR
         aKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p9jmLvhXyVcm9YMFLcoGeCzARhjBsMZGpuKosF1x3QY=;
        b=pDXx/CvqklWdDfavj2bj5b5itAH346Xzxl/fh+tbO52l+v4l04hTzm0+KlVRyDOeMu
         7lR6nBtLJJI2HNrexygSP/qSn7GCxDZzynugkbXb8wkrtc9Amli8bApfWJafX6tzozth
         9edhS9+kqG3Geh0g0DO3WJwPcNlSBLjEqPyp9IBtU28wAckun3gb4bn8SMVlb+HmmNij
         Fn4WIYKQnL0xPRRppIXUF9euF0TBHidUSq2+sbvBh+9ZZwEOlPtmnfTPVO1ig7fBWMVR
         /nYj6nH7vqvQtYegzLCFNbA0U1YWTPKA2NV/d1+5iAYwawunF6VGvfx76Awai7hhVUzX
         ShSA==
X-Gm-Message-State: AOAM531kGzwDPKMOIc+n/TSSKsY5vPmZkGTzQegPTk9mssvRvDWDhlnj
        AadPRscZ5IGoBgoKNMSSENnUwNTPTnWZ+fq8bD0=
X-Google-Smtp-Source: ABdhPJy8RBTTzKbwqwrUkwZnWZxggqYo/CrpwXyUQJQ3VZJlGVE1ouICA9eNzoKa9wgYsAix1oq3h3rZIUM92/T91/I=
X-Received: by 2002:a25:ba87:: with SMTP id s7mr3636097ybg.97.1626159144926;
 Mon, 12 Jul 2021 23:52:24 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 13 Jul 2021 12:22:14 +0530
Message-ID: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
Subject: Regarding ext4 extent allocation strategy
To:     tytso@mit.edu, David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Our team in Microsoft, which works on the Linux SMB3 client kernel
filesystem has recently been exploring the use of fscache on top of
ext4 for caching the network filesystem data for some customer
workloads.

However, the maintainer of fscache (David Howells) recently warned us
that a few other extent based filesystem developers pointed out a
theoretical bug in the current implementation of fscache/cachefiles.
It currently does not maintain a separate metadata for the cached data
it holds, but instead uses the sparseness of the underlying filesystem
to track the ranges of the data that is being cached.
The bug that has been pointed out with this is that the underlying
filesystems could bridge holes between data ranges with zeroes or
punch hole in data ranges that contain zeroes. (@David please add if I
missed something).

David has already begun working on the fix to this by maintaining the
metadata of the cached ranges in fscache itself.
However, since it could take some time for this fix to be approved and
then backported by various distros, I'd like to understand if there is
a potential problem in using fscache on top of ext4 without the fix.
If ext4 doesn't do any such optimizations on the data ranges, or has a
way to disable such optimizations, I think we'll be okay to use the
older versions of fscache even without the fix mentioned above.

Opinions?

-- 
Regards,
Shyam

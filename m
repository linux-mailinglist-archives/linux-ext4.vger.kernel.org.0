Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975522F569D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 02:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbhANBuB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 20:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbhANA23 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:29 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1BC061795
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:27:45 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a17so3002715qko.11
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0o/vA1AfNKxyGaMPPfQg0SvsINA0ByEgrAbYEZaT+Ow=;
        b=CVUuO+20ns0ZdokW3B55E6xkRruNaFweTHsuWjgfUcMJShZE1Zrjf16Eee5zwHMbO/
         q5Krh5wM+6VyZtugOkHpQqIa7kfwx9Yh6SBgW/WeTCbRlm79InpH9qEPEAAYi71MhFGx
         HRuLX0XXblgHVEdWk8LvMyolCix1h3x8s9tLnNlLGSjbSvCCliAg1nCh0ARqXqZj6vwp
         /UEd9ZGtWkBpu2+iOfd0OFI1e2LI1AVMTMDwWnv3m17SUdoDU2o6s05dg9eNTp2kxPx7
         1IORgwVv6lVkY+ucYwX/lmRqCh1TEyn9y+lYeLDwEGnvDb5S46TOwlul4VfL5Km13haI
         swQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0o/vA1AfNKxyGaMPPfQg0SvsINA0ByEgrAbYEZaT+Ow=;
        b=cv12NaKwpKGSVFaEdMPUz2/CBVERbiKkewx3Tww7AVOyt5m1643vIm38aodrGjXfLx
         Y+uy1DwWS7jcVkGObSm2DWjIFvFrfD4f6SortR/u881WQlo0CcA3Uj0mhB3XFz/xIyjh
         MjFmkGeFYtST1+UUlQQYwm8BP9Zp2+VHqTgtFa2l96lNNI1CfBtA+xBvYl8vlyGwB8fB
         4aYepMMaCJpJWO2x49A08nydU8eCkMsYLPkFlNHjM89vvItLdNVg4fpfnZzsH2TCDVv+
         LK2j+T+2brmmsme41c0OM0VcqGbVmSoBk3YIAPhTco8LFk+3Z86lmwbVJO9hy6hczeX3
         FpIw==
X-Gm-Message-State: AOAM531nz+CuCCuLA8YmNwjkosx0Kgwu22QUYHlYMXQO0uBDYf/4aM5+
        PPU74ccj5nSsAhRF6Vd/igq+mMnfKGXlpnBne7z+4k5UYRkpkFXKUthMWyCgEQjpRf2qXGM32v+
        fEXDSSNweIvCYi2UNKZn08jU7Flfzzq6zzNlqRWK7P2cHIBKbFyBNVJ2+8IU/Uu70bh+mhXaSZ7
        ui9SBUVrs=
X-Google-Smtp-Source: ABdhPJzgjaaidynmdK061DiaeXp7QpvJlGfnJ0smxX6DU1lF3FX+TMZtutovzkhHwZuNpoXDninMBKKsjMzBpSi+yhk=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a25:99c2:: with SMTP id
 q2mr6750017ybo.265.1610584064871; Wed, 13 Jan 2021 16:27:44 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:18 -0800
Message-Id: <20210114002723.643589-1-saranyamohan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 0/5] Add threading support to e2fsprogs
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch set adds the infrastructure to support threading to
libext2fs.  It makes the unix_io I/O Manager thread-aware.  Wang's
parallel bitmap code has been adapted to use the new threading
infrastructure.

The code has been tested with TSAN and ASAN built into gcc 10.2:

    configure 'CFLAGS=-g -fsanitize=thread' 'LDFLAGS=-fsanitize=thread'
    make clean ; make -j16 ; make -j16 check
    configure 'CFLAGS=-g -fsanitize=address' 'LDFLAGS=-fsanitize=address'
    make clean ; make -j16 ; make -j16 check

As I(tytso) needed to excerpt out some of the changes to generated patches in
"Add configure and build support for the pthreads", the full patch
series can be found in git:

git fetch https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git pthreads

Changes with V1:
Fix review remarks for "ext2fs: parallel bitmap loading".
Tested stat_mutex performance on instance with 60 CPUs and fragmented 3TB Local SSD.
No noticable contention seem for the stat_mutex.

Theodore Ts'o (4):
  Add configure and build support for the pthreads library
  libext2fs: add threading support to the I/O manager abstraction
  libext2fs: allow the unix_io manager's cache to be disabled and
    re-enabled
  Enable threaded support for e2fsprogs' applications.

Wang Shilong (1):
  ext2fs: parallel bitmap loading

 MCONFIG.in              |  12 +-
 aclocal.m4              | 560 ++++++++++++++++++++++++++--------------
 configure               | 213 ++++++++++++---
 configure.ac            |  24 ++
 debugfs/debugfs.c       |   6 +-
 e2fsck/unix.c           |   2 +-
 lib/config.h.in         |  83 +++++-
 lib/ext2fs/ext2_io.h    |   3 +
 lib/ext2fs/ext2fs.h     |   9 +
 lib/ext2fs/openfs.c     |   2 +
 lib/ext2fs/rw_bitmaps.c | 332 ++++++++++++++++++++----
 lib/ext2fs/test_io.c    |   6 +-
 lib/ext2fs/undo_io.c    |   2 +
 lib/ext2fs/unix_io.c    | 156 +++++++++--
 misc/dumpe2fs.c         |   2 +-
 misc/e2freefrag.c       |   2 +-
 misc/e2fuzz.c           |   4 +-
 misc/e2image.c          |   3 +-
 misc/fuse2fs.c          |   3 +-
 misc/tune2fs.c          |   3 +-
 resize/main.c           |   2 +-
 21 files changed, 1093 insertions(+), 336 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog


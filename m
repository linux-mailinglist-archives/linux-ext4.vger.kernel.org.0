Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4632FFC4D
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhAVFpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAVFpo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:45:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C06AC061756
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:19 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so2984515pfm.6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DppVr6EG5dBG+w2iXAMd8fKW6F004/NHb4ifJ0ffG88=;
        b=dn0+IcqWVTboL5qnwHce6acreTPmrhzKtJcrbJotRQFjdeKjtLj9ZrCx+eHw4CbiHC
         0klGB4TLQgNy8BWco6x2KRdQRfhnyhnNU8Uw57nhk2dOmEGrSEPdPXuNmVAgwbHtZl7n
         px3omFdvtIeWlbv/BHdOGyP9J64YVRqnLsxvRFC2M5ToMm2uFAQdyZQQT7jh2uFIaauf
         D2Fdv965zYI5ar/esvkD6gEym5m++nZoAa1IwGJ+fGIePbGBRIJDcSsd5jokt8Bs+GDY
         vLjESSBNS4QxhHu52p4sMyWNAzFLE9oRipYYIP0EvUQ8i+74FNd8K6PXu61DLM+/lYPn
         JU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DppVr6EG5dBG+w2iXAMd8fKW6F004/NHb4ifJ0ffG88=;
        b=H9hIDGdf+kMP4is2VuUYxp2M8cQmUAxsUtqcipWtojkUN7Sl2grVk8uvQS5eMFLltU
         HRn78IBknY6J7k8615nhYgiNj3MVhK/wE9X0sxZJKiDxuHVnSSG/o8I8+R0sfkKshdxe
         pHSkPDEnjonslmfHupta92xJ6RckR1oucQHO7bdS24HF9zrWlFZ+l4LlhFpGiLNaz4WM
         jHUCgjqXXs8gzWWG+8Ht8P6ZvVe7TyrfCvxHpPWNXOeDeOpKpdvBjvu0sJc2rfH6Nzsn
         qoJ6N8tSNyicfFhjJ/bZihCoJwcCIBylfd16fF793xA58uege741P6baaa/boQJnZK3A
         jn6w==
X-Gm-Message-State: AOAM530o0Pom8+7HqMdcCKWyxTokLHdpy7AAXSBNhvBgqvPkhLJfG4vd
        AFLaKMIX3AkrDc39TPDnepUXS9+XYKo=
X-Google-Smtp-Source: ABdhPJyv1L8p52EE65Y26ouFBf2L4YzYyUsf3TMIxCFq7/6KFZFEAJ9cKL8cQIJB2xPoKZ6Bv1mKCg==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr3178652pgs.248.1611294318515;
        Thu, 21 Jan 2021 21:45:18 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:17 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 0/8] e2fsck: add fast commit replay path
Date:   Thu, 21 Jan 2021 21:44:56 -0800
Message-Id: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch series consists of modified e2fsck fast commit replay
patches from the patch series "[PATCH v3 00/15] Fast commit changes
for e2fsprogs" sent on Jan 20, 2021
(https://patchwork.ozlabs.org/project/linux-ext4/list/?series=225577&state=*). All
the patches except fast commit recovery path were merged upstream. So,
this series contains only the fast commit replay patch changes.

Verified that all the regression tests pass:
367 tests succeeded     0 tests failed

New fast commit recovery test:
j_recover_fast_commit: ok

Changes Since V3:
----------------

- All the patches except the replay path were merged upstream. Thus,
  this version of the series is shorter than the V3 of the series and
  only contains the recovery path changes.

- Added errcode_to_errno() function to translate libe2fs errcode to
  standard linux error codes. As of now, we simply translate any
  errcode_t > 256 to -EFAULT and <= 256 to -errno. We also log the
  actual ext2fs error code to stderr along with function name and line
  number for debugging purpose.

- Consistent naming: renamed e2fsck replay path functions to have the
  following convention - all the ext4_* functions in the e2fsck fast
  commit replay path return standard linux style error codes while the
  functions starting with ext2fs_* return errcode_t error codes.

Harshad Shirwadkar (8):
  ext2fs: add new APIs needed for fast commits
  e2fsck: add function to rewrite extent tree
  e2fsck: add fast commit setup code
  e2fsck: add fast commit scan pass
  e2fsck: add fast commit replay skeleton
  e2fsck: add fc replay for link, unlink, creat tags
  e2fsck: add replay for add_range, del_range, and inode tags
  tests: add fast commit recovery tests

 e2fsck/e2fsck.h                      |  32 ++
 e2fsck/extents.c                     | 175 ++++---
 e2fsck/journal.c                     | 654 +++++++++++++++++++++++++++
 lib/ext2fs/ext2_fs.h                 |   1 +
 lib/ext2fs/ext2fs.h                  |   8 +
 lib/ext2fs/extent.c                  |  64 +++
 lib/ext2fs/unlink.c                  |   6 +-
 tests/j_recover_fast_commit/commands |   4 +
 tests/j_recover_fast_commit/expect   |  22 +
 tests/j_recover_fast_commit/image.gz | Bin 0 -> 3595 bytes
 tests/j_recover_fast_commit/script   |  26 ++
 11 files changed, 929 insertions(+), 63 deletions(-)
 create mode 100644 tests/j_recover_fast_commit/commands
 create mode 100644 tests/j_recover_fast_commit/expect
 create mode 100644 tests/j_recover_fast_commit/image.gz
 create mode 100755 tests/j_recover_fast_commit/script

-- 
2.30.0.280.ga3ce27912f-goog


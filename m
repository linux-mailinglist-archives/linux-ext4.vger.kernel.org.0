Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874EF218330
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGHJMm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJMl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 05:12:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBEC08C5DC
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jul 2020 02:12:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a6so1315169pjd.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Jul 2020 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=;
        b=L6GJq+QmffCuIO7dqu43ag2+8gyTCJKALyR927sB9QwrDr8ea9dQSlepyzo1/pbivU
         81VhNFeTc5ba4uNGCOKWwR6NtWw3vTd+Qu+tpL+mhk3YiLgeQ2bQlJ6iQV3e/a7Fjc+a
         Zima/ekvuWZZS6ASF9jCKBu37/A2Jin6Iy8Wn+pguLOztRhTnk0KTHaPooojcoZ/EuZI
         sYuiK6cbscTme8vE2a3QaDKbA/ZbUTqQ1RaySTP/XI6ilapmzdSCczpfKItt9bDiD5B5
         qGfYbnSRxkatzVYIsfGsnlJDgXk4iEpvIVtLpfH8c12B6aY5DEyiILWeDMM0HQEhPPox
         cUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=;
        b=TgUj+Np/Q86nKnZHOjs41lKwU4+qY/FlKwA8vqme+SwMx0NALQuYBcdZI4+SmnZrUH
         rI0RY0/iXZgjyFNdMLxtNXz3ZG4Qq8h7KZJLnvOVgcBefaApb7fKzj/3nAdTzbl8gMuL
         TI6AN1GhIb4m7wDZLd78m5qiRoGka+d12HRJUsofROmB3qyWPErgjBfZJHeBvplz+Y0c
         5AOhxy8wZD36AR0/drK9CFQWy0eTsq1D+UG6WGZrG0/GTnti1rPdyWdeOASr9IfIoCox
         /w7B8KiEJARSITIDhJ3lMqMy919pLBMscoVipjhY3w9XlpSl5C42gXq+9YxmWwWCAOcz
         U3fg==
X-Gm-Message-State: AOAM532Vy/wFbdZYhkA7seiSR/xmX9Sr5BTgycqKex5uPPTUQswJG1/w
        DI01j51F2XDSKGVc4w+0HsLPdE5J3bE=
X-Google-Smtp-Source: ABdhPJzFvfpDeyxPhbKxpb3zpnUW+cZnsByq5J9vChYiBZ95cs4wd1HMbcH72CKn2IWI+wWEMSs035Y65Co=
X-Received: by 2002:a17:90a:7103:: with SMTP id h3mr8662006pjk.34.1594199560750;
 Wed, 08 Jul 2020 02:12:40 -0700 (PDT)
Date:   Wed,  8 Jul 2020 02:12:33 -0700
Message-Id: <20200708091237.3922153-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This lays the ground work for enabling casefolding and encryption at the
same time for ext4 and f2fs. A future set of patches will enable that
functionality.

These unify the highly similar dentry_operations that ext4 and f2fs both
use for casefolding. In addition, they improve d_hash by not requiring a
new string allocation.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           | 64 +-----------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++------
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 84 +++++----------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 87 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 ++++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 ++++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 165 insertions(+), 185 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog


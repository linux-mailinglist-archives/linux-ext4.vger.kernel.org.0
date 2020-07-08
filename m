Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D374C217D47
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 05:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgGHDF5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgGHDF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jul 2020 23:05:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72852C061755
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jul 2020 20:05:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f2so17037805plt.2
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jul 2020 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sxoy6q+HxdTygJctVhkj+Ncax7HD8YrVRDBUHbmI/GA=;
        b=jvxGSCDzgqCSzD3A5CZ6zoxEY3HwELi8FObL00AmNlxQWLpvrUeBFZBc3B9zB5etbX
         mYEpJX0jRgUUJ4S9ot+BQk61eRDjpYkKZjXS5FkMSOUavjWBlMPiA5+LW/699y0iXpQC
         s8ynNf8lIHMTPkHzVRmSAVfDowYI++DiMfl/exKk9l+l/8eEG3w0s91A1Ycqqyju5MfB
         hrssrkk130gtKV4YYHCQ2dycaO4RT4XQHdC+kpGmlUYHSXN8zNcGMq9fWspZLGH9mYPU
         dePpa1pDLmtFFKbvxkZX6SahRyc7gjEHircUdtQBKPXrVPw+ESEA+mxA7Fqh1xXzohzl
         +nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sxoy6q+HxdTygJctVhkj+Ncax7HD8YrVRDBUHbmI/GA=;
        b=Bw+KS65i85uGnQwv7cgAcpGRTXF9jX7Yz0Y4eZqpZu9oopdmnxw/wgBv6SU0emKsA2
         AGJar48Q12IEPl6jv3qcxdwx946vPq8IfH5hmi2w7QbIBOutr/zwJUzA2WI4Yarp/Imv
         m79B11Og1ydYoPr92vYZbeCNoClnQXsMYd/5Bd4uycR1lVvD1BWxWPKT7iVynO5KYPV4
         bH9B2s/ibP7b+BtMN4d325VBjMGzEiFm6HX5VHWfhqLAtj/wJcJ5OALSkaNtfsrba5ke
         YFrKKjycd37uJjhhe7Z74C+kwEqzI4qNqFSdqmUXDZjJwwhqwJL0YoPLt0TZk0X3oCr8
         ODOQ==
X-Gm-Message-State: AOAM530Rq/f1RxGUReKmDa3UFPiuyxxcrdkLxaUr7ko3/mdE/mGdi3Ef
        7Xnoswk9cayokZSWB9iv/qC2Y5zP2wI=
X-Google-Smtp-Source: ABdhPJxHc+FKhRyKZRaUpdsFwS/kCIg/eIMdmz1LxIxSnZIjP9Kv5YSfmEOlULOG9PgVuLCQSbtYJSctP7g=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr1032734pjz.1.1594177556279;
 Tue, 07 Jul 2020 20:05:56 -0700 (PDT)
Date:   Tue,  7 Jul 2020 20:05:48 -0700
Message-Id: <20200708030552.3829094-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v11 0/4] Prepare for upcoming Casefolding/Encryption patches
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

 fs/ext4/dir.c           | 64 +---------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++-----
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 84 ++++--------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 94 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 +++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 +++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 172 insertions(+), 185 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog


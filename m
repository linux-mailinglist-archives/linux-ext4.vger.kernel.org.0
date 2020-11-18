Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39F62B7673
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKRGmv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 01:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRGmu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 01:42:50 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DFCC0613D4
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 22:42:50 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id du18so660651qvb.14
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 22:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=u5caVYpjW51UviyAUiIiuabnW39XcM6vjoXzylmjMQQ=;
        b=nEBuvp/4qXTH4AAIx8Gr2DG2ZKpgZ7YLYjZB4voXYemMwTXptimZcegqwTHgPpPw0I
         EwVwGOxQa0Aap22fetPS3Lj1KFiJioOyzRYapPZ3sh/IAuvruSKA7NOPaADtyCApdcOZ
         eAHvd6+arAeAaZ+UyJBdV9j0eelWwDnmi6lZpJl9AxxsRYC6qRxvLZVskUhKpBbGb5qW
         pV4o4S/wW+/n3D8iLw3TM6UN0E6wiazwRqgTjGZUDhQT6iU9/QB6j3bqBsuOg9PvT/PI
         dyzTuACoqvvljMcN66fAqWLJpRZe+hY81fFWPiwVJVjTQu1i6Bp5N0pAHXwnA55L1ZPQ
         JGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=u5caVYpjW51UviyAUiIiuabnW39XcM6vjoXzylmjMQQ=;
        b=lDN92KXfu2GgpHW+r7UrtFGOnHBmsjBORj/4B/xv3AuBltproYrCNBPbcRURNQbeU7
         YIHhrBU+mK94rzs6KZjXnGz5tf9fEldaTY2FU7w9WMMIKYDmT7O9MZiC1jCaco4fxifP
         YcsqwLQKCAmJxEQSg4k7HQmC5lg5DS+sWXpW0PQqsqobAuRnzve3JpseolkedzDue80x
         NixIXL5AtO+VR/l25obFIKhvZR5It1LqMYe03coSaY1bYjyTQXRatsc4ny4vhswlDSg/
         jltbwmd3WfO2ELSs6B2964CaboDlv1oErhwRYoJZtSPXhl6+BtdWRSO4sWxDHaHa32he
         bCdQ==
X-Gm-Message-State: AOAM530/ZElk0ug9rgnSuzuS0Anc6yApmHuWUG9xvoQkThfMB9Fc6nx/
        z0JvVzJkKo8WIhgQ22rNpxcMQOfUsxs=
X-Google-Smtp-Source: ABdhPJxIZ2FilqfFWaJShB2bRFVummoWsUhq+iNGutp/cAxbjC3GBHd8GSqHZEJazc+0X49BH56xSs8BuGU=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:ad4:490d:: with SMTP id bh13mr3584587qvb.14.1605681769641;
 Tue, 17 Nov 2020 22:42:49 -0800 (PST)
Date:   Wed, 18 Nov 2020 06:42:42 +0000
Message-Id: <20201118064245.265117-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v3 0/3] Add support for Encryption and Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These patches are on top of the torvalds tree.

F2FS currently supports casefolding and encryption, but not at
the same time. These patches aim to rectify that. In a later follow up,
this will be added for Ext4 as well.

The f2fs-tools changes have already been applied.

Since both fscrypt and casefolding require their own dentry operations,
I've moved the responsibility of setting the dentry operations from fscrypt
to the filesystems and provided helper functions that should work for most
cases.

These are a follow-up to the previously sent patch set
"[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"

v2:
Simplified generic dentry_op function
Passed through errors in f2fs_match_ci_name

v3:
Split some long lines
Cleaned up some code
Made some comments clearer
Fixed bug in v2 error passing

Daniel Rosenberg (3):
  libfs: Add generic function for setting dentry_ops
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption

 fs/crypto/fname.c       |   4 --
 fs/crypto/hooks.c       |   1 -
 fs/ext4/dir.c           |   7 ---
 fs/ext4/ext4.h          |   4 --
 fs/ext4/namei.c         |   1 +
 fs/ext4/super.c         |   5 --
 fs/f2fs/dir.c           | 105 +++++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs.h          |  11 ++---
 fs/f2fs/hash.c          |  11 ++++-
 fs/f2fs/inline.c        |   4 ++
 fs/f2fs/namei.c         |   1 +
 fs/f2fs/recovery.c      |  12 ++++-
 fs/f2fs/super.c         |   7 ---
 fs/libfs.c              |  70 +++++++++++++++++++++++++++
 fs/ubifs/dir.c          |   1 +
 include/linux/fs.h      |   1 +
 include/linux/fscrypt.h |   7 ++-
 17 files changed, 185 insertions(+), 67 deletions(-)


base-commit: 0fa8ee0d9ab95c9350b8b84574824d9a384a9f7d
-- 
2.29.2.454.gaff20da3a2-goog


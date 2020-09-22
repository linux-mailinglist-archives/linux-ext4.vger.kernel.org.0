Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4229273FE0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIVKsW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKsV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Sep 2020 06:48:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECDC061755
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 03:48:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1256381pjb.2
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gd9BXK6Qogm8GWzcEx/RRuoN03o4stNhU2BMPs3db+g=;
        b=cjBL0njHm+8zUypttYPB1lyQmH9E2S3jK9rf/cmZXEh6EGhIdRL9gIUk/vQojZYKYn
         IihVstLnA999VhtdeYb2+OGsEINb8d80uZmj0iYuYKmjzqdzEUI76X8MpUdm0QgCwDJk
         oPFPSJ3Z+Ng/XKbFdKJfbc2uQyDB1AM3XB46PycPUVTODJj7MfvUhH1c9SOBH6hy3fN7
         +MmI5yEbIvmoO31Bcs6jUoukXNaA5DDoZecxGw2h+gJmXdQsHQE99QS9XqsD892baliJ
         wjhdtIqH6uXDr1VRf4Cpg35fClhascX89HcZ86PTKJaI3hQP1+2H5OmowlFkWHmQUA8X
         0uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gd9BXK6Qogm8GWzcEx/RRuoN03o4stNhU2BMPs3db+g=;
        b=k6AlXDfwX5fMKXtzLKhXLkC6zGa92aP7CjRw0oLpD5Aoj3mygmJJ5g/Ieb05ukTRoC
         Z7Ph/rrUsB5UA3wdYzHhwFT4Dpc5M2ixC3pzQGgbGTln4hwu1txgXYvOlOqVceJvNbh+
         NsbmTVRlrIkhm9yLOKs4gzT436g9LUPgX3Tw5W31Buw0rLm6JOuPE6rRiK04JVHZ3Kox
         eNdQuj2kS+sV61XMo0F4DNL+JdS9amvmHrk/VNtpTFUPUT2ff4rA5u1J+9c1vWT+DjZt
         HlbftlvWpqtMqv6ACDsx6veSI6kJFPG9TMYLxUsAswn7Ad8XXrX3SDJtzAhcTi85I6W5
         tF6A==
X-Gm-Message-State: AOAM5317QcgDcfPsxlnAAhwFc03pvlm6yw+gv3RJ0vQ5+pc/o0q2qRDa
        WxPzywYYO+7+w4bj/lq+wxuNuA==
X-Google-Smtp-Source: ABdhPJxmaXOIQxSeBKkx6n6E73BxPgRUl72SH7IqG1Psmqep24Gl/+025pnEfhuIqXdYNK3DnALwOg==
X-Received: by 2002:a17:90a:e10:: with SMTP id v16mr3235865pje.84.1600771699965;
        Tue, 22 Sep 2020 03:48:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-5-90.hsd1.ca.comcast.net. [73.231.5.90])
        by smtp.gmail.com with ESMTPSA id kk17sm1958427pjb.31.2020.09.22.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:48:19 -0700 (PDT)
From:   Daniel Rosenberg <drosen@android.com>
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
        kernel-team@android.com, Daniel Rosenberg <drosen@android.com>
Subject: [PATCH 0/5] Add support for Encryption and Casefolding in F2FS
Date:   Tue, 22 Sep 2020 03:48:02 -0700
Message-Id: <20200922104807.912914-1-drosen@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These patches are on top of the f2fs dev branch

F2FS currently supports casefolding and encryption, but not at
the same time. These patches aim to rectify that. In a later follow up,
this will be added for Ext4 as well. I've included one ext4 patch from
the previous set since it isn't in the f2fs branch, but is needed for the
fscrypt changes.

The f2fs-tools changes have already been applied.

Since both fscrypt and casefolding require their own dentry operations,
I've moved the responsibility of setting the dentry operations from fscrypt
to the filesystems and provided helper functions that should work for most
cases.

These are a follow-up to the previously sent patch set
"[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"

Daniel Rosenberg (5):
  ext4: Use generic casefolding support
  fscrypt: Export fscrypt_d_revalidate
  libfs: Add generic function for setting dentry_ops
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption

 fs/crypto/fname.c       |  7 ++---
 fs/crypto/hooks.c       |  1 -
 fs/ext4/dir.c           | 67 -----------------------------------------
 fs/ext4/ext4.h          | 16 ----------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 21 ++++++-------
 fs/ext4/super.c         | 15 +++------
 fs/f2fs/dir.c           | 64 ++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h          | 11 +++----
 fs/f2fs/hash.c          | 11 ++++++-
 fs/f2fs/namei.c         |  1 +
 fs/f2fs/recovery.c      | 12 +++++++-
 fs/f2fs/super.c         |  7 -----
 fs/libfs.c              | 49 ++++++++++++++++++++++++++++++
 fs/ubifs/dir.c          |  1 +
 include/linux/fs.h      |  1 +
 include/linux/fscrypt.h |  6 ++--
 17 files changed, 148 insertions(+), 144 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog


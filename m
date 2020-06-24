Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75218206B33
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 06:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgFXEd6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jun 2020 00:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgFXEd5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jun 2020 00:33:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3309C061796
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 21:33:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so973828ybg.21
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VIhRPUc686EfpzyL1ZkpMu0h/tTzQnqLcgbnZ2tSukA=;
        b=ATg4ot7iQfZhD7VJCToYCJEq0+HHgex7Fu5otS5NIVKN8IP1NunyBFhinY6vJQmpWp
         4Ij36w/kSxOzIDs1lg4m4ranBcUkYgjgGqDBqZtXEgUF/A6viuow4yzNYWkxxGRvlpWC
         mmIuA8xMCysfmJgO6z/8XuIDppG81o+uGO/b1g0+chDgAnIrr/7wD3ZVV8Vz040+E4+Z
         OdVyjEqMLwNTcMPpg5aX3GyMmWgYDsyC79JWjtqgCg9JBAfM0b3dFkEJ4zIsj8DZBgV0
         XSQbXGyBLB4NyxkGBW2KMLsu3Za4MN22eTnqS9Z/oFfinJGodSjpc65NAWPD+W0KoXtQ
         L6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VIhRPUc686EfpzyL1ZkpMu0h/tTzQnqLcgbnZ2tSukA=;
        b=iQyT8tc9Ok7ZcJ2ZeQKcXYG/GpXN54Ukf3VWbGJ4xuiSXiKwqN8tLkWWZyG92hbt8h
         HfxJARCUAHR5damjl+nkc+WfeMzju2GgByfHiIaRITJdJvw/9+2WFxrTR29O9SIC4hV0
         +Wtp7/1txGvnQTDix8+u1dWKiZHApnDNH2k/VVtzXrqNHrgCDoWnFerX17kRPzgTAjAG
         QVhvknietqNt87v3XLJTRG+QLBYwXwi2R98566Xjf3Kgi3ZKrkBYDKfgIWOnpz8eUQkb
         pTTKf9Ne4D4wV8f5yVOqnmqCQmreLMXIXGpXYaM/GgNrjBltNOCnqjzYbzSPsBy8TxuC
         dEqg==
X-Gm-Message-State: AOAM532W4zs5ANlIVMYDgVVv1nKk73dvuwWHY81TeSqZ20CRqjzfOvmf
        og3/MdPeYRQ+U/0hPZpeStbPI+12cW0=
X-Google-Smtp-Source: ABdhPJzqZudoyjfwmOnuXUVebSWSY1PkS5+3B30QL46yfijJWtmCuoeOhxK7BwlRH7FbBAlVw+Pj75yPbZ4=
X-Received: by 2002:a25:b8b:: with SMTP id 133mr42829755ybl.373.1592973235828;
 Tue, 23 Jun 2020 21:33:55 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:33:37 -0700
Message-Id: <20200624043341.33364-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v9 0/4] Prepare for upcoming Casefolding/Encryption patches
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
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
functionality. These unify the highly similar dentry_operations that ext4
and f2fs both use for casefolding.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           |  64 +------------------------
 fs/ext4/ext4.h          |  12 -----
 fs/ext4/hash.c          |   2 +-
 fs/ext4/namei.c         |  20 ++++----
 fs/ext4/super.c         |  12 ++---
 fs/f2fs/dir.c           |  84 ++++-----------------------------
 fs/f2fs/f2fs.h          |   4 --
 fs/f2fs/super.c         |  10 ++--
 fs/f2fs/sysfs.c         |  10 ++--
 fs/libfs.c              | 101 ++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  |  23 ++++++++-
 include/linux/f2fs_fs.h |   3 --
 include/linux/fs.h      |  22 +++++++++
 include/linux/unicode.h |   3 ++
 14 files changed, 186 insertions(+), 184 deletions(-)

-- 
2.27.0.111.gc72c7da667-goog


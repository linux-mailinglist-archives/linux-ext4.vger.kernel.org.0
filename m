Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E12B287
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 09:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfL0IFb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 03:05:31 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45556 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IFb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 03:05:31 -0500
Received: by mail-pl1-f174.google.com with SMTP id b22so11440504pls.12
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+8HU0nkRmpEaPHE32oGDcSZ6v+oNOkTh8gV+47zziqs=;
        b=cdSA+e2HmjuYcQYYb3synt4ShMzHTqgEapxrcY3Bp7mWRtpViH22l5hkQ6trISa8MU
         SZMxtheUlQeFteRsV4ZYu+WhGGYiusxQFlHhofWUsD8vpo7HriZy/6HXOKjXFUiYVzt7
         GDmOP5cKCw5f6uOA+UiDv6RmkrPhTHjYdY4+NJOqm64LX4SnCbWvtcsJzlthK1u7GG6V
         h/HrNXJKekg6FZMM4GXGz6USmrQb+pzdwTr+M6NXJ/pRm3CKkOPoVYDIW+8tFlfyzjN0
         NXRofrJAdzFgskcjUYezGqKIlwQ7hoCfo7FYAuYW8tbgnEOxnR1ck3d2ViITFIl/rAWn
         iW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+8HU0nkRmpEaPHE32oGDcSZ6v+oNOkTh8gV+47zziqs=;
        b=bWlM1rYF8SJl1rPVP0UMB8psgtPCvHr/RUNe9yzK504cWRajilfNRr5qIZB3r9d7P0
         6oEfEmpItgbQWlC1Pd2Riv85kExQ6q5DkFYpjgDYJPs83lwz29hAR8xr69ekTlQ0AXvM
         PyvsukolvDKYRg05686AwRz9tkC2ruxGfCKuIe4tohr6ojvmoDI2avy/FCWSMnGRV3Tc
         vd+P/5tJvImWXgpdU9rEwwdHuSd+UrrW7PqzjRopDrpBIWbvkq660U7tE2RNaPimW9uT
         Gz0MX/LPjHN0gep1ZI/JCrmlrPC0Y3UfptpQ6kHkdkuu7DQsag+BLM7BoJFAEpo0RIh7
         EQLg==
X-Gm-Message-State: APjAAAW1Ml2mKQ0X/d+0BnAE64F+joAiNOJpcE5KoB4QJSg4NzQkPsmL
        mLnil3VIqRGH0Y9E3dkDxf9CLe26
X-Google-Smtp-Source: APXvYqzd1utiqIjQ7x/QXxFfEaHdVXMZDX4+QsF6fbjE7nihYhWOuQmtGl5lnux/Hgng3c/XP+aESA==
X-Received: by 2002:a17:90a:9f04:: with SMTP id n4mr24584970pjp.76.1577433930276;
        Fri, 27 Dec 2019 00:05:30 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 3sm37271702pfi.13.2019.12.27.00.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 00:05:29 -0800 (PST)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 0/3] ext4: Prevent memory reclaim from re-entering the filesystem and deadlocking
Date:   Fri, 27 Dec 2019 17:05:20 +0900
Message-Id: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.6
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series aims to prevent ext4_kvmalloc() from re-entering
the filesystem and deadlocking. Although __vmalloc() doesn't
support GFP_NOFS[1], all of the user of ext4_kvmalloc are using
GFP_NOFS (e.g. fs/ext4/resize.c::add_new_gdb), causing the memory
reclaim to re-enter the filesystem.

To fix this issue, use memalloc_nfs_save/restore() that get
__vmalloc() to drop __GFP_FS.

[1] linux-tree/Documentation/core-api/gfp-mask-fs-io.rst

Changes since v1:
  - Add Patch 1 to delete ext4_kvzvalloc() that is not used anywhere.
  - Add Patch 2 to rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and
    drop its flags argument since all the users of ext4_kvmalloc() are
    using GFP_NOFS

Thanks,


Naoto Kobayashi (3):
  ext4: Delete ext4_kvzvalloc()
  ext4: Rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and drop its
    flags argument
  ext4: Prevent ext4_kvmalloc_nofs() from re-entering the filesystem and
    deadlocking

 fs/ext4/ext4.h   |  3 +--
 fs/ext4/resize.c | 10 ++++------
 fs/ext4/super.c  | 21 +++++++--------------
 fs/ext4/xattr.c  |  2 +-
 4 files changed, 13 insertions(+), 23 deletions(-)


--
2.16.6


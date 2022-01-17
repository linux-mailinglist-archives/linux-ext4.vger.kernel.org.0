Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8E4904F7
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jan 2022 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiAQJhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jan 2022 04:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiAQJhR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jan 2022 04:37:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C31C06161C
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m21so9731747pfd.3
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvPpCs+ezXbQSTZ8OgmJhT9FWSW4EaMX0JrbDvZ8imQ=;
        b=TKIDUYPO6HG01wxRyk0XR3cvXtqwODkG7069aj4SHHe22mWRkWMnAHoIB/y5e51NWq
         j7p0X4/gs8CGTp92hagv50gQ282ej0LxH8OyDCFz49UJu5tCrQMruv6jtAlQIFpKoifZ
         QI6DXJ/qGJrtrQ0cwVB40pH2j5lrftXA91pptdLUjs4hjem9Pp28Lf6FdRcWiNpHu8dL
         AvXXG/pyVB1WEhVdsfrhIc5kmLReIv/4MBW+nXjkIxt/atIm8ZT0dtjUaNLEFQQZy3y/
         g9ydxSVpkp7mNgC/8bx5g+BM5jI+KzQsmwd/x82hcbFdFMYVqithii+N4f0otRT2pVRk
         Zh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvPpCs+ezXbQSTZ8OgmJhT9FWSW4EaMX0JrbDvZ8imQ=;
        b=aXSlUvUDfWetwtEIACKg19kVbGc7zPQoPi73HC9syR6zTIcte6sphTnS32N6z8vtik
         sjB1QJoAQg7qJ3g7abA1keuNTrDI2RUH8rIShmzwoCnkT3zJty+hO7poG1dBVyITZO9n
         AG6/6PVkRfewJgZwX6zk5sz5Wv//PRHLqCKpeBBNcthoEY+y/M5qadtAmfYqSGzWyc5v
         pWHEEoP6j/xoZEt9h5CLkjQQamnHZVwMjkrnm53Kh3nC7lYEr7Ie54e/dPiUHpJIddQb
         iRp3WJtKMc6+w8sI7O8QxjQFz12heUJWmNCE3wx6XYyqAd7sz5u/9VrE1XYjt5tA6ir/
         WZeg==
X-Gm-Message-State: AOAM533nZtjT04jW4QSXy2E58u6z2nE+Mu2qJ78nDPhN+HS0O1Y+X/dH
        rB1a0xU8w1IJNY+HEFo0OHv3Yg==
X-Google-Smtp-Source: ABdhPJyB1ZCB7BMO5GUYsfOE4FddvhQiFT/pAvQdbq3I8PHb6MsrBZW0S7ayXA6cYW2+/gLdQwk/9w==
X-Received: by 2002:a63:6ece:: with SMTP id j197mr18277481pgc.322.1642412236901;
        Mon, 17 Jan 2022 01:37:16 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z16sm11426497pgi.89.2022.01.17.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:37:16 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     dan.carpenter@oracle.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v3 0/2] ext4: fix issues when fast commit work with jbd
Date:   Mon, 17 Jan 2022 17:36:53 +0800
Message-Id: <20220117093655.35160-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When test fast commit with xfstests generic/455, some logic issues were
found. When a full commit is ongonig, the logic of fast commit tracking seems
not correct. The first patch fix the ineligible commit case , and the
second patch fix the common fast commit case.

After testing this patch set with xfstests log and quick group, no 
regressions were found, and the generic/455 can pass now.

---
v2: drop EXT4_MF_FC_COMMITTING
v3: change logic of ext4_fc_mark_ineligible() when set 'handle' as NULL.
Fix use-after-free issue for improper use of 'handle' for
ext4_fc_mark_ineligible().

Xin Yin (2):
  ext4: fast commit may not fallback for ineligible commit
  ext4: fast commit may miss file actions

 fs/ext4/ext4.h        |  8 +++-----
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/fast_commit.c | 44 ++++++++++++++++++++++++++++++-------------
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/ioctl.c       |  4 ++--
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  2 +-
 fs/ext4/xattr.c       |  6 +++---
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     |  2 +-
 include/linux/jbd2.h  |  2 +-
 11 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.25.1


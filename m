Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B834B628
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhC0Kcq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhC0Kcq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:32:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA95EC0613B1;
        Sat, 27 Mar 2021 03:32:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i19so6033404qtv.7;
        Sat, 27 Mar 2021 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7BBTPMNYUV8rOoYLCTtqBbdjG4BGaxvYP5NaWTpNz8=;
        b=XPA8bzZwEKGk2TQvx/bDBm9WO9VqXBYOY09xm3p/O1a7iyKItidfasUhHuMMiOxfCz
         M4mJ8rwuUHVDbHFxsgr4rGI2U/IpjcQ7wz0kTot/ZerejWRp+QYfD29RkXOAMWMLzSFV
         YggL7tNSJyDwp+bkjlVz3BQi+FrWruxT2NDElWNANuKguD8zbveNUdd4y+VpPxuKM/0B
         Ng314qtesztzYTmn6QqBiotHe77oE56vzQacxnnFdET1WvNU54lhqSQr9tZyILLdbdcy
         tdfFAW/Fv+9HF9gLdMfSWVyq5tNcuM7rErjehugd8GYvcCcGS3RK4k1V3yEHtrVkIlSX
         sC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7BBTPMNYUV8rOoYLCTtqBbdjG4BGaxvYP5NaWTpNz8=;
        b=nHRv5P6IOcq6/dbP1PrJJciBYIUPUPz92K8dwcaZxn1RBpBzrsJjLOeASE/7KagITq
         73yve97vnRre2PM6YQM6a2MaNnsmuncExW+iXX6jObYe2K/vJ17z5mdTEwXZzUlF3bCU
         QWJIGzbetlIjZx+Db9UU6sgR8LJwsC8+HZ5ij3paTBZe2/DGno5/WddQQocxRG8s9cpb
         ufXRMUIHGO0SyrM8okmU0vOMdbRr6uaQ6Z3QwtIfDOIM7X7kPtug8j32fga1TIkTkJw1
         PzKLxzsq+x909A/CB9vO0gVzaxOcd5OTui1WHgszmKIwmaSXNQN7P74NSA3dkgfDJZ4C
         WFeg==
X-Gm-Message-State: AOAM531I/vbcktp1qXXFEiZyG4j7nPoblTRqFhcgjVHexZJXbbB9Avvi
        awrBAAc2SqXQNvT41nOWcWCwXOJPw91E4VUn
X-Google-Smtp-Source: ABdhPJycMugdI7OSIPg9fZa89zuZn9qRV1mEfI33lMa/wvbp6c2inqO0pR18NOuBeGmPvGytTSP20Q==
X-Received: by 2002:ac8:5e0b:: with SMTP id h11mr15547648qtx.194.1616841161219;
        Sat, 27 Mar 2021 03:32:41 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:32:40 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] EXT4: Trivial typo fixes
Date:   Sat, 27 Mar 2021 16:00:04 +0530
Message-Id: <cover.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series fixed few mundane typos in the below specific files.

Bhaskar Chowdhury (8):
  EXT4: migrate.c: Fixed few typos
  EXT4: namei.c: Fixed a typo
  EXT4: inline.c: A typo fixed
  Fix a typo
  EXT4: indirect.c: A trivial typo fix
  EXT4: xattr.c: Mundane typo fix
  EXT4: fast_commit.c: A mere typo fix
  EXT4: mballoc.h: Single typo fix

 fs/ext4/fast_commit.c | 2 +-
 fs/ext4/indirect.c    | 2 +-
 fs/ext4/inline.c      | 2 +-
 fs/ext4/inode.c       | 2 +-
 fs/ext4/mballoc.h     | 2 +-
 fs/ext4/migrate.c     | 6 +++---
 fs/ext4/namei.c       | 8 ++++----
 fs/ext4/xattr.c       | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

--
2.26.2


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42982523D7D
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbiEKTcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbiEKTb7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:31:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557B69484
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:31:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C53011F42914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297515;
        bh=YVY7Dsj2P/gpMxAXakIigK52MS4RKuWy4L2G7t4v4ns=;
        h=From:To:Cc:Subject:Date:From;
        b=njLxSzNxseww7v2/JuRZpGc16AWA+FBP9wCkyyUOSmMNMH5EAmkvg2pVq1baaz/i4
         BzZJHSxMys7Yijf6wyRcfrufLRTBySTCtLvkLUEkL3HNPgMajilAFZbXJNtNfdFOc2
         zeR7IL6TBM/giBK0xABWc6iZYV9xFZJ5PEEs1SvONWnTWRxXE8GQtnlWf8wDpb3baQ
         LvfjCNYrP6Z1YmVyIKx4U6Swxt7O996r+r4BjLhvob7S3y2wiaMlrfvNpNhLfSLscg
         oTGZwYyUOhkNtPXxq5F4/eL3BUuGc0WIGQ78zXoP2kBz9U1DRDLFEoYICL+n9oFHuW
         tzlGv3g9l+B1w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 00/10] Clean up the case-insensitive lookup path
Date:   Wed, 11 May 2022 15:31:36 -0400
Message-Id: <20220511193146.27526-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.  It also reduces the clutter from many
codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
the codeflow now.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. Therefore, it also
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (10):
  ext4: Match the f2fs ci_compare implementation
  ext4: Simplify the handling of cached insensitive names
  f2fs: Simplify the handling of cached insensitive names
  ext4: Implement ci comparison using unicode_name
  ext4: Simplify hash check on ext4_match
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move ext4_match_ci into libfs
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/ext4.h     |  41 +++++++--------
 fs/ext4/namei.c    | 126 ++++++++++++++-------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 103 ++++++++++++------------------------
 fs/f2fs/f2fs.h     |   3 +-
 fs/f2fs/namei.c    |  12 ++---
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |  22 ++++----
 fs/libfs.c         |  61 ++++++++++++++++++++++
 include/linux/fs.h |   8 +++
 10 files changed, 185 insertions(+), 200 deletions(-)

-- 
2.36.1


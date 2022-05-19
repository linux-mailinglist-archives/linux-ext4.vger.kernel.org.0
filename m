Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3352DF2E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiESVYH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiESVYG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 17:24:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806AED787
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:24:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 880C01F45EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652995444;
        bh=xCVBbVqmp/7jdLxAOUghr2fFaWRVCwCpo6pL22/iD0s=;
        h=From:To:Cc:Subject:Date:From;
        b=VHzlb5p5uTnIJL9Fs9GAtX9nIvNF1bAC5lywlDj7RP7kYwQQG7YI+TSyIJExeaqjR
         nNC3SBrlIOSLYpznDuIfg7ULqavjlBfshG0DGu+P5L7M71Ksn8Gh8GIvRGGOmKx2Pa
         hU2M7T8jrNzXh020lHr2Uak9srNi+0Dn6CLDNexowOV2yK+0H4vLCFlhglSj0iqtyg
         tPEwsTkigWYsKGPM+LORkOCQ8Vm3hzEBOCvjLlV+8+AUU3vpnVUH6ZvZAMyWEjUi0F
         /BNAvVj7a9lQQZBhtYPEJiAlooJXOVxcxKtfAEUtrujgphiz6M4/SiBV9WCtTOyIL2
         BwSXjXMdvxkGw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 0/8] Clean up the case-insensitive lookup path
Date:   Thu, 19 May 2022 17:23:51 -0400
Message-Id: <20220519212359.19442-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric, Ted,

This is v7 of this series (thank you for the feedback!) .  This picks up
a few r-b tags and has one small fix asked by Eric to handle a corner
case in ext4_match when IS_ENCRYPTED() and the key is added during
lookup.

* Original commit letter

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

Gabriel Krisman Bertazi (8):
  ext4: Simplify the handling of cached insensitive names
  f2fs: Simplify the handling of cached insensitive names
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/ext4.h     |  49 +++++++++--------
 fs/ext4/namei.c    | 130 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 103 +++++++++++------------------------
 fs/f2fs/f2fs.h     |  15 +++++-
 fs/f2fs/namei.c    |  11 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  68 ++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 10 files changed, 197 insertions(+), 200 deletions(-)

-- 
2.36.1


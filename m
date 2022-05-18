Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109F152C151
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiERRXd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiERRXa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 13:23:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2E15E60C
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 10:23:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 706011F45484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652894607;
        bh=YLLmZUREElcB6QXqzHwxccTA7cTmLYu0yInBvss0WkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=WOXfJn4PkYBihSyvj9xRRBbIUqflUqURpDvMNzL1NpoAv8ARdyeCzXONlYxPWfdEk
         jGDIBVed5WmJouN2faiePxKQ0QKEN0XjjQIfsivcF78YG/93Ruli4wWEZv6LLMIz5M
         WtHNWTkK17UYC6gBqKQHOF7DtTHGqNmaLPSjHRsBFlq7N616aEjbSDrBS//YcxnCSX
         Ddib/YxbcqexCqRdVtdd2++o8q76MVLExhKFv9u8q8+dA4Q9mauFS36QHQBzl6ZmKw
         eOqnHqpnC7PyWP3RCDVUH0J2mZlXMXDhB5JTb0JGHxYMD9RDPk+XFdzibv8ljArcab
         QZe+0zUbWu3dw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 0/8] Clean up the case-insensitive lookup path
Date:   Wed, 18 May 2022 13:23:12 -0400
Message-Id: <20220518172320.333617-1-krisman@collabora.com>
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

This reworks the entire series to apply Eric's comments.  Thank you for
the feedback, Eric!

The biggest change is the removal of unicode_name and the split of the
libfs patch.  It made the series much better to follow.  I also dropped
the hash patch, but there is still a minor cleanup on that code flow in
patch 4 ("ext4: Reuse generic_ci_match for ci comparisons").  I'd
appreciate your review there regarding fscrypt semantics.

This survives the quick group and generic/556 (casefold) tests.

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

 fs/ext4/ext4.h     |  39 ++++++++-------
 fs/ext4/namei.c    | 120 ++++++++++++++-------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 103 ++++++++++++--------------------------
 fs/f2fs/f2fs.h     |  15 +++++-
 fs/f2fs/namei.c    |  11 ++---
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  65 ++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 10 files changed, 181 insertions(+), 193 deletions(-)

-- 
2.36.1


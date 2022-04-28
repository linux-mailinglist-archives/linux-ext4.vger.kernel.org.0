Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CE513E56
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352788AbiD1WOB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352812AbiD1WN5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 18:13:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70A5B3D7
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 15:10:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F32B91F4247A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651183840;
        bh=bcfClgonf+RR4NyaZu4xkE6VsQ2rDh7rY79Hk2fkr/0=;
        h=From:To:Cc:Subject:Date:From;
        b=n6W+0k1R5Hnp5cLFsP8gLdcYlA2KDLKx12h/b1DC2byjWE3xs7D8z1Y5f9bYLlQxA
         6ejaZiPS6Idg8XOKU+bX8ZnlFB7KeW5vTK5tZyqoIa6L9khwCwC62OYQia7VVHT7ak
         JpfJFecAaLc4QnIncRvaGmyRbOn9YoxS6i7Ri99GO2aTgStTeHKxGXT1zXd+6AuMA0
         f1QZJ2aQ0lgcAHhM4fXFselCaI2h0qlzpO8JD2kGjv/JNnw8RaPBStiZ74jkJ5k/hu
         ijQc1Qrvw3ZbPGh/SUODOxLDc9Rme8ZYdBmn2ta63HXnob4d9eZSRFcrw1SWP8qw+9
         95dcCFsUrplQw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/7] Clean up the case-insenstive lookup path
Date:   Thu, 28 Apr 2022 18:10:20 -0400
Message-Id: <20220428221027.269084-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is the v2 of this series.  it applies Eric's comments and extend
the series to complete the merge of generic_ci_match for ext4 and f2fs.

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. The final patch
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (7):
  ext4: Match the f2fs ci_compare implementation
  ext4: Simplify the handling of cached insensitive names
  ext4: Implement ci comparison using unicode_name
  ext4: Simplify hash check on ext4_match
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move ext4_match_ci into libfs
  f2fs: Reuse generic_ci_match for ci comparisons

 fs/ext4/ext4.h     |   2 +-
 fs/ext4/namei.c    | 110 ++++++++++++++-------------------------------
 fs/f2fs/dir.c      |  58 ++----------------------
 fs/libfs.c         |  60 +++++++++++++++++++++++++
 include/linux/fs.h |   8 ++++
 5 files changed, 106 insertions(+), 132 deletions(-)

-- 
2.35.1


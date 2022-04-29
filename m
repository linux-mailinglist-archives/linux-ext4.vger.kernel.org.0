Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADC51539A
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiD2Sa6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Apr 2022 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379861AbiD2Saz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Apr 2022 14:30:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42747C74BA
        for <linux-ext4@vger.kernel.org>; Fri, 29 Apr 2022 11:27:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B275E1F4690E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651256855;
        bh=BennjuHd6cboenERnfAOrIYnBLd5KMc0poz3LPBQ9hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=M07arppDaVxsrRh+13BjTik245FkbwpbvYdveXca5NR7rll6mK85puUsuqYBuNxTv
         36b62YjR79DPSKBsaxSw3fbsOmAWdRHs7MNP5CBjXm9BI9rQTgS+EcoirCv4kSeADT
         hswVnZUTnj03JstDOzUm+mjFs/PoBFo1j5zwj4JgpBqKYIGgzUIKXuZJwaIHvDDp8B
         /zOaoshm4KeWVBUKmmHtQ6teirk1YScRsVR4unylK+XeWFUhn7d15PmPfkrzmKXVLn
         9ZBuKdx6jGfrh7lopvDdU0jaGPU9VJ0YHSM/6ZemSOIA6nq5oJJ032VBYVnZw66U8o
         KGNPWpAV/1i+A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/7] Clean up the case-insenstive lookup path
Date:   Fri, 29 Apr 2022 14:27:21 -0400
Message-Id: <20220429182728.14008-1-krisman@collabora.com>
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

This is the v3 of this series.  It fixes a build error when building
filesystems as a module on the previous series.

* v2

This is the v2 of this series.  it applies Eric's comments and extend
the series to complete the merge of generic_ci_match for ext4 and f2fs.

* Original cover letter

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
 fs/libfs.c         |  61 +++++++++++++++++++++++++
 include/linux/fs.h |   8 ++++
 5 files changed, 107 insertions(+), 132 deletions(-)

-- 
2.35.1


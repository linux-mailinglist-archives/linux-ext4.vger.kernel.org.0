Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691F5B7D9A
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIMXmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIMXmC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 19:42:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7A3E775
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 16:42:01 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CB626601FB9;
        Wed, 14 Sep 2022 00:41:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663112519;
        bh=NkYVyeuwI/2gBd1BQe2j2SOPCFHneHhCTKmec17TYMo=;
        h=From:To:Cc:Subject:Date:From;
        b=g+iniuRQu5VXHNund2XMCfZ2vMLAqfVZ2Ls+dexJ2CwAzNMjXu9EGk/8Y5+Rv7AQn
         fKCXKFPH4GMCEAAZkAHBvXZScoOdOyCn2/OBA4kMC/GrSxAJOnIJUekA5DWpb5HAlY
         xRbStlOQPcULVG8KAtl8oi5mLlGNN1/VBwI7NedFrgdjKlngOD1tg+qEHGCymSAEyp
         1HDjulkiZ7a2G5dqyvpmmbIEgFeCj8rQ/Y5CDW2ybqFbfQ6qtu+qCEefk/CRWsiwWd
         HaSMRO02UFmpahzjKOuvbriBn+tmdIYuKcxIo78Leck8iROr9PaJUUFN6+LesOyF4w
         ZqLedh7gaqocg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v9 0/8] Clean up the case-insensitive lookup path
Date:   Tue, 13 Sep 2022 19:41:42 -0400
Message-Id: <20220913234150.513075-1-krisman@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I'm resubmitting this as v9 since I think it has fallen through the
cracks :).  It is a collection of trivial fixes for casefold support on
ext4/f2fs. More details below.

It has been sitting on the list for a while and most of it is r-b
already. I'm keeping the tags for this submission, since there is no
modifications from previous submissions, apart from a minor conflict
resolution when merging to linus/master.

Thanks,

v8: https://patchwork.ozlabs.org/project/linux-ext4/cover/20220519212359.19442-1-krisman@collabora.com/

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

 fs/ext4/crypto.c   |  15 ++----
 fs/ext4/ext4.h     |  34 +++++++-----
 fs/ext4/namei.c    | 130 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 +++++++++++-------------------------
 fs/f2fs/f2fs.h     |  15 +++++-
 fs/f2fs/namei.c    |  11 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  68 ++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 198 insertions(+), 201 deletions(-)

-- 
2.37.3


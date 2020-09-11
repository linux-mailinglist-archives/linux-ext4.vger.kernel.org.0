Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A792669F1
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgIKVQV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgIKVQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Sep 2020 17:16:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B10C061573
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 14:16:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so2277789pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/X+ANG38zyPMDGtnc7V92C6hGkNE1nXSr2kA7wsuH6c=;
        b=RqJXE/3F6TAJjIECOp+Y46vj8oFDEMbRhpYmRpm3uSvvqmMSuEwYWlydajFz5vquR2
         pbGoCoYTe1i63TuYqTt09g+aOCC6jIfBXceX7/CWHTvFod9dTQYFas2Du+5bp+1fdHHD
         x+FqaYUS35seoARbxbpUMu+ck3o23evI/eV2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/X+ANG38zyPMDGtnc7V92C6hGkNE1nXSr2kA7wsuH6c=;
        b=K+Vv36pUWI+ccf54S1/huGUlfdQVHNyRK3v7EnsAbU555A6ARBUcqwJG9Ckj7mUja/
         dYW3m+s5avXBCLyM7xlLwM1XpxIROxpkIy50ls0Ys7aGozukvnLcUjAfFwVExCuG62RY
         MAp56mclmjRhLQ2tRUT+PmTDqKBJaxq66KhTGFIFLfzAfVROKVC1seXBCc6SJx/62nj+
         /paNueKHtDby8DwCqJ6TvjZ9XiXnkuJHDtptR6IutWB8mfrljeaAIJ3M/V5RWa0Rgs0m
         +tiDRmbFFPR6Y9bfc+0RcbgjS0DpbcCgw31dsDdNfMvbQBLdgNbUQeRJpITwc3fLAKXE
         hGfw==
X-Gm-Message-State: AOAM5300+JofuKPRmV2NubM23LAuxP3tIxGI0d1zyZ3TbILCnpGJSnph
        hEfpPMQ1TOpvaWLMlX4FlfGdg4z8XjH/OeBNNs8TSrtYLEcppATVp+McwscN1HnrXUoJwksBX0B
        Zaz7w6IPChYJYdhiZyaB7MLlD+7Bu8rXJ3kgDzriy/CcglhHPJjRCOU0ZNE8jVGShuubCaaS2dV
        Bde7o02Q==
X-Google-Smtp-Source: ABdhPJzOjrPKV1AYWeb9Mi28GGQZRmb2KCYM3QNHQkZOljTPI/bQgQLFRVGOLMrRdMIZpD5ARMXKTg==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr3998643pjt.68.1599858978089;
        Fri, 11 Sep 2020 14:16:18 -0700 (PDT)
Received: from dev-costa.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id c24sm3173379pfd.24.2020.09.11.14.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:16:17 -0700 (PDT)
From:   Constantine Sapuntzakis <costa@purestorage.com>
To:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Constantine Sapuntzakis <costa@purestorage.com>
Subject: [PATCH] ext4: Fix superblock checksum calculation race
Date:   Fri, 11 Sep 2020 15:16:03 -0600
Message-Id: <20200911211603.5653-1-costa@purestorage.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The race condition could cause the persisted superblock checksum
to not match the contents of the superblock, causing the
superblock to be considered corrupt.

An example of the race follows.  A first thread is interrupted in the
middle of a checksum calculation. Then, another thread changes the
superblock, calculates a new checksum, and sets it. Then, the first
thread resumes and sets the checksum based on the older superblock.

To fix, serialize the superblock checksum calculation using the buffer
header lock. While a spinlock is sufficient, the buffer header is
already there and there is precedent for locking it (e.g. in
ext4_commit_super).

Tested the patch by booting up a kernel with the patch, creating
a filesystem and some files (including some orphans), and then
unmounting and remounting the file system.

Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..3f7fdce5ab05 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -201,7 +201,18 @@ void ext4_superblock_csum_set(struct super_block *sb)
 	if (!ext4_has_metadata_csum(sb))
 		return;
 
+	/*
+	 * Locking the superblock prevents the scenario
+	 * where:
+	 *  1) a first thread pauses during checksum calculation.
+	 *  2) a second thread updates the superblock, recalculates
+	 *     the checksum, and updates s_checksum
+	 *  3) the first thread resumes and finishes its checksum calculation
+	 *     and updates s_checksum with a potentially stale or torn value.
+	 */
+	lock_buffer(EXT4_SB(sb)->s_sbh);
 	es->s_checksum = ext4_superblock_csum(sb, es);
+	unlock_buffer(EXT4_SB(sb)->s_sbh);
 }
 
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
-- 
2.17.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22C269126
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgINQLi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgINQKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Sep 2020 12:10:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD4C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 09:10:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so184510pgb.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IRsgGa1G98lqotgMC8zH12tt2GmtFhgxtnSUD+dw6j8=;
        b=Nnuip7KwhUJExh+T9RfI0G1OuU0eeP2U+tX6faI9gnHdTta6iuRwqwbS2u9NfyLvQb
         6PL9vA2Gn67Q7YV4ylRjegZQrm1TzGGXh+3LD3eM6pc2woGteNHJY87r3RfuMwKYykKl
         HJkLzjdKXAmfstnWdvSSbcPwkOBPHiR5C96Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IRsgGa1G98lqotgMC8zH12tt2GmtFhgxtnSUD+dw6j8=;
        b=ORGrub6VyaN4CMcpTAqB7iSJ/lhRdHQPUzVIfe9G4gvXM+PeD2yeg5AHW6d7ZoiT9t
         HNLSO2ZPN99uQe5lRjrJcj+wOPca0bBk5n4S0yr9lWBwEX8wbMy0OPL+nGZM98KX4TAY
         D6il4tiYX9gLsFT+ymN5+ghe5VaZOkIYcFzKz94Y2G9zO0IKijVhBFv0tF3A+mQvlGMc
         P/4cYLAFZT+eYyS0jNb3Re0ACVzmOXfynnqIQzFlFa0HtiQ5K2yKfHUQ4k6I+4oc3n18
         VdGVNzEXlqFCnJJngzveffdgHf8H+4cjGHi0UoDz/Qm/jJs995IOiSj/YeGon6dsa7uw
         0Avg==
X-Gm-Message-State: AOAM531OnAPq14RF2X3RFrb3LYm0KrtYfGR6/t/Gikj49xzPBOztZrql
        k5CB5+YJEa3IZdIeYqxmEUWQ/w==
X-Google-Smtp-Source: ABdhPJxa3vSmp27KG9oCF2+jY9yrElTsLgCHZulslxN5vFuafmn948FOW9Z9PxCo2NjV3NpbMxJLmg==
X-Received: by 2002:a63:5fc3:: with SMTP id t186mr11214909pgb.100.1600099848545;
        Mon, 14 Sep 2020 09:10:48 -0700 (PDT)
Received: from dev-costa.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id cf7sm9909834pjb.52.2020.09.14.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 09:10:47 -0700 (PDT)
From:   Constantine Sapuntzakis <costa@purestorage.com>
To:     jack@suse.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Cc:     Constantine Sapuntzakis <costa@purestorage.com>
Subject: [PATCH] ext4: Fix superblock checksum calculation race
Date:   Mon, 14 Sep 2020 10:10:14 -0600
Message-Id: <20200914161014.22275-1-costa@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914085427.GC4863@quack2.suse.cz>
References: <20200914085427.GC4863@quack2.suse.cz>
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

Signed-off-by: Constantine Sapuntzakis <costa@purestorage.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


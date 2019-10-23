Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B43DE0FAF
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 03:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfJWBbW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Oct 2019 21:31:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56271 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730047AbfJWBbW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Oct 2019 21:31:22 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9N1VHwh025989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 21:31:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6E0D8420456; Tue, 22 Oct 2019 21:31:17 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH] ext4: fix signed vs unsigned comparison in ext4_valid_extent()
Date:   Tue, 22 Oct 2019 21:31:12 -0400
Message-Id: <20191023013112.18809-1-tytso@mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Due to a signed vs unsigned comparison, an invalid extent where
ee_block (the logical block) is so large that lblk + len overflow
wasn't getting flagged as invalid.

As a result, we tripped the BUG_ON(end < lblk) in
ext4_es_cache_extent() when trying to mount a file system with a
corrupted journal inode was corrupted.

https://bugzilla.kernel.org/show_bug.cgi?id=205197

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fb0f99dc8c22..d12bc287abdc 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -367,7 +367,7 @@ ext4_ext_max_entries(struct inode *inode, int depth)
 static int ext4_valid_extent(struct inode *inode, struct ext4_extent *ext)
 {
 	ext4_fsblk_t block = ext4_ext_pblock(ext);
-	int len = ext4_ext_get_actual_len(ext);
+	unsigned int len = ext4_ext_get_actual_len(ext);
 	ext4_lblk_t lblock = le32_to_cpu(ext->ee_block);
 
 	/*
-- 
2.23.0


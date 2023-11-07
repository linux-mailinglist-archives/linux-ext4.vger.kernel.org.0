Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2897E381D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Nov 2023 10:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjKGJtj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Nov 2023 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjKGJtj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Nov 2023 04:49:39 -0500
Received: from sirokuusama2.dnainternet.net (sirokuusama2.dnainternet.net [83.102.40.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E610A
        for <linux-ext4@vger.kernel.org>; Tue,  7 Nov 2023 01:49:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sirokuusama2.dnainternet.net (Postfix) with ESMTP id 128C3BF47;
        Tue,  7 Nov 2023 11:49:33 +0200 (EET)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.251
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Authentication-Results: sirokuusama2.dnainternet.net (DNA Internet);
        dkim=pass (1024-bit key) header.d=anssih.iki.fi
Received: from sirokuusama2.dnainternet.net ([83.102.40.153])
        by localhost (sirokuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id iw5ov505clzu; Tue,  7 Nov 2023 11:49:32 +0200 (EET)
Received: from omenapuu2.dnainternet.net (omenapuu2.dnainternet.net [83.102.40.54])
        by sirokuusama2.dnainternet.net (Postfix) with ESMTP id CFAE2AB71;
        Tue,  7 Nov 2023 11:49:32 +0200 (EET)
Received: from mail.onse.fi (87-95-225-209.bb.dnainternet.fi [87.95.225.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by omenapuu2.dnainternet.net (Postfix) with ESMTPS id 8A545222;
        Tue,  7 Nov 2023 11:49:30 +0200 (EET)
Received: by mail.onse.fi (Postfix, from userid 1000)
        id 2B0A432049F; Tue,  7 Nov 2023 11:49:30 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.onse.fi 2B0A432049F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anssih.iki.fi;
        s=default; t=1699350570;
        bh=W/vZ18m97bXygpP2gazTOAZ4aww/lTRBr2mYcFSTp10=;
        h=From:To:Subject:From;
        b=ThUh1GgK9uLvVBMiurbsA1CNUUwnBnbWyxREeKMy5mZ62LFX83a1+TkNccuaCqDaW
         kSlU4dj28zjclHIsFIhFRYGqNSpfLMaZ8miLKPtUYaNGc50HyRYWURXr2Gc0JERk9K
         icik9dXzFzeto5rU1f0hXtjRLyxfPnswK1mHg98Y=
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH e2fsprogs] resize2fs: avoid constantly flushing while moving blocks
Date:   Tue,  7 Nov 2023 11:46:53 +0200
Message-ID: <20231107094920.4056281-1-anssi.hannula@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

resize2fs block_mover() flushes data after each extent and, curiously,
only if progress indicator is enabled, every inode_blocks_per_group
blocks.

This significantly affects performance, e.g. on a tested large
filesystem on top of MD-RAID6+LVM+dm-crypt these flush calls reduce the
operation rate from approx. 500MB/s to 5MB/s, causing extremely long
shrinking times for large size deltas (70TB in my case).

Since this step performs just plain data copying and does not e.g. save
any progress/checkpoint information or similar metadata, it seems like
this flushing is of very limited usefulness, especially when considering
the (in some cases) 100x performance impact.

Remove the mid-operation flushes and only flush after all blocks have
been moved.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 resize/resize2fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 5eeb7d44..46540501 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -1863,7 +1863,6 @@ static errcode_t block_mover(ext2_resize_t rfs)
 			old_blk += c;
 			moved += c;
 			if (rfs->progress) {
-				io_channel_flush(fs->io);
 				retval = (rfs->progress)(rfs,
 						E2_RSZ_BLOCK_RELOC_PASS,
 						moved, to_move);
@@ -1871,9 +1870,10 @@ static errcode_t block_mover(ext2_resize_t rfs)
 					goto errout;
 			}
 		} while (size > 0);
-		io_channel_flush(fs->io);
 	}
 
+	io_channel_flush(fs->io);
+
 errout:
 	if (badblock_list) {
 		if (!retval && bb_modified)
-- 
2.41.0


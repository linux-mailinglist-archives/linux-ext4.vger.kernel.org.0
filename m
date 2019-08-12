Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6169E8A4E0
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHLRuJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 13:50:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46043 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbfHLRuJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 13:50:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CHj8dt019363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 13:45:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE2394218EF; Mon, 12 Aug 2019 13:45:07 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: drop legacy pre-1970 encoding workaround
Date:   Mon, 12 Aug 2019 13:45:05 -0400
Message-Id: <20190812174505.8384-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Originally, support for expanded timestamps had a bug in that pre-1970
times were erroneously encoded as being in the the 24th century.  This
was fixed in commit a4dad1ae24f8 ("ext4: Fix handling of extended
tv_sec") which landed in 4.4.  Starting with 4.4, pre-1970 timestamps
were correctly encoded, but for backwards compatibility those
incorrectly encoded timestamps were mapped back to the pre-1970 dates.

Given that backwards compatibility workaround has been around for 4
years, and given that running e2fsck from e2fsprogs 1.43.2 and later
will offer to fix these timestamps (which has been released for 3
years), it's past time to drop the legacy workaround from the kernel.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e2d8ad27f4d1..17cc2dc13174 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -828,21 +828,8 @@ static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
 static inline void ext4_decode_extra_time(struct timespec64 *time,
 					  __le32 extra)
 {
-	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK))) {
-
-#if 1
-		/* Handle legacy encoding of pre-1970 dates with epoch
-		 * bits 1,1. (This backwards compatibility may be removed
-		 * at the discretion of the ext4 developers.)
-		 */
-		u64 extra_bits = le32_to_cpu(extra) & EXT4_EPOCH_MASK;
-		if (extra_bits == 3 && ((time->tv_sec) & 0x80000000) != 0)
-			extra_bits = 0;
-		time->tv_sec += extra_bits << 32;
-#else
+	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK)))
 		time->tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
-#endif
-	}
 	time->tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
 }
 
-- 
2.22.0


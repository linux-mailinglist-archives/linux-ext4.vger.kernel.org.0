Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90483193276
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYVSY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 21D5C28666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 01/11] tune2fs: Allow enabling casefold feature after fs creation
Date:   Wed, 25 Mar 2020 17:18:01 -0400
Message-Id: <20200325211812.2971787-2-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The main reason we didn't allow this before was because !CASEFOLDED
directories were expected to be normalized().  Since this is no longer
the case, and as long as the encrypt feature is not enabled, it should
be safe to enable this feature.

Disabling the feature is trickier, since we need to make sure there are
no existing +F directories in the filesystem.  Leave that for a future
patch.

Also, enabling strict mode requires some filesystem-wide verification,
so ignore that for now.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 misc/tune2fs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index a0448f63d1d5..656389c61281 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -161,7 +161,8 @@ static __u32 ok_features[3] = {
 		EXT4_FEATURE_INCOMPAT_64BIT |
 		EXT4_FEATURE_INCOMPAT_ENCRYPT |
 		EXT4_FEATURE_INCOMPAT_CSUM_SEED |
-		EXT4_FEATURE_INCOMPAT_LARGEDIR,
+		EXT4_FEATURE_INCOMPAT_LARGEDIR |
+		EXT4_FEATURE_INCOMPAT_CASEFOLD,
 	/* R/O compat */
 	EXT2_FEATURE_RO_COMPAT_LARGE_FILE |
 		EXT4_FEATURE_RO_COMPAT_HUGE_FILE|
@@ -1462,6 +1463,19 @@ mmp_error:
 		}
 	}
 
+	if (FEATURE_ON(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
+		if (ext2fs_has_feature_encrypt(sb)) {
+			fputs(_("Cannot enable casefold feature on filesystems "
+				"with the encrypt feature enabled.\n"),
+			      stderr);
+			return 1;
+		}
+
+		sb->s_encoding = EXT4_ENC_UTF8_12_1;
+		sb->s_encoding_flags = e2p_get_encoding_flags(sb->s_encoding);
+	}
+
+
 	if (sb->s_rev_level == EXT2_GOOD_OLD_REV &&
 	    (sb->s_feature_compat || sb->s_feature_ro_compat ||
 	     sb->s_feature_incompat))
-- 
2.25.0


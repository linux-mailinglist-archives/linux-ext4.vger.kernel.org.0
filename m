Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD72DD64F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLQRge (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQRgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD2C061794
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 09:35:53 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0082F1F45D0A;
        Thu, 17 Dec 2020 17:35:51 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 01/12] tune2fs: Allow enabling casefold feature after fs creation
Date:   Thu, 17 Dec 2020 18:35:33 +0100
Message-Id: <20201217173544.52953-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

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
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Changes in v3:
  - removed extra lines

 misc/tune2fs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f942c698..f766bfa5 100644
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
@@ -1513,6 +1514,18 @@ mmp_error:
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
 	if (sb->s_rev_level == EXT2_GOOD_OLD_REV &&
 	    (sb->s_feature_compat || sb->s_feature_ro_compat ||
 	     sb->s_feature_incompat))
-- 
2.29.2


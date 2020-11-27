Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E352C6A53
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgK0RBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57090 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgK0RBh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:37 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BDBE21F464FC;
        Fri, 27 Nov 2020 17:01:36 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 01/12] tune2fs: Allow enabling casefold feature after fs creation
Date:   Fri, 27 Nov 2020 18:01:05 +0100
Message-Id: <20201127170116.197901-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
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
 misc/tune2fs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f942c698..0809e565 100644
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
@@ -1513,6 +1514,19 @@ mmp_error:
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
2.28.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9D68FDD6
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 04:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjBIDTB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 22:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBIDSj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 22:18:39 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134025FD4;
        Wed,  8 Feb 2023 19:18:39 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675912717;
        bh=jjDU3ChkgfkUs+8zhzngad6rgmB2giHbf/BU63I4rfg=;
        h=From:Date:Subject:To:Cc:From;
        b=dtKAwyvAdiuOCUq8Dhc0NnN4IYZmYBdZ1QEyh0eLS5Z8ZnhpNne/lGiHXnQeoCl2f
         QCT8UzQ2rpzC7vsH32Ok7UIvNPp1zkboWPcmJ8aO77PWgyWYD88MhP/lAr+OKYNxGl
         n0A+d2Je8B/W9OW1jE+tGRv0F0u4PwT30kfBs3s0=
Date:   Thu, 09 Feb 2023 03:18:35 +0000
Subject: [PATCH] ext4: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230209-kobj_type-ext4-v1-1-6865fb05c1f8@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAApm5GMC/x2NWwqDMBAAryL73YV0fZR4lSKS6LZulSiJikW8e
 5d+zsAwJySOwgnq7ITIuySZg8L9lkE3uPBmlF4ZyFBuyFgcZ/9p1+/CyMdaoK2oLwsqH5V1oJF
 3idFHF7pBs7BNk8ol8kuO/+XZXNcP9uWlhXUAAAA=
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675912715; l=1209;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jjDU3ChkgfkUs+8zhzngad6rgmB2giHbf/BU63I4rfg=;
 b=GdidmAXCVsiBRCNB6UgRitsMUO+dUYtE4OIJBJDx3Ub8W+X0GY7VE1WOd/Miup14Sabtl5pGU
 weuMSzG4eaOC9F1em4JLPSQn8pY/8Y5FaTcs69FDIavi320vbuPIznx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/ext4/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..364e3da49b03 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -496,13 +496,13 @@ static const struct sysfs_ops ext4_attr_ops = {
 	.store	= ext4_attr_store,
 };
 
-static struct kobj_type ext4_sb_ktype = {
+static const struct kobj_type ext4_sb_ktype = {
 	.default_groups = ext4_groups,
 	.sysfs_ops	= &ext4_attr_ops,
 	.release	= ext4_sb_release,
 };
 
-static struct kobj_type ext4_feat_ktype = {
+static const struct kobj_type ext4_feat_ktype = {
 	.default_groups = ext4_feat_groups,
 	.sysfs_ops	= &ext4_attr_ops,
 	.release	= (void (*)(struct kobject *))kfree,

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230209-kobj_type-ext4-962d5425769a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FBE294D69
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438167AbgJUNX2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 09:23:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438107AbgJUNX2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 09:23:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kVE5O-0000iy-BV; Wed, 21 Oct 2020 13:23:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ext4: remove redundant assignment of variable ex
Date:   Wed, 21 Oct 2020 14:23:26 +0100
Message-Id: <20201021132326.148052-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ex is assigned a variable that is not being read, the assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ext4/extents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6b33b9c86b00..80fac488769c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5993,7 +5993,6 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 			kfree(path);
 			break;
 		}
-		ex = path2[path2->p_depth].p_ext;
 		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
 			cmp1 = cmp2 = 0;
 			if (i <= path->p_depth)
-- 
2.27.0


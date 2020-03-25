Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CB193277
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYVS1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVS1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5AE7828666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 02/11] tune2fs: Fix casefold+encrypt error message
Date:   Wed, 25 Mar 2020 17:18:02 -0400
Message-Id: <20200325211812.2971787-3-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Refering to EXT4_INCOMPAT_CASEFOLD as encoding is not as meaningful as
saying casefold.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 656389c61281..ffd1d39f2e9c 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1420,7 +1420,7 @@ mmp_error:
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_ENCRYPT)) {
 		if (ext2fs_has_feature_casefold(sb)) {
 			fputs(_("Cannot enable encrypt feature on filesystems "
-				"with the encoding feature enabled.\n"),
+				"with the casefold feature enabled.\n"),
 			      stderr);
 			return 1;
 		}
-- 
2.25.0


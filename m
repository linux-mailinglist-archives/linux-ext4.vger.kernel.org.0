Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FD2DD64E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLQRge (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgLQRgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:33 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3A6791F45D0C;
        Thu, 17 Dec 2020 17:35:52 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 02/12] tune2fs: Fix casefold+encrypt error message
Date:   Thu, 17 Dec 2020 18:35:34 +0100
Message-Id: <20201217173544.52953-3-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Refering to EXT4_INCOMPAT_CASEFOLD as encoding is not as meaningful as
saying casefold.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f766bfa5..fade2b0b 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1470,7 +1470,7 @@ mmp_error:
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_ENCRYPT)) {
 		if (ext2fs_has_feature_casefold(sb)) {
 			fputs(_("Cannot enable encrypt feature on filesystems "
-				"with the encoding feature enabled.\n"),
+				"with the casefold feature enabled.\n"),
 			      stderr);
 			return 1;
 		}
-- 
2.29.2


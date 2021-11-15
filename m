Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F174526A6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Nov 2021 03:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhKPCJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 21:09:54 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:59066 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhKOSAq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 13:00:46 -0500
X-Greylist: delayed 2099 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 13:00:46 EST
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mmfed-00BE1m-Io; Mon, 15 Nov 2021 18:20:29 +0100
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mmfec-0002Nz-4V; Mon, 15 Nov 2021 18:20:26 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mmfeY-000F3O-Qg;
        Mon, 15 Nov 2021 18:20:22 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon, 15 Nov 2021 18:20:20 +0100
Message-Id: <20211115172020.57853-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001 autolearn=no
        autolearn_force=no languages=en
Subject: [PATCH] ext4: drop an always true check
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT_FIRST_INDEX(ptr) is ptr+12, which can't possibly be null; gcc-12
warns about this.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 fs/ext4/extents.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0ecf819bf189..5aa279742da9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1496,8 +1496,7 @@ static int ext4_ext_search_left(struct inode *inode,
 				EXT4_ERROR_INODE(inode,
 				  "ix (%d) != EXT_FIRST_INDEX (%d) (depth %d)!",
 				  ix != NULL ? le32_to_cpu(ix->ei_block) : 0,
-				  EXT_FIRST_INDEX(path[depth].p_hdr) != NULL ?
-		le32_to_cpu(EXT_FIRST_INDEX(path[depth].p_hdr)->ei_block) : 0,
+				  le32_to_cpu(EXT_FIRST_INDEX(path[depth].p_hdr)->ei_block),
 				  depth);
 				return -EFSCORRUPTED;
 			}
-- 
2.33.1


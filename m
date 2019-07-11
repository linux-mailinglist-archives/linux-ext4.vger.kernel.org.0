Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED06624B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfGKXnq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 19:43:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729098AbfGKXnq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jul 2019 19:43:46 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6BNhfgR031122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jul 2019 19:43:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4F233420036; Thu, 11 Jul 2019 19:43:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e2scrub_all: fix "e2scurb_all -r"
Date:   Thu, 11 Jul 2019 19:43:39 -0400
Message-Id: <20190711234339.30389-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The e2scrub_all program was broken by commit c7d6525ecaab
("e2scrub_all: refactor device probe loop") so that it would use the
path of the snapshot volume instead of the base volume.  This caused
"e2scrub_all -r" to pass the wrong pathname to e2scrub, with the
result that e2scrub would abort with an error instead of removing the
snapshot volume.

Fixes: c7d6525ecaab ("e2scrub_all: refactor device probe loop")
Addresses-Debian-Bug: #931679
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 scrub/e2scrub_all.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 24b2c681..f342faf2 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -115,7 +115,8 @@ ls_scan_targets() {
 
 # Find leftover scrub snapshots
 ls_reap_targets() {
-	lvs -o lv_path -S lv_role=snapshot -S lv_name=~\(e2scrub$\) --noheadings
+    lvs -o lv_path -S lv_role=snapshot -S lv_name=~\(e2scrub$\) \
+	--noheadings | sed -e 's/.e2scrub$//'
 }
 
 # Figure out what we're targeting
-- 
2.22.0


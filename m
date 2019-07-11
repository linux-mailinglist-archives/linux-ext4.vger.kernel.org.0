Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BDE6624C
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfGKXnx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 19:43:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59157 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729127AbfGKXnx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jul 2019 19:43:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6BNhnEN031151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jul 2019 19:43:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9EF29420036; Thu, 11 Jul 2019 19:43:48 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e2scrub_all: only run in service mode when periodic_e2scrub=1
Date:   Thu, 11 Jul 2019 19:43:46 -0400
Message-Id: <20190711234346.30454-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By default, e2scrub_all will not actually trigger online scrubs unless
periodic_e2scrub=1 is set in /etc/e2scrub.conf.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 scrub/e2scrub.conf.in | 4 ++++
 scrub/e2scrub_all.in  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/scrub/e2scrub.conf.in b/scrub/e2scrub.conf.in
index 5c030877..661fc13f 100644
--- a/scrub/e2scrub.conf.in
+++ b/scrub/e2scrub.conf.in
@@ -1,5 +1,9 @@
 # e2scrub configuration file
 
+# Uncomment to enable automatic periodic runs of e2scrub_all
+# (either via cron or via a systemd timer)
+# periodic_e2scrub=1
+
 # e-mail destination used by e2scrub_fail when problems are found with
 # the file system.
 # recipient=root
diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index f342faf2..5bdbd116 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -25,6 +25,7 @@ if (( $EUID != 0 )); then
     exit 1
 fi
 
+periodic_e2scrub=0
 scrub_all=0
 snap_size_mb=256
 reap=0
@@ -79,6 +80,11 @@ while getopts "nrAV" opt; do
 done
 shift "$((OPTIND - 1))"
 
+if [ -n "${SERVICE_MODE}" -a "${reap}" -ne 1 -a "${periodic_e2scrub}" -ne 1 ]
+then
+    exitcode 0
+fi
+
 # If some prerequisite packages are not installed, exit with a code
 # indicating success to avoid spamming the sysadmin with fail messages
 # when e2scrub_all is run out of cron or a systemd timer.
-- 
2.22.0


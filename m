Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD367B54
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2019 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfGMQ6W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Jul 2019 12:58:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43945 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727768AbfGMQ6W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Jul 2019 12:58:22 -0400
Received: from callcc.thunk.org (75-104-90-136.mobility.exede.net [75.104.90.136] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6DGw0an000584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 12:58:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 549E4420036; Sat, 13 Jul 2019 12:57:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Philipp Thomas <pth@suse.de>,
        Benno Schulenberg <vertaling@coevern.nl>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Petr Pisar <petr.pisar@atlas.cz>
Subject: [PATCH] po: remove unnecessary/buggy positional parameter specifiers
Date:   Sat, 13 Jul 2019 12:57:52 -0400
Message-Id: <20190713165752.7820-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The strings in e2fsck/problem.c use a special %-expansion scheme,
where %b gets expanded to a block number, %i gets expanded to an inode
number, etc., where these values are in a problem context data
structure.  As such, there is no need to use a printf style positional
indicator (e.g., %2$s).  Indeed, the use of things like %1$i or %2$b
will cause the %-expansion code to just print %1$i or %2$b, instead of
the inode or block number, respectively.

Addresses-Debian-Bug: #892173

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Philipp Thomas <pth@suse.de>
Cc: Benno Schulenberg <vertaling@coevern.nl>
Cc: Trần Ngọc Quân <vnwildman@gmail.com>
Cc: Petr Pisar <petr.pisar@atlas.cz>
---
 po/cs.po | 6 +++---
 po/de.po | 6 +++---
 po/nl.po | 2 +-
 po/vi.po | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/cs.po b/po/cs.po
index 368eb520..dcd0d0e7 100644
--- a/po/cs.po
+++ b/po/cs.po
@@ -1939,7 +1939,7 @@ msgstr ""
 #. @-expanded: inode %i extended attribute block %b passes checks, but checksum does not match block.  
 #: e2fsck/problem.c:1052
 msgid "@i %i @a @b %b passes checks, but checksum does not match @b.  "
-msgstr "Block %2$b rozšířeného atributu iuzlu %1$i projde kontrolami, ale kontrolní součet bloku neodpovídá. "
+msgstr "Block %b rozšířeného atributu iuzlu %i projde kontrolami, ale kontrolní součet bloku neodpovídá. "
 
 # ??? WTF
 #. @-expanded: Interior extent node level %N of inode %i:\n
@@ -1977,7 +1977,7 @@ msgstr "Iuzel %i má nastaven příznak INLINE_DATA_FL na systému souborů bez
 #. @-expanded: inode %i block %b conflicts with critical metadata, skipping block checks.\n
 #: e2fsck/problem.c:1080
 msgid "@i %i block %b conflicts with critical metadata, skipping block checks.\n"
-msgstr "Blok %2$b iuzlu %1$i se neslučuje s kritickými metadaty, kontrola bloku se vynechá.\n"
+msgstr "Blok %b iuzlu %i se neslučuje s kritickými metadaty, kontrola bloku se vynechá.\n"
 
 #. @-expanded: directory inode %i block %b should be at block %c.  
 #: e2fsck/problem.c:1085
@@ -2613,7 +2613,7 @@ msgstr "Iuzel adresáře %i, %B: adresář prošel kontrolami, ale součet nesou
 #. @-expanded: Inline directory inode %i size (%N) must be a multiple of 4.\n
 #: e2fsck/problem.c:1679
 msgid "Inline @d @i %i size (%N) must be a multiple of 4.\n"
-msgstr "Velikost (%2$N) iuzlu %1$i vestavěného adresáře musí být násobek čtyř.\n"
+msgstr "Velikost (%N) iuzlu %i vestavěného adresáře musí být násobek čtyř.\n"
 
 #. @-expanded: Fixing size of inline directory inode %i failed.\n
 #: e2fsck/problem.c:1684
diff --git a/po/de.po b/po/de.po
index e09e3d95..1fce5cf8 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2064,7 +2064,7 @@ msgstr ""
 msgid ""
 "@i %i block %b conflicts with critical metadata, skipping block checks.\n"
 msgstr ""
-"Block %2$b von Inode %1$i steht in Konflikt mit kritischen Metadaten, "
+"Block %b von Inode %i steht in Konflikt mit kritischen Metadaten, "
 "Blockprüfungen werden übersprungen.\n"
 
 #. @-expanded: directory inode %i block %b should be at block %c.  
@@ -2349,13 +2349,13 @@ msgstr ""
 #: e2fsck/problem.c:1314
 msgid "@i %i @x tree (at level %b) could be shorter.  "
 msgstr ""
-"Der Erweiterungsbaum von Inode %1$i (auf Ebene %2$b) könnte kürzer sein.  "
+"Der Erweiterungsbaum von Inode %i (auf Ebene %b) könnte kürzer sein.  "
 
 #. @-expanded: inode %i extent tree (at level %b) could be narrower.  
 #: e2fsck/problem.c:1319
 msgid "@i %i @x tree (at level %b) could be narrower.  "
 msgstr ""
-"Der Erweiterungsbaum von Inode %1$i (auf Ebene %2$b) könnte schmaler sein.  "
+"Der Erweiterungsbaum von Inode %i (auf Ebene %b) könnte schmaler sein.  "
 
 #. @-expanded: Pass 2: Checking directory structure\n
 #: e2fsck/problem.c:1326
diff --git a/po/nl.po b/po/nl.po
index 3b1e0c19..a95baf1a 100644
--- a/po/nl.po
+++ b/po/nl.po
@@ -2068,7 +2068,7 @@ msgstr ""
 msgid ""
 "@i %i block %b conflicts with critical metadata, skipping block checks.\n"
 msgstr ""
-"Blok %2$b van inode %1$i conflicteert met kritieke metadata; blokcontroles "
+"Blok %b van inode %i conflicteert met kritieke metadata; blokcontroles "
 "worden overgeslagen.\n"
 
 #. @-expanded: directory inode %i block %b should be at block %c.  
diff --git a/po/vi.po b/po/vi.po
index f38cd773..2c0c96f1 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -1528,7 +1528,7 @@ msgstr "Đang định vị lại %s của @g %g từ %b sang %c…\n"
 #: e2fsck/problem.c:684
 #, c-format
 msgid "Relocating @g %g's %s to %c...\n"
-msgstr "Đang định vị lại %2$s của @g %1$g sang %3$c…\n"
+msgstr "Đang định vị lại %s của @g %g sang %c…\n"
 
 #. @-expanded: Warning: could not read block %b of %s: %m\n
 #: e2fsck/problem.c:689
-- 
2.22.0


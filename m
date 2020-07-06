Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484B6215FAD
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jul 2020 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFTxy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 15:53:54 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:35010 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgGFTxy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Jul 2020 15:53:54 -0400
Received: from neo-pc.sch (55d4bc09.access.ecotel.net [85.212.188.9])
        by zulu.geekplace.eu (Postfix) with ESMTPA id 6924C4A0928;
        Mon,  6 Jul 2020 21:48:05 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     linux-ext4@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 1/3] e4crypt: if salt is explicitly provided to add_key, then use it
Date:   Mon,  6 Jul 2020 21:47:25 +0200
Message-Id: <20200706194727.12979-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Providing -S and a path to 'add_key' previously exhibit an unintuitive
behavior: instead of using the salt explicitly provided by the user,
e4crypt would use the salt obtained via EXT4_IOC_GET_ENCRYPTION_PWSALT
on the path. This was because set_policy() was still called with NULL
as salt.

With this change we now remember the explicitly provided salt (if any)
and use it as argument for set_policy().

Eventually

e4crypt add_key -S s:my-spicy-salt /foo

will now actually use 'my-spicy-salt' and not something else as salt
for the policy set on /foo.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 misc/e4crypt.8.in | 4 +++-
 misc/e4crypt.c    | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/misc/e4crypt.8.in b/misc/e4crypt.8.in
index 75b968a0..32fbd444 100644
--- a/misc/e4crypt.8.in
+++ b/misc/e4crypt.8.in
@@ -48,7 +48,9 @@ values are 4, 8, 16, and 32.
 If one or more directory paths are specified, e4crypt will try to
 set the policy of those directories to use the key just added by the
 .B add_key
-command.
+command.  If a salt was explicitly specified, then it will be used
+by the policy of those directories.  Otherwise a directory-specific
+default salt will be used.
 .TP
 .B e4crypt get_policy \fIpath\fR ...
 Print the policy for the directories specified on the command line.
diff --git a/misc/e4crypt.c b/misc/e4crypt.c
index 2ae6254a..c82c6f8f 100644
--- a/misc/e4crypt.c
+++ b/misc/e4crypt.c
@@ -652,6 +652,7 @@ static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
 static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	struct salt *salt;
+	struct salt *explicit_salt = NULL;
 	char *keyring = NULL;
 	int i, opt, pad = 4;
 	unsigned j;
@@ -666,8 +667,13 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 			pad = atoi(optarg);
 			break;
 		case 'S':
+			if (explicit_salt) {
+				fputs("May only provide -S once\n", stderr);
+				exit(1);
+			}
 			/* Salt value for passphrase. */
 			parse_salt(optarg, 0);
+			explicit_salt = salt_list;
 			break;
 		case 'v':
 			options |= OPT_VERBOSE;
@@ -703,7 +709,7 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 		insert_key_into_keyring(keyring, salt);
 	}
 	if (optind != argc)
-		set_policy(NULL, pad, argc, argv, optind);
+		set_policy(explicit_salt, pad, argc, argv, optind);
 	clear_secrets();
 	exit(0);
 }
-- 
2.26.2


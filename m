Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE621685B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGI23 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGI22 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jul 2020 04:28:28 -0400
X-Greylist: delayed 45619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jul 2020 01:28:28 PDT
Received: from zulu.geekplace.eu (zulu.geekplace.eu [IPv6:2a03:4000:6:3a8::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52AC061755
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jul 2020 01:28:28 -0700 (PDT)
Received: from neo-pc.sch (55d4bc09.access.ecotel.net [85.212.188.9])
        by zulu.geekplace.eu (Postfix) with ESMTPA id A8B784A0919;
        Tue,  7 Jul 2020 10:28:25 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     linux-ext4@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH v2] e4crypt: if salt is explicitly provided to add_key, then use it
Date:   Tue,  7 Jul 2020 10:27:30 +0200
Message-Id: <20200707082729.85058-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706194727.12979-1-flo@geekplace.eu>
References: <20200706194727.12979-1-flo@geekplace.eu>
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

Notes:
    - Clarify -S description in man page.
    - Do not store a reference to salt_list entry, as it
      could be reallocated causing a use-after-free.
    - Only parse the salts of the path arguments if no
      salt was explicitly specified.

 misc/e4crypt.8.in |  4 +++-
 misc/e4crypt.c    | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/misc/e4crypt.8.in b/misc/e4crypt.8.in
index 75b968a0..fe9372cf 100644
--- a/misc/e4crypt.8.in
+++ b/misc/e4crypt.8.in
@@ -48,7 +48,9 @@ values are 4, 8, 16, and 32.
 If one or more directory paths are specified, e4crypt will try to
 set the policy of those directories to use the key just added by the
 .B add_key
-command.
+command.  If a salt was explicitly specified, then it will be used
+to derive the encryption key of those directories.  Otherwise a
+directory-specific default salt will be used.
 .TP
 .B e4crypt get_policy \fIpath\fR ...
 Print the policy for the directories specified on the command line.
diff --git a/misc/e4crypt.c b/misc/e4crypt.c
index 2ae6254a..67d25d88 100644
--- a/misc/e4crypt.c
+++ b/misc/e4crypt.c
@@ -26,6 +26,7 @@
 #include <getopt.h>
 #include <dirent.h>
 #include <errno.h>
+#include <stdbool.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -652,6 +653,7 @@ static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
 static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	struct salt *salt;
+	bool explicit_salt = false;
 	char *keyring = NULL;
 	int i, opt, pad = 4;
 	unsigned j;
@@ -666,8 +668,13 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 			pad = atoi(optarg);
 			break;
 		case 'S':
+			if (explicit_salt) {
+				fputs("May only provide -S once\n", stderr);
+				exit(1);
+			}
 			/* Salt value for passphrase. */
 			parse_salt(optarg, 0);
+			explicit_salt = true;
 			break;
 		case 'v':
 			options |= OPT_VERBOSE;
@@ -692,8 +699,9 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 	validate_paths(argc, argv, optind);
-	for (i = optind; i < argc; i++)
-		parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);
+	if (!explicit_salt)
+		for (i = optind; i < argc; i++)
+			parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);
 	printf("Enter passphrase (echo disabled): ");
 	get_passphrase(in_passphrase, sizeof(in_passphrase));
 	for (j = 0, salt = salt_list; j < num_salt; j++, salt++) {
@@ -702,8 +710,10 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 		generate_key_ref_str(salt);
 		insert_key_into_keyring(keyring, salt);
 	}
-	if (optind != argc)
-		set_policy(NULL, pad, argc, argv, optind);
+	if (optind != argc) {
+		salt = explicit_salt ? salt_list : NULL;
+		set_policy(salt, pad, argc, argv, optind);
+	}
 	clear_secrets();
 	exit(0);
 }
-- 
2.26.2


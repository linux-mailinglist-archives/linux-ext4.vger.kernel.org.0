Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13A1215FAC
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jul 2020 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgGFTxy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 15:53:54 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:35006 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFTxy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Jul 2020 15:53:54 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 15:53:53 EDT
Received: from neo-pc.sch (55d4bc09.access.ecotel.net [85.212.188.9])
        by zulu.geekplace.eu (Postfix) with ESMTPA id B377E4A0930;
        Mon,  6 Jul 2020 21:48:10 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     linux-ext4@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 2/3] e4crypt: refactor set_policy a little
Date:   Mon,  6 Jul 2020 21:47:26 +0200
Message-Id: <20200706194727.12979-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706194727.12979-1-flo@geekplace.eu>
References: <20200706194727.12979-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove the superfluous 'salt' variable and simply use the functions
parameter instead.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 misc/e4crypt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/misc/e4crypt.c b/misc/e4crypt.c
index c82c6f8f..23980073 100644
--- a/misc/e4crypt.c
+++ b/misc/e4crypt.c
@@ -344,10 +344,9 @@ static void parse_salt(char *salt_str, int flags)
 	add_salt(salt_buf, salt_len);
 }
 
-static void set_policy(struct salt *set_salt, int pad,
+static void set_policy(struct salt *salt, int pad,
 		       int argc, char *argv[], int path_start_index)
 {
-	struct salt *salt;
 	struct ext4_encryption_policy policy;
 	uuid_t	uu;
 	int fd;
@@ -366,9 +365,7 @@ static void set_policy(struct salt *set_salt, int pad,
 			perror(argv[x]);
 			exit(1);
 		}
-		if (set_salt)
-			salt = set_salt;
-		else {
+		if (!salt) {
 			if (ioctl(fd, EXT4_IOC_GET_ENCRYPTION_PWSALT,
 				  &uu) < 0) {
 				perror("EXT4_IOC_GET_ENCRYPTION_PWSALT");
-- 
2.26.2


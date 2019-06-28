Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD965A5CC
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2019 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfF1UTh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jun 2019 16:19:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfF1UTh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jun 2019 16:19:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D8D97284D58
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, kernel@collabora.com
Subject: [PATCH] ext4: Fix coverity warning on error path of filename setup
Organization: Collabora
References: <20190624122906.GA30836@mwanda>
Date:   Fri, 28 Jun 2019 16:19:32 -0400
In-Reply-To: <20190624122906.GA30836@mwanda> (Dan Carpenter's message of "Mon,
        24 Jun 2019 15:29:06 +0300")
Message-ID: <85r27dlay3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Gabriel Krisman Bertazi,
>
> The patch 3ae72562ad91: "ext4: optimize case-insensitive lookups"
> from Jun 19, 2019, leads to the following static checker warning:

Hi,

The patch below should fix this issue.

-- >8 --
Subject: [PATCH] ext4: Fix coverity warning on error path of filename setup

Fix the following coverity warning reported by Dan Carpenter:

fs/ext4/namei.c:1311 ext4_fname_setup_ci_filename()
	  warn: 'cf_name->len' unsigned <= 0

Fixes: 3ae72562ad91 ("ext4: optimize case-insensitive lookups")
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/namei.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4909ced4e672..898295286676 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1296,6 +1296,8 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct fscrypt_str *cf_name)
 {
+	int len;
+
 	if (!IS_CASEFOLDED(dir)) {
 		cf_name->name = NULL;
 		return;
@@ -1305,13 +1307,16 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	if (!cf_name->name)
 		return;
 
-	cf_name->len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
-				     iname, cf_name->name,
-				     EXT4_NAME_LEN);
-	if (cf_name->len <= 0) {
+	len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
+			    iname, cf_name->name,
+			    EXT4_NAME_LEN);
+	if (len <= 0) {
 		kfree(cf_name->name);
 		cf_name->name = NULL;
+		return;
 	}
+	cf_name->len = (unsigned) len;
+
 }
 #endif
 
-- 
2.20.1



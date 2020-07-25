Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92922D787
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jul 2020 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGYMda (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jul 2020 08:33:30 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:37044 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgGYMda (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 25 Jul 2020 08:33:30 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 738F12E150C;
        Sat, 25 Jul 2020 15:33:23 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id tkF5ew7AMV-XMu8o3O4;
        Sat, 25 Jul 2020 15:33:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1595680403; bh=TfCL0CFkdZVUnLf18W8f9TTEIMStg9w7tIP6qnVDzJQ=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=yTpIdvheW/mQKsauTTW/uuLbW4P+QzWYUXRJliWdMdlEhd++bxEFXizONox23cmLI
         bfrzJawcB8tHqxXVoPT6zETWOnPLEffwP1M/My5cjlePyvAxdjrJ2gIAz4gT4bvLo9
         LtGW2dVwGGw2D2FscfcWCvXlJ88vmjbzwhbsvIvE=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MtNvF1pJiO-XMj8gjtg;
        Sat, 25 Jul 2020 15:33:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] ext4: export msg_count and warning_count via sysfs
Date:   Sat, 25 Jul 2020 12:33:13 +0000
Message-Id: <20200725123313.4467-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This numbers can be analized by system automation similar to errors_count.
In ideal world it would be nice to have separate counters for different
log-levels, but this makes this patch too intrusive.

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 12 +++++++++---
 fs/ext4/sysfs.c |  7 +++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 99a737c..e7bef27 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1573,6 +1573,8 @@ struct ext4_sb_info {
 	struct ratelimit_state s_err_ratelimit_state;
 	struct ratelimit_state s_warning_ratelimit_state;
 	struct ratelimit_state s_msg_ratelimit_state;
+	atomic_t s_warning_count;
+	atomic_t s_msg_count;
 
 	/* Encryption context for '-o test_dummy_encryption' */
 	struct fscrypt_dummy_context s_dummy_enc_ctx;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7a5a8a5..4c408d3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -744,6 +744,7 @@ void __ext4_msg(struct super_block *sb,
 	struct va_format vaf;
 	va_list args;
 
+	atomic_inc(&EXT4_SB(sb)->s_msg_count);
 	if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
 		return;
 
@@ -754,9 +755,12 @@ void __ext4_msg(struct super_block *sb,
 	va_end(args);
 }
 
-#define ext4_warning_ratelimit(sb)					\
-		___ratelimit(&(EXT4_SB(sb)->s_warning_ratelimit_state),	\
-			     "EXT4-fs warning")
+static int ext4_warning_ratelimit(struct super_block *sb)
+{
+	atomic_inc(&EXT4_SB(sb)->s_warning_count);
+	return ___ratelimit(&(EXT4_SB(sb)->s_warning_ratelimit_state),
+			    "EXT4-fs warning");
+}
 
 void __ext4_warning(struct super_block *sb, const char *function,
 		    unsigned int line, const char *fmt, ...)
@@ -4819,6 +4823,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ratelimit_state_init(&sbi->s_err_ratelimit_state, 5 * HZ, 10);
 	ratelimit_state_init(&sbi->s_warning_ratelimit_state, 5 * HZ, 10);
 	ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
+	atomic_set(&sbi->s_warning_count, 0);
+	atomic_set(&sbi->s_msg_count, 0);
 
 	kfree(orig_data);
 	return 0;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6c9fc9e..4f15992 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -189,6 +189,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
 #define EXT4_RW_ATTR_SBI_UL(_name,_elname)	\
 	EXT4_ATTR_OFFSET(_name, 0644, pointer_ul, ext4_sb_info, _elname)
 
+#define EXT4_RO_ATTR_SBI_ATOMIC(_name,_elname)	\
+	EXT4_ATTR_OFFSET(_name, 0444, pointer_atomic, ext4_sb_info, _elname)
+
 #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
 static struct ext4_attr ext4_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
@@ -226,6 +229,8 @@ EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
 #ifdef CONFIG_EXT4_DEBUG
 EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
 #endif
+EXT4_RO_ATTR_SBI_ATOMIC(warning_count, s_warning_count);
+EXT4_RO_ATTR_SBI_ATOMIC(msg_count, s_msg_count);
 EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
 EXT4_RO_ATTR_ES_U8(first_error_errcode, s_first_error_errcode);
 EXT4_RO_ATTR_ES_U8(last_error_errcode, s_last_error_errcode);
@@ -267,6 +272,8 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(msg_ratelimit_interval_ms),
 	ATTR_LIST(msg_ratelimit_burst),
 	ATTR_LIST(errors_count),
+	ATTR_LIST(warning_count),
+	ATTR_LIST(msg_count),
 	ATTR_LIST(first_error_ino),
 	ATTR_LIST(last_error_ino),
 	ATTR_LIST(first_error_block),
-- 
2.7.4


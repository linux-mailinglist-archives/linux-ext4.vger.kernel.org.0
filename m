Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC012B289
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 09:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL0IFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 03:05:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41338 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IFh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 03:05:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so11447883plb.8
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9IP3vGhdoAH4adCJgVBCBJgsdlu41+GlgA29+CqjKc=;
        b=o4/wMylmxzzXiJtOJ5jIgDqFxi+MSHjUCpiOGySlZ9HvmAJUkb/BN3oH7RMhVdnW7t
         xGBBI0UHrMw6zbO9lUJiqJKLSux8FLqVBiv0IyiciOW2vSUDCa//xWMjM4cU4UMNQFO1
         0PqhUewrbwkIUhSQOZtOdLyg65hNQeA+IDxY3EYwC+cCEs6PjP2flMVKmzqqsdILMdCq
         LTSkWiRWvB8nELsy/67XPoXE4q9jsezVHPAeSWrnLB5QGNZnx8iJdZxS/6srIGkGW9ME
         ScJFbY92gBtHz7LNKWU1+cpaModUv/Mk9qqeRvWrSWzY90QmDru6zxnrF6/2mcK+tOR5
         Mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9IP3vGhdoAH4adCJgVBCBJgsdlu41+GlgA29+CqjKc=;
        b=JtXowhXnnPWh8KMiKLfSsZM8UEaVoLmUEirplC5Y6m2ZkxvuaobxgMLd+2Cn7zXxZH
         7qmAJ34sgbknwLsNkpuAAK2GY9wvPnjrhBG5MEtlPctSFpC0coEldCGgkLezMy9nPg0I
         CMhSRHnnhLN392vVcrwH7N6Lg19ei7CdM8YU85S4JH0mXss6WNKPTksSiPc5cFeJNBmq
         uPuufDBhfJCfKMI0skUyQwZKPQpaMJtJa/A+0e30cj/AdW/MRtrYK8cNZC0z671W+7zT
         PDRb6ZJDJrDI85848wml2ybWuM8NmSVtLgobWNx+rsXWzrV9CBxChwX4cGJOq05vMTK5
         di8w==
X-Gm-Message-State: APjAAAWB6A7URY+3lLezVGBqpV3XFMxq7jxdXDQV5afRIEe7IpeJCK4k
        eGp3QC5GbGurHCX6sMQs7Zs=
X-Google-Smtp-Source: APXvYqyeXqyb3ygrD5b9RjhMiVk3ekl/LwBjVoK2g8cI9BNuwUZERdnDDO9v2JDqf4VwK7r+zhhjtg==
X-Received: by 2002:a17:90a:9bc3:: with SMTP id b3mr24459571pjw.64.1577433936871;
        Fri, 27 Dec 2019 00:05:36 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 3sm37271702pfi.13.2019.12.27.00.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 00:05:36 -0800 (PST)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 2/3] ext4: Rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and drop its flags argument
Date:   Fri, 27 Dec 2019 17:05:22 +0900
Message-Id: <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and drop
its flags argument, because ext4_kvmalloc() callers must be
under GFP_NOFS (otherwise, they should use generic kvmalloc()
helper function).

Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/resize.c | 10 ++++------
 fs/ext4/super.c  |  6 +++---
 fs/ext4/xattr.c  |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b25089e3896d..e1bdeffca0ad 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2677,7 +2677,7 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
-extern void *ext4_kvmalloc(size_t size, gfp_t flags);
+extern void *ext4_kvmalloc_nofs(size_t size);
 extern int ext4_alloc_flex_bg_array(struct super_block *sb,
 				    ext4_group_t ngroup);
 extern const char *ext4_decode_error(struct super_block *sb, int errno,
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a8c0f2b5b6e1..7998bbe66eed 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -824,9 +824,8 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	if (unlikely(err))
 		goto errout;

-	n_group_desc = ext4_kvmalloc((gdb_num + 1) *
-				     sizeof(struct buffer_head *),
-				     GFP_NOFS);
+	n_group_desc = ext4_kvmalloc_nofs((gdb_num + 1) *
+				     sizeof(struct buffer_head *));
 	if (!n_group_desc) {
 		err = -ENOMEM;
 		ext4_warning(sb, "not enough memory for %lu groups",
@@ -900,9 +899,8 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
 	if (IS_ERR(gdb_bh))
 		return PTR_ERR(gdb_bh);
-	n_group_desc = ext4_kvmalloc((gdb_num + 1) *
-				     sizeof(struct buffer_head *),
-				     GFP_NOFS);
+	n_group_desc = ext4_kvmalloc_nofs((gdb_num + 1) *
+				     sizeof(struct buffer_head *));
 	if (!n_group_desc) {
 		brelse(gdb_bh);
 		err = -ENOMEM;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 83a231dedcbf..e8965aa6ecce 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -204,13 +204,13 @@ void ext4_superblock_csum_set(struct super_block *sb)
 	es->s_checksum = ext4_superblock_csum(sb, es);
 }

-void *ext4_kvmalloc(size_t size, gfp_t flags)
+void *ext4_kvmalloc_nofs(size_t size)
 {
 	void *ret;

-	ret = kmalloc(size, flags | __GFP_NOWARN);
+	ret = kmalloc(size, GFP_NOFS | __GFP_NOWARN);
 	if (!ret)
-		ret = __vmalloc(size, flags, PAGE_KERNEL);
+		ret = __vmalloc(size, GFP_NOFS, PAGE_KERNEL);
 	return ret;
 }

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8966a5439a22..d5bc970ef331 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1456,7 +1456,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	if (!ce)
 		return NULL;

-	ea_data = ext4_kvmalloc(value_len, GFP_NOFS);
+	ea_data = ext4_kvmalloc_nofs(value_len);
 	if (!ea_data) {
 		mb_cache_entry_put(ea_inode_cache, ce);
 		return NULL;
--
2.16.6


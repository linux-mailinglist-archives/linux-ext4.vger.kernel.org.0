Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE033939CF
	for <lists+linux-ext4@lfdr.de>; Fri, 28 May 2021 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhE0X6f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 19:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235114AbhE0X6L (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 May 2021 19:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A770861006
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622159797;
        bh=iUvu7i3aYS+lmwXOQCxlGXl7RxMidmO54Xkvicclc+c=;
        h=From:To:Subject:Date:From;
        b=WqZYR7uls1EmAAWtHTMmwzNu3rJue1ZFozD1srz59m6rc4lZTafV6YLAycFzZVN/d
         2vR92NUuGFbogiSI49hzCNgofKvoeRKToosRuiN2jHoUAJ70U5cK26B0hyYaAS/Cwd
         SGVMZXsW05CuqXOvmjaeCWU9jM6fjfBVeJoPLCZ4ZC6GM/laxCz4h0nymTQz2cOmqt
         gZtcNtiXrSh/4hb/28QnQQXCnaynA5WpfYc25+3L7EXxtIYNThvM8Bbs8JOGujxOhj
         qkODeccHLXcOT4JFLi98RKF2on+s2mGd3/qQn8RXrWgUWCpWymi4bJ6PXPjwNaBNf+
         0ShJQAGD+/cRg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: fix comment for s_hash_unsigned
Date:   Thu, 27 May 2021 16:55:57 -0700
Message-Id: <20210527235557.2377525-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix the comment for s_hash_unsigned to not be the opposite of what it
actually is.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37002663d521..54ba34b30044 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1477,7 +1477,7 @@ struct ext4_sb_info {
 	unsigned int s_inode_goal;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-	int s_hash_unsigned;	/* 3 if hash should be signed, 0 if not */
+	int s_hash_unsigned;	/* 3 if hash should be unsigned, 0 if not */
 	struct percpu_counter s_freeclusters_counter;
 	struct percpu_counter s_freeinodes_counter;
 	struct percpu_counter s_dirs_counter;

base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog


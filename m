Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A887B2CF95F
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgLEE7z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50370 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgLEE7y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:54 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54wwNC001990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:58:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8CC2E4202E2; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 3/5] libext2fs: allow the unix_io manager's cache to be disabled and re-enabled
Date:   Fri,  4 Dec 2020 23:58:54 -0500
Message-Id: <20201205045856.895342-4-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205045856.895342-1-tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2_io.h |  1 +
 lib/ext2fs/unix_io.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 2e0da5a53..95c25a7b1 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -106,6 +106,7 @@ struct struct_io_manager {
 #define IO_FLAG_DIRECT_IO	0x0004
 #define IO_FLAG_FORCE_BOUNCE	0x0008
 #define IO_FLAG_THREADS		0x0010
+#define IO_FLAG_NOCACHE		0x0020
 
 /*
  * Convenience functions....
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 9385487d9..2df53e51c 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -942,6 +942,8 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 #ifdef NO_IO_CACHE
 	return raw_read_blk(channel, data, block, count, buf);
 #else
+	if (data->flags & IO_FLAG_NOCACHE)
+		return raw_read_blk(channel, data, block, count, buf);
 	/*
 	 * If we're doing an odd-sized read or a very large read,
 	 * flush out the cache and then do a direct read.
@@ -1032,6 +1034,8 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 #ifdef NO_IO_CACHE
 	return raw_write_blk(channel, data, block, count, buf);
 #else
+	if (data->flags & IO_FLAG_NOCACHE)
+		return raw_write_blk(channel, data, block, count, buf);
 	/*
 	 * If we're doing an odd-sized write or a very large write,
 	 * flush out the cache completely and then do a direct write.
@@ -1161,6 +1165,7 @@ static errcode_t unix_set_option(io_channel channel, const char *option,
 {
 	struct unix_private_data *data;
 	unsigned long long tmp;
+	errcode_t retval;
 	char *end;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
@@ -1179,6 +1184,20 @@ static errcode_t unix_set_option(io_channel channel, const char *option,
 			return EXT2_ET_INVALID_ARGUMENT;
 		return 0;
 	}
+	if (!strcmp(option, "cache")) {
+		if (!arg)
+			return EXT2_ET_INVALID_ARGUMENT;
+		if (!strcmp(arg, "on")) {
+			data->flags &= ~IO_FLAG_NOCACHE;
+			return 0;
+		}
+		if (!strcmp(arg, "off")) {
+			retval = flush_cached_blocks(channel, data, 0);
+			data->flags |= IO_FLAG_NOCACHE;
+			return retval;
+		}
+		return EXT2_ET_INVALID_ARGUMENT;
+	}
 	return EXT2_ET_INVALID_ARGUMENT;
 }
 
-- 
2.28.0


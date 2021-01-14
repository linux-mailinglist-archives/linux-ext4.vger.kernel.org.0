Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60B2F569B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbhANBtu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 20:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbhANA2o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:44 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A01C0617A6
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q12so2204944plr.9
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5oYwqcz/mL1id4IF95JBBwOI4so/in2G3bJcwqnfCyI=;
        b=rb6wSDijKp0wRoPqYfBiWvBcXfmwukT76n2zJwLd0YB5tv0x4lcm0/cVlKJpYvxZqA
         SXeUy8DHROaU9jepXAG05MSwPnumsLIdmaJGB3VxnSJhH6yqf112749yZH2rCM28wJem
         qpPugHaWgY2fILRsziL759TiEKwGUqDkyXMXB7Bt0eXrDbjbXZmJ+9VIOXVvaSlWPXTC
         KD0zD+CfndXetQbJFLem5X8d0jvbifdGUDWPe+wqzkNA/hxvp9da41nV9hFbx1Gb6kzm
         FYasmQooX+CSAQXlttPly0rJowiGNCMmPkzstOmW2hQ3iZO7124ipRecCXGMdY1brhqU
         Wf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5oYwqcz/mL1id4IF95JBBwOI4so/in2G3bJcwqnfCyI=;
        b=VbYH5A06YMcZVxtP8VnJpFYBpLUL4mbTjWn39aaH2tvx3gJ0Dsslpo1k3PxM+NK8uF
         QD+yJfY7NVEd/nX+rocms1B9Be1h+3dh/0HK00ulBnGTOq8e37wMAkzmA+JxjstPdHhu
         YrmuTLgdGKvUX3SNpWDlRo4TyYXhk5sKTfyJZM2vEl0VLiZbhoj3H/rt5HEtLb8upfMb
         zbLEi7pY1VOXKD0phOaVsaGgiz0vgul4//kGnlfPqWoQ5Djk2P65TrwF6HIAGGN3dyOi
         9dO7xj78fO9Xpw4IsD73I0PwyxPMxZwIvkAvaLUTQaOlV5DxoKJ+K0i0rpwrahTqKFTI
         /2uw==
X-Gm-Message-State: AOAM530pCmb3/XSOMgxnFEp/j12ifiUcO0g9jAV7agXDGEBwVsnJiNL8
        h90S+rsgDc0pdLbIAblvWJ3j7YbXwqhok3LSKBBDEMCHYvscYdMyL9r/yy9Y+IowAtO9cUXh/33
        hYE8JLIB672IrGJjszJ0apYbJMsR7aA+WNZMpcbuIBXJkNL5sO4W44xNJvMkCD0V2yaVsDKGVFO
        /E4ecTJFI=
X-Google-Smtp-Source: ABdhPJwmfwdGwhgY/QHzOU/dh+08LajhS5B1dj+ocPkdl4TdqcqxK3dY8i9W9S4R1t1u9JVxda1a/Y2VhBMorjl7YZ0=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:aa8b:b029:da:ef22:8675 with
 SMTP id d11-20020a170902aa8bb02900daef228675mr4993880plr.15.1610584082966;
 Wed, 13 Jan 2021 16:28:02 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:21 -0800
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Message-Id: <20210114002723.643589-4-saranyamohan@google.com>
Mime-Version: 1.0
References: <20210114002723.643589-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 3/5] libext2fs: allow the unix_io manager's cache to be
 disabled and re-enabled
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2_io.h |  1 +
 lib/ext2fs/unix_io.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 2e0da5a5..95c25a7b 100644
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
index 9385487d..2df53e51 100644
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
2.30.0.284.gd98b1dd5eaa7-goog


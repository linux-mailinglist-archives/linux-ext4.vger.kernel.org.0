Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD65FCF07
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNUB6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 15:01:58 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:39724 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbfKNUB6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 15:01:58 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id ACB6D2E152C;
        Thu, 14 Nov 2019 23:01:54 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id JJXvP3aroV-1sIeV3Dt;
        Thu, 14 Nov 2019 23:01:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573761714; bh=GnQFMIkMVjacXA5wEOUiBzHV78Dm9W/eccNJXi+qLiY=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=m7C44SqmoEohpwOfhIkZSbvtdNVM1ayCaf1MHiFydtzXDu/oJgUcWy7EuPPfriC1t
         IfqDiWyiI4xOtqXmOVat8dKG5c2e0sBtb+26qH72igcI29XOwos1HQxOMIAwi3ijnd
         ePV99EKC7/ypG/J1rUcuvXkC1EeGc1ZUuIjXU2rQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id weyrU94q4p-1sVGvBCs;
        Thu, 14 Nov 2019 23:01:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     darrick.wong@oracle.com, tytso@mit.edu,
        Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH 1/2] ext4: fix symbolic enum printing in trace output
Date:   Thu, 14 Nov 2019 20:01:46 +0000
Message-Id: <20191114200147.1073-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Trace's macro __print_flags() produce raw event's decraration w/o knowing actual
flags value

cat /sys/kernel/debug/tracing/events/ext4/ext4_ext_map_blocks_exit/format
..
__print_flags(REC->mflags, "", { (1 << BH_New),

For that reason we have to explicitly define it via special macro TRACE_DEFINE_ENUM()
Also add missed EXTENT_STATUS_REFERENCED flag.

#Before patch
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags 0x20 ret 1
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34304 len 1 mflags 0x60 ret 1

#With patch
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags M ret 1
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34816 len 1 mflags NM ret 1

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 include/trace/events/ext4.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 182c9fe..3bf7128 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -48,6 +48,16 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_KEEP_SIZE,		"KEEP_SIZE" },		\
 	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" })
 
+/*
+ * __print_flags() requires that all enum values be wrapped in the
+ * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
+ * ring buffer.
+ */
+TRACE_DEFINE_ENUM(BH_New);
+TRACE_DEFINE_ENUM(BH_Mapped);
+TRACE_DEFINE_ENUM(BH_Unwritten);
+TRACE_DEFINE_ENUM(BH_Boundary);
+
 #define show_mflags(flags) __print_flags(flags, "",	\
 	{ EXT4_MAP_NEW,		"N" },			\
 	{ EXT4_MAP_MAPPED,	"M" },			\
@@ -62,11 +72,18 @@ struct partial_cluster;
 	{ EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER,"1ST_CLUSTER" },\
 	{ EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER,	"LAST_CLUSTER" })
 
+TRACE_DEFINE_ENUM(ES_WRITTEN_B);
+TRACE_DEFINE_ENUM(ES_UNWRITTEN_B);
+TRACE_DEFINE_ENUM(ES_DELAYED_B);
+TRACE_DEFINE_ENUM(ES_HOLE_B);
+TRACE_DEFINE_ENUM(ES_REFERENCED_B);
+
 #define show_extent_status(status) __print_flags(status, "",	\
 	{ EXTENT_STATUS_WRITTEN,	"W" },			\
 	{ EXTENT_STATUS_UNWRITTEN,	"U" },			\
 	{ EXTENT_STATUS_DELAYED,	"D" },			\
-	{ EXTENT_STATUS_HOLE,		"H" })
+	{ EXTENT_STATUS_HOLE,		"H" },			\
+	{ EXTENT_STATUS_REFERENCED,	"R" })
 
 #define show_falloc_mode(mode) __print_flags(mode, "|",		\
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
-- 
2.7.4


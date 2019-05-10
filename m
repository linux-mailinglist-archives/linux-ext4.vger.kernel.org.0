Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675341A2E8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfEJSVJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 14:21:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51295 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727453AbfEJSVI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 14:21:08 -0400
Received: from callcc.thunk.org (75-104-86-93.mobility.exede.net [75.104.86.93] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4AIKwio009258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 14:21:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A833E420024; Fri, 10 May 2019 14:20:56 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] libext2fs: add missing check for utf8lookup()'s return value
Date:   Fri, 10 May 2019 14:20:53 -0400
Message-Id: <20190510182053.23819-1-tytso@mit.edu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes-Coverity-Bug: 1442630
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 lib/ext2fs/nls_utf8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ext2fs/nls_utf8.c b/lib/ext2fs/nls_utf8.c
index 42148099a..e4c4e7a30 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -789,6 +789,8 @@ static int utf8byte(struct utf8cursor *u8c)
 			}
 
 			leaf = utf8lookup(u8c->data, u8c->hangul, u8c->s);
+			if (!leaf)
+				return -1;
 			ccc = LEAF_CCC(leaf);
 		}
 
-- 
2.19.1


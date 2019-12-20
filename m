Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5575A128321
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfLTURe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Dec 2019 15:17:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56851 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727402AbfLTURe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Dec 2019 15:17:34 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBKKHU4P017946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 15:17:30 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D7F4A420822; Fri, 20 Dec 2019 15:17:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] mke2fs: fix "mke2fs -d /path/to/files" to support 32-bit uids and gids
Date:   Fri, 20 Dec 2019 15:17:23 -0500
Message-Id: <20191220201724.264430-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://github.com/tytso/e2fsprogs/issues/29

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/create_inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index 0091b723..5161d5e3 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -121,7 +121,9 @@ static errcode_t set_inode_extra(ext2_filsys fs, ext2_ino_t ino,
 	}
 
 	inode.i_uid = st->st_uid;
+	ext2fs_set_i_uid_high(inode, st->st_uid >> 16);
 	inode.i_gid = st->st_gid;
+	ext2fs_set_i_gid_high(inode, st->st_gid >> 16);
 	inode.i_mode |= st->st_mode;
 	inode.i_atime = st->st_atime;
 	inode.i_mtime = st->st_mtime;
-- 
2.24.1


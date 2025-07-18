Return-Path: <linux-ext4+bounces-9099-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19DB0A1A0
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76965879D5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B252BF007;
	Fri, 18 Jul 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AbX/yYuC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290D2BEC24
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837104; cv=none; b=lihZ7b5G6cNga9VPFtZWPyfREa8gda1913DTboRte4WfFDxDmPYEWn5BCb+1yU7O2tTjwxkesmhFEVUVUoSlO+CSuF44AHByTQZdNlt+IdpQ6/pE5f24yaDbHpUK/wHiLOHxKMSpn59oNOMjLc6AfSsYStzln16wMwCOBcOeNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837104; c=relaxed/simple;
	bh=1gETe68d4cQ9qr00saG7VQL3QwKgNUF1EddFkVzlaa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7mH8tAwJiD8Q+vRutK46dfcTKhO8w9GMUiFtvRAplOQFDZ+iOjzkUW9hGHIjNMM5NPHJMAvDmXVmSPTdFxDoL24LuFdDQHzFbaVGyMnpmGPMgSGZNwIDOWpwecU9CNDCSlBCqp812rU2mKHncnM6nyYPLXkDDdlii6uz7A6nDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AbX/yYuC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56IBBUSH016460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752837092; bh=CiAtWjnHLLV3xqjVF49fn0cRx92x5Sbc2RWuDj12tTA=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=AbX/yYuCi2oNdcoJLhFWgD14XMobgKGIRJx69DM7TGLCZe65tXaEqRRQOSZTbvAwK
	 fF3p76JMBq9rCq6URQdUHXtGB1jlunrv34ezmrxYYNyAC7J3faVouD5ugs2T88BBih
	 NPnSR4/zDrXgBDeA9vzLZYjzwzf3mMvx03JpL2upWf1u5XuzWCwzGpZbL5M8dJzuMl
	 fevrN5iJE1e35pCneaA+KS5d0UenvG4UFsOJvjjI5BnJFJaBZHaqvOHq4iUXYjd5iO
	 hifkOi1TK3v/YwhasCG6moHoyAq97yGpAFtEvH+c7G6Su6EgwRttk9IjWFC6d3m2Sa
	 a40GCL2V4kCww==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 36A7D2E00D5; Fri, 18 Jul 2025 07:11:30 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: Moon Hee Lee <moonhee.lee.ca@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Subject: [PATCH -v2] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
Date: Fri, 18 Jul 2025 07:11:25 -0400
Message-ID: <20250718111125.366912-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A syzbot fuzzed image triggered a BUG_ON in ext4_update_inline_data()
when an inode had the INLINE_DATA_FL flag set but was missing the
system.data extended attribute.

Since this can happen due to a maiciouly fuzzed file system, we
shouldn't BUG, but rather, report it as a corrupted file system.

Add similar replacements of BUG_ON with EXT4_ERROR_INODE() ii
ext4_create_inline_data() and ext4_inline_data_truncate().

Link: https://lore.kernel.org/r/CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com
Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a83a643ff923..7b7e6aaec5ea 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -303,7 +303,11 @@ static int ext4_create_inline_data(handle_t *handle,
 	if (error)
 		goto out;
 
-	BUG_ON(!is.s.not_found);
+	if (!is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "unexpected inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 	if (error) {
@@ -354,7 +358,11 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	BUG_ON(is.s.not_found);
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
 	value = kzalloc(len, GFP_NOFS);
@@ -1867,7 +1875,12 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 
-			BUG_ON(is.s.not_found);
+			if (is.s.not_found) {
+				EXT4_ERROR_INODE(inode,
+						 "missing inline data xattr");
+				err = -EFSCORRUPTED;
+				goto out_error;
+			}
 
 			value_len = le32_to_cpu(is.s.here->e_value_size);
 			value = kmalloc(value_len, GFP_NOFS);
-- 
2.47.2



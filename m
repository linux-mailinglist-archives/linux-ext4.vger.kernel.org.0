Return-Path: <linux-ext4+bounces-5508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD749E7750
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784AA1887F44
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA52206A0;
	Fri,  6 Dec 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sMfTboRC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4720459D;
	Fri,  6 Dec 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506143; cv=none; b=Sd043ymhlW4yPBSPighCg4zGPH/G/z11AoTsgpMTpcq1ST5X7sdmYA0Hvb9JIvTDYju3h+8V9VTMgoZkYuliaw3UO2vROtWMQOrQGzYuD0y3UO6bL8vnF90tBILdPZBa+YKPJ7jCE8o2zUMGGHRqdzB6i7y2YyD+2J0xLUNl4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506143; c=relaxed/simple;
	bh=b080vVlV8tHb90OsSrK+IEUUi08J1cDRUHSL6tuv3e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=law/EZD3Mpci47/m0Fs6mIKcsMPlAkzP7C5rda3JTlgw7pBKYy8+ajvqcHlSK4xepDUP9y2ZU81e5NRrz6JMjEfllb3nxFcmE8afR2PdO7RMRi/raPrKZnIOgfLi7GuKxV4aIFV6JmVAt2P9AhtN3FwcyYStxfvl3AwXIUVoOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sMfTboRC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rjUd2AM2/YEWsLZUV6glYoJjEHrghXkYN6js8vSJ7uo=; b=sMfTboRCamx/JCedNhTDecnvGk
	dDC6Czow+OToi2tF2XPKxCVgFjRlSn6bXqou0K6D43EXMvb0epseRAq8RtO4gC7yOJJUAWcccu3er
	FeuTe/Lgrpmqgn39KCvkiABBNmxiRbw+u5hhKdOxl5N33Ua6AUeGus6lv21P2H8kmic0wySU7LZul
	vVXJnsg4UMPYKoWwQ8qrEy0KMKIEWsUqpZKXUIm7Q4Rl33TC2JpE1hiZ0EIfDueBBDQnNW7Xlqb4p
	iQLM7KePMRivGWx33xl2PBUHYRhlyIETsaxyxZSKusxRNPVNtrueZpz14nUswFowfHC8bijq0Pu87
	dvmBeuAA==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8R-00HUmO-Gl; Fri, 06 Dec 2024 18:29:00 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5/5] ext4: make i_inline_off point to data
Date: Fri,  6 Dec 2024 14:28:28 -0300
Message-Id: <20241206172828.3219989-6-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206172828.3219989-1-cascardo@igalia.com>
References: <20241206172828.3219989-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having i_inline_off pointing to the xattr entry, make it point
directly to the value offset. That will allow e_value_offs to be ignored,
preventing many issues where it might have changed on disk after being
validated.

This prevents many potential out-of-bound accesses.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index cd2014af9823..92e300c3f873 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -133,7 +133,12 @@ static void ext4_update_inline_off_size(struct inode *inode,
 					struct ext4_inode *raw_inode,
 					struct ext4_xattr_entry *entry)
 {
-	EXT4_I(inode)->i_inline_off = (u16)((void *)entry - (void *)raw_inode);
+	struct ext4_xattr_ibody_header *header;
+	void *off;
+
+	header = IHDR(inode, raw_inode);
+	off = (void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs);
+	EXT4_I(inode)->i_inline_off = (u16)(off - (void *)raw_inode);
 	EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 			le32_to_cpu(entry->e_value_size);
 }
@@ -184,8 +189,6 @@ static int ext4_read_inline_data(struct inode *inode, void *buffer,
 				 unsigned int len,
 				 struct ext4_iloc *iloc)
 {
-	struct ext4_xattr_entry *entry;
-	struct ext4_xattr_ibody_header *header;
 	int cp_len = 0;
 	struct ext4_inode *raw_inode;
 
@@ -205,14 +208,7 @@ static int ext4_read_inline_data(struct inode *inode, void *buffer,
 	if (!len)
 		goto out;
 
-	header = IHDR(inode, raw_inode);
-	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
-					    EXT4_I(inode)->i_inline_off);
-	len = min_t(unsigned int, len,
-		    (unsigned int)le32_to_cpu(entry->e_value_size));
-
-	memcpy(buffer,
-	       (void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs), len);
+	memcpy(buffer, (void *)raw_inode + EXT4_I(inode)->i_inline_off, len);
 	cp_len += len;
 
 out:
@@ -273,8 +269,6 @@ static int ext4_read_inline_data_from_inode(struct inode *inode, void **buffer,
 static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 				   void *buffer, loff_t pos, unsigned int len)
 {
-	struct ext4_xattr_entry *entry;
-	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	int cp_len = 0;
 
@@ -301,11 +295,8 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 		return;
 
 	pos -= EXT4_MIN_INLINE_DATA_SIZE;
-	header = IHDR(inode, raw_inode);
-	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
-					    EXT4_I(inode)->i_inline_off);
 
-	memcpy((void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs) + pos,
+	memcpy((void *)raw_inode + EXT4_I(inode)->i_inline_off + pos,
 	       buffer, len);
 }
 
@@ -1085,16 +1076,12 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 static void *ext4_get_inline_xattr_pos(struct inode *inode,
 				       struct ext4_iloc *iloc)
 {
-	struct ext4_xattr_entry *entry;
-	struct ext4_xattr_ibody_header *header;
+	struct ext4_inode *raw_inode;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
 
-	header = IHDR(inode, ext4_raw_inode(iloc));
-	entry = (struct ext4_xattr_entry *)((void *)ext4_raw_inode(iloc) +
-					    EXT4_I(inode)->i_inline_off);
-
-	return (void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs);
+	raw_inode = ext4_raw_inode(iloc);
+	return (void *)raw_inode + EXT4_I(inode)->i_inline_off;
 }
 
 /* Set the final de to cover the whole block. */
-- 
2.34.1



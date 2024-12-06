Return-Path: <linux-ext4+bounces-5507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8C9E774B
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F5018882B5
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6EF204591;
	Fri,  6 Dec 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pd8VBJvf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7214204572;
	Fri,  6 Dec 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506141; cv=none; b=JTlrKRhHOxMxsntFmzL3WNdZGZuq6Xb7bkiiBZY+1Bh2unZC20H/5EiTNj42OwBdxISYHD9xVYKW8rvUNbcMWsvpXadyVQMeAv8HR3qACmunXbdClsa/nIAziQIQdqxtawuo2J84BKrJfsGVzlJPzU6b0PTXy+P3ivCiCoTwhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506141; c=relaxed/simple;
	bh=vw/WbYE8RrUcs04aujsMJJvqGf3y5OIp03ii0Db40eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEzUCmApFsQF6X4+TbTYKeQ4BK18Yp82d73a4dLpvDfCdsyUwNCGsoJZ5qQpDWHDUXUEmDonCRo/4vnsOvYYy1kV/L/QPo0/brKaVSFLshw2nzPfZOJ5egLR/raJP8yOygnbRrsWDkc13K8Rb39nGb0b8a0IIyUeHlBSj7LRP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pd8VBJvf; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ye2tcP/e/A7fCZi3F9QVa918q4hBAxGAnVtC03cUxcU=; b=pd8VBJvf1p50UapWyRtcnqX7Hq
	VTOGaNCjFYyVYpEcBWSppbSnPVcBYEUxKGA1Xs4B3VcIBo2Ozt91KO68gkCMl3wJIorQScI0EVSws
	XL5KGNxo49kbjeytbOHNw9b75kJKVvSRk6uFFHpwpinQk1Y/nl1xKrW2gw5SJ2OcVoa5eLUnLVuBw
	GSRBIevi7nZeG0II3ocmlTi3TbN84m7WIq3Fq6dVZQ8Yn7dK0bVG2hJqKZZEKlvNBhwL9b+cp8i0J
	+qYJzGKuANyRNFbcdr3oSpGAtib2su/WZJaqoN+2IdZQms0iIRo/ZNKdxNe487ot1uxIv6YaG8Uim
	NfrnfiVg==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8O-00HUmO-OL; Fri, 06 Dec 2024 18:28:57 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 4/5] ext4: add a wrapper to update i_inline_off and i_inline_size
Date: Fri,  6 Dec 2024 14:28:27 -0300
Message-Id: <20241206172828.3219989-5-cascardo@igalia.com>
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

They were updated in three different places, with slight variations. This
will make it easier to change them.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c3d2fcae6191..cd2014af9823 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -129,6 +129,15 @@ int ext4_get_max_inline_size(struct inode *inode)
 	return max_inline_size + EXT4_MIN_INLINE_DATA_SIZE;
 }
 
+static void ext4_update_inline_off_size(struct inode *inode,
+					struct ext4_inode *raw_inode,
+					struct ext4_xattr_entry *entry)
+{
+	EXT4_I(inode)->i_inline_off = (u16)((void *)entry - (void *)raw_inode);
+	EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
+			le32_to_cpu(entry->e_value_size);
+}
+
 /*
  * this function does not take xattr_sem, which is OK because it is
  * currently only used in a code path coming form ext4_iget, before
@@ -163,10 +172,8 @@ int ext4_find_inline_data_nolock(struct inode *inode)
 			error = -EFSCORRUPTED;
 			goto out;
 		}
-		EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
-					(void *)ext4_raw_inode(&is.iloc));
-		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
-				le32_to_cpu(is.s.here->e_value_size);
+		ext4_update_inline_off_size(inode, ext4_raw_inode(&is.iloc),
+					    is.s.here);
 	}
 out:
 	brelse(is.iloc.bh);
@@ -354,9 +361,8 @@ static int ext4_create_inline_data(handle_t *handle,
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
 
-	EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
-				      (void *)ext4_raw_inode(&is.iloc));
-	EXT4_I(inode)->i_inline_size = len + EXT4_MIN_INLINE_DATA_SIZE;
+	ext4_update_inline_off_size(inode, ext4_raw_inode(&is.iloc), is.s.here);
+
 	ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
 	ext4_set_inode_flag(inode, EXT4_INODE_INLINE_DATA);
 	get_bh(is.iloc.bh);
@@ -420,10 +426,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
-				      (void *)ext4_raw_inode(&is.iloc));
-	EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
-				le32_to_cpu(is.s.here->e_value_size);
+	ext4_update_inline_off_size(inode, ext4_raw_inode(&is.iloc), is.s.here);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	get_bh(is.iloc.bh);
 	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
-- 
2.34.1



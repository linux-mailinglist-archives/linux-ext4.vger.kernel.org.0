Return-Path: <linux-ext4+bounces-3830-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB095A148
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2DB28531C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E3152790;
	Wed, 21 Aug 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IXFxnzKo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9B14D446;
	Wed, 21 Aug 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253834; cv=none; b=YrPOiguOKHozy6bYxjP7bXHg9FajnzRbYiufXhRZ5jwHLhftEwtRGLF2WU6QpxZBUgi+9mYSHCBlLuMgMSEcG020DgDCCon3SY/D46SvturFDD0dIRfZyN4uhK0M0phN7SKkQAYN2gkGxthmobEq04QFCddtkngeeBxZR4OjfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253834; c=relaxed/simple;
	bh=eLX+HnBOZZysohoQkdehuCZ8E4AhIA+hbL1gYQrz0Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGoUDDaLONpvSR1maYCXf/zgwDZ13bQ1aYFYLfE/fPTWerIkRCsoy6NkROao6JXemeekrWP0prTZKh9DIja30nBYohqB+6ynVRlyIR0hGLLWu5XfQMTJ4fKa9wkL6VuCEFyecqKzjYTr0xBTEoeTK+vCEhM8QtUO0DBbp9ptq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IXFxnzKo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Yietb1rV6uF5doHrg/u8VKbYC0LJEWRDRAAuODOefGY=; b=IXFxnzKoIaKb35Lv1tRUTsYEdN
	4WqxFOtphSO137aZVCNrPo7nzQDUmh5m025dMjqjgKbZeyn8WfvbSAAqc29LJYHy4wYscy+dCDvUm
	yHtivqVzpAryLEQDPHkUF5Z7vVLm0FvFdXwSZhtenUEncR+wq9trb4NoblECbkijqJgixBr4zes/D
	SQZyf7W6txA549QUyGG7CkpiN3luy7KOdTA5oObNYo6Tj8YpGqOWbcyKWmHnC2n4eRk9kJkiC/RVy
	JogJWJiJ/0EMRoIOnaYNROh59SQ3g77v+IF74sWPlml30EVzyljxkk7ttKDi63gd0/WY5rR8GaySe
	RRuWTEpQ==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgnBc-0034iV-HC; Wed, 21 Aug 2024 17:23:48 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 2/4] ext4: return error on ext4_find_inline_entry
Date: Wed, 21 Aug 2024 12:23:22 -0300
Message-Id: <20240821152324.3621860-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821152324.3621860-1-cascardo@igalia.com>
References: <20240821152324.3621860-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of errors when reading an inode from disk or traversing inline
directory entries, return an error-encoded ERR_PTR instead of returning
NULL. ext4_find_inline_entry only caller, __ext4_find_entry already returns
such encoded errors.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..7b98b1bf1dc9 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1669,8 +1669,9 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	void *inline_start;
 	int inline_size;
 
-	if (ext4_get_inode_loc(dir, &iloc))
-		return NULL;
+	ret = ext4_get_inode_loc(dir, &iloc);
+	if (ret)
+		return ERR_PTR(ret);
 
 	down_read(&EXT4_I(dir)->xattr_sem);
 	if (!ext4_has_inline_data(dir)) {
@@ -1701,7 +1702,10 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 out:
 	brelse(iloc.bh);
-	iloc.bh = NULL;
+	if (ret < 0)
+		iloc.bh = ERR_PTR(ret);
+	else
+		iloc.bh = NULL;
 out_find:
 	up_read(&EXT4_I(dir)->xattr_sem);
 	return iloc.bh;
-- 
2.34.1



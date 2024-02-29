Return-Path: <linux-ext4+bounces-1434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6786CB6F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 15:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E303D286D6D
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA11361D6;
	Thu, 29 Feb 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDaCacHR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D831369B1
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216668; cv=none; b=ioVLODBTyBRd9A5KFQdu5GCp2C6qQa0xDoKVBTXDxAFRKM1Vt2UWDTMfGN6+P3eiUT28eKZJQ9tX+q9pd1bgE2Hv5TTjUlNU224f15UF3PxsAzwR7dNMq0EAwgYpjMnd297nr31g965lZhYjxhd4Z0QmMXOE/0Yq5RDlWL+tI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216668; c=relaxed/simple;
	bh=5sdwJcrorpWZYJYa3Cxxef2Wg2r5AC5nmj/VEvFeAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkAuID4r6iNxBbj7opNlgOzW95UDC3uOsxVJ9UktgJTQrTPWya1/vSOv175v7AX0y45Q1nC1+MZWMoNZcsvXELT3NVY1SfIT5508zWmO+qjtRdPrnLlR6x80mCcFRwzNVhxlVnb0OjFkhp92lyt4DWcqU6hzYWnpiIeXYIWth+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDaCacHR; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bba50cd318so647025b6e.0
        for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216664; x=1709821464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCNmVzVlBGnDKAbqszPwXD9+Tbb+ulfXyjjucBp4CFs=;
        b=NDaCacHR01gew4xkR4Sfpk6W1GdL2ZcMDJDcs7ghdFXUZPUKaeccVE0pfEYX9y5euu
         vtvalfhww85VjU8afzD5O5mkT8SolkFBHX8S91FDL8PtY6UtwYiuD3eGa/6X9yy66xkH
         G5WQkvqjEfDUlP5Y1rzKiWi2r5FIPFAn/RlBVdSsqlRNHfKwfMouPlcwiKQBDLuZqRna
         w4hikk/JscT6JOWGi2/J+Hezq9H6pT+aVVrhrhLqFIZJIWpmfqSCAM8A3LXDhCbgcSVc
         2vmOmiUj/E4IzikxP8uf+HeuyZFlWWtD71I9usvoBJQfDPvhq/lsoI98p/W+bFjU9N01
         M07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216664; x=1709821464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCNmVzVlBGnDKAbqszPwXD9+Tbb+ulfXyjjucBp4CFs=;
        b=sf3iByzZHSjCUxnKVSUVawIsdBg5nlNxsI5EVUOM/yC7ys4Otni8VssD8Otkc5q3bZ
         WXaeY3yr+qoPO6TTyKz+j5xMHLdwYe3OocCQklqhxteJUb0HcbAO/k46bzNvFp5eg7dn
         fGH1Gt8NDvbixXekHTwGtkh6KDGpgNxMIsTFMptz8vlYy6EcUhUgv6WDSCOEBitVg4N3
         Prn0iFqcI/vsUNDKXjv7qPzkz59dEFPIfSkgJkQTrkwIqkPbWrLR/D4d5ztIKiLtmbWx
         FrE7+R2rbvFl3y0E6uwndg1n+X16PAEoBe8JYFizshEswHOc0NUHKgCeKYfchPmBUY0i
         JZYw==
X-Gm-Message-State: AOJu0YxUzSEyx51ZQb0XfQcblQw5OFwlyeKaX6rSFAf37hxvYnPccZa7
	bLVYfB8c3euXgjIr3pLBnbU2777jc4rzcG0qoPNz5i6zztKypfOsBf/54bkNwa0=
X-Google-Smtp-Source: AGHT+IHrlesZUO+xY254h5s3hDMjCg4XtB0h9AQXAvgQBNIqwwGmH0KM17D8WI/tvviu0nA9SNpuGw==
X-Received: by 2002:a05:6808:2e86:b0:3c0:bdb1:eb8f with SMTP id gt6-20020a0568082e8600b003c0bdb1eb8fmr3057660oib.17.1709216664086;
        Thu, 29 Feb 2024 06:24:24 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b006e58920c58asm1306693pff.185.2024.02.29.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:24:23 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] ext2: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date: Thu, 29 Feb 2024 19:54:13 +0530
Message-ID: <94f78492f55c3f421359fb6e0d8fab6e79ea17b2.1709215665.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
References: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c  | 8 +++++++-
 fs/ext2/inode.c | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 4ddc36f4dbd4..10b061ac5bc0 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -302,6 +302,12 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return generic_file_write_iter(iocb, from);
 }
 
+static int ext2_file_open(struct inode *inode, struct file *filp)
+{
+	filp->f_mode |= FMODE_CAN_ODIRECT;
+	return dquot_file_open(inode, filp);
+}
+
 const struct file_operations ext2_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= ext2_file_read_iter,
@@ -311,7 +317,7 @@ const struct file_operations ext2_file_operations = {
 	.compat_ioctl	= ext2_compat_ioctl,
 #endif
 	.mmap		= ext2_file_mmap,
-	.open		= dquot_file_open,
+	.open		= ext2_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_fsync,
 	.get_unmapped_area = thp_get_unmapped_area,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 5a4272b2c6b0..6f719d784eb9 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -965,7 +965,6 @@ const struct address_space_operations ext2_aops = {
 	.write_begin		= ext2_write_begin,
 	.write_end		= ext2_write_end,
 	.bmap			= ext2_bmap,
-	.direct_IO		= noop_direct_IO,
 	.writepages		= ext2_writepages,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
@@ -974,7 +973,6 @@ const struct address_space_operations ext2_aops = {
 
 static const struct address_space_operations ext2_dax_aops = {
 	.writepages		= ext2_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.dirty_folio		= noop_dirty_folio,
 };
 
-- 
2.39.2



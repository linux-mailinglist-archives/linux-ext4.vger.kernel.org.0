Return-Path: <linux-ext4+bounces-3732-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D639E952D74
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 13:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF31F25EC2
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326537DA9D;
	Thu, 15 Aug 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsg5Rk8c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA831AC891;
	Thu, 15 Aug 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721274; cv=none; b=EabVhZO9c5dTiKGnisnyl3t/sNoJO0Np0KI6MHDVon68yfUsmR23G+ESv42pTll5GEDr+OcHaPNa20yq/6Tye53lJZnOqwNvmORMMN9kFduEt+EXJjXG2DYU2AsIOz4axgCdz0NBDuxlf5mRWRm3wttqtFRpX+SZnzvQpqKmMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721274; c=relaxed/simple;
	bh=jMQOiwjRbvfwNZgSQ2FQRzwUrVRGLEJDvC8BdAPu9ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rraO2aMaPYlPckdJ8czvbN+09BoUmvuskMepLK86hg710YCbjrC6oVKhLEIQj87LlDC+qg1mV8b73HzGGXOAEOngIUu8rKUAk31kQpptoIYUCOWstZp1S5rDo/44hvjbgX9AWwH+3wAzS8tIec2LADXDWCEGWnxxGHx8CYIRYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsg5Rk8c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso591800b3a.2;
        Thu, 15 Aug 2024 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723721272; x=1724326072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKheqVSEnUqvFLH/97WLdGTkqi4n/pNJlYmRDr/i0K0=;
        b=Wsg5Rk8c55PaUYce6qgfb3Jb2TxmZCYC22jxnyDARaJKvc+0mcSSXIvYKrd/VFrfrs
         7NZz5XgucGilHB7ptjKT0ysD9rMbr6NxCmaAcZqsUqZ6FVemoh6soJmnvZ1ftkrRivnO
         lP/lMbTvOBWhsgR3lQNyXajhh1Zu2uhzFQm99PAZgPAjXh5iAVa62J4pKCHe4VFtS63/
         iRqwcnYkSG4IrGpC4reiycRR901yL8FxSFfAhDesBQ0pUlcAxtKUAIX0uXIDgcGf+gPX
         +sadfe0QAcx3nizfmww24X6rAqZeMczkADO2Irgqh1hI+ZN+ENg/SuqZpS42pUA4tASv
         ddiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721272; x=1724326072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKheqVSEnUqvFLH/97WLdGTkqi4n/pNJlYmRDr/i0K0=;
        b=Rp3oxhKcbf7GwSMwJWkm4TGMYhen8W8JgSQZpRUfJRuX+fhdtNx6ghp3BknMMrb4Go
         fMoQF6nOS713E7cTetboCsJl9rNAS5jEPB84xPBXj5E7JLC6PBiFNXDKh89kl97VHxL3
         /h5Ft/KQWw1zqne4PK56BAwsoAfB1YcUCel82beD7U7lcJlbjFlUGo+tCz7/Pswthp+o
         uij6O2HRNE8piLnr4xriD9VqWyqIFn55wsBj3Tt6xf0oCKinerTKnd/YKG3VXuG67aKd
         uDTN/fPjakyXhLMNEiQNvB0acts6MwAhs09KLEGZhs00EdJ+jX0K7GnU59SoPiRPUbbe
         dogw==
X-Forwarded-Encrypted: i=1; AJvYcCVa7mrEq5p7KT2WRuiWy8Na+ZG8INDbbD5LbBUhmYiTyylzN4IomkXu9sNRJhhZHq+c5PMdBv9ZX7YMfV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrpao1OdqMSu+ytKCbTjGHoNoAFxmIdf100d3QErPMDlAq9wLz
	OC3u4o/I5840qaOocXVSHwu2k4L13GJu/6/2O5XwjyuoW2bRkL5V5E3aP8F/
X-Google-Smtp-Source: AGHT+IEv1Mhf/8/EmGnrV0xJC0S5lQ2mFMobbZv55rNB1NQ0v0Op70Zl/X9BZ62BmHAcO7d01+yMZw==
X-Received: by 2002:a05:6a00:1404:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-712673ab9acmr6684894b3a.20.1723721272482;
        Thu, 15 Aug 2024 04:27:52 -0700 (PDT)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c72d8sm822262a12.23.2024.08.15.04.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:27:52 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] ext4: disambiguate the return value of ext4_dio_write_end_io()
Date: Thu, 15 Aug 2024 19:27:46 +0800
Message-ID: <20240815112746.18570-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
direct IO") causes confusion about the meaning of the return value of
ext4_dio_write_end_io().

Specifically, when the ext4_handle_inode_extension() operation succeeds,
ext4_dio_write_end_io() directly returns count instead of 0.

This does not cause a bug in the current kernel, but the semantics of the
return value of the ext4_dio_write_end_io() function are wrong, which is
likely to introduce bugs in the future code evolution.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/ext4/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..6df5a92cec2b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	 */
 	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
 	    pos + size <= i_size_read(inode))
-		return size;
-	return ext4_handle_inode_extension(inode, pos, size);
+		return 0;
+	error = ext4_handle_inode_extension(inode, pos, size);
+	return error < 0 ? error : 0;
 }
 
 static const struct iomap_dio_ops ext4_dio_write_ops = {
-- 
2.41.1



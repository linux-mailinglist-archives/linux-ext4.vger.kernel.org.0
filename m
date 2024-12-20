Return-Path: <linux-ext4+bounces-5821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F899F9543
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5318831C5
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67D21A45A;
	Fri, 20 Dec 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4C/XHBa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D121A449;
	Fri, 20 Dec 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707855; cv=none; b=WxNd0RGemolL/xQ1gs8YaNWZ96SpSeIb10zMuE2OWwk50r2UwzSUUZva9nVQmNDD25kvqpaivzo+Hf7Up2fC5noG3tKJhXRpB3w1nMnQwAlyQJ+YzLc5m0sbr5dx3/JIS1FkJ245LfE3Hc7NV2dfjCihlPMr1gA5Vtb5y/2mRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707855; c=relaxed/simple;
	bh=+l125FCIio3jc7xkLqYtOpV6fVUzW2bGbqPDfBLQ95c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHtYkn88Gxz/Q4QvLgxpThLAIIuMksqI47FCdO1LfqnBRXurMbh9LjxJYng++KDaWj3Ed5cXr6R/QWGvySYFlBnhib5kNHvFldAyjjD8PlHrXSdzGffHb04PSHd5akKGqTongLtlo/M+xT2lp+HWvXenoAGZ612eoLNlG+TQMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4C/XHBa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1472422a91.3;
        Fri, 20 Dec 2024 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707853; x=1735312653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iusn4zwVH0ycFLzmzIggbRz4Uv05uzzTCW5NCcfxX7I=;
        b=F4C/XHBavRqlLQh3r7qVktzwho4zer24msCFg+TiV4Z9gAn4cA7aki5K+xhGzU88Gt
         FMgrRUC2dXmAAxbtxjoV9URyw1cvftWmSGOKFLopX+2n9R6f/LG6hnRE7heIWgssY4Qq
         m4Gtqi6iXk1z9HqzfE+cAIfGUPt3T+FQVvCyIAKDITRrLtGPxNKTVn0rBDD5k/JJBiZE
         2F1yX1S9HyHNpSMedKRge2A4b0WlO/xqS00itN9Q/ATF1MAQvEBhRNOyBaOhgX4RRm5X
         KL7R0/IOPG4Pwk25QLM0+kOSxIXZg8722YZ2waLkauEynau7u+9iC4HOG1S27S+LOOMk
         flBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707853; x=1735312653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iusn4zwVH0ycFLzmzIggbRz4Uv05uzzTCW5NCcfxX7I=;
        b=w0JcI9CtRz18jtlV9z5lQLwwUcm29Sa6cqr2D0fgBNsdRcNuHfswoH8L1W3Y5IKJPy
         dAZVinbcUqqjEUExBM/ib4CxS3f7fr/EHWFUDSlHpFVd3+RChXtkcmSARpAcIrbuQKXf
         SPS78xTdYcvorKnORliL1dsQZcERcxw8640vpfN0bHaRVkiWFvPJC6XkK4xgRP5vMSHF
         WPOntmpFU3JupqD9DE3x48oDJvr086Jdl1a15sYdiKCSDTXMZQynBiS+HcMU2FIx6S2y
         50KLLhMqCGguHr3rXBeltgZJenirK8jh1s/CJlN/BgdlRbJzTQ3q6sEhGTBDDGd/PWrD
         HBwA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5RXadnh+NUh/2Yumd3DjHfJZwQqlSGrBtkJP1JvxvUdbOTPldroj6mUEVTZ4SMolL54MpWEdEv2X320=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ul5E4BTozmqjbcAN6lMqjHsOxI6Jov0Mj01ffGFK0YDPwVKE
	qkN/IMomx0T9miADLJDEKcxdUlVdvxzZrET7+Ps07PqI22ifLde2q8B8A7EbctUoQQ==
X-Gm-Gg: ASbGncvTtedUclQtbiTnfH5GxKqnRYMguzgRsjg28FRe2nCzCLBGwbpgwDYs0mXj+ul
	TdcZ4IKLaCBtxFOTP4aQF2ho5lkINKCaGwyXzTGTYclqnMexA79Mokvm15309I8NqQmP2OqXQJt
	b5cjiEC8aLwbJAie6OU1K31wFGnjATD32j4KOj3uboVKDBakDx6rzUU3rm9y1q0GeCcojD/pS2b
	zhL8CsfgTtts2ovXzlnw0oWRuHde6Fzr0Vuavk7bJgIcEw9XK505rtQUwc8Uig=
X-Google-Smtp-Source: AGHT+IHOGsKlyPe1BXzSthUnUR1RmDNy5LK842i9ozh6ph6DSJvKZnOut9X8Qv+cBbrUItmCoeHntg==
X-Received: by 2002:a17:90b:524b:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f452e38c6cmr5171208a91.19.1734707853031;
        Fri, 20 Dec 2024 07:17:33 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882b09sm3762402a91.41.2024.12.20.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:32 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 6/7] ext4: Refactor out ext4_try_to_write_inline_data()
Date: Fri, 20 Dec 2024 23:16:24 +0800
Message-Id: <20241220151625.19769-7-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220151625.19769-1-sunjunchao2870@gmail.com>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ext4_try_to_write_inline_data() to simplify its
implementation by directly invoking ext4_generic_write_inline_data().

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 77 ++----------------------------------------------
 1 file changed, 3 insertions(+), 74 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 5dd91524b2ca..2abb35f1555d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -747,81 +747,10 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 				  loff_t pos, unsigned len,
 				  struct folio **foliop)
 {
-	int ret;
-	handle_t *handle;
-	struct folio *folio;
-	struct ext4_iloc iloc;
-
 	if (pos + len > ext4_get_max_inline_size(inode))
-		goto convert;
-
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
-
-	/*
-	 * The possible write could happen in the inode,
-	 * so try to reserve the space in inode first.
-	 */
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		handle = NULL;
-		goto out;
-	}
-
-	ret = ext4_prepare_inline_data(handle, inode, pos + len);
-	if (ret && ret != -ENOSPC)
-		goto out;
-
-	/* We don't have space in inline inode, so convert it to extent. */
-	if (ret == -ENOSPC) {
-		ext4_journal_stop(handle);
-		brelse(iloc.bh);
-		goto convert;
-	}
-
-	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
-					    EXT4_JTR_NONE);
-	if (ret)
-		goto out;
-
-	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
-					mapping_gfp_mask(mapping));
-	if (IS_ERR(folio)) {
-		ret = PTR_ERR(folio);
-		goto out;
-	}
-
-	*foliop = folio;
-	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		ret = 0;
-		folio_unlock(folio);
-		folio_put(folio);
-		goto out_up_read;
-	}
-
-	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_folio(inode, folio);
-		if (ret < 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			goto out_up_read;
-		}
-	}
-
-	ret = 1;
-	handle = NULL;
-out_up_read:
-	up_read(&EXT4_I(inode)->xattr_sem);
-out:
-	if (handle && (ret != 1))
-		ext4_journal_stop(handle);
-	brelse(iloc.bh);
-	return ret;
-convert:
-	return ext4_convert_inline_data_to_extent(mapping, inode);
+		return ext4_convert_inline_data_to_extent(mapping, inode);
+	return ext4_generic_write_inline_data(mapping, inode, pos, len,
+					      foliop, NULL, false);
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-- 
2.39.5



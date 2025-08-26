Return-Path: <linux-ext4+bounces-9629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B4B36E0F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FC07C6936
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D334F464;
	Tue, 26 Aug 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rhBrX+W6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69A279357
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222857; cv=none; b=thgfn8vCR8Mi91moi96nz28fQuXbFPZYMyVVwKv540tOf9p4uZfKPgjme6+KW69RwHDxJH1PEGN9drwpYxJzKJvh+8n5hJO8bjAjqqv4/1NAVowHCK7ryc36GOQQ9OjWgg/PfOB2n6Ug2FSZA2rgh9agPc5iwra1L9Dsjan6tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222857; c=relaxed/simple;
	bh=824s3eeNyPtqfPMcWFvG6qpWsh9sKBrHSzpVhkI4CHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeIApOlPBIDChkN4wdRWoJ6coVWA28easLLEutk5AlRmktACZOA/0fjLBEBL1DKDphT4y1AvIAFBysBW7Y/gO+b4hxwy3xzrozw+bhhb8zr/8yHe/17GcYLQ8HXM8od6zSSO6hLxq6zr7h0pd9aUs33RW/yXdlB8Tz5u7DthEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rhBrX+W6; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e931c858dbbso4583652276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222852; x=1756827652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOHH5GxgumXNSgv4ws5caQ9qUmUz2v1LLekhwJWPqgQ=;
        b=rhBrX+W6C4K3I41wVrVmf+OKGbkRdx93AtalnWNvKaLxZXReAQ4OrZpiKdSStqEkPR
         kZzZH4pwl4rN4JkwMqPfs6N5OqC3f/10yGV9GoOw0SVJDabs+Fl9IbFl6TEllQTShOI5
         LNER1Bs+N1CbpV0HBKxX1OGmQUJc7YnsemktnS39ZrZ0+PtCeawlx2fIbOezIF+zUV3N
         J8oe22situQdTmTiobPiNW3U6i+GzrutZjm1AgCJwRqVBPEYqEKTCTNyfGvbDDcPgKlO
         zAv8wphWs2apXQnkyzwkl7EWE+6yyR6S+AJyPqlzs5K9Fmi2qUUXJnBvtTpKVnLeuNwy
         iATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222852; x=1756827652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOHH5GxgumXNSgv4ws5caQ9qUmUz2v1LLekhwJWPqgQ=;
        b=uA6NnN1mGm6Lr834c1mhztaV8ijZkAiZm6oMCkY50Mynqabkp0cZwly3ULUpL9wH8b
         P/Og6O3Tk/eQc7swcx8VXgJSKYy34/7bWB8C+3RTSv+AtTVoxeZgbcbg5jSCP7GqMSOQ
         RCmg/teVgdDyky4DiBt63tW9YiCGLxDyjK/PRnurUFj8eEWpxhhfXKX5ehYiacvaF8Eq
         r988jo/UAzlrSLDn0XBS+ko3gLVin+Hakb38kf8ndZNR2h3AFlBVIj1T1Pim5PeX3+ou
         +/j6UTPMeqPgTg25hcIIJNd4gNGrHDuPLTBy1UoKJFDYYXr0G9wFljGfK+XPTm3q4k2z
         KNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7K0OzU2FCRS+YUffo+FsJqqfJh2axg5zYRTD+IUwWJJgSxSI6RpOrD9S59F4dqMObV9K20rXHmcxR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2STdQ7WuZVr0dgzXBATSY4FoHGi14Pg6DSNbsnP+yi8/hEDAA
	v+i25uLDtLF5FBNCUdKa7IeOfMt3q2VNnUVOgdEoAZDhsI3w4U4e3UWLPTiIu+LN6Ns=
X-Gm-Gg: ASbGnctjHgR0cLdRySWY1nFeNaKFCeuDNI5MUVtf8oEwI8+ln3qj72Nf8rxiF1GMghc
	LSjLnS/MFPuDLXhOpKV3XveEsrCJ8JfPUFSMA5G9EHK3WcsTRSIe23++eGEIU6ayYkwfIS4Lz06
	hXfPCJkiMmbe7Bz0awxmjB3nI3qyS8oEXlseI4jI+iGCk3vTrtt5+FXvQ/fcs1TnQSrs9BAN2iF
	kw5MEKkHhTSGD8EGternUOjmbIUsaNEamRDgiqPRQEJfd1o5I65WCWMTvnQMGlTutn04xJfqClM
	1dFeE4fmP1Y2J/+tdjV1BkmUsVSecq1eJeak6TBWFqLlR5d7vRYlPB8eENiGc9rkMkN5UVjcJNl
	HuOq8BOkEFjVImp4xSRxSHdoMFXS1dr7FcBbkAKwmSCA0LDpNcZFNYuy8hLqXA5PyxKMvZyt8L+
	hIXAqG
X-Google-Smtp-Source: AGHT+IHCkFxTVHekKtVIMKKoKBA/v/EmSAFjwci1Wt4iPVt6NciQDsFy301ND2wdcONLCbcSXMgElg==
X-Received: by 2002:a05:6902:2b03:b0:e95:1945:8672 with SMTP id 3f1490d57ef6-e951c2ce819mr17137482276.10.1756222852464;
        Tue, 26 Aug 2025 08:40:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c37715dsm3292356276.36.2025.08.26.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 03/54] fs: rework iput logic
Date: Tue, 26 Aug 2025 11:39:03 -0400
Message-ID: <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
set, we will grab a reference on the inode again and then mark it dirty
and then redo the put.  This is to make sure we delay the time update
for as long as possible.

We can rework this logic to simply dec i_count if it is not 1, and if it
is do the time update while still holding the i_count reference.

Then we can replace the atomic_dec_and_lock with locking the ->i_lock
and doing atomic_dec_and_test, since we did the atomic_add_unless above.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a3673e1ed157..13e80b434323 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-retry:
-	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
-		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
-			atomic_inc(&inode->i_count);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_lazytime_iput(inode);
-			mark_inode_dirty_sync(inode);
-			goto retry;
-		}
+
+	if (atomic_add_unless(&inode->i_count, -1, 1))
+		return;
+
+	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+		trace_writeback_lazytime_iput(inode);
+		mark_inode_dirty_sync(inode);
+	}
+
+	spin_lock(&inode->i_lock);
+	if (atomic_dec_and_test(&inode->i_count)) {
+		/* iput_final() drops i_lock */
 		iput_final(inode);
+	} else {
+		spin_unlock(&inode->i_lock);
 	}
 }
 EXPORT_SYMBOL(iput);
-- 
2.49.0



Return-Path: <linux-ext4+bounces-9660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D63B36EB2
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DB08E5404
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D536C06E;
	Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d+q91+Ln"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D5369981
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222902; cv=none; b=T8w8geLuuHRkkOLl1/mNC8blXfaul9B0HZM1INstkpAoTmKtwzuuolvVRZKpOhIlpP9cBjWJGXElo9kzPLHh4kefwW/bV1g9ZAdsS/Xrq/4dibxgA1ZRJVTJXVBvvcxoQq9u2fpACKKI4xST/rCpQZ8kNSkSe5hBMLD7teY1jvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222902; c=relaxed/simple;
	bh=x4c2iqAV39w68dzaJaOLDjwZ1CiAhVhup47lgo1+0KA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaKUVVk4CQn/rjFsZ65DIJU/vcLFMmdDNz6LLpKehiPSwOIIlH+HnQSGP+aSpcz/OfW09oeQNjHIg73XAcFLWutHQ3b5+YRT5o2ZWSy/ZHKYCuvQIkjUlcc996dlZpYtaAghgc63hnQBZ3CtlhG4f/wmx7rFEzw03+teNPfQp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d+q91+Ln; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so62450357b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222900; x=1756827700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=d+q91+LnZeCKIF5NP27wS8hZQE7/PoR4R7ofsaefdHGnVzX4/dD1sKQYT3oudmq/nG
         2JLwDYxzIB5l+1yqc+nrTTC85GCEruVOxvDsD7KCunzaoII1Kv5sdQKsM4AM9YzwGuCn
         kxeMnaQrCB1WYInMXpR22ENyNiAmi7jiuuwFgAI5ikmEenVncS4nIjK1+SvOMNtQOtEk
         rMXjcv+pL2+sraPzhCzF/mCjw9A3/sHvRMPVvjLNv02cIbKROWKyNgghLKoV75POgbJ5
         5cNsRz0LjYOHPj5bZmIy7I3FqFUUyAZrIhPh9mZ2poJyxftf9/i1WhqzKoXb4nCepC9D
         N2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222900; x=1756827700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=M3Yut9G1C9WdtQj9cOSn93/bPKu/Y1ZnKzLgCwtvMIDUS7X68m8d3Qx/TgLdiUWouE
         VbiMRpeLCwacmMF3wHsgX5cehVO6o9S0CnHx2txWfLP3YiSWR6syIIM065J1eoXs4p5G
         47UV6ud2TSX9xezYpcsGWXwrpaM3d2eicOHxuUhXps/K4CN0V1FRN1wNzfmzJAhPOMBu
         dUGYeWaytn27dFkTY7QiguGsjx8m3mvvc8TzOMgcwruixRVVtAk/RmUY5ptwRKvb5FVC
         /EySU32Z4e0j+cL7dsegAKUjxZnjoT3JetVj51Wr76c9yKQorB3aqTCwbRpCTgpFtEwZ
         02LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0GZknH1WIbywoQfgrJnH2fMdhtTcf2qXUqHiRvxRsNvimqVpWEwuo/4QEZXiV79WiG7s0Rrg+i3Yd@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFxWjXsd50jWxxQCT6VQSjAoejOaDjCIT5t/2TCAU9NQ+mSrQ
	/Uu/K8BUMbuSZV283N2hovXVHmQWVlvnZiNK2oNmx3k7iPDipnW+nwuaaHdL18j+XMc=
X-Gm-Gg: ASbGncvhQOccVpstD0V1i3i0ZNXmYCzB6ltRZG6FMMwq8TtpY2HcILmgD5XXRGC0pdW
	zlRAfvgjqoKFgQDxYrppw4msuDJOz5ONXScAddftseyczLfGgDnYJ8HlFtfmbeXCsJcW7dSpkt0
	v/EFxhEe3dYfRU0YYLqyAd2mIL5VIm9Mbb7GcM1M95RQvFzDDi8MWOCPg2fOZqAb/dLjQKWLUp5
	UU2QOWU1nW96wkzsP6Av/hQcduCqotFnnbv2KtJEoWLgbcV05gAB3tMZBk+OvJsJUuchwy20Qjv
	vzpK5EJTYw6JTbv7YdA6cCwjI0UdAGEgZiarg08IRCCatRqw1AB65wMIOSrl9DTtroCQpi6hp0Q
	3izCtTe3uucC2ObqbWz46FcDARL+oqKytBGYdLFab5HbJu1qOh8Ytfv74bqY=
X-Google-Smtp-Source: AGHT+IH6IljKhKMKAzfBvsIF2UqCk9sa/1rQsNeda0irdzGfCJ90MbR5GskvJ+4DVKKxRao85tvYhQ==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr171930987b3.2.1756222899935;
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17354cdsm25393337b3.20.2025.08.26.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 35/54] fs: stop checking I_FREEING in d_find_alias_rcu
Date: Tue, 26 Aug 2025 11:39:35 -0400
Message-ID: <8077a41a37c9088d3118465ca7817048fac35f90.1756222465.git.josef@toxicpanda.com>
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

Instead of checking for I_FREEING, check the refcount of the inode to
see if it is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..3f3bd1373d92 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1072,8 +1072,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
-	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	// used without having an i_count reference, which means no aliases left
+	if (likely(icount_read(inode) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
-- 
2.49.0



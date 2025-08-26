Return-Path: <linux-ext4+bounces-9641-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A0B36E45
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262932A6DF7
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8612FDC5A;
	Tue, 26 Aug 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UZ2Ilx5X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715435A2A1
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222877; cv=none; b=JyBb8PLUBYbUGCBapBoZSvIT8qLHVVHSAh84bV2zuqD91GuLt5lv6gXKVfQ5IZdcWW4GzpMFst3epm4uvXkdogz1ncyugm+ATKCUrNrWaO355N23C4n2q5DT9+UIF5nCbbSVUx0sKlYwS/LqQiIXe3a0Sq8SUMTCcEL6b5YbTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222877; c=relaxed/simple;
	bh=VwsDvHLoXX1uKTN5GqLXpMQ6MRvXRWQZwSKzj05otD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEp/h73ZHxKnlnGjX8ilHYdMTB85Ft9WJ6mmfgVL8oE3Kt2E39wuJw78NXI2nQKl4NyD90R1adiL9Zl18V4tiU+TyX5UhUnYshpbj1vilZLFx9BJe+8V0E0/TRotc4VeZu+kH0icRAbp7uok/s1zGLoqRsaXcBgfjRDPfLTyCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UZ2Ilx5X; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603b60cbso45352957b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222872; x=1756827672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2LHx31lTtBHtYaRln9gOaHDdksI8aSH74+SGcGPP5E=;
        b=UZ2Ilx5XYrI6h7DZdgdXxsM7wqEqa9/YxK3DSxpz3AWYFZatt9JwfV0Ei/YIUE8UWx
         QYb9beu+HB59eu15RwEarmcNsr6P2wZvFuUJ3D9SFAmiefPV7x3nmChdd6+okD/Nys7a
         7wfGfOXUPYTuHuNRcDFJsBEIysA/GmA/E+42PRwG/j9NgaE262btjHzNpzgTDNbIUMly
         2apjbW/dCF9+qWSHgUIY6mXZte7xH0uRcwB8nhyPw9P7dyizZ5+zn4ufAhh9kQwNFbQ7
         Ve+zXsJKfPjdHZleXzMv6cU0P3WOvXlY9sQk9zdFgZwBrl0qPn78T74YV4YO+joJhhz4
         5qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222872; x=1756827672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2LHx31lTtBHtYaRln9gOaHDdksI8aSH74+SGcGPP5E=;
        b=SlsiKMpFLjK0f7yorSI4zm1xGzCGhHdsth33Kt6THosFfJcC8e+CMvIWlmM/pgMkM5
         KTiqK7dtJkSN6MFQI0gT9Ob2BNSTXV2r/dr3IG4ph22UWrhqLktwvGe7F1yj9zA21eU+
         Qa2pgspMvANm33NU6CFn1YJPm6heGMqH35Lb19Xh6tkA56C8oaiRjPAkH1dm2asOAKsO
         N5qi+5xw+Rjik8alkK1IqFSeBJFOH5lwZb8gWMDHtRqDUWP0OuML+HvBPfkm71BCXDkr
         eWeJygUWOPEeHDqU9co2X78JhoNS7IDoOw0bZu6tqr2futj2liyQpD10QU5UBcsAVnXD
         xEKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjhbD9hUqHCvekVTOMVPobsMI3WiHk19yQ4GBiGOKuH/dDP31bGJX9E4ry/cI/fS/VVNWtO0kq9V1L@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ8fGb03szo+X7DNPF6lL4Gsm1Fq5RO9K58S68ILQ4P/K5a1x
	1huUBcPUquZjMEnMKQEHkkvzsKOr6fxb3YYCNGquSxpoG+S7RlfPgHavW+QOn46JoSQ=
X-Gm-Gg: ASbGnct3zAC0nFh3T+zSon+wzHJT7+AHxCg9XmUVaVbZ3n0NhsST/A2rQWJe2pv8nB+
	pvL6SVFPPFSvsc+pKFl5FxEN2P9Z4lKzZfZn6lQjsuhPxDQVz0qg/l3Rye7bJXzut7Q2U+M+HNd
	OYJOPYoRH/fd3cNmz2OIEBlLOF6AF1hC4fRxktHE6sXAkGiCZxZxCtZE0vCmVcnzC4jrVuhZzDA
	W+93nQSWcxDFMso317qQh5caGeKgQWtAKrPMrTTzDk8xqRH4owbUNAtUQTSJttae0jjnHJGbuwm
	+ePfWw72I8zevpPTwHLx5/HYJuiyUK9gPmdxL/TrJ/EWIIcdnPP7Ac6iHYD/OV4rjJCdscozxBE
	0cjvHgvdWEuEhQRYmpCBRBUbi53kZtJQULxXg8jhjRMjDriXGAgxbJZ85SX0=
X-Google-Smtp-Source: AGHT+IGT/XuD8mmhvooE8E8UkA6256XoF7vusI/+JGpOkFM0b1RNjbEYVhkocKaciv/nEIMzWHJRFQ==
X-Received: by 2002:a05:690c:7684:b0:721:10a3:65ae with SMTP id 00721157ae682-72110a37a2bmr69440357b3.11.1756222871810;
        Tue, 26 Aug 2025 08:41:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff188b0f1sm25303157b3.42.2025.08.26.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Date: Tue, 26 Aug 2025 11:39:16 -0400
Message-ID: <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
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

When we move to holding a full reference on the inode when it is on an
LRU list we need to have a mechanism to re-run the LRU add logic. The
use case for this is btrfs's snapshot delete, we will lookup all the
inodes and try to drop them, but if they're on the LRU we will not call
->drop_inode() because their refcount will be elevated, so we won't know
that we need to drop the inode.

Fix this by simply removing the inode from it's respective LRU list when
we grab a reference to it in a way that we have active users.  This will
ensure that the logic to add the inode to the LRU or drop the inode will
be run on the final iput from the user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 4d39f260901f..399598e90693 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1146,6 +1146,7 @@ static struct inode *find_inode(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1187,6 +1188,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1653,6 +1655,7 @@ struct inode *igrab(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
 		spin_unlock(&inode->i_lock);
-- 
2.49.0



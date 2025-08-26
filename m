Return-Path: <linux-ext4+bounces-9656-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A5B36E89
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789B0460B82
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB236932C;
	Tue, 26 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VX3rg/1n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2023680BB
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222896; cv=none; b=QviNTxPC5+VRFcLtpz/LGAt1sSYL9Ea1LB21TjBpFNHI307S53jkwmN/xxQqdvZpoLeHJ7RGBSNBkFOwF1ynw/dJcU6tK2DuTfZlh99K8nk+6KvaiP/oZkDNhwDF2xnCZt+HbeYXvbK6/dODADWNp9+jA2wkNaZxBgwywQVhcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222896; c=relaxed/simple;
	bh=Ek+K7HnIxIEopRMdqMnNty91y2VWEE+x+hrrKpFJIDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2uiNFl497tr9BwWTzZwzSfysjN+DfPhTfooHktXm0keaO/hLnv28r1f/r4rhFanxrBhFuTRN4cFVPtKnNJh3+4IRD63LW9j+xdopsiOy8V2FbnWBY9uenvOCEafLeqr06G7yUYU7zp6SnXmI/DA2ZLnlChVWsJlzMWeJiBr+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VX3rg/1n; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96eb999262so150950276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222894; x=1756827694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=VX3rg/1nwaBPBki8rHZ8UMExRSuThguHtxx0flJqoSvOXhaKgDjDtKIA9EExV3qk5T
         Lqz10q8Di5PI1oODeVYRbgF9u76OCf+emIJobOksU8NQXOzWMc+5V4S5R+zwW24dLhrr
         o3mbJQQhDm/K2PBw/cD36W1RjN4n7mW+rT/mHqT/KCDwiXwhmLiHqBvUZ2+V7kv5Nnj/
         LU7Uft/YyWnrh5UMWE6VaGIZ1Y89oBRVuzQ8LFofIdzNVuSH1+CeQVbKI6gfxtBxnXY9
         9POUaUX+9zt9GdgGY1QctZaiKg/jBZ7hGSx/DUmlX9hLHYgsZeIPLwZouW/pYPC8fZCt
         RC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222894; x=1756827694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=v39VH55iMg8VEGx6gCi9u3TuASeP/ZG/a7dHnNlPTIWviM364B+YkAUugnhpNgqzOC
         bAfkALsIiKW/ai5BVMOZYD4QEvjdxj5pzGSsg9QZ4kQJHFzlgPtb9eeGC12vbUmpnaxw
         XRIdFMuOyOa9VEO6tSDygTdTOpFgvlnWBdjG4wYs6O420iBNGznzMx0gJfkuuYXPuN/I
         MPBr6/xCxHkze7DOsgNFVQqsq/O5LPPTcFAWzPZUHugap3oUycDBzSXjBgbUWTciFCgq
         cNRa0FAvzsi9+l+dN5WSVqG2npmRp13xuuANPuBRgqGwKYFTKRkWIF4NtJNGouvzpQQ+
         XbbA==
X-Forwarded-Encrypted: i=1; AJvYcCXhEKRB0dNX9euJ/0L8VOWP6dJB9Hx0zpC9xAwDqFHVApBgnOc7PWhA+Ip7HUiyYIZa2dIAXBpCj8lE@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhCNs1t3ELShx82JBjmLWzoYxRa6r5pAIUeE2cIlZasMz1r72
	RpwWn/YEEIZzxFmaZLLbBefpKPY9OrmJOK8Ks9u6oJne8wFDNvs7IbdpKs7E/fo+2KQ=
X-Gm-Gg: ASbGncuATLtCM+RV2vDopmpxwDQ1bSh0lH1rccfXo3BZU1khzzFklqQ1eR+eQzw+XEQ
	fZujWxWzt8ujOLnneXSS7YS26eZtwhjNpcUfQ5nhdMVOfsXXnSMyv2JdYgY31E+2w37M6ft25zz
	XzAgbKdkV3FmT0wHMQNi+9G/8xHb9rj+LKyUEQSML8aN/UUrPQ+pA+2KYo7VS2vI9d6kJbJ/2Jq
	oNc5Ep/9mWwKdUHk9BGZIGhbhnyauP+L4aVMZpMCI7n4+ygtgPKR74CCfTmKSmuQWeTlIOYS98D
	epm2AR4d1OFNPdXXxjzy2+/l/6d3NxppI+9OgY2xeQ2prCv/bZXeXX+rHKQzDSoIzqMYTdmzn0v
	Wivu78ly6RIFsiXj8ux6C9iuYfOikdjL6bztyPWsg2H1Dh2mneTRa4xqNDOM=
X-Google-Smtp-Source: AGHT+IGsMpG/UCDruSz3Wvi7CzZlKIL5xzEKlg+zB+8+jIE4udBR1skQ5tPNMiXAg2ctT0vtiUJNQg==
X-Received: by 2002:a05:6902:c11:b0:e95:25c2:e800 with SMTP id 3f1490d57ef6-e9525c2f090mr16314789276.44.1756222893943;
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm850314276.20.2025.08.26.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 31/54] block: use igrab in sync_bdevs
Date: Tue, 26 Aug 2025 11:39:31 -0400
Message-ID: <83700637bec18af1ca85a2d232a11c0fa85dca34.1756222465.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE or I_FREEING simply grab a reference to
the inode, as it will only succeed if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..94ffc0b5a68c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,13 +1265,15 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
-		    mapping->nrpages == 0) {
+		if (inode->i_state & I_NEW || mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
+
 		spin_unlock(&blockdev_superblock->s_inode_list_lock);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
-- 
2.49.0



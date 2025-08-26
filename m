Return-Path: <linux-ext4+bounces-9646-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CEEB36E56
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34AC460FFD
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522472D12E7;
	Tue, 26 Aug 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AjnpHHL1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343E35E4EE
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222882; cv=none; b=iq7xWgdANR9tPzhZGn3eJIy9L+SzaG9AeF15oaUDDYrEuFOnnbvjlDwDUuom4ytyVsUyYCQVfmu0mccQhLlgp9i0HW0LPvo5/LYB2Ryr9kMEa61/y1UA6sFQc1K7zgGXFd1whoHrh4eo/we8ncZjiJsqs9DBdAze4KgUNd1ej1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222882; c=relaxed/simple;
	bh=9h6PPznuSE5nPJ74VSVyjjLvORGODq5PPIqVHYaiKuw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn2cHXmoC4tTfW5Zk8JRDIHgWwwYiZ1WutvPscEz5tmi4PD1T2UhkXg3K/G3WKsrdB28HmftXVqr5V2t30QdVhW7hgCd0hIiBJeBO4vXv+8CMRg+H817yJYyaeC3aL108uTwtLueqmhrohBfAHxR10QzaYR4/AmTJdgd8I8EgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AjnpHHL1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e96eb999262so150734276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222879; x=1756827679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbLQoR7hnQAMVl5aGLYTpEQarM8sb2EoAq+ZL5IeLT4=;
        b=AjnpHHL1enuJhFyTHe5bVpEY4e+nbhowgl8US8whiIL2vqfQkOmQ+mh8kNpkXDrv8o
         rpexrT8FbR4WsGp3PXfS46Z9RgG3qXJ+ANuaTGA18pBS1FdrFUEF+MaKo+JP6rOn/jnq
         OIRL4e2vtfTIBqsYG/QqQB3sN/NV8CBAhShtwiGvlQ13Xz1gOjMEKEx5bZB4LJ7/2+Fo
         GYqnOs1vJOw5V2TxHRN7skQFEpPN8KMBRtayCtsI2mf1mdNkGV2BE2rNme9tGFDOtq/A
         dBskaSGuwz6p+rC4g5eZE9J5p8GRbAlAfpq0CCAbUepksUVNDmiRNtmtEEPZs8NLJIbv
         EtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222879; x=1756827679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbLQoR7hnQAMVl5aGLYTpEQarM8sb2EoAq+ZL5IeLT4=;
        b=RK9M+U6C9Pi9a/xuvmUFWGBzjZpy63DS5UO78LQs6lptdD7FPH6SvUhe2QrpbbXQtZ
         j303ZAHo7dgVwKjyjq724X1XeWux43/zHKuSysH1OLSNrvDwBbLXGi9hhP+EF7MQrlac
         o8XHReEBYCcFs0Bu/PbjGuqEMwTWosAVmco2vOaCW+XZM7p2Uu8+XDgHvg0UY76mw+dq
         62LQAk9BEnMFZYh5FdB1CqzFaNfos70lrixCSeXNSlfl3r4qwUJGol87mP78tvIuf2Ot
         NWDtLpDKh/SDoY5b7TNDpmufv9JBVf6lm08V9kfD8dv4mO156II20SxSzUCWSZGoRZGG
         kGhw==
X-Forwarded-Encrypted: i=1; AJvYcCXMDYGL/7tVk7rSCb3Yr5CaGCSNd30zWcZLblzR1HoSAEmZNS70Tzd/+GpjKvOC4ZtCd4idycin93Fl@vger.kernel.org
X-Gm-Message-State: AOJu0YzonHCGjMd0tY2WX+p2twPnp3HyIoFBGVQQbVMXI2iA2q0hL+Uk
	yYrliaLNLWk/atYD8VRW98e0t8FEQ7ZQffoGckVlwWP9r7j1+vC0dkFTEQWcQqsw+wc=
X-Gm-Gg: ASbGncvWOI8EotexoV14PJJsv0/T4HjTO603IYcx47Gln93WMF8doSkxASlXICMrnrs
	/aNaJ9dYIiLeT2YWJ0a6RugC0U295nwT1zUTd46md3MTBGUlEn+8zBTGwJ/uncaIO7P78LjR6rp
	86rHCW+yHJxpQoyKuwKQg3JgcGhCWWdNj4DpOV7UHzKRBJpg2hPIgB29alaxVHiD8S0Zryz9d9P
	ZKoVIQoR6ttnQty5PPPw1ABFTzX/kkCa7i7APjeLR37ERhQKu2ZLdufYJ5sAl1ROM3lXDtXnjPD
	NAgmSyLPEmurFzwRronbceoXRUen1xLJBgoyN6hR+iwyW5kBAfWa1Hadl+gV3UtCcuoY0wMv1bi
	jq4BZfA0OmXX4KARH7ukaQY5G5DeO6l8danQSbYUfdTMQju+Y0swiZA97eOs=
X-Google-Smtp-Source: AGHT+IFVd/Dppsnb6E1/+4Q9E2BDcwXG8IrdClOe5QP1Pciq2pnbXmjT7B3KKQidZ+9xNPYLXeeOlg==
X-Received: by 2002:a05:690c:311:b0:71f:9a36:d33c with SMTP id 00721157ae682-71fdc41251amr159706727b3.46.1756222879135;
        Tue, 26 Aug 2025 08:41:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e9fa5d42sm189948276.18.2025.08.26.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 21/54] fs: make evict_inodes add to the dispose list under the i_lock
Date: Tue, 26 Aug 2025 11:39:21 -0400
Message-ID: <c500d99c66c4b09a212005fe75465745d5c78f3d.1756222465.git.josef@toxicpanda.com>
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

In the future when we only serialize the freeing of the inode on the
reference count we could potentially be relying on ->i_lru to be
consistent, which means we need it to be consistent under the ->i_lock.
Move the list_add in evict_inodes() to under the ->i_lock to prevent
potential races where we think the inode isn't on a list but is going to
be added to the private dispose list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index d1668f7fb73e..1992db5cd70a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -975,8 +975,8 @@ void evict_inodes(struct super_block *sb)
 
 		__iget(inode);
 		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+		spin_unlock(&inode->i_lock);
 
 		/*
 		 * We can have a ton of inodes to evict at unmount time given
-- 
2.49.0



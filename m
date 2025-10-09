Return-Path: <linux-ext4+bounces-10702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91999BC7DAE
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764AC3A7417
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9952D130B;
	Thu,  9 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK8TLnBV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAE2D2496
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996788; cv=none; b=gO1yqd62nxynlTCVwpzkiWmjuSVNNS16uBdbjS6xZEQlzcNkwZmXXo1BwxSR2Gl4+9Mg9k71Dgi9C7DUwmRdiNsaIoJPc/IyH4+l7brSsSyEcg5elristrm+8mcwiquuxRBPYYjtvrzcc9MEt8d/JOjN3dgLhlgLQVcsBAeLvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996788; c=relaxed/simple;
	bh=ASNy7RmtSltSBzEynaqDPxE2iqjwE0ZPcjj4whWJ4kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR66TbItogIvZcWEuxB3tcgcM3UTGI+Y44qhVWBDadfEjh0j+nVGnizuYJnSmTpo5tt7wA922hs7+9Wog5ks1SsD2Dk6yROwlBq423jnum76arLTujbdbRjPycXnuCx02LPwT/V9ksQD+WeS2FOgY6tl7LoEJL4BpNkJCoN9JE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK8TLnBV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso1017487a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996783; x=1760601583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnyVCyplzK+z1W2ORGsEbSjRDIE71IW/QrGYX9ePnTE=;
        b=QK8TLnBV8F6IPKH9b//mxMoquBU1AYrHverDd2jJnQIsgDXYysnPt+5qBsl4ki720U
         3ocIW7Jcipyxz+FB5i0HVbJvTq1bAwhiq0szN2RgKkAbWEjK59xK71mA/UXyiIHGLjks
         i8X1rXeYq/6eOyN9qk6y7SDbeKEfkeMPkSkycmy6w9cX4IbDACFodVHNf7ayS2tuQQzf
         IKbgSxng/5QEfd21nDFSwlasUSaPDixT4WIxVsZxCU8P/0dDBiGiYR4j/rTXKjR9ALI1
         mumT8GIbxFNYEvHLNz1UYKyV+o9ECQ3E/6bbvg2TYrcGqhvXosgo02hjcVjVX1duKbm9
         ES7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996783; x=1760601583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnyVCyplzK+z1W2ORGsEbSjRDIE71IW/QrGYX9ePnTE=;
        b=pJKb23VdbI5349BfbfbiIiojR5vxIrdmHGSy9ivDptp98dfcwUS2gTzkwq7VEj6EWZ
         PK1iVYT85FRJPDTotQOHuzqvBY1/iuZvtCEtUiVsPWFJXvz+KIpbzXeSYktM1AZUcpts
         D6iqdK+pzS25oHSZjjC2w4nSQd3OStJxdJA+g0/o1iladh/dLumoUY0qqse+Uvnp4Oub
         4JuhabNcuUtGaXvvuyXwnVouLjyeosPCUDEvFBSCse1+Q8VinFpuhZYn+nmFn8bPFV1T
         MCqbb9cABFTQk4kE2BnWhqxVTmc0MA9tzDz3+/I1b+hioUCK3C2qnGDYht0+Inp6XHeB
         mY0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHWdazK7v/JSguLIZAe8xFjaYlA2qSP+kO9aVB0kdK1N1NUQ8TTJCntY8NhJ5I+9Yi9dyufaUOoyMS@vger.kernel.org
X-Gm-Message-State: AOJu0YwDftkCqK3QityEQDVJ9VPnUOHm0TMsBmTcyIcyzQz3tIBbjlux
	guqQlFvvgpXn4SGuz4vG6CLZTA4S3C8N55/uwTsRBHbr0ntHvw1gEcW1
X-Gm-Gg: ASbGnctAvGKFZSEMU/EJEPvPjUqXP9eHfp7vbFqLwLieggwQYkynbsIkwWYTXp35rsQ
	pfVp/wgoQHrvU9eVNXUbIOatEiQBNqjK31MQ1mtDOhNK0HJpr1wiZ8rINeqtFnCcord9ry44WY2
	p2ckGnrP35DTVffXZsMI1E3qcCMNtOO5sKYgF+Bq0QldMwKHNyxN95S9+N07Zy7asghHcptHYNW
	0957NcgQeGf+I5D7d9++caSF2DXI09Wp0dNmIwzSnVr+9wM6Zf01u6QRuXirTbhTQdHGCKh+WMA
	blUnDG3RLkKyfJg/93ACixvmtqrTXead/IIP9jsWp21j4wMB49b385VodsFbogn3Q68oTWV+12r
	SQluJoMCuIpQ2K+CHEuivQ46tLyg1SlBWxqprjdQoHWffm9/rAllNUQsni6UkE567/Dxi15WoB1
	3/x58MNPXGHagukpY1lFJl54zLJ+5NvSvE
X-Google-Smtp-Source: AGHT+IHSi6VF6s0uOD+PumlBjGkMUoulpOekOEwVZLQpfCJd1Jc4jSCHGMuyuANtbvnedJ6DnWPu/g==
X-Received: by 2002:a17:907:7f0e:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b50ac8e52b0mr657263766b.43.1759996782956;
        Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 02/14] fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
Date: Thu,  9 Oct 2025 09:59:16 +0200
Message-ID: <20251009075929.1203950-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The incomming helpers don't ship with _release/_acquire variants, for
the time being anyway.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c           | 5 +++--
 include/linux/backing-dev.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..9cda19a40ca2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -476,10 +476,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	switched = true;
 skip_switch:
 	/*
-	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
+	 * Paired with an acquire fence in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
+	smp_wmb();
+	inode->i_state &= ~I_WB_SWITCH;
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e64f14739dd..065cba5dc111 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -277,10 +277,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	rcu_read_lock();
 
 	/*
-	 * Paired with store_release in inode_switch_wbs_work_fn() and
+	 * Paired with a release fence in inode_do_switch_wbs() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = inode->i_state & I_WB_SWITCH;
+	smp_rmb();
 
 	if (unlikely(cookie->locked))
 		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
-- 
2.34.1



Return-Path: <linux-ext4+bounces-9537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBAAB306E6
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FB362735C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4513743F3;
	Thu, 21 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RmE+irxL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC2374261
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807673; cv=none; b=nVw2G54VOjPLi4T973/ZmeCNAvwcOe2NdyOfj4I7cfB0q3Y9lPwN4UKg0ktW7HZmR49rKNOHoFX2Kn0ymAfYWE1+VvlVqO6zBP0F2PEN3Xfn4Ubkim3u/TVkcymkCf7rwY+A/TEPoO5ga0gtiu2dJCzgKhLI835Axbio5XnlMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807673; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDbAqFc5+Ggi4+6fyGGbVN/jClk5hzob6ZNkndKqkvPANJ25/mbyIz08a13Dy9MrAC5T+CrYotFekl+LCjtaBKrr27oxsQDSgifFnmPl5duQruhVEyOALv1cuAL9T3r6+1p+he06wofvt2lGFLunB9f2L8xSJt/qOP+56vMmGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RmE+irxL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e951dd0689bso82897276.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807671; x=1756412471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=RmE+irxLbr8dhHU/ye60oarMKOW3m1gPME3Wd7Ldi9qcnoXpt8r1SkMJeMJglf15U+
         1oFrhsxsO+YI+fJ+yx2xrQuMdSFROZyPo4NPa4x7eDchqOYHDxh24YwT128ODXGG6Egc
         XRAju03vaOqChD6PCt54IdhnDx40gjjAw9sIUt4H3+NRKquL+s4PnZDh0GtvsdqfEEuN
         7B6DZzuXUO3ZIJVFRXqvcb/vVb9Blafmaz1/3LBXltazJjHdjeBmAZyxNCXdntbrab6O
         GOCkxeVE9NDzklw0TwczMPWdl05mYGBGP4DERw7sTBitUGJ8SyOco+jJCe4v6AgT+NKV
         L2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807671; x=1756412471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=D/TR3vU9IrSpBNIipxWVz1yd+1KlkC3ZDz9yJyVtdtSIr9G46rwK5rLLHJUjkUxrKH
         GqEBXdvJLWzEdV2ky/4GM8HHuau0OZM8FwPzXF7Md3xzGflhTGbzC3j/i1Hn+dlm1SxU
         LGiL/F8+83GPVxqoi8mWMvfYVJGY06YW3Cxu3ll6GImOjDPfoDTzIT/ax8qIBOj/ankZ
         BhY5RzSCMGf4pd0DMrqOHaYtbHI7UieO4z01fKa+ktDNR3ny3aqXffxn9NglNwpmiaQP
         oAutXvoqsOvtrffv1bNKoy+MP06et3ddagACTnSYlbxRKKLFX9f5EeZmO7j0pdM0upb2
         Rppw==
X-Forwarded-Encrypted: i=1; AJvYcCXJLIKr0D5O6DcphIBhir1C53WoiUnS/IupR+9Ge9NtsI6Mbkn43hXiQLY53sRjbi3VcacQz1YtAOuo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81DnCk3XMv0h4nyP3pDQ2/uGCUoM+60DJPcZjQtGMzef/XFKR
	u8agBan+C/60b/kpE8fbUc5rlaok/CsiHcFXOlLRitC5IAxwI4us2HR5KKKRY6neaMw=
X-Gm-Gg: ASbGncvJ80LLWtflREHd/giZHv3FsnUQ4uhhHxr/vyRmjBm4ePRrdJYC0BIr+Wpu+t3
	zhUnkdgOCl9kk1mnIxH2J3PIDh6jz2Q+GwCfL+LRhKvVc3xw/VzrHo6QA2iAe6quPiJSJKuJXBw
	6ApAem0dnMUHiRDnNhuhfz0e+FE0zyxfzt0fPtOcFH+N1UfC9yd8ocSBIQcMdKRCHbq28d5z6yj
	QuLI5ecKW6DyC7q//BsfvdQgs93mhrAzFy7ar6ah1WISxMXzkQ9AHDHNONfM6KWifasGXoe65aN
	3vCYN+GY5aXRAGvndDNge4LJbcyRt9FWtiS1LIu/m62vfitXskYKnp1uHHK1mrGTPUW3oXK0hEm
	tP/DY79WaQVYpbu25N/DnCjeSGBB5/FXuDYJlMqC/y3rx3rgmL0M0q4bgA5k=
X-Google-Smtp-Source: AGHT+IEK9Y3HGsRw84lNwHY9ub4929O/sGVc990y8WeBLhD6pl7WYhs7lL5XHgi9vuczlX82x2XgRg==
X-Received: by 2002:a05:6902:33c5:b0:e93:4b5c:d50d with SMTP id 3f1490d57ef6-e951c2a6db5mr895451276.25.1755807670806;
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm2508563276.17.2025.08.21.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 36/50] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Thu, 21 Aug 2025 16:18:47 -0400
Message-ID: <0551f9d37b57fecb82930a3465d42ee6a55ea11e.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the reference count to check if the inode is live, use
that instead of checking I_WILL_FREE|I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/ops_fstype.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2b481fdc903d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1745,17 +1745,26 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
-		    !need_resched()) {
+		if ((inode->i_state & I_NEW) && !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode)) {
+			if (need_resched()) {
+				spin_unlock(&sb->s_inode_list_lock);
+				iput(toput_inode);
+				toput_inode = NULL;
+				cond_resched();
+				goto again;
+			}
+			continue;
+		}
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(toput_inode);
-- 
2.49.0



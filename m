Return-Path: <linux-ext4+bounces-9670-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960AB36ECD
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198F93AC89D
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEE371EA4;
	Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QwR3rDVy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60ED371E84
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222917; cv=none; b=WSZgwR4t0XMpze+fGIwnpEn+RhqVveaKeRUID/WkN45WLr/VXM+hhmmdkL66aQimAbH3TZjYSQfp4sEhHNAoEBqdVvywTlNZXmhXAaQXDBZmszGnAHCItJnLhMYGq93BrXRlhuQSnWLClatLy9IEOQd7+0b2W1K9ijn3iAyA+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222917; c=relaxed/simple;
	bh=XsaKjFvjn2X2zQJVY/YiX6emHhDV+XFSGzy9JGOtu5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8lU5kaBbCnyo+SrSLTzjgOAlLlS6B3j74qrg7yqKeylS7fc69t5EqquwBJGAcBXmNMT5kRjUd0K0VPpJAPXLQqla330dleciEn/fq6bZExBrlPyGABNmn2mWL/x+7gF9Be9BmnUInuqr81Q0zcdNjqPSAKe07JEmxo2YlsitMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QwR3rDVy; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e96b9022f51so2646334276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222915; x=1756827715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8PyrEAUPXNhyhibERc9OWnq+up7VaznWDP3y3iEFg8=;
        b=QwR3rDVymZqt8hRveI94+a2iu7hKzHAMVnuzeNt/Mgdlzhokvc2gExOfcoLJxCDQ2C
         LsdMhUm3IpgEKw5PmSF0ktzDGG7/szFPfVrp7YAhJeAjh1NKYGu+/2rSsoYwcTWtymrV
         97wpQkTyY6n4h2I7w0O1HyitlAMjDPWEkp7T0J2CbYTrN3LlE+jRPfV1cY2K0s2hTwFI
         ExUQLowQsIrstjx/DekBOK0ciTD9V47A7bO8qOcXHm2d67C5UcQcWOOPRZM0hZUOx6WR
         jbDhRDNg10r5szKSxsVXYpfhLvY1fyhyxIMCFIvlCvC6pOfnEUXEvwqpQvQr7T49xx6K
         VF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222915; x=1756827715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8PyrEAUPXNhyhibERc9OWnq+up7VaznWDP3y3iEFg8=;
        b=mXK4ykCaJlM+kbfKauIbxEXiFTCcGFreGbnixg1hzqThcd/0xKWppREDu0dv8bsfMc
         ZAnwluKyR4lPMDMvfNgzCLrOfen/g+Pfp44D9NRQU4lDWrjdau6/gxZvYoww0FBeHBOh
         cVSnyOwf4K3k5axNUlcT4y4snf6SMNWae8zEKXaWPi0ZXMjDOg/hbHynp4wj9aCOkQUg
         saPmCheOZZqK++dgEtr2s0m4BJnmXP40cTqMH9YMEDB04w5Zxgyjfz0cy2I3xDOcVrYh
         f35XzvHfic3XyeUitmQC0jCOuGaSe1LQ8V1wiNNIyWcqrEszdhoOVCbGtaquZqEytu9H
         JV6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQGDf5b/YtgYIlw8OPzDS7lLJrqmL17Wbp6INjGgvFptVqYMhrB2bs/C3UaxfZ2mR9aODauDCd+RA0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzma9zHhQHSoMRfP2VQxBGfUqls3Flt/laTuIPS4SdP8jue7GJZ
	xrzD/cPTC+DFf4of9kDO+46ESNsbSK7AqMraR1RIwUq78cP62z35m4r/Q5m3SMU+6yY=
X-Gm-Gg: ASbGncvcc+IIqxATDw2wifv/E8q36t7zy+xpL0yINpqtVM4QSshNJhe1Rfxg5Cu5DnZ
	HaCdhXpvlZm8FRvovpreeLK9vK0Z5DYNIXUbEf//xA9mlLGcHWFhURM9tMZEPA+2LghsASWW2Y6
	FAYZllTlpfXBH1YIJhcMuxF+DsDdjz/ql3ocXkeJvMHUZVZkC3wXPlwpBXxHjiEVzSlOkY3xEu2
	Lm/KEzaO+9VBurP1OmX+es3VmMgwJeaTVXh8R47B5u9ZzR/rsbRHqEOQl2i0yXoiQOxA0rUfXh5
	B1nVVoouXth2F8VmcmD7eVIzIDA4ZIhs5GW8BPf43P9Gr36bIzqLsGdy4HtLYUjL8j+81DX8I1V
	rs5m7R6xOXIlsu4kXTJMlgH8HR3uf8k9BxdrGBaYiZbylfCzhfaTT2vQiDFlXHv4s5L6umg==
X-Google-Smtp-Source: AGHT+IHnCtvK0jxYJNkTESswSosZnios2zMRKwe+/SpsjsU6S+aMRrm0t4ADvA18pKD/XqQvgFp4JQ==
X-Received: by 2002:a05:6902:33c5:b0:e90:8278:5ef7 with SMTP id 3f1490d57ef6-e951c3c715emr17788783276.37.1756222914605;
        Tue, 26 Aug 2025 08:41:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e9fa5d42sm190363276.18.2025.08.26.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 45/54] ext4: remove reference to I_FREEING in inode.c
Date: Tue, 26 Aug 2025 11:39:45 -0400
Message-ID: <934a321990245e31ebd29a44e905ed6e5202ea65.1756222465.git.josef@toxicpanda.com>
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

Instead of checking I_FREEING, simply check the i_count reference to see
if this inode is going away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2c777b0f225b..178448fb73df 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -199,8 +199,8 @@ void ext4_evict_inode(struct inode *inode)
 	 * For inodes with journalled data, transaction commit could have
 	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
 	 * extents converting worker could merge extents and also have dirtied
-	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
-	 * we still need to remove the inode from the writeback lists.
+	 * the inode. Flush worker is ignoring it because the of the 0 i_count
+	 * but we still need to remove the inode from the writeback lists.
 	 */
 	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode->i_state & I_NEW) && icount_read(inode) > 0)
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
-- 
2.49.0



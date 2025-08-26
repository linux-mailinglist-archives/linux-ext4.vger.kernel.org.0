Return-Path: <linux-ext4+bounces-9663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F78B36EBA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3FD8E626A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845236CC89;
	Tue, 26 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uxi7ohXq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7336CC72
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222908; cv=none; b=i5TZ5mMQSRqXE+fDU30dpilyprWe7zbyYAOr75+a+HTEIG30H5IEkRuzaFecHdK5M9N6hYwn9CeLUpVIy4Ws6t79PD2pSjZoUEhDAujWBZCtRs3hyiFMAA/2SxUXJazmclf6Oyl2QJ+tixEcKQ8RcaCT9DyA1TO9P7icvb/j/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222908; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auIR04gKMNnt0gflk1HzTwrT6wkNSjiwYbmCelCqCQ5KPC74yLmwuClhgSgilEMEhmFsvnEMnI8zohmWc275H3nFA0DyY4jrjcuuZdjrQ4InlEaotzHUlj/HW8PMmKyNPW+qQBbSuCgcawo/SeYliRJNBZ5PRkc8RwsWwMrJhWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uxi7ohXq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603a269cso43800577b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222905; x=1756827705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=uxi7ohXqKUcBZO7Ua+hc/ajCXggSTI51qc1be8CHoDfUpzc91NJRWTj/ghdlaZYRf9
         UZg0KXNhymiGudejku1NoA3cYkQKamjzBVlLEFd6DdClC3w5WTOYjiwjrdo2npfRk5se
         rccY1P8OI+uIIFRIpkNDPGmZORCr2dsZ5FwzsD7zEg2OYIpROZqzcWcry128AHtFhHlp
         40XeOJZzb9CJ3Pw9dhXIg7BYAJHGtCSTnyJwArIl0VKn+2nxcrh0YTOXBwxok1KBlNTo
         i6+JRCs2Ohy6I6h+rp+4maxUIdO91tkyGK/4frTy/5B5MYdwS9dXV8z+ZV8yR/zK0Gls
         O3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222905; x=1756827705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=pUsCqU0Zwu8to68LuJ7jHU0D7PP30VCKsb96Y6w1ZU4Nvy/Se/DC8ofHtNmpbNmgIB
         0tpwev4YctJWxWY+Dk1NqMIBoglmie86AN2EbDvUu8tfmTCyudQrP6B4HHKxoiUHiafk
         I1Gfbq8Ma6ThEmB0qHUrOGQWd6porGjIIA0gI2Axw5hafqAOIjQy2GhEHRx4uQDlmimO
         lCVgsXvY23D9JjD+CwKo6/ohXAsxrU2b+CB4ZcJHtAuSJ6Ns0XYIDjb2qI5dsO6bM8P9
         cqhiAQqz/DLo9qbOQKaVhzly0Jp9VPp8t9zRu3jy3Dbl3aSZsFvjCBmDIX/ulXk57VKK
         PkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGrm7+fo7FWkbzSoieTaZxWVIUV15OSScEE4uMt66JnUnaYuphm2cFuaSVIPCL96OS02bv8DYa8aks@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKndeFcFQVDX69C6a1UkqdKIBzADCNCI8iTiRH1yVTnkCrWC5
	eCQN2/SzE6FMlMffY7CfmZgq3lDy/g86YKI2cI+xi5AiOehW3uX89H777jjHWY9Tjmc=
X-Gm-Gg: ASbGncvcddRGCM1SQ5iKjaatFemcQx8IFKMqGXbyKH4D/ZoBqfgHQfxxyq8qVA+lSRA
	HbHoIJvwxOvyUgI8b/lMPUu8obl24pLPE+ehz9xK2+UFkD/skDOMwodztgDHFZNTGTAVxLjWljM
	i1mkm/Hu/eyutc+I3HMio64WzEsj1lH+6pnilHG39AP+5QcTKN8eZBtwvz1qWJLNG3RjbBhs07n
	Fzx1Tb04R12Maz/22H2iHxbC1uBCg1ceR1jwQc7z4dqOjvst7dC0gMRvAO25AWlsc+BkFJDWUxB
	XZAkK8qpaRIzxIX5RL6LmnFkLv9Ekygw94lXUrmoGoHFj+aLl8RHL+csoKlH7M9HKl0/vMneRes
	m4tRcjjiBXmfYfOgr2WsfOUyWhNKijP5Rz9z1feEBLrQEK/pRCd3NWufUOjah6i5KayC9Uh0/mq
	QTx6qS
X-Google-Smtp-Source: AGHT+IGukatO5Mwgl+iFpY8aNAJGoZlPwkGqVoc2HLHPS4uUtL3IivdATW29hDRBnU0HqwHw9U1Bqg==
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id 00721157ae682-71fdc40d339mr188030487b3.36.1756222904483;
        Tue, 26 Aug 2025 08:41:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm418881d50.4.2025.08.26.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 38/54] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Tue, 26 Aug 2025 11:39:38 -0400
Message-ID: <45b3bd8bf31cdb07d0b7db55655f66ab49ecc94f.1756222465.git.josef@toxicpanda.com>
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



Return-Path: <linux-ext4+bounces-5945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F83A0371D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B29188534E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AF176AC5;
	Tue,  7 Jan 2025 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRzcD4qF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF130193074
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225242; cv=none; b=CxjjJNDGiSA1iqxioY4z2giWnI3hzgG1Se2jFCNOYD+FjPaoSjT+gNPajSozjagHqJIuG4wxT/xa3BArk8jg4aJXzGUeaWn/qh3X1XwcRaG852MjErfxabKU2NVZH7n7Hci8NiP/iYdqD0MkDbhaW0F1HRTCcNCNRY3d8FJp+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225242; c=relaxed/simple;
	bh=e8UImHQpkM9zI+JQsYCSXVXGEfUuZD6PtkFiTlsvNko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWfLTEnzJiy4bSymk7Fo3jO2w7Bx7RrMLDO3PHdy+jjUHWqv5vxfU5yQ6lNtYFSVJro2GkQBVfmYKIr3ETmccqlB2VEMNF8EJgMGSBVkiq2YrMr6FgGnMVOYEOEXgefqxoIWC1RePIREpHSQOKi4bfLAiiyO5xyxRaQ8F/m8MMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRzcD4qF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162c0f6a39so227173715ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225236; x=1736830036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/XMrd6DBXG+ogaLjnU8VvGZYg+JHh/WJrYWtJchkzo=;
        b=ZRzcD4qFRUKgKDUWPm5vINppwdtYGU+OoAC2yRoVbptZltx8o0kbvb47SsLrNNGQie
         Fp25aL3bvatVURtqiwgW8jOwiEyNthWutS3D/rx3EXxq00sL6Xq+Ol4d+fNgkL3GKrWc
         D3Cw3LMyMgz+ABfmNkMDI4yDiBFiBCr7/qZ3FqhnC3G5MAKlW8Bl4AWABrL4U7UOjaF0
         XgzRXPalnsNzmOc4aFVVjWtzkx34Gu7fj70Td9nSm3Pr2P6OMy2jfjxVsSEVQvdeUgVR
         Mp4wHHgZXVeBV74AvcFWjuWXzYe33AZxx8Vw1iN6XLTT7v9yjRvLuAmKmvV1WWly7r2i
         /MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225236; x=1736830036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/XMrd6DBXG+ogaLjnU8VvGZYg+JHh/WJrYWtJchkzo=;
        b=fs7M6MikW2CDfn8ZiuAaemTn8RcKapehFLHEq0Kbs6c9xmSQtK86CoyC4DVJO2yD4c
         kir++lOPNXsGFBVG0ZlcSZD5nRdoP9GpcQommLnNPRGnkAjrKgdzl9nfPpMsMeC3XYqE
         yVbVqCd6inksVUEj++T/UmQVc433wQE5/tfdatWwwLo9qbXTtytALGW4ujIO8/FgYdoc
         NWGB23lDlJK+PM8CieiHcC6wMaizmgY6minXYz7UAu+G3J4QWdfodNAbgnjLGD70+Jm7
         cjt3Npk1EsKgRdVy6U7w32bPedS96ulWKR04k1FiRjBV0dkDJvKXM0sadgfbJRow18gW
         jncQ==
X-Gm-Message-State: AOJu0YxoqEixV5i+DIS+MX2TonYtD/8UA4iJEtnFp+MWF5EVK9n0Kptq
	3qMuWR73JqxKDVpNHbNb7WoiHbmU1Wu0uZOB1aF6L7gvo5GfXDv1GsWhfY36rEE=
X-Gm-Gg: ASbGncvfYvZmQyaryddtBqkz6p4XI9JqpJc7plfuyx5S6bhug9RKBMLAYaR4lB+WBts
	b5Q7RC657EDiwJdgb9WOYyFYjLHNkqSQbJ3WLv6CvLSI9ww7olkmh05qIjNilqOecK0WCLP5SnN
	BkN5hZ5TT2mGsgKgDxsZ+iHhHqeaEAAMtcTBsafzVBtkukguinPeJLUMIOZRUNjIkNLePSIKz3d
	XWFGqoJxINyFEnM91MSXHnXUf9NppGv1LJfyRR1RLBmJdVJD7nq9g37F7bPIw==
X-Google-Smtp-Source: AGHT+IFjGX0LYjjBqXaRm/74+VFvtgbDlh+YkYAoc1/+k0UNFq372vYFk4E81p1ZBQxfAl9wBV3QWg==
X-Received: by 2002:a17:902:d591:b0:215:7e49:8202 with SMTP id d9443c01a7336-21a7a25ef6cmr33382715ad.13.1736225236564;
        Mon, 06 Jan 2025 20:47:16 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962de1sm300779655ad.35.2025.01.06.20.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:47:16 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 1/5] ext4: Remove a redundant return statement
Date: Tue,  7 Jan 2025 12:46:58 +0800
Message-Id: <20250107044702.1836852-2-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
References: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a redundant return statements in the
ext4_es_remove_extent() function.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents_status.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3..c56fb682a27e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1551,7 +1551,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
-- 
2.39.5



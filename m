Return-Path: <linux-ext4+bounces-8409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A7AD819A
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 05:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A1189A183
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C023A563;
	Fri, 13 Jun 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggFghHLV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A215278E
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785110; cv=none; b=Un3PaQB8hDoHlu7nUfmfaNOZ2cSwv3lLE7Sdl4lKwaN72T33Jakb/Dh57nVdMeUJIonmXuBvc32xBHO/DbE8aMxzQxUh3NkKXa+ErboS+a5wvzlsncmfutiEZy0Mf1cJ03NlXxTFp1DQFTIgKwxzVMaqqJURQAEH02XVWLxaaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785110; c=relaxed/simple;
	bh=FaPZa9IHzNOvH4bmqcBMC83mjoJKfAKPO/ztTFspTOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmGIcKI0UgW52x390DpIk2Xa9DK69/SKSrz105ZzLHkJgo6vouunD7e8lMC785HD1T6gUZjoB+IBRVWmzR8DD6yDR+PrikEw7bE8aU2UUCnRersFi7yV8EGbNuhBuF/sN85FI/OELf1GDsU0mrh/f9uiuWxS1VidY+aww0yD1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggFghHLV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4508287895dso17543605e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749785105; x=1750389905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2fREc+AJyXByCSx89CWeAOJxNBy6PYYGd7sGZkmHQ8=;
        b=ggFghHLVmYvut5sipTcSHSzxvHvG4bijx5r40UQBnAuZqCb9Ohw7LSb9ihp16dPIyY
         gJ7JIQzcD0XjaBHVeuaw8eQRgT+/OIf1XcSbK7qrVLb+w+87zaxehk4tffBJnZ2Kh4CV
         dW7OgDu76gD11go2GAcUw+uiQ0ZyndBv4c54ESJx/Ep/678uMljetJH8mPxAmhz32jP5
         bHAeTJX53HAwi51kULW1NxuhdrHOwxN2FDhdt6LBoQKG41BNi7ea6Gu2IByeN1kc1QiQ
         ikDvkUpD6ZKZE9QUm39VJ6AFlM5qYOtlHTlEv8TrgHQJ9JNr5AwdkvgDG4a5lY7HiDZG
         0PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749785105; x=1750389905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2fREc+AJyXByCSx89CWeAOJxNBy6PYYGd7sGZkmHQ8=;
        b=tXQ6E1NqO4eHxfg9BPHdIsnByLSsreNHxmG8LZxM3puULEa3ifHa7KjHPh++ymzvjU
         Xiq4h2buWe7s5OY1Ymu0hiDXGPwxoPiDcrrpBIVdOd+caZgnSme7vTkeVM2lkDDohGpj
         AGGJk9ZutvGa+QMPDBs8TWM95nGlCBJLc1lfnEHFgQnj3/swkRFOrvWxhJdzoyOAZ09K
         H7oEF6S8Uo3/9g9nVjbKjS7seG+5fWOcKcBo8tBbcYjuvWh2xpiegugjEr9bPw2vnTeV
         NiPT1zm1pCUK4VcASEpPOMMY4rTL2ucBYXapBoyG8oQQwb9v9J8A6PsB2BaFGA5/n2EG
         +0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX9N++CePZjTRkHDac90D+BjNftwIqkmLpiKA/Z+oL2Mbo/cUOcY2EygpOUeM5stuPBonKzrD4qIiB@vger.kernel.org
X-Gm-Message-State: AOJu0YydO3EsQpRB7jYSPA34KpF5zcEMrh1UomG+HEnYuhdOQ+Py68kd
	F6hqb0n/lybuge90b9cQ8xx1iE5BIhlpVF9EdfmjkcVKeXIkp7CveJWbl4l0S9OeJQ==
X-Gm-Gg: ASbGnctlV2MsW3WeLZw04zCRI0Yqf2kkyOG9BPUlvTb/rdynUMl5w+q0JDaK4WKlowx
	G3nhT4KIjjsBaHz+kmwKNvVrtLUr+zzzz626rcldgl/7eW6xOzLuRlCjLDJWXhjghqiQ0dTberx
	AuotXNa8O+8TTWxnpI9xQlaUQSZoOA//UpZXkUL2/lFR+ozYuwzv+rqSa8vxBkCzpOxwnxwXJDa
	FakU6u3USz6kVqS+HG3x9NE3lBoT7vbFH93+sFtL8ADXaSwuqrHk0jDX8RVjtIIVE0JryS7JDx2
	wLensh/m3WeLR7PpN9bSZMbpLu2Js+ra2BaCHdOEDc9hsdv0VXs=
X-Google-Smtp-Source: AGHT+IFF2MYUpmBOV7t6AV7qpogCCm7ZuPkeNrX1RdBwqDvurBf2ligtHScARmXgbcqtMwhmDQWkCQ==
X-Received: by 2002:a5d:5f88:0:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3a56a2c323dmr583210f8f.8.1749785105644;
        Thu, 12 Jun 2025 20:25:05 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900d0d90sm525256b3a.155.2025.06.12.20.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:25:05 -0700 (PDT)
From: Wei Gao <wegao@suse.com>
To: Jan Kara <jack@suse.cz>
Cc: Wei Gao <wegao@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v2] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Fri, 13 Jun 2025 11:18:38 -0400
Message-ID: <20250613152402.3432135-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612142855.2678267-1-wegao@suse.com>
References: <20250612142855.2678267-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
then result in an -EINVAL error, even for valid queries on empty files.

Link: https://github.com/linux-test-project/ltp/issues/1246
Signed-off-by: Wei Gao <wegao@suse.com>
---
 fs/ext2/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..591db2b4390a 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -895,9 +895,15 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	u64 i_size;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+
+	i_size = i_size_read(inode);
+
+	if (i_size > 0)
+		len = min_t(u64, len, i_size_read(inode));
+
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
 	inode_unlock(inode);
 
-- 
2.49.0



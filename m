Return-Path: <linux-ext4+bounces-11835-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D69ACC540B1
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 20:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9811A347239
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9934B414;
	Wed, 12 Nov 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFO18ydV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0626290
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973954; cv=none; b=JYm3sgh5FBxrABnPkRw+I4Efpgxo2oMh1a5c+J55dV9FGFUhO9bRn081xVFw+Tj1TAgY8v7KDw7caeY7OEDnacrSZZuxxNAq2Tu1YmucJgD+OiM6JIM9ZGpaJ2AZrMQPWxhm0lzuoJrOAlSuCjxyN/qw8ereFPFEJGAxQAzmigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973954; c=relaxed/simple;
	bh=e+vkzTXZpebv4x57j1CGKLaD1D6tZMW1EsZ1XwAHvFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUH7masXhPruuKADTskOj2haNEUCYFdu3O/8EEz2HYKNZxEXlJ80z0g71F5UHtTbKA6PBVng/18Jp6Ko+9dJKw7BRqbGxGfSvBuFZkHgpShHLScL8ZGSmMsYIUmYsiB1+WYStjH1pO3TOFhU9yPs2OLM5/55gEz8fAkj8WM50ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFO18ydV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b23b6d9f11so404485a.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973951; x=1763578751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkHIbEfS/RNvXEomxAVQK3p1e0eKqwElvBQxcuWip4A=;
        b=BFO18ydVZMP8NS6mCuuGL5zF3P7FOFdS1CjaFAPJEoOXX4p7O54xp7PzVxJ74xk5YN
         l/1zmVA1spvURY30JdxqrZCjTh+uB7eVnwefbKA3bRE9qU1/ifln4G9gJqGhcDynvFqZ
         mKFgVQo30BWBgKjZXKbJ2fFebjii6RdxrEYoIPTB9GKsrVaZnwlkZLrPQegHlEOBt609
         G2qenLm+BQyj1BvbVI/EmYC3vRmEDyXj3RMJKkYR3dOrI+cAV2TywqDqfqrBscUJGp6g
         WEKJEr8cSvg3kjbfa/e8n2aohaRgxwWz4wztbh+XSDoU3F0EOVcBb6R2pyqQhEM8Ro+Q
         eU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973951; x=1763578751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkHIbEfS/RNvXEomxAVQK3p1e0eKqwElvBQxcuWip4A=;
        b=cVnr2+XwjTPREnfmYdYIHiKBpvEU3evReZYXL7vBVljihvSdo2MEcJOt6K/Fwi/7to
         rv63jBv3DqL7GQtPbVp1kXpHH1wjfCioH+zUtiE860xESysvEHjxaeAggBPDxftY9cNv
         y/bRDwEyXIHmNE69//QxFlZgoOuj8Nkb5tEIQP3abKEd6cFSkekf/Ddh3zsOS6XqTIq2
         HqI120/BwM58nozspLNf0fxQ6xgwqqmH5AQszZ6sq6FN03+/iYVOzmVGP3ukUERTNFEd
         JXMXQaPgt6ywygCPKpZB0rHDWfH5UkNSzVpZk8+1KNHCl7w9OC7oWVBgin/dniVAeggr
         bBwA==
X-Forwarded-Encrypted: i=1; AJvYcCXA3i1ZqcZ57kypO3rbWsrFon9hb7YEhyUbsyvyXYLhKWuKEoFPxnQr+K8Bbxl1bG3CQ/V5wcZtlxRG@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyfxWqwlklJB5tauzYyAV/O7/ydTSsg/k2HNBQ1+tleFldoAj
	HNTGnLfcUMqcgiqcycYAQlGBdMRoa5c5zoRYapGb3jDRpOdU3Q9a9jUG
X-Gm-Gg: ASbGncsWm9u3QVWDQgC8IPyrjN999XDT7rnIXfqhkbYJKVvCYqyzLJoG+QTgW4+GIRl
	EXKztPt6rQeqfxd0BCAGgH6GehDiyqTLh2VfZ5AvlNbb36c2jRyL2bM7YoL2PVoae+aInnMQux6
	DGoFPoS8nlI+sRoWhCFT0Pe3d3mgC7XUldmp9HDhzFoyeuXiswHHTirHCllRVVkVnele3a6Ecx9
	CeaqXrj1ztSXbgBZGez+Nmnef4xObZdqMZF9ZgjF1LA8TF50ias1ueFoUYhGoB8lxbNXSAVUHxH
	WEb06/p3EJ0TtLsSwmCRzCykB2uIy+Vr/R9iOkoaopIFD94WIRwdXJtFHqK8aA4Lfb+Zssl9UEJ
	fN+xN5HgjqHc671NI7myoI8Za3/GUz/fGg2CRfKUBvxnNzkFNNtAXQRWrCK0P6JHW9ofXE2G/vm
	ICQhKwebRTE2TqP3XiaV1F
X-Google-Smtp-Source: AGHT+IEZ/eFmBvYWxQT6tHvgfcJ/HtfGiXneBQsdqEwDBB0RGnuIeLuNXC6xaD38X4tP/8xo1OT0pw==
X-Received: by 2002:a05:620a:414f:b0:86e:21a4:4742 with SMTP id af79cd13be357-8b29b987041mr480654085a.77.1762973951464;
        Wed, 12 Nov 2025 10:59:11 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85d2efsm244726685a.14.2025.11.12.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:59:11 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: cascardo@igalia.com,
	jack@suse.cz,
	yebin10@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH v2] ext4: validate xattrs to avoid OOB in ext4_find_inline_entry
Date: Wed, 12 Nov 2025 13:57:13 -0500
Message-ID: <20251112185712.2031993-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
References: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When looking for an entry in an inlined directory, if e_value_offs is
changed underneath the filesystem by some change in the block device, it
will lead to an out-of-bounds access that KASAN detects as a
use-after-free.

This is a similar problem as fixed by
commit c6b72f5d82b1 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
whose fix was to call ext4_xattr_ibody_find() right after reading the
inode with ext4_get_inode_loc() to check the validity of the xattrs.

However, ext4_xattr_ibody_find() only checks xattr names, via
xattr_find_entry(), not e_value_offs.

Fix by calling xattr_check_inode() which performs a full check on the
xattrs in inode.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Fixes: 5701875f9609 ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changelog
v1 -> v2: change Fixes tag to reflect that ext4_xattr_ibody_find() used to call 
xattr_check_inode() until 5701875f9609.

 fs/ext4/inline.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..7d46e1e16b52 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1593,6 +1593,13 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 	down_read(&EXT4_I(dir)->xattr_sem);
 
+	if (EXT4_INODE_HAS_XATTR_SPACE(dir)) {
+		ret = xattr_check_inode(dir, IHDR(dir, ext4_raw_inode(&is.iloc)),
+					ITAIL(dir, ext4_raw_inode(&is.iloc)));
+		if (ret)
+			goto out;
+	}
+
 	ret = ext4_xattr_ibody_find(dir, &i, &is);
 	if (ret)
 		goto out;
-- 
2.43.0



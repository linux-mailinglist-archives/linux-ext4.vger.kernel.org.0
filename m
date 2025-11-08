Return-Path: <linux-ext4+bounces-11704-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 795DDC43492
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 21:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 907D74E2D54
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57597280A5B;
	Sat,  8 Nov 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYB5okYl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CC263F54
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762633610; cv=none; b=E6TwTaDV7p39yRtnFOSbku5OZVDB+v+NdjHyCYEqSZdA6JpFn1mi/wb+0bD6uPhHh2k7s8jAHAxHVQjZjUGuy1OsfnvCbbchThCsuQILE0a4qlg/fxoSut5sGWeuqHUvKX8nD5v5NZtSgGBEDTpNJHKPCGBqruU+5wXTb4uCGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762633610; c=relaxed/simple;
	bh=7r2vaQFsXYEdBsj8HiqWkBplfeax3sxT6mHqMhZQqOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mraUwIZbhUt305C3Rgz70EBtiqiBa2GQ4SEjq4h/Txru/TVxR0zR3sa/dr5bL2p60G8D/3wQ/8HofGx4ln3X0gQg5cf0k+aPuDDA4IcSkHcq91LqhIi8zM5cH1f4+qYAysD6pZFvX6B8tTzBew8/sWNlh8XNUUupREuFEkJT3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYB5okYl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edaf8773c4so3658531cf.1
        for <linux-ext4@vger.kernel.org>; Sat, 08 Nov 2025 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762633607; x=1763238407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqdNy1cXW3Hz2aSEK4LLxs8ePlR8f5QrAsxwadDsOPg=;
        b=lYB5okYlr/wOc/BlevLimd09e8pWzbu0gOgsdFaMYD4rs0W2rcTYbeIr5ji1BzNt4x
         ZNsPzIZFBdx8QlNlyq84Y1qN5RIbJxaTe8UZ9kQPBQk2qELBrq0OfYQhz1BcFa1eGMNv
         YzeEA3K1016zElRiPeUOLdPC5D/1Qye7g2WaxMwMNimZdPrPzniVVi5ADX+qluh+6yL6
         9Bx/KutxYXn7MvOl3bMEghTy+i7Wm0IyGbFkqHC5Ljb7+ox2Hv+883oGt2UwJC3HUZ/R
         tWtXAz9QW3PUq08S8TVcQg1vUoc9vgJjeVefBA65p68lo3HoHueVD3j2ItY2oPfUmqGN
         xXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633607; x=1763238407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqdNy1cXW3Hz2aSEK4LLxs8ePlR8f5QrAsxwadDsOPg=;
        b=TprV+HMmGIg6tmLof20R8bVGCOPbWjpoMVHKUwofyywaoMI//91GPgtT2PfVYeXcZh
         F8FHqExiWHbBUzMEW/KkD6Re9meuG0PpGci0OEB7dbee/wuOwx0J/g1FYPzdf7Ikv2iD
         cEb7sHHF3Ahj5FwcmZMV2dGi5wiM0jRti4BL1Lzg8TubDBbAMDHnCBjZ5m6cx4NgP2rw
         8o2NrniqS4KdkUrU3a7DiLpuq8w6aGjx0bXI/3OP7fIWrRYpXiLBqqsu5vQ0YzKTq0uK
         /IvS3xlfM2gT8e3cT/r4Eo7jiqBvTSnnIVUpmgV0U8E5CNpCqAbgnptWFaaQkoGigWXl
         6J+w==
X-Forwarded-Encrypted: i=1; AJvYcCVGt4IGwXsrN+cOjlcTEnrocr6+fHEacBEbKz5PfVHhpjM5IoL7DZPEbZ7VdAHEHUhQVHq+2iBSpUjp@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUbO8nFfLNCihftPab9RZAfR2Oh3FpHNxZfhvFgjQHOyCla/a
	qXEskroFPppzNGPtk+a2A6LHki3knEBK5YY343/HJRHcbS9Dc5GpkJoG
X-Gm-Gg: ASbGncu9y0Fp9y9XeC9Yh9cI+doSrDd8vKDsUAMPoHMf/c+/vlc6SnJrSNBC2xh0lyd
	dCNS9RUKGAJrfNt8XHq2XfWJumt4q0+B86ao6fr4qpDz8Lo9RBQb777dy3scqOJdXg/hFe9tWlU
	SxqU3ZV4QCIBxapJXuj/KKpZYAVb9AEZBLmTOd2Wjo2k/YJ+AylepjauumO0b9iEn0hvdN8G1IS
	0GBM+iwKhDsbrPeWklQoZtdKQVRjqsnrqT5FaxU0QY0GFrieu7m/EzcKLhOYs18LRZhF5zQi6zI
	XJDq/4O7Iqd/y+5qrN4klSfijwXJcn30F+4Th0409+FmUbyVCheJkV3lgJeU0oH2XFN7nrCXYEs
	fSwUslAgq/NoS7NNDPUD37OFjZNVnSg+cBXQLswEWN0iHV2212onPSPgxlTxcXUrOOMgDuY4ir/
	JV9QfN8PxwmuDb4UyDnw5x
X-Google-Smtp-Source: AGHT+IGONkC6+DYOwOtmQYThFKcoR7JN6qMjHtFFocpFa9KyeI27WnTRQjoR1Bqiw3sai+RnnmkvIw==
X-Received: by 2002:ac8:584e:0:b0:4eb:a291:fbf7 with SMTP id d75a77b69052e-4eda4f90bd7mr46135221cf.49.1762633607356;
        Sat, 08 Nov 2025 12:26:47 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edaebc73b0sm7067891cf.22.2025.11.08.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:26:47 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: cascardo@igalia.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] ext4: validate xattrs to avoid OOB in ext4_find_inline_entry
Date: Sat,  8 Nov 2025 15:25:46 -0500
Message-ID: <20251108202545.1524330-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Fixes: c6b72f5d82b10 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
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



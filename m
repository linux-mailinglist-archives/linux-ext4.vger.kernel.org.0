Return-Path: <linux-ext4+bounces-13999-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nGdSKecwnmlPUAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13999-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 00:14:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9718E1D6
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 00:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9037F304C63E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECF361671;
	Tue, 24 Feb 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvcP+ZFS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9234BA2E
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974879; cv=none; b=qM2gqjw3aUIB44nXwfDVtV/RAt94o5zXV1LbK1CEEM9HjMoqS1jeI1j8cB2sSaYU8t+mpKGGwsanCPJMZ1r/jc0wchnyNEnOZIwsuASMKLVl6OZIbuxqUkfhywhbI21RFIloJ4RLKZvpcX6tbDPnmdk+xt3IdYAcOveubFmGRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974879; c=relaxed/simple;
	bh=ts4y1LSDqSm8xzbqqKhGJ+vKB4CEPxtkpC8uTT/eNoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxnVcN2PG1DsFABq9Mv9qBjene0QvjdDJZqReKal8+/PhSCKuasbh9YklZy7FPfXTsfmDlbbUbWUILyYpzY0E0yWty1a2xXgw0xtW/qxpQJZMdNx+U+aioT5yrzTjsy27kwQjtO9iZ/tNPHGCjNe6wfiIykBEDbVdYkXPb4rnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvcP+ZFS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35621aa8c7fso3325037a91.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771974878; x=1772579678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p34qi6n0TBfPz0KJzPBXeXgql7kmsqZRDFsgeZgUqEs=;
        b=IvcP+ZFSmcpahoYCH9GQP/MZP8I5hcDdWnGooiZoLNeoXYKhhI1gQM6/TXCl+Ttqxl
         iyFJjXhqqQPDZtCmNHmzG56gx6+opOpTd+iuL177yc442N2+Q7SPkIDOxHwds+7z28TQ
         4PzvA/ZI3p0loT1nEzlJcQOkm8HAgvjwctdqJWNqb0//TAYBkaMF7oOFG1U55m4WTCEn
         a9G99PJ5JnETbBmqFmS7o1t2iHlNZXiFpYikfjQ9iVRP4xKU5rxqxtMyZncp0n1/u2XP
         k298we+eZfdFNIAln80yH5woOZhhtU6duAmuLbO0IrHQWHwnzKwWgFeQpLBgB8QnZdcr
         dBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771974878; x=1772579678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p34qi6n0TBfPz0KJzPBXeXgql7kmsqZRDFsgeZgUqEs=;
        b=mXKL3Udee1xAeovmcB8cqZC8UV52pZBxKJ85zz8KGiGp6z+soEv0OR7fqBsW4cGD97
         J/do9uJag5tJUgEcAYmwjIJW/BymrArbr85JdJ0wDyPS474CGy0p6hS33+yLWVQmrz6P
         rwZauh8Daf2th56x3aCOeBsnJrSQpKfht3oZ1OAlWU1S/AlOfjTDWFQX5lqoJs5jwidS
         4rLK9j7PKso20DjSlM3GVJMXB0u9Lf7b0JG7A13I2q6nopghNQwm+P54C50bMvdmulX7
         bXjiON13Zcg1aVlEBMKEZTTqOQaWxvy5Up7AlgBq3RPswlS3ZyKNvHcEd/HClf29DeR7
         87pg==
X-Gm-Message-State: AOJu0Yw7/Jion4JShD9lTUrlGVd0qvHFfSwTOU9n4GR8gs4EUvIQufmz
	eNXyaiMp9sZtSFxuofZwenfVO25yz99zshKqyMYkY/TZjP5F3+LisY8o
X-Gm-Gg: ATEYQzx77XCaUOcYlpp47IbGGd8R4TMTPrYDQiktUYWU0ewfPqhBnxMI91teCqnRD3N
	7jLVZNbP/moGfrNq9oqXOqKB5ia0AbxPjAacQFl2m4WYajR3c30gR/Xsc+JpglWPqjQ0Lq17VMB
	7ToB7w5tLK95kP6YvZk7uV94hMEyIeWqsFr8FiXl6C+wW1ernvsO38+m67eOXhc2QW4RkrWVsLf
	DvU8i3PhZ1L7lNKJQrQTnAugDvTtwrTFUaogxdiMuhD78X+tU4fXRBbnNaEY9xSbp2up8M2qkdu
	7JnQeqIHyCrtOyzbJOjr6l2IxMjgY2BY3a1ZFD2jo9LPSNV27bAx0BD79Ag2YvLBw6CvZkpg3p3
	rpeJ9eGy7Cn1EW+JCyGCW0GM3A94tXdGNS5FWle3BGDiG4f/3/OfJ5tV/YGGsRe31VL/Ad3nMtV
	qLWsqNnj9W/QGAXEMTw58JJW0H4Y5GTLYeRMSejvrE9ap5BFbE54ENZYIsjZFbWe9GXKw=
X-Received: by 2002:a17:90b:5847:b0:358:ee2d:df2d with SMTP id 98e67ed59e1d1-3590f069d87mr298702a91.8.1771974877587;
        Tue, 24 Feb 2026 15:14:37 -0800 (PST)
Received: from deepanshu.. ([103.171.98.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b72434e3sm11917667a12.18.2026.02.24.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:14:37 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: [PATCH] ext4: add bounds check in ext4_xattr_ibody_get() to prevent out-of-bounds access
Date: Wed, 25 Feb 2026 04:44:29 +0530
Message-Id: <20260224231429.31361-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13999-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4,fb32afec111a7d61b939];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A8D9718E1D6
X-Rspamd-Action: no action

When mounting a corrupted ext4 filesystem, the inode's i_extra_isize
can be set to a value that leaves insufficient space in the inode for
the inline xattr header and entries. While ext4_iget() validates that
i_extra_isize fits within the inode size, it does not account for the
additional sizeof(ext4_xattr_ibody_header) needed by IHDR/IFIRST.

This results in IFIRST(header) pointing at or beyond ITAIL(raw_inode),
leaving no room for even the 4-byte terminator entry. When
xattr_find_entry() is subsequently called, IS_LAST_ENTRY() reads 4
bytes from this out-of-bounds pointer, triggering a use-after-free.

For example, with EXT4_INODE_SIZE=256 and i_extra_isize=124:
  - ext4_iget() check: 128 + 124 = 252 <= 256, passes
  - IFIRST = offset 252 + 4 (xattr header) = 256
  - ITAIL  = 256
  - IS_LAST_ENTRY() reads 4 bytes at offset 256, past the inode buffer

Fix this by validating in ext4_xattr_ibody_get() that there is enough
space between IFIRST(header) and ITAIL for at least a 4-byte read
before calling xattr_find_entry(). Return -EFSCORRUPTED if the inline
xattr region is too small.

Reported-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb32afec111a7d61b939
Tested-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7bf9ba19a89d..5080ec44228a 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -652,6 +652,13 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
 	entry = IFIRST(header);
+
+	if ((void *)entry + sizeof(__u32) > end) {
+		EXT4_ERROR_INODE(inode, "inline xattr region overflow");
+		error = -EFSCORRUPTED;
+		goto cleanup;
+	}
+
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
 		goto cleanup;
-- 
2.34.1



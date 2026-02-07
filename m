Return-Path: <linux-ext4+bounces-13616-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C++BCWUOh2nMTAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13616-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 11:05:25 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6AB1056F0
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18073301DBA5
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78E332902;
	Sat,  7 Feb 2026 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqJ0Kt/+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6973321C8
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458720; cv=none; b=Rp1cAh/gssJoLFUO2atT7jIyyfFbsEc0wj5bPulTBgRw0HFIzvABPitFyb4ss/65wZMeNQToaCkkm3LpJty4RoM83O7BxUv8f+jffTHO5l6iv8su9Z3wwq9iFBdBT2+G7TWj2WGxNdaH5CuNlcXXyUJKqx2uR+JS5PRQeJm2OEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458720; c=relaxed/simple;
	bh=nt0OpJk9yNClYqQUmCVLyWL3xhyGAkVjpnvfTJmp1J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VV1qP2TwjoVenDaSCDqoRcLw8jzd6vc82qv8OEIAWQ65mz0eJRRLK4mBrbZe9Mc7jHuBt4c+6aNXO1J9AGB2YrNvxXQz0AReCCuxZsYZyqkYlpw3Chh38+SMA5SjN7oxlK0T5vMivPk+i3LAEyIrKqdq/tVR1ZlMiNLRLRbZZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqJ0Kt/+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f2599980so34956685e9.0
        for <linux-ext4@vger.kernel.org>; Sat, 07 Feb 2026 02:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770458718; x=1771063518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoH7DPlRY6JcUO1K1yPBAL6Lwnx34i+NcsDw5009tM0=;
        b=YqJ0Kt/+Vn5d6IfvROuf1qTysc5F96Q6lOB06hU8vjffDgMg3AXO7XprdlxKi8LR3d
         Mg2rMxCJyFEQInn/V007sQgbjSAtllK617QsDh5Jge7xsSxfaJFOwmFOBrCy+GCVo028
         aewH5JNLd6YlXMuA7IEop/JxwuD6r7tYXBTGklEmqUij8RWka1URz2v/QjGgICq5ou6t
         6X/2HE1UWxhOZrDYQacGJ/bxgi5d/vNOMD6zf+DJaAvPHLO1X7S1zfKaTqKhAJRgrLr2
         QVa6Ur3o9pGBhX9qWg+38Qunqwc8MrveUcU3FIYnRSsSvrP/YO4cnhuvUzkHu54WweL3
         Xz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458718; x=1771063518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoH7DPlRY6JcUO1K1yPBAL6Lwnx34i+NcsDw5009tM0=;
        b=MoVtO9wxYAiJeYIA/K3Iq9JVHNzZFsoX6KuDvUiZ9usiKKSJ/b/HdsnrPZOPS3KlBc
         tmaLRAxNvn+yygwOJG3/DkWC4DFSpNl1hH3E0E/akhN+lkx5Z1B6inJJRN0tDoX+sI9d
         R2vtA6VTZtTXrzF6cl90JHo4zY83zPmCL3BE4gD+gJdjTro5K0/QuElmna/9nzZsd6hf
         ODmxD/ROELBMU5p6gq6YY+WJLC8HbDoXBNW/0eRdxhXiOeV2uuAya2kLKF8d01fRwPPD
         cQODMTxcicqzlMewlx/xQ7gF2qOROyRrHiEqPqpAp7PAsLCklTdLE0XMUrf3RDrfPRSw
         ljtg==
X-Forwarded-Encrypted: i=1; AJvYcCUqAyaCstpXRD3eAm7Ltjqb69tQu5c8zat9+sHj2rfuj2Fnke5EdwZB+BMaMiponyJmcxJZPk+0dSLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXxRVhiUQ+oY05hLOGiZgUAWo43ervfT7XDj9Bt0Z3b828H55
	ybgS3hLamq664YHfX5f6s58dXqNv4GzRAjhK2TqrPlV2XcsskmLsJiLa
X-Gm-Gg: AZuq6aLgJEcfV7iFnoq/g4QsiM81MdCCGABkvErQGJlumms7u30fmt7BYluLqWge1mn
	vzHDowy/ursLSBSeH9YGeKjlVccg8Ocej3uvuXdJ3LdVp69vE8qZEjxV33b68oGcmwlVX9gf+XU
	EupyXecxjVr0ixzIT8RKsz9EF/0J/JVx8sbzFqTlvSVYYLG8klmhwEL1JGG+7oXij+RqTyOl8bH
	xc5crnVLk8UQIVpbFmhXcJ1owbIf2n/8uMeRsgHBV16gEzQn6ohS/ILB5I2/B+kGXjg1fjADuPg
	2BCxmDNoih6fZ2IJ0ihVkAZLqR+S6FVR86kmAJdb16i/00ECTsx3qmqFYEQhG/Nl+tC5aztxkch
	RFei/Xl/8fV4gY3c+7afYaqfYcyRaOZfhGy/qtmnU6F6N/iuksr9UyhVGpYl7CJ5G
X-Received: by 2002:a05:600c:46d2:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-4832022c31fmr76247505e9.34.1770458717680;
        Sat, 07 Feb 2026 02:05:17 -0800 (PST)
Received: from ewewe.. ([2a00:d4a0:5:3200::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d835f0sm181827715e9.14.2026.02.07.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:05:13 -0800 (PST)
From: Simon Weber <simon.weber.39@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: Simon Weber <simon.weber.39@gmail.com>,
	tahsin@google.com,
	ebiggers@kernel.org,
	Anthony Durrer <anthonydev@fastmail.com>
Subject: [PATCH v2] ext4: fix journal credit check when setting fscrypt context
Date: Sat,  7 Feb 2026 10:53:03 +0100
Message-ID: <20260207100148.724275-4-simon.weber.39@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13616-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,fastmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonweber39@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email]
X-Rspamd-Queue-Id: 6C6AB1056F0
X-Rspamd-Action: no action

Fix an issue arising when ext4 features has_journal, ea_inode, and encrypt
are activated simultaneously, leading to ENOSPC when creating an encrypted
file.

Fix by passing XATTR_CREATE flag to xattr_set_handle function if a handle
is specified, i.e., when the function is called in the control flow of
creating a new inode. This aligns the number of jbd2 credits set_handle
checks for with the number allocated for creating a new inode.

ext4_set_context must not be called with a non-null handle (fs_data) if
fscrypt context xattr is not guaranteed to not exist yet. The only other
usage of this function currently is when handling the ioctl
FS_IOC_SET_ENCRYPTION_POLICY, which calls it with fs_data=NULL.

Fixes: c1a5d5f6ab21eb7e ("ext4: improve journal credit handling in set xattr paths")

Co-developed-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Simon Weber <simon.weber.39@gmail.com>

---
 fs/ext4/crypto.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index cf0a0970c095..a89a14dffa48 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -163,10 +163,15 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	 */
 
 	if (handle) {
+		/*
+		 * Since the inode is new it is ok to pass the XATTR_CREATE flag. This
+		 * is necessary to match the reamining journal credits check in the
+		 * set_handle function with the credits allocated for the new inode.
+		 */
 		res = ext4_xattr_set_handle(handle, inode,
 					    EXT4_XATTR_INDEX_ENCRYPTION,
 					    EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-					    ctx, len, 0);
+					    ctx, len, XATTR_CREATE);
 		if (!res) {
 			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
 			ext4_clear_inode_state(inode,
-- 
2.49.0



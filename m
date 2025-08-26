Return-Path: <linux-ext4+bounces-9650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EDB36E6F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1AF8E62ED
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850E35E4EE;
	Tue, 26 Aug 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="E7v9DGwg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A2334393
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222888; cv=none; b=aLb3uUmGp7BCRr/FT9W6Qnqv5ijMn5x1O0A1M2QoA0ntFtqcCoSyLXLmnD60dt42B4ZJkDP9o7ZYn1VgY8GGVDKGCCLL/JdkSrjhiiHWWa+4qjSaZe9Ad1MYFZJ6nc+9F07j1JBf+W/Fl3mZbYIMN4JBrTDtIX+hgThN/B1Gus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222888; c=relaxed/simple;
	bh=n2PMRuPR6JYZVUW2/KJe5vnseijKbMo3WzgrzTCJifo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL4HQ7QKA/K6bnVPOAxP7cyD4cT3KnQzZSLp6ugjJuzkZAFS7P1T5M0CL/5sJ4fS/4o/FHZJ7uG3aV3Bw+qnPmVs3PHaWlbzNnD3zxqscoqyGQTmU6FlZIu4B0OtexO+ZBZ4pbBmh6RThRICRVBtRhBWhxs1rF9jvimlLng8eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=E7v9DGwg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603b674aso39508937b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222885; x=1756827685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlLhOSIwCH5Ivh3dHEMbxIwp8egJF9NMtkZv3ZbCr3U=;
        b=E7v9DGwgsmKY7t1jhTV4pIfLjhzC5WYtx+XzOZFLGfh1YpY05yFYpOIIUX9D055s4j
         225zoSyf7juEHEWrhLt42HsvDWo5m0OQ8iCDW6GpILZdfFzbCgLvXGaJLgBuh3WzR1oG
         e+2svNTsgeUTWbdzzh5IJXQ5TZi/weAOn++0qe+Pmwlvv0+Knx+MvLhrqtPUd/m6EEzO
         awxa3xEX1qpVaGCAFf26fC8Zp3owRAvGFgzesZpK2P8aEAfXY2N3G3lnRcXw4D7/b8kS
         K+KJFXkUcq4jXbV42Xa4WZ59sTk25VaXqrf3rJ7U3oXTCWPoWKkyeOZR/1NkyB9/OPEc
         PCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222885; x=1756827685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlLhOSIwCH5Ivh3dHEMbxIwp8egJF9NMtkZv3ZbCr3U=;
        b=cB0phvYjFH+Pbm/2YdxooeKg4G8rLWowcu1F7ZY+X6fqgMOei0WJHhSb9rKhNj9xVN
         deX343i5sacAHc0hhcTtPQIzaY0Frofan/O6yKykmnGhD/TGBgW6ymE3cfHNMPXWfiPo
         YTxtS+HPvSxqLPpnqFQ1EJrBP5u7kx538NF/geHyFqRtHpLsIbC70nKK5B1s6HkQk5DH
         GvqA/mpy6IL7Qjz3s9beh8dgCpciKQxkjrMMTpqXSU9dq9+sBkDVQJ/Q40QauBJIPta7
         NUuZZK0bn69/Bv07x4PEqBK0GoJ6R9HdHEHrSa0/TL6UEhV8xPSS5S5Wrwem+af1hrdV
         A/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqmuJKBRZd0SQIUxwTMcQr48XNMPni8ORxzgG1AZfq7vMbxaweznwmhbb0MInsZZ6ztB+075uDlqLp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64jkwaNd0pw807Gs5OebfiiJxzWmI5O0QIwahF908C9BVUSlW
	ZrD8RmZw8ZHifr5J8EqDLFWyL7/avrTtvtq4cYpeuIsM/qZ/qOv1fX/Z51ehrCfuhrE=
X-Gm-Gg: ASbGnctdL2SOUEsAeEXFyXHsXqKZH9NVYoqsHEbzEVQSlNbdWjNjF6U8tt6iuRWgfWV
	r5pWHLQ1fudKkscJTfhVms7NI4fNDZc5VbF4nU0LFR9c2bP7efv8z1mT9RxwXEVv9A6ljaiCWQ3
	8p6NVCLvR2C+zjs8ng03etjWlzC4SV4W+hiJ5ZTx2j25t/iqeKhO9+duBysrWMANGOZLPhkB0SR
	nfuaLAUOceesIDKZUXNf86SZDitVuGHiH0e0eVNciHw8h9yi7jEQJF8TfKDc6phd3+5/YhtNWf2
	x8/E6fymW7gqocttrOGIAhJn0e3Sh6hQI3FkS6EQWbN9SIzGs4GXSKyF80/27qQxB1WKvnAtHHE
	fRWdc8yxMSsRfoZa0Cw6svyhrLxrZT9Kj5VZt56/fIezvQG5eRU9VvOyJc7bQNzoETr955Q==
X-Google-Smtp-Source: AGHT+IGWS2z+DTg1fDukCryUmw/K/ldjfo8vScGliNb0JD4SGdAHIMczu/WUBMkIGgEqVpAF9+oHHA==
X-Received: by 2002:a05:690c:311:b0:71f:9a36:d33c with SMTP id 00721157ae682-71fdc41251amr159709517b3.46.1756222884962;
        Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18add4fsm25000297b3.51.2025.08.26.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 25/54] fs: update find_inode_*rcu to check the i_count count
Date: Tue, 26 Aug 2025 11:39:25 -0400
Message-ID: <d612f83abe1ff518ee85319cb593c0ac4f266cb2.1756222465.git.josef@toxicpanda.com>
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

These two helpers are always used under the RCU and don't appear to mind
if the inode state changes in between time of check and time of use.
Update them to use the i_count refcount instead of I_WILL_FREE or
I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4ed2e8ff5334..8ae9ed9605ef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1823,7 +1823,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    icount_read(inode) > 0 &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1862,8 +1862,8 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
-		    return inode;
+		    icount_read(inode) > 0)
+			return inode;
 	}
 	return NULL;
 }
-- 
2.49.0



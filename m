Return-Path: <linux-ext4+bounces-11539-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D26C3CFE1
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D911891E9F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808434F47D;
	Thu,  6 Nov 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m++XvFlg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694C354AC9
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452083; cv=none; b=g3biaxOlkVTEdWwqUtw6TDu37DAKgi5H8rSGWx81Z8ka9W4lo2OfHyRTfcoo86agW6W46syDb5tzjdRgyv+ETxP4atMK0Jji9CEDVlEyCKBwTJGBeQEQe9XVm0PZS757yayYP5HMRE9N0COPDhY1oY7x3Qdx3RgkeYGQbBwdJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452083; c=relaxed/simple;
	bh=ujXfxZ/rw4BEjhU8Wrycg8rg26Ml1Aaup7GlBWzDyZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJifTJqoAQpxc8GYVIZdbF2H6CkKH5IeUHEUR5ILOrkCBMeULRhyx6lXRod6lJxDHlI60siUaVmmAnfZAeq7pWXrkLiWQ35q1/SiigYbTD+yVOU4x2ts4wK/xNSAVpNf0pdPbULJR1Zx17OONvrasTsEYBSKgfjJUXj43Ff0Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m++XvFlg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso4049089a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452080; x=1763056880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=m++XvFlggLYGtWURJpzC7p/1C9rYObR0h2Tyt10Ec5uh4olTmPPwiGdkW7aSmtfKTP
         oPY8EmvSv9mgZsadOVci/gGUfPTND/8BNUtseqRtzFCnH48A5/qigLhDr4UN1Yp44LIW
         Stpto9z0foT6A0HGJ+IJHT9m3ow+9Qy7yNZ/FRrHBjvdw483rCfl5jqAX30+eMfr2yXQ
         vYm7y0Caa7Oescun6lrsyNiTp6LDf/gQfVt9dxsIIh1R3c9ORJXccBgnP4q2hyJeMb2m
         EtN6itT2HacccrUuSD7JohWIyskBJNVZBqFCAh7MWE2YEdn2sS3Z1fVoDlPB+HkHDUVD
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452080; x=1763056880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=KEQ0C52LpKxMafrAsUhVYTvmCBKaJQjBjPm9jV37OOiCXKnLwwMpEzPsuk1SWMUGSz
         Md5CqP1lCE+Q9ouB3aqAz807g2ilJtg0ORwszV4PbBSQz81aC4koeGwvIULQpbi2XlAK
         DJPkSjvqQDKtviKJv3uer9f4jBM5Cbj/TNWd0OBfgx/rKElOLFf2Qn/IbXp5sd1yKu/v
         pHZhr6gJB5TUwYmZIr/RAHnpCaEKrk12tJb0/TBcCIskxy8l6ZJV/I9x0grmQQC+X63f
         jCHAdTFTxP/hl8tGhi/KRrk6XWqtX/zVfDZ2h/EZAwj4c68rcwX7jn+Rwk+V+0NohhHb
         W7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVLGeIsQWRtW+RPJbupeNHLEzV4rYrfruVWE0/2C1Q8CQKfF1wrli6wSFz4AaqJqTkfV5vp/AlX9pyZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjHGwrZG5YbUx5RCXTTwb5pZEPOGxrWxNtceLVqjSBtXo1sx0
	eH1uWPhZEmUL5xFXwF0YmyAZMnCfmj+f/xU4jtaS+0D91dXIm6k8hv6m
X-Gm-Gg: ASbGncuBqWyBm8QPVwaPImLmp0eNhv5RlyBPsZ7m/76yuj4AAlVoeYnvXOg697Ac5rS
	bVdoq6VXDccpRwvtho+5Fu2+OTder8mamPpLSSK5iqjQ9Zs8EnNawIkiLGLOxw9ucJZwJQ7UKux
	URqX/nA3/wmZFzXyqh5g4OHEX2HHIDbcfYlvgLF/eKFM6tnjLhTfniGX+FyAUgB99nI7cyeSOf2
	9aJYkCJp1J/jrr19Yi9cjWUMN9P6iMAvTp5wwtI/RggkBf5pQd/sNNmByL92Bqc6s1YyYvn/rab
	ymGHZKdpUVSp9z9oxpSqqnT4hhtSHxqkMySlSbR3u7+qqp7jAtwAkgfwpf7ISd/WBeUfgJDI6ne
	Dj+sbQXHy4QSVcegAVPg6hlxC4PsnP5Ky8hfzSO3uNakalTKXaBaXFnKEUlvaT15yNVN3SmeW4R
	6TtBOQj8ysCHjSxqWZ46jSo+DpG0FsKluyZOeZ5Km307yzzY7l
X-Google-Smtp-Source: AGHT+IH23Tiy/uzhlQVevCqmAaX2EuxhMCeC/ChKrhzDKky+KjjBLdpLh4g1NTZxdt8W+eURbqVM8g==
X-Received: by 2002:a17:907:86a3:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b72b9550caamr52972866b.7.1762452080227;
        Thu, 06 Nov 2025 10:01:20 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] tmpfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:02 +0100
Message-ID: <20251106180103.923856-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c819cecf1ed9..265456bc6bf0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,6 +3106,15 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	}
 
 	lockdep_annotate_inode_mutex_key(inode);
+
+	if (S_ISDIR(mode)) {
+		WARN_ON_ONCE(inode_state_read_once(inode) & I_NEW);
+		/* satisfy an assert inside */
+		inode_state_set_raw(inode, I_NEW);
+		inode_enable_fast_may_exec(inode);
+		inode_state_clear_raw(inode, I_NEW);
+	}
+
 	return inode;
 }
 
-- 
2.48.1



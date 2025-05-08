Return-Path: <linux-ext4+bounces-7772-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A5AB01F4
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6466A4C056C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C5286D68;
	Thu,  8 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2PqFmua"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BF286D57
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727177; cv=none; b=HBD7qugJKNnC1i991L8O1ef00ybAoSrvUkLft9wpAcItT0kedcP96Us4umKckAXOxhMzpjZCxoDdKQwmcQzTMWRlCv+N34OMHDIfDdn88NECBEvehojDsTeHjORAxU1aNRVEOwKUNNdnfCXuq6spQ1niFiAVVciFhYi9cRgFPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727177; c=relaxed/simple;
	bh=euzDy5W3RCCN/7/FFqniDYNWbLu9Sf8b8BbLwh6BIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwUtBtP+IdEsrVXIwNlOE+6fS7dQkUdwMQovy7LxzTt0M/hHN0TxmhjPR1aTNiraq5YdqTTSgQXfVhJMJXWoKSJcPxcTQ6dNfR7s74QHU6IePUWdmZOU8etV2RRHOJ8n2TVqnPVJsGPE9UWYd+7Z6aUKGaQxfAWUwfYP4laYads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2PqFmua; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b200047a6a5so766720a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727174; x=1747331974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J3ONY8vgdLjhe4cTDoDJfzp8TTcSljQEGDbEciEr/E=;
        b=I2PqFmuasJ1NDvIYbEpTze8zYNXvt5Q7BCBn0kyqg1S3y/DELBcGPJ9NvLfdqkqoNl
         MMgOakjFX0MO/FqzyLNH5sIhw73n/4/jwnDtMpypCbcgUhgNd13UDG5Q37BvlA2aqpMO
         yw4lG7pOdY8pI/uZtOEmkpGh6mLU0iJIT1Ef09eiM9MSv3ZoJ6g+dppBkB32yEwp2BRA
         iQTdDumuYbpgkEWezMm0l60dkb1ELuGknnL2NguHXdbsSKxbD/fOtSh7TMbhJpELk2a4
         u29bC/ibCgVIswRojWhaDk7wImfT916sCw/phIUqSrWX3ZpVUqkFnMJE9phzqPdWFq2W
         FN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727174; x=1747331974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J3ONY8vgdLjhe4cTDoDJfzp8TTcSljQEGDbEciEr/E=;
        b=bChp1oTeVESqmO4ukq0v54KmDNrysG3YwL8aSAd+iB0h9Yn+uGf0VhOEWHYjOmvyp+
         DHvgRn71aLj/IuQts49allrsfg0RxajvKiK2SlONCXPTQIj2QEc790TukXwWmDQc5wX6
         6vptCLOZKYv85I6I5kGhaE7QOMnJShTJLzUUTq9JzHIfTrVxOPCe96NjsMH8PEN7g8E+
         35LUbctqbawIxwg+h/a93GZCHAnFzjnsJtk/Kg7R+QGkEvtuC9kQo0KW5mvEyhTf1+Og
         bxZZrbhh/MceX1bOzHzOzQMkaQeaCaMmG5+sUVXs238b9yc90NE4iU1AVH6dYF08SwFg
         DESw==
X-Gm-Message-State: AOJu0YzY2G5r4iUySxngptGHhZMEm8uvzXjGPTNCUN1LGR1MNYRSYgYw
	d56uosX1ohgIDOH/zScYxv/Fh1OjoL7UZooobOXTHKbfZYOk+41sAEi4KEHjbCc=
X-Gm-Gg: ASbGnctpEVJljsQtj6l79s6kZNQtlloWau/n2pqkrkRc6NHAQYcfYZDMvPtPnOD9UOm
	VLKWGEShf0t+QZrE+6juvG9hyZIAHoehxtqNdVYLNl8ml2AP4pOOluXinOUN9OxYgASIcEWi0VQ
	9GghUkQ4iE/Hw88ZRur+x+wTMaRpNd35yIupiPhEeVkplO+XlvUdRsdViGTpPMx99Lma2OaAtZl
	N1PIYIQXn4ziczmuG0TBZZ9DilIhq4gnLmpiGs1ptjv7J7NaBF8FZIlg2a/qBt6Mab0GKg6kC2s
	AwZYSW8lAt/tb/F8wGF3sYO49N44j28KZ20uOBW5G3J+Kn3y9TCpCk6SaqjGVAZM1GEiYjGZkKF
	PM0LuV8V3v1t54+xurZjs8hMLADR3xMV85Vv+
X-Google-Smtp-Source: AGHT+IGH7W4aIu4onz8qGaRGeceN0YjRFsSg95EdhhCr3dnak6AQxV7YBi3TofZOWGSN0G0n97u6WA==
X-Received: by 2002:a17:903:1744:b0:224:3994:8a8c with SMTP id d9443c01a7336-22e8470d946mr61701005ad.8.1746727173718;
        Thu, 08 May 2025 10:59:33 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:33 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 3/9] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date: Thu,  8 May 2025 17:59:02 +0000
Message-ID: <20250508175908.1004880-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark inode dirty first and then grab i_data_sem in ext4_setattr().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d58b99407..3005053e9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5568,9 +5568,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			down_write(&EXT4_I(inode)->i_data_sem);
 			old_disksize = EXT4_I(inode)->i_disksize;
 			EXT4_I(inode)->i_disksize = attr->ia_size;
-			rc = ext4_mark_inode_dirty(handle, inode);
-			if (!error)
-				error = rc;
+
 			/*
 			 * We have to update i_size under i_data_sem together
 			 * with i_disksize to avoid races with writeback code
@@ -5581,6 +5579,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			else
 				EXT4_I(inode)->i_disksize = old_disksize;
 			up_write(&EXT4_I(inode)->i_data_sem);
+			rc = ext4_mark_inode_dirty(handle, inode);
+			if (!error)
+				error = rc;
 			ext4_journal_stop(handle);
 			if (error)
 				goto out_mmap_sem;
-- 
2.49.0.1045.g170613ef41-goog



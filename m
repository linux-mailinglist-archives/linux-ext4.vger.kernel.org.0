Return-Path: <linux-ext4+bounces-5180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33FE9C8E56
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A24286242
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61E1B392B;
	Thu, 14 Nov 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vqv0OtCw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD81B2181
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598107; cv=none; b=qiNCPSMP//PDF/Kv90JErazZgnzF+R8kuPcg24d1Jls3eYNRnAdntvjVJeMMoNDTP3+/rDyKS3ylUPXqht9RrQ7SoatVC+UOQHt8CSo8WO/GC9euqaMfeLkYoHlFBB/swyBmCxoGbg73eUIT2jjEAFvx997vEJxx1st/WfrXq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598107; c=relaxed/simple;
	bh=EWturTTFhXmkkEY1vgH0sCBOxeoOqbPcFCX1D34ye48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkIeApWHlD8csUWchm5OOZfudAKzjvWLybzY8Nu+j6athPjUEl8iVvdUZB6wl1ekHAvVkW4y/wXCVcjUerVCba3P8Llsfl64xtd6Q4m9aud/PZlDM+qeehJx6sVaaoMANDOlUxoG2f6K0DtlIuFjy6Ij9+KvvY/G6HFlO08opZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vqv0OtCw; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ee9dbf1b47so432192eaf.1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598104; x=1732202904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyBHBKICHAilzWbXxQX4w3ArnCN9Xkn7LoXdkHxZ+NE=;
        b=Vqv0OtCwgRDqsZtuQe08cRI5AEU4os8/ta0n4eX/9ZzESqQr69CLPRaiNzfcALUAMb
         aCHuZLxROp6xGe2OFYherg9GVvtPc4ZPytYRlb7ZAU1YXLo73tMCG8+XXwbnEdRC2apn
         F7FVPaW6JyU6pWRUOovA9Wsor71N2l3XfSmtTGH9Wlaov6WWbD8BrbVgtJutLcEn+kS8
         iffYTdAD3JeLbC6yYgcbX+1+CWmxard7f0dv66gi42wzXTfeawuVkxuMUFVygJRVBlWy
         WrBfOK2BNxRfRDtbZujF1cDTeAzQWfWRinS1A8GeBXJY6qE0+I6Sx52yGTaII0XUT6rW
         n7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598104; x=1732202904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyBHBKICHAilzWbXxQX4w3ArnCN9Xkn7LoXdkHxZ+NE=;
        b=HnYh5o8qyXtHMLShoCmhpXt84PM3X1Tw+MINrAMHXfnjT8YWuP23iOdk/WpGEj8KyV
         hhkOP25mvha9B5wl7mwoYA2d+Dl+nXOb2uqnbl869cv6hyr+ZsVVIG9Y1U0ZY66ERx06
         +BgKidiR1522UY4DqEmH2KN9NUczDwnwiJ8CVzJJzHilVLRehqpZtMVi3WLJcH5VagdT
         ro/8RY7vRtiLf34QWTHPcl6Il3Qt8hmxy91DwF8sAJJEX13k9fFyfu5lh15ZnkMmC2vb
         5Ks1+Jr7snjdC4eGaHoPTIjksxVORSTuh0QGLuvz9rACsvvAwpC/Y5U/a065onLcRolj
         U6FA==
X-Forwarded-Encrypted: i=1; AJvYcCUQmHAVSrETv833DBWOqeg2PNlYX1kg89sYgn6MANeJe+31CWGV+eQvq6isLo0lmZXZSMIMjrFnZneE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ93sVDFYxCNUxvDW6yKVjmO9tR0Wx1JxDjAY+vH7/dc3pINZf
	TPepUgXENJcAvwrz9AAEwuHDnG6aIYfKBj6qYtOYN8uwnuZOHX0K2abcL4pIxf0=
X-Google-Smtp-Source: AGHT+IGTccgjkWiSk1+iFGbOjrOkQSSEn+5BvJmTbBLfatp4glFbzMa7kfcy1vSIijdABdXFBUl4NQ==
X-Received: by 2002:a05:6830:7101:b0:718:8ce4:6912 with SMTP id 46e09a7af769-71a6af419f8mr3092006a34.14.1731598104601;
        Thu, 14 Nov 2024 07:28:24 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/17] xfs: flag as supporting FOP_UNCACHED
Date: Thu, 14 Nov 2024 08:25:20 -0700
Message-ID: <20241114152743.2381672-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read side was already fully supported, and with the write side
appropriately punted to the worker queue, all that's needed now is
setting FOP_UNCACHED in the file_operations structure to enable full
support for read and write uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..4fe593896bc5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1595,7 +1595,8 @@ const struct file_operations xfs_file_operations = {
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE,
+			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
+			  FOP_UNCACHED,
 };
 
 const struct file_operations xfs_dir_file_operations = {
-- 
2.45.2



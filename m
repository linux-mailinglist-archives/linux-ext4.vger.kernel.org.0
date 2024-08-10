Return-Path: <linux-ext4+bounces-3695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D194DB6F
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FAE1F220A3
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4376153BFC;
	Sat, 10 Aug 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMOnmKtl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10261514E2;
	Sat, 10 Aug 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723278517; cv=none; b=mqJeYphflGQ95BvfT6DE+eZkslDHgGsX8KthX4TxZLscfYqFbqtkCvpnkisKKPkqgQYaa5nTZ7EexIVyW9JBzkEpORg7bBDKal9/r6/wXOu6o0YE3wNrNx0XdTKRe69hFOI5FcXk0PNfcxPSHhL2GMCHaYVq0XtJi+QkF1D6hhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723278517; c=relaxed/simple;
	bh=pgVoWRfxgQs6Hha/2qLVeJyPGpJ96P+XjQIWWOGJFXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8T3fQAsAEFCvnxUl001CoVvk9j3FcmOSGUEd1FO4mRxYNt9WE+JXdYGwDtyvq+vf5NPEHsQI6ehXIz7enjRpC5KHg5HPIEeobfz1Lu6MtQPj76OxtnUfepJ3KR2kZVJhnF8NnMcywCnML+m1G6lqaVjJ4ZOUxc00j02WrMNxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMOnmKtl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d18112b60so1823505b3a.1;
        Sat, 10 Aug 2024 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723278515; x=1723883315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adNFyWjIXtMjUcXG11VGomGh7BHR8ZvgxWwTiurTFvU=;
        b=TMOnmKtlq85YkVvida9HrOBEO696fRpHOXhfiJ+OCcf4yssYrAGeLQZgDbOF+/iIpS
         Yydkqi4rDGMvOxXpbDzARWqH3ZBswCCNHY99RcCi4MyJw9LsLY3G15UXm8L7iQU4Tl2D
         Mpx02fwPu1m3Vj3sJvf0cJ0igDpc/iWN27gGxU7NMceHjeJScgZ/AseRT0BV2YOJBrU1
         jEDiLqIsceHkkvi3O43A6wXjX/1t1rDOuRYA3qiR8yoR+xKUJG/BJXA6xIN7U/v8w+S7
         42SxTGyvHb92VQaNnBpRJLpifByFRigL24+mmA9lUBsItp7ec8CeLB0GOhIRf7KHtwFq
         vbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723278515; x=1723883315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adNFyWjIXtMjUcXG11VGomGh7BHR8ZvgxWwTiurTFvU=;
        b=QKzQxs4iJifBsALPwBcHOY1RNpu1nDmb7pTe5uD+vYZUWhYOiqOOY6Giw/kspMXJfQ
         jJVYf1eOq826vL3Fv90U+nC284aQsFEsJja9074mRw10srbJ528QQZ70Vpk9+iVwXhoa
         rJHqSvPPEgYCKokO+YRkrDDjiOLOAqcKrX1+tHmu13u0k1m573unYR3sNpBNCAJ5H4bi
         DR0yUPeEMJWNcFlTHWbe1wT4sYi09s6s0NGbchzeAVPaGeQvJGGtoswT77uJHekNthlP
         ihE6DkOuv1VmrsQcIAIGL67rTl0brv7qZ+bLLQfypMU+EKCuKiAAkLNVl92ouKQvX5A6
         Eb/A==
X-Forwarded-Encrypted: i=1; AJvYcCVpIQnkPcNNSO3WBZ1iI8SpRgzbkV4TR//H08/N6qbYGd0AJp2ksoHl2CPQ4GUEV1k78hSiiWUCsO+OBt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgyOiq44mTgUQh+UpMVOyfAbzaUmOLirITyAhOTtml+pRIB9G
	tfWuCiKNA1ge5mnaTeQOuJdnFhq+2iglM97NYdK24wAWtPWreHcS
X-Google-Smtp-Source: AGHT+IFR72KuXHFDYfNVANkWiU3aZvT48F4qXTFGZyp86Cy2+d7Yk4ks6c5rk6vIcD+Fj6ABmrgakg==
X-Received: by 2002:aa7:8d53:0:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-710cc90db8cmr11683860b3a.12.1723278514878;
        Sat, 10 Aug 2024 01:28:34 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8c454sm854092b3a.180.2024.08.10.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:28:34 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [RFC PATCH v3 3/3] ext4: remove the superfluous things left by __block_write_begin
Date: Sat, 10 Aug 2024 16:28:14 +0800
Message-Id: <20240810082814.3709867-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240810082814.3709867-1-zhangshida@kylinos.cn>
References: <20240810082814.3709867-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

This kinda revert the commit 56d35a4cd13e("ext4: Fix dirtying of
journalled buffers in data=journal mode") made by Jan 14 years ago.

Now that the whole __block_write_begin and improperly dirty things
were removed from the code. Remove the related code, too.

Now we get a better and cleaner world!

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/inode.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c34827da56e..cb6de9921655 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1023,27 +1023,13 @@ static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh)
 {
-	int dirty = buffer_dirty(bh);
-	int ret;
+	ASSERT(!buffer_dirty(bh));
 
 	if (!buffer_mapped(bh) || buffer_freed(bh))
 		return 0;
-	/*
-	 * __block_write_begin() could have dirtied some buffers. Clean
-	 * the dirty bit as jbd2_journal_get_write_access() could complain
-	 * otherwise about fs integrity issues. Setting of the dirty bit
-	 * by __block_write_begin() isn't a real problem here as we clear
-	 * the bit before releasing a page lock and thus writeback cannot
-	 * ever write the buffer.
-	 */
-	if (dirty)
-		clear_buffer_dirty(bh);
 	BUFFER_TRACE(bh, "get write access");
-	ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+	return ext4_journal_get_write_access(handle, inode->i_sb, bh,
 					    EXT4_JTR_NONE);
-	if (!ret && dirty)
-		ret = ext4_dirty_journalled_data(handle, bh);
-	return ret;
 }
 
 int ext4_block_write_begin(handle_t *handle, struct folio *folio,
@@ -1246,7 +1232,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 		folio_unlock(folio);
 		/*
-		 * __block_write_begin may have instantiated a few blocks
+		 * ext4_block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
 		 * i_size_read because we hold i_rwsem.
 		 *
-- 
2.33.0



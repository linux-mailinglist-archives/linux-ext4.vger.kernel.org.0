Return-Path: <linux-ext4+bounces-9655-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DEB36E82
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F52A228F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DE36932B;
	Tue, 26 Aug 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sEstQBzG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3343680AA
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222895; cv=none; b=aH0dPZxuvmEZ+uuT9hD+nEkLhm7NYR6xkYTxlPQyJYxhj0lDfG7xEwxI0lXRRbSAoOg4fXgfEB8hn9OI4FKKjN9Xrvjxbx9A36RpO7/NdjUMN6HKQbg7X4y5qlAqNZvIrJx1553TlH4quNCHK5N0EtQxtBPGtRE/2fzXkCBCl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222895; c=relaxed/simple;
	bh=HO3qn6E2mu4iKLp4ae70vUhOoqfZurpCVV09CRALkRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ4qFdLLLvjb1i9D0PAAw2UuzVN7A9pKpQJ0chuuqpyl0cH5DmOVy9irhZFD7gxGVnNT83xNXgXyCA/rVGJuTiDp6sIEO7EgHHbAZQslBCZ4OKs79AtFf4wj8GeL5JRPCg2cYY+zPycs76Dexa9XSE3hNItUyAqm5kFe/ze2nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sEstQBzG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72019872530so23005407b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222892; x=1756827692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=sEstQBzGN1LPfhVQ2Rz5gE9Q1fD8N/GQEnAqr8Svk8lo2CdmDjEQF4SGIAR45zluP0
         eYc9gFHTsGaJ+dtZ1b/J9RQz2D49IKVzp/y2VeyjzmQ4bx3hzQc5RCDknQ+Km2/yp/S4
         a/QKOnWyx53s6PTckNaPJO1JPJbcp4TurWvzaWUfjUJuoUM84QgQ93egZUHK1rQswQmx
         Zv4Z0enm/kpHqLBS1+a6J1orIP2n65XxzvFIHtFc6xB2YHRhvhC2gOq8mCNS8ptOyljd
         g7Hb1T/EyczmSiiYX3ANbXTUywkeRBNRQ+e6tN6SyQjgCozQuF/0uAbpu265w3FrJLc3
         zu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222892; x=1756827692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=iml2KeWMtj+qOGwUMP6P+LsLeZ6QFMJcyE1acURY7+rurkvIUqwJpkR9toCWzVO1VF
         NCsXkvBySgupx7DthAeAxiVvplAXlXyFEi33PIPB9oLoO6cOLhq7CLYCXWVkyMBv0GnS
         pWmt3qaUO+QzG6CF6mBdvN6X27xzi+QZZGN115YNxsY+5wwNruh0ZfOEzCpVXCSfz4or
         D6CTNnTnqFx5EQr4UMFl1DvF16Zef25z+e/ok8sOkp65tAzH63B+92TkgIsWHWIBB3uA
         s2IQ5gFO83veUGoe2p/YLLFHJbEn/U4Plv5JXrhG2HYokfkDkziShhuVTzfCY1ftNqmg
         zxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVFwrHoK5EPEObz2G3DpWny9Oji8DlUjUHCcXgf0qx5cZVtKUbTmnAOC0I+WIo78m+JCZiQuciapE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16MrThYPRWVGLX9GPsC9bsHTQ/b8nA50WgD/r97cL25cZBFoi
	xWBLRnRAO59YToYcyJiQWhe7HwoI3D7szIgopc7CbZH0FdUMEpm7OrAm0qHepq9IijM=
X-Gm-Gg: ASbGncslYcBc0gBmxy0aAcomKWoMRzWG6+NUIe3EZhc00PnUcA8+FRn9FVfZflBuIm5
	6OMcZa3O4INIdYoseoffm09tOgPiD8KkE/s0FqgulhOzd6Fm73u9z1S4zwHe+Rnsb1wAtdocubk
	woFnxWbgrFpE/VM+aANq66RBHaku33e4VGIaD+ZI4uJqYvHc1j8rro1+ZMFMOE0dlUhsPR+oCy4
	jMUduE4x7/rbJfw4+Slew6LCgXzEJuxigsVvIjE/GSrd7HKBBt0Zvhy987wWAaZg6qSBES173yv
	qTao06HJM/IsX2Y6zlrkDKZ0BvqrSx1694oPoLRxfFK27tIkp1FEn6zkpr7q4qN+QZ/3S8SdJ1c
	G/PlJWVn/4iH/POYJAwMIavxBLrjO9nYSPQtpFXCVOO4degVGoKp4c/+CqOk=
X-Google-Smtp-Source: AGHT+IEGTe9J6APE8G1RzLna9v2A4NhqUMcOqyHW3B9fdF1qoADqmNsdHuHOZlvMk5nr/NaX035KJQ==
X-Received: by 2002:a05:690c:7009:b0:720:999:cc91 with SMTP id 00721157ae682-7200999d319mr90958807b3.28.1756222892428;
        Tue, 26 Aug 2025 08:41:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f657f58b61sm2303577d50.2.2025.08.26.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes to use refcount
Date: Tue, 26 Aug 2025 11:39:30 -0400
Message-ID: <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>
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

Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
make sure we have a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..969db498149a 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -956,13 +956,16 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
+
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&mk->mk_decrypted_inodes_lock);
 
 		shrink_dcache_inode(inode);
-- 
2.49.0



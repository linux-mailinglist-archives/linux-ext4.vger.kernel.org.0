Return-Path: <linux-ext4+bounces-11396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D102DC28227
	for <lists+linux-ext4@lfdr.de>; Sat, 01 Nov 2025 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB74EBB37
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Nov 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A722172E;
	Sat,  1 Nov 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="n4M0JJJf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651E7261E;
	Sat,  1 Nov 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013273; cv=none; b=hyaIg0HVdINcW/cVqw746i6MzFaMqrS/jTL9v8A7TR05Y7rQIz9ibYNEUnlBpXRUpZ6fSpnehq4AKsMbbqK00bky+MQb4UVNVsjcdat88cU5A9huBK8nkGQFhdBvXHPdHRkWs41Ckb/JYVI8nCRHWntbOflMN76KhuBnAJNejEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013273; c=relaxed/simple;
	bh=rLaA5biyEWgzLspmyBsTRKuveqKq94YSvW4jCahrfgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7xH6TLm2rzRJMZkFeVN11UGj56vGY2LkIbtHVgC1TaVgoqJfZs3B+61YSMETOLPfZy8oq6TROhN3CRc0TdY4b1FfOv4/c4VUXfPWseQaq9OtJ3p5QDUV3cb/g51llcTUPGat6bzu1p8faJmV8vGWTN878/q13QrEl/GYtEHHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=n4M0JJJf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 89BF24076B5F;
	Sat,  1 Nov 2025 16:07:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 89BF24076B5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762013260;
	bh=XFSe9gHlAGM09jrTHm/1yNU5d6iXc71Vqx/fAARQGHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4M0JJJfimxzUvBdgmVj1WFvpIZFzn3LetwwQcF/goDK3bl3jdaJuvsRSmRWA36iC
	 rfPZVcLjLSSoJdPBQKE9kbtXfIncV8sQQZkbvayY+rPOBRwCaLmQZTXx1T4ENj5Ehp
	 BBZHJYfM08UqlmKVbFRwZzX4TuE+oW5AjAfOjT0s=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 2/2] ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()
Date: Sat,  1 Nov 2025 19:04:29 +0300
Message-ID: <20251101160430.222297-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101160430.222297-1-pchelkin@ispras.ru>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

params.mount_opts may come as potentially non-NUL-term string.  Userspace
is expected to pass a NUL-term string.  Add an extra check to ensure this
holds true.  Note that further code utilizes strscpy_pad() so this is just
for proper informing the user of incorrect data being provided.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: check length of mount_opts in superblock tuning ioctl (Jan Kara)

    Can't plainly return error at strscpy_pad() call site in
    ext4_sb_setparams(), that's a void ext4_update_sb_callback.

v1: https://lore.kernel.org/lkml/20251028130949.599847-1-pchelkin@ispras.ru/T/#u

 fs/ext4/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a93a7baae990..3dec26c939fd 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1394,6 +1394,10 @@ static int ext4_ioctl_set_tune_sb(struct file *filp,
 	if (copy_from_user(&params, in, sizeof(params)))
 		return -EFAULT;
 
+	if (strnlen(params.mount_opts, sizeof(params.mount_opts)) ==
+	    sizeof(params.mount_opts))
+		return -E2BIG;
+
 	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
 		return -EOPNOTSUPP;
 
-- 
2.51.0



Return-Path: <linux-ext4+bounces-9044-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799CB08FFB
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACECA47BB0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9B2F7D06;
	Thu, 17 Jul 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Te4Vy94d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AC2F6FB5
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764362; cv=none; b=LUQzIpH1SVUZqkQM6KqUZ+6WbsGF5B7ngjppr+FqaV0LWuPcFM8b9OxJ9Y4nBg7xB4xx54/cN6YB7AAO2onhpmZg4YW9xsyi3ecip5KXLTaBfRus40G63LMj70kyqQPSgm+JRl17jcKUWKvzgdLOINntnRg0EX9s24t+Sp/Aj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764362; c=relaxed/simple;
	bh=HRPRnUbv+IUYwRHjZngwvzXt/tke7oBTUtnsR/pSXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX93fwpGRF6GKLalu14hZW0MrVTNSDZdYpBmibiWG/pg3jr/Ci3O7C60aU6OvGmCQ6XB7EPU1cmm8oHU/AtmMNxquEuIk7yX+7wbJ3bd24qQNCNtC4OtQbsF9soy2Z/QaxMRnvrfDDCdNN0TQY6dcnMez7YrQlxJqcAzyrx2wJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Te4Vy94d; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56HExBb9004311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752764353; bh=Odp2UM/cnTsVKC+HqpsKgzP8a5piubJUqGcExF2j5/8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Te4Vy94d6EBL+Qh5NmAN47V8ycTKuiJeRPmPK/oGJWfTd1C24ACveDvpcP8/9MwJY
	 H2ht7sEA2uyFG19KKk6S7ohiWKTQE2FVKgXABsf3f5G4DY2I1U8LngWzBX8MLtDs0S
	 4XnJu7gQ7X1vr6t0+/Tb4D/WOt9sOLLcN/vv+ORScab7XFF7d4yWg/eOLz+qIrnaEo
	 oLzxFjnzfCY8NpDxrtuivSSrNs3t6VX1T7bnSoZdzC4p1kLDQxWGK/e91jW6R4Ac76
	 QHBu+pKtwvJKEapcI4QMlVeOMpjhgP30lluhbf5sjHGCFOgSlrYGys1ytfYm/T29Cv
	 2zhJLSMNuil3g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7CAD62E00D5; Thu, 17 Jul 2025 10:59:11 -0400 (EDT)
Date: Thu, 17 Jul 2025 10:59:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
Message-ID: <20250717145911.GB112967@mit.edu>
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>

On Thu, Jul 10, 2025 at 01:01:04AM -0700, Moon Hee Lee wrote:
> From 4c910ac989e7a6d97565a67677a1ee88e2d1a9ad Mon Sep 17 00:00:00 2001
> From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> Date: Thu, 10 Jul 2025 00:36:59 -0700
> Subject: [PATCH] ext4: bail out when INLINE_DATA_FL lacks system.data xattr
> 
> A syzbot fuzzed image triggered a BUG_ON in ext4_update_inline_data()
> when an inode had the INLINE_DATA_FL flag set but was missing the
> system.data extended attribute.
> 
> ext4_prepare_inline_data() now checks for the presence of that xattr
> and returns -EFSCORRUPTED if it is missing, preventing corrupted inodes
> from reaching the update path and triggering a crash.

Thanks ofor the patch!  However, instead of doing an xattr lookup in
ext4_prepare_inline_data(), we can more simply and more efficiently
just not BUG in ext4_update_inline_data, like this:


From eedfada9eb51541fe72f19350503890da522212d Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 17 Jul 2025 10:54:34 -0400
Subject: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr

A syzbot fuzzed image triggered a BUG_ON in ext4_update_inline_data()
when an inode had the INLINE_DATA_FL flag set but was missing the
system.data extended attribute.

Since this can happen due to a maiciouly fuzzed file system, we
shouldn't BUG, but rather, report it as a corrupted file system.

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5b32d242495..424c40c768de 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -354,6 +354,12 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
+
 	BUG_ON(is.s.not_found);
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
-- 
2.47.2



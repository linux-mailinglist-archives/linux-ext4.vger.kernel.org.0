Return-Path: <linux-ext4+bounces-9845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305CB48E65
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B1B1767BA
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43630596F;
	Mon,  8 Sep 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBxRI5dG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74E306D53
	for <linux-ext4@vger.kernel.org>; Mon,  8 Sep 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336235; cv=none; b=u5Pw4xtBh+892ZZAgLLoRm3BE2bYG2icVKNejWRw4//FZq4jYMSpg0RcyfklZ5moXeDPExylJW+NQ2DnnJMImbysgRw1QGEJ7oYrXvwuvldmr0Xq2mQXcu1ZdgmrGQony9o+ooiaeEQ+OOYDPUIu53r++CmoDRi2m8u5yycgz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336235; c=relaxed/simple;
	bh=MhbcOwX2MxS51mmnD4KeIrKi3jxNGwv7djuoxh2v8yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruF8lyl6kpEKiWWY7EGYEWKpe4Yf4z6UitSRmG41KpMfP+0Exh6/VZ7c7RcaG2+mUV6/IHf73svmTHYF5C1WK2HEzmrvt6AM7U7gVOzkZgXBM90Hcjl2HgHrYJAFVuXffRB1UYkAfMt2K/uIQMCESbY1B1nYgSKc6EhWIk7ZlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBxRI5dG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roK87h7SJk0xMszRssGEGW3y5zhgvRYMHOpqvKw92wA=;
	b=hBxRI5dGj9/tJIHsC4hjHhRrpE3WjiJN6fAbnAzpj6myKJ/9lse75QnFCyE1IWmHCMBLYi
	xMpgt8koyVW+Ih5ExP1MaQ7NcJynVAsOb8+NOvZ6+rakFsCCtXFZxuZ09xgoWynmAEE5Po
	2yR79njNEwcu11Zvi7anMXbZI9ZlNow=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-sNvhf916PIKMwNAjemZsig-1; Mon,
 08 Sep 2025 08:57:05 -0400
X-MC-Unique: sNvhf916PIKMwNAjemZsig-1
X-Mimecast-MFC-AGG-ID: sNvhf916PIKMwNAjemZsig_1757336223
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7685119560AF;
	Mon,  8 Sep 2025 12:57:03 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65D9319540EB;
	Mon,  8 Sep 2025 12:57:00 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/2] iomap: prioritize iter.status error over ->iomap_end()
Date: Mon,  8 Sep 2025 09:01:01 -0400
Message-ID: <20250908130102.101790-2-bfoster@redhat.com>
In-Reply-To: <20250908130102.101790-1-bfoster@redhat.com>
References: <20250908130102.101790-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jan Kara reports that commit bc264fea0f6f subtly changed error
handling behavior in iomap_iter() in the case where both iter.status
and ->iomap_end() return error codes. Previously, iter.status had
priority and would return to the caller regardless of the
->iomap_end() result. After the change, an ->iomap_end() error
returns immediately.

This had the unexpected side effect of enabling a DIO fallback to
buffered write on ext4 because ->iomap_end() could return -ENOTBLK
and overload an -EINVAL error from the core iomap direct I/O code.

This has been fixed independently in ext4, but nonetheless the
change in iomap was unintentional. Since other filesystems may use
this in similar ways, restore long standing behavior and always
return the value of iter.status if it happens to contain an error
code.

Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
Diagnosed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index cef77ca0c20b..7cc4599b9c9b 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -80,7 +80,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 				iomap_length_trim(iter, iter->iter_start_pos,
 						  olen),
 				advanced, iter->flags, &iter->iomap);
-		if (ret < 0 && !advanced)
+		if (ret < 0 && !advanced && !iter->status)
 			return ret;
 	}
 
-- 
2.51.0



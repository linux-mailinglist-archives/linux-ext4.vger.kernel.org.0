Return-Path: <linux-ext4+bounces-9789-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5DB40875
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA21560F85
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8080A31DDB8;
	Tue,  2 Sep 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0ddIvLl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517531B126
	for <linux-ext4@vger.kernel.org>; Tue,  2 Sep 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825446; cv=none; b=nHiMhFvRFkTbR1EcKRxrn0VgZXscKzyL2iLq+FHdwPBTizWHQADjA57rPsQ3e+HzvAUXBh1Z0Uo3Et9LSyjfg/Ovw88kOzp3e4U4WlOMzqv6kVyPwOCpuNaA3/JJXUsTl5ukwWS3fz2elLzd4BfUYYUv4S6OAJqkoMQexJdvsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825446; c=relaxed/simple;
	bh=o5p4D7iznk9qsrXsVnL7b5qBJ/DveyfWVcgqkpxQlT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM0z6vCKcPUpFq368W+RU9TN9EYsveBXX2trUck6HqNHVRM2EWVtxKERE387VucKojP0XdPlx5bxz96b0a/S/Vga5iONbiJbgm01fWp4k0L/NlQfhOC5w/aOiE0zFgAL4mceTBUzQrEWSrXcosgX6CSSJcdQnIj3bF6QieMArWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0ddIvLl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756825443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vACa1TsQUFc/du4UTAppL9owMQoQL+CDFDwa9C6qm8=;
	b=f0ddIvLlCZEClMgkJef9WOw46MKhNqslJzH36K+GGZlhsKQ/7RgCIobe6EL5rNbiNJrnuS
	VUFQCyWubcDrFi9g858USmXI+C3XnM/Hcv7AjTG/0QIPMXBdGEiFE7CSm0cUrkHxiWIQYL
	qVUcEBfWXl7+Sgu7idv8WkxhjfU4eGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-vC0bRm2TMYOCq45lP9cUtg-1; Tue,
 02 Sep 2025 11:03:55 -0400
X-MC-Unique: vC0bRm2TMYOCq45lP9cUtg-1
X-Mimecast-MFC-AGG-ID: vC0bRm2TMYOCq45lP9cUtg_1756825434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80C0518002C8;
	Tue,  2 Sep 2025 15:03:54 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51CD3180044F;
	Tue,  2 Sep 2025 15:03:53 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: jack@suse.cz,
	djwong@kernel.org
Subject: [PATCH RFC 1/2] iomap: prioritize iter.status error over ->iomap_end()
Date: Tue,  2 Sep 2025 11:07:54 -0400
Message-ID: <20250902150755.289469-2-bfoster@redhat.com>
In-Reply-To: <20250902150755.289469-1-bfoster@redhat.com>
References: <20250902150755.289469-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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



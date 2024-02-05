Return-Path: <linux-ext4+bounces-1115-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BAD84A7A3
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DBF28CC80
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE012AAE7;
	Mon,  5 Feb 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uob/dDzx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455A12A14A
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163568; cv=none; b=U/+cr3kd6xGs0WvH5KeidpwSnnati2PJ/nMvFQVMZxuiZmmY4w58nmPTe/5c61kX/2172Wm/tCaFYjYQhqf+XmaBXV5sWGshROJ+ynX6p4HPGRzH2B9txWye6RaTxoKU8mSmdBhT9yh3iLzID84XesE4jElTp81/ZoKUd8sApEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163568; c=relaxed/simple;
	bh=sT0YhdGMz+E9RZmaN5yZSWMd1g+aYCrhSj7fqmLAo7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iojZrQAi08dpdEkl+Iau1yW5TSwjo7Pp1GOhe//l2BFPdMLj4NrYQE7XXZ7sEfaHQqvLOzp1n8JybIeAmeqFpTPZyBwIIY3AeoxQBUY4wUfm8IjYYFOHqYppIfq2Y+KnG2Xj76VtCVyQSzrfhzi+EpE2P7xtYOjR0a9qSFOWvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uob/dDzx; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxk7XRZEL0snESkDWwhfb1zBoSWiW2T8Lz3o6KIMn8M=;
	b=uob/dDzxQcIREDsMEM9g/iWBuz0YPHzPTzop+cY2f31oBhFBJpCrXqtQ7KCYfdmuorHek/
	3BdFAyeJ8xmW3cVWSpJ8jwVBKqrGw114zEAqI1kXcx6EbAAY7oyS1MVSqTQRGZeWGiMh3T
	67MIwynAHlE/7CcJzvVvZxLHj5EuROc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/6] fs: super_block->s_uuid_len
Date: Mon,  5 Feb 2024 15:05:12 -0500
Message-ID: <20240205200529.546646-2-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some weird old filesytems have UUID-like things that we wish to expose
as UUIDs, but are smaller; add a length field so that the new
FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/super.c         | 1 +
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index d35e85295489..ed688d2a58a7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -375,6 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
+	s->s_uuid_len = sizeof(s->s_uuid);
 
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..ff41ea6c3a9c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1257,6 +1257,7 @@ struct super_block {
 
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
+	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
 
 	unsigned int		s_max_links;
 
-- 
2.43.0



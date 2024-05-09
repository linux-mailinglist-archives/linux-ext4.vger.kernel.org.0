Return-Path: <linux-ext4+bounces-2425-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AE8C11D1
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E04E1F24BAC
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6915ECC1;
	Thu,  9 May 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tKoN2z+0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161A131750
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267804; cv=none; b=jCftDY943xyfNj/aDbWTvdQA8zIYSftLm2rmIHw1xiUmgn7xG2SIIWZHlK7savVHAge3PlRd7Z/+iSEUJHmif/7YlK6QWtgZXy5xqQj49y8gPLF3Jwhm7q7iNCGQ8ga3HdXAeMrcyLwPMG7aX2A5PWsJibDG2ejf5UQdKLOCBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267804; c=relaxed/simple;
	bh=rENpYzuzYep+kKpc+ClGh2Jqy7GxYlD0JOeoKeVYATU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIOfhgSEPIjsQiivtkWJ9Xu31FGH8x8/4R0KJDQctdsnJ7EpmGtXIBqCaZBg6YO16wkB7L1PY5jnjx/5nvfzg47Z0Omvxc8uvUBN5YiV5rKTTRGt1EoEC+hqwI+XJED9JBwaxhYgVR89qJrvXfLVj1LZryb6RzxqOM9vzkTaZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKoN2z+0; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715267799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WuV7M9mHf7zLGoXyvtH3Is1VnuTrzUZ1N2ISvLJru+k=;
	b=tKoN2z+02HEGPxaMBMX19ZneYgaEWjlQx1yjDRa+5EtNM+Tk4h+QyONWXsiZlzBqwIkM0v
	y02jbP0F9WK/J4dQxTDaCsJa9HxkYxUlN07D+ppV/DoxZeEABmqSngg/D+YBoNgF7iuP38
	uWCX/WykcZyS911GVQsXeGumCrHpsR8=
From: Luis Henriques <luis.henriques@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  jack@suse.cz,  ritesh.list@gmail.com,
  hch@infradead.org,  djwong@kernel.org,  willy@infradead.org,
  zokeefe@google.com,  yi.zhang@huawei.com,  chengzhihao1@huawei.com,
  yukuai3@huawei.com,  wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
In-Reply-To: <20240127015825.1608160-4-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Sat, 27 Jan 2024 09:58:02 +0800")
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
	<20240127015825.1608160-4-yi.zhang@huaweicloud.com>
Date: Thu, 09 May 2024 16:16:34 +0100
Message-ID: <87zfszuib1.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Sat 27 Jan 2024 09:58:02 AM +08, Zhang Yi wrote;
<...>
> +static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
> +						  struct ext4_ext_path *path,
> +						  ext4_lblk_t lblk)
> +{
> +	ext4_lblk_t hole_start, len;
> +	struct extent_status es;
> +
> +	hole_start = lblk;
> +	len = ext4_ext_find_hole(inode, path, &hole_start);
> +again:
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> +				  hole_start + len - 1, &es);
> +	if (!es.es_len)
> +		goto insert_hole;
> +
> +	/*
> +	 * There's a delalloc extent in the hole, handle it if the delalloc
> +	 * extent is in front of, behind and straddle the queried range.
> +	 */
> +	if (lblk >= es.es_lblk + es.es_len) {
> +		/*
> +		 * The delalloc extent is in front of the queried range,
> +		 * find again from the queried start block.
> +		 */
> +		len -= lblk - hole_start;
> +		hole_start = lblk;
> +		goto again;

It's looks like it's easy to trigger an infinite loop here using fstest
generic/039.  If I understand it correctly (which doesn't happen as often
as I'd like), this is due to an integer overflow in the 'if' condition,
and should be fixed with the patch below.

From 3117af2f8dacad37a2722850421f31075ae9e88d Mon Sep 17 00:00:00 2001
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Date: Thu, 9 May 2024 15:53:01 +0100
Subject: [PATCH] ext4: fix infinite loop caused by integer overflow

An integer overflow will happen if the extent_status len is set to
EXT_MAX_BLOCKS (0xffffffff).  This may cause an infinite loop in function
ext4_ext_determine_insert_hole(), easily reproducible using fstest
generic/039.

Fixes: 6430dea07e85 ("ext4: correct the hole length returned by ext4_map_blocks()")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..193121b394f9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4064,7 +4064,7 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 	 * There's a delalloc extent in the hole, handle it if the delalloc
 	 * extent is in front of, behind and straddle the queried range.
 	 */
-	if (lblk >= es.es_lblk + es.es_len) {
+	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
 		/*
 		 * The delalloc extent is in front of the queried range,
 		 * find again from the queried start block.


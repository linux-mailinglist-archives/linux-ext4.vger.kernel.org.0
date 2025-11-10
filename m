Return-Path: <linux-ext4+bounces-11724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D7C46B38
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576C23BD790
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE430F93B;
	Mon, 10 Nov 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZMFkeVps"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833A309F01;
	Mon, 10 Nov 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779108; cv=none; b=Kb/nevWbduhoRuVldY7WyxWEnXJg+mLq4h93zJJVvFi1eLAG9F6nzNglIDmhFq045mjwGn/m2OvEbzfimGrvAbYIWGY5QEQJg0ceCeKDu6qVoJwFNExtk8DPFA+48C4vrySQkxgGQKncFSB8vYqrD3mb0xCgwgMeFsP2aAhzteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779108; c=relaxed/simple;
	bh=jYiH844hnP+2YzhVntgwEfXL9Yyc8ZTNP2YAHnykuxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+JDOXq+5hixeU4LwrMi6y34WGSnvI7SDWB+8ih2HOTDa6X09gWcrn/4+91UmTzXPhwxCkR4KnF4C+Vvo4kiIxdA/nGD76sqJHkIUQqLLegakW7N8XRlWfhz8l/BHa7FSOOwPBbiRDeG1IRiyPpmO+v3iQDgEjF8eEvjJG4X4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZMFkeVps; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d4qL14cvmz9v7K;
	Mon, 10 Nov 2025 13:51:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1762779097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqD4KmFi2qhbmaAeR2Tnjr263gH6+lT2p5UnUHEXznY=;
	b=ZMFkeVpsBCrS1P1u97z9PMaKpGxo//8zBBOypcvo09mGeLFndBlcocdwlJFgQ/GG0es6A6
	1GlGD2FYr8jjOSOakyGO64tR+X2H9cJ73Ogkh1F6+kHJWx0rv+ZQItEpjyCJMBNfBng6cl
	hofwL5c6d8yE6XGNcSmEm9pA1pHJg8LMOtCglSudzJ1jzQGjF8cK/EBJEL+pqgJq9FXVIf
	frQRA3ouslxgJsJszapAlI9Ky3MnF1pEcgircD5Gos8vt9x+cvWBlzbANH6Mwnvt9e5eR2
	ZmNU+iRDSk/pKjGoSUTklG/2lQeqpYRg1GEqrg898dJIlKVNtIjb0XoQCLJMHw==
Message-ID: <52401c3a-26aa-473f-b7e2-1c658550dd37@pankajraghav.com>
Date: Mon, 10 Nov 2025 13:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, ebiggers@kernel.org,
 willy@infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251107144249.435029-25-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 15:42, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since block device (See commit 3c20917120ce ("block/bdev: enable large
> folio support for large logical block sizes")) and page cache (See commit
> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
> cache")) has the ability to have a minimum order when allocating folio,
> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
> large folio for regular file"), now add support for block_size > PAGE_SIZE
> in ext4.
> 
> set_blocksize() -> bdev_validate_blocksize() already validates the block
> size, so ext4_load_super() does not need to perform additional checks.
> 
> Here we only need to add the FS_LBS bit to fs_flags.
> 
> In addition, allocation failures for large folios may trigger warn_alloc()
> warnings. Therefore, as with XFS, mark this feature as experimental.
> 

Are you adding the experimental flag because allocation failures can occur with
LBS configuration or because it is a new feature (or both)?

In XFS we added this flag because this was a new feature and not because of the
allocation failure that might happen.

Is it even possible to get rid of these allocation failures in systems were the
memory is limited as the page cache works in > PAGE_SIZE allocations?

--
Pankaj


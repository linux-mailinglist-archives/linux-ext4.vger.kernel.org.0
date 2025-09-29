Return-Path: <linux-ext4+bounces-10485-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44015BA925B
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B2B17E5A6
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316B305051;
	Mon, 29 Sep 2025 12:07:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47877305045;
	Mon, 29 Sep 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147654; cv=none; b=CbB2z/5TJmgTUyZZrGs9zQ7XgZTQMzaynNCAf5kRCYxAsk8huneR2ZbF8zlSL8yxV1GCAVq/gKZShuQdS2IzPS/hIqJ7WJVWLJE+J5hhkOoDTh2kG+xwPMI2mNKqZqAZFHasEVOZ/AMGy0fyIVm88ci4P/Vb9ErlK3hTjvvGimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147654; c=relaxed/simple;
	bh=6xXpK4jRrtsiepa1z7gZsQBCzfMazbL2vEZotmsifcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0q/0pKX0Ry2gH4RouhtGv0FLCkvRrL0e0BHmfcXezeernHWje2JMA2pQE1UTO6L+riK1nz8+k+UNUgzsWKMRTxP1qniGCKY5RNSmQxfjqQzQyw5MUChGGyeySqfDGaYAljmsRPltHnGd1xmOYSjPQ9xNm+PnAdcgryvbpQkHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cb0L440v6zKHMx4;
	Mon, 29 Sep 2025 20:07:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AE131A0D78;
	Mon, 29 Sep 2025 20:07:22 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGF4dtpomU3dBA--.2477S3;
	Mon, 29 Sep 2025 20:07:22 +0800 (CST)
Message-ID: <5e9c229f-cbd9-4fcb-a349-4605e52f13a1@huaweicloud.com>
Date: Mon, 29 Sep 2025 20:07:20 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: validate extent entries before caching in
 ext4_find_extent()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250929052718.334986-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250929052718.334986-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3CGF4dtpomU3dBA--.2477S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxJw4rGw1fGFyUJryrJFb_yoW8Ww1UpF
	W3GF1DKrn5GFW7WF92ya1jqF9Y9wn7Zw45Jrs8GF9rJFyYgF1xta43trWYvF47G3W5Aayj
	vF40vry7Xas0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/29/2025 1:27 PM, Deepanshu Kartikey wrote:
> Zhang Yi,
> 
> You're correct that ext4_ext_check_inode() should catch this. I investigated and found why it doesn't:
> [   18.824142] DEBUG: Validating inode 2 (no inline data)
> [   18.835777] DEBUG: verity inode 15, inline=0, extents=1
> [   18.836793] DEBUG: Skipping validation for inode 15 (has inline data)
> 
> The verity inode reports inline=0 when checking the flag directly, but ext4_has_inline_data() returns true at the validation check, causing validation to be skipped.

This makes me confused, how can this inode report inline=0 when checking
the flag directly, but ext4_has_inline_data() returns true?

Does this mean that this inode has both the EXT4_INODE_EXTENTS and
EXT4_INODE_INLINE_DATA flags set? If so, we should detect this in
ext4_iget() and call ext4_error_inode().

> 
> This corrupted filesystem has a verity file that somehow triggers the inline data check to return true, even though verity files should never have inline data. This allows the corrupted out-of-order extents to bypass validation.
> 
> My patch adds validation before caching extents, which catches such corruption regardless of why the inline data check fails. This provides necessary defense against corrupted filesystems at the point where extents are actually used.

Generally speaking, we should avoid redundant checks. It is sufficient to
verify the metadata after reading it from the disk, without considering
scenarios which intentionally corrupted the metadata by directly writing
to the bdev. Adding checks in ext4_find_extent() would introduce
unnecessary overhead.

Thanks,
Yi.



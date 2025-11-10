Return-Path: <linux-ext4+bounces-11727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB03C47935
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900DC421EA0
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BE246BC5;
	Mon, 10 Nov 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="A7fpUFke"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520C18A956
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787960; cv=none; b=lZoOednNKK7RKK4uM7bxB+6qQR5Vq5cRf4iVXn+O91N/KLfBlKO+lRbgLaS4AnP2lWL5T51+uTfJUbAkr2nqvfyyhIG18okb5GHRF4rSeTnkvg9BmWClFyspgatM1HtL4N98pbxNMl99RVZGifg0yPNrE3k8GxgeHJ1kZhY0cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787960; c=relaxed/simple;
	bh=tBjErGJOew5E8ixULQkZ1ls7tJAQVQbm2rWMhGX+lVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6FSV9kXU8QYX/no0/axaxbTxltuXU1ePOPievXq7UBcMqtpWzatOV7y/6XLdaaBvCSMvpzlxAF1TJq0pZR7ms7LVXaOcALR0kkR66PVIp+9LVWWUeq+giCYl29D2SmfoG3tjQZhzzQJ/yejIEednGTyCr+viO9gsin1scN4llo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=A7fpUFke; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AAFG42n019301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762787768; bh=RlW8c8KpIHzWD8RCcxAE4qUXBV9gYXqMcVmmRGjMj34=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=A7fpUFkeHD68md1CIsDiXiO/u74DhBCLSzhRoUfZkC3hnpz8abCUKAFfz+J4Dr1H0
	 /+HKOtYeHpzHiHLsFxDzDQHLUw6ehhaqci5yjPje9jnW9ZxD/PJ5yxdt1PcBfJlXxd
	 fbbBv3a7WsWCCbR/DspU4NSMNkFIPTOOtxTnAo+0pA4Yxr4m+D5ncd9db1S9v5F/yS
	 QVmNuKz7gV+rYOC433SJ3ncUs3dV21pg/UxdfgngmIWe4gIHRUAH8TyJs39+O6w9iJ
	 sRXSIgjn9DthSBAcNH2d2xLiCJurCqTNUaC+lcjJqMI+4VYXPGC1W07YLCWgoThoX1
	 4wTU6AjdZ6dgg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3E61A2E00D9; Mon, 10 Nov 2025 10:16:04 -0500 (EST)
Date: Mon, 10 Nov 2025 10:16:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
Message-ID: <20251110151604.GE2988753@mit.edu>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-25-libaokun@huaweicloud.com>

On Fri, Nov 07, 2025 at 10:42:49PM +0800, libaokun@huaweicloud.com wrote:
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
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Could you add:

#ifdef CONFIG_TRANSPARENT_HUGEPAGES
EXT4_ATTR_FEATURE(blocksize_gt_pagesize);
#endif

in fs/sys/sysfs.c, so that userspace programs (like those in e2fsprogs
and xfstests) can test /sys/fs/ext4/features/... to determine whether
or not blocksize > pagesize is supported?  That way we can more easily
determine whether to test the 64k blocksize configurations in
xfstests, and so we can supress the mke2fs warnings:

mke2fs: 65536-byte blocks too big for system (max 4096)
Proceed anyway? (y,N) y
Warning: 65536-byte blocks too big for system (max 4096), forced to continue

... if the feature flag file is present.

Thanks!!

	 	    	       	       - Ted


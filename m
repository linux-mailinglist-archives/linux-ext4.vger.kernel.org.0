Return-Path: <linux-ext4+bounces-9159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A214B0EA28
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 07:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB25E1AA335D
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3692472AB;
	Wed, 23 Jul 2025 05:48:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD398182D3;
	Wed, 23 Jul 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753249691; cv=none; b=XTTszHw/7ym7187SduWcQGssmOWmUKuJic5BoS6F1JZx0U8Qs2iSSFSI1rpj/wlYv8SnwwxAa5b1E53bRf+Sn2/MHnh7E4361lWgU5NtjDodxNaQ9DAYpz7XPg33od8Ir7TJMK08k9pMqm9OPGB0oKZNlvhRwrGvDrSdrDYj67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753249691; c=relaxed/simple;
	bh=gkIUfd/D/ipbRme1xVbi3313xf1eZlBNCbFdGG+F/XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuvzUOeMy6hAN2iWQ/j/vZ12RUhX9C4aRjMA3rs1bnYRLEglSJb6mAtP2w94zl1XSO46GtJNDV9JdDWHeJwstpLd1NHrIDRLnzaJyeXPMY6l9+4jeAkVfmwa5TzdwNhBXKolDoFZwHswsdYq4ASM/RjXvYRfrNALl9tT61c2IwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.2069462472
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 1ACC940008A;
	Wed, 23 Jul 2025 13:44:20 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-67b7b5d8b-hc52f with ESMTP id d5fbf68be4ee4d06b323a9dc52f42bb8 for tytso@mit.edu;
	Wed, 23 Jul 2025 13:44:21 CST
X-Transaction-ID: d5fbf68be4ee4d06b323a9dc52f42bb8
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <2d9fc63c-091d-4224-b5dd-968bceed72ee@189.cn>
Date: Wed, 23 Jul 2025 13:44:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ext4: fallback unaligned part of dio to buffered IO
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710085910.123168-1-chensong_2000@189.cn>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20250710085910.123168-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear maintainers,

This is kindly ping, i would appreciate it if you could have a look and 
give me your feedback.

many thanks.

BR

Song

在 2025/7/10 16:59, chensong_2000@189.cn 写道:
> From: Song Chen <chensong_2000@189.cn>
> 
> When I was trying to read a big file in direct IO mode, if the
> file was not page aligned, ext4 rejected the request in
> iomap_dio_bio_iter which checks alignments of pos, addr and length
> before submitting bio.
> 
> As my understanding, pos and addr must be block size aligned, but length
> doesn't have to be. Instead of rejecting entire request which is so
> frastrating to upper layer, this patch splits length into aligned part
> and unaligned part. For the aligned part, still uses direct IO with
> no problem, for the rest unaligned part, falls back to buffered IO.
> This way looks more friendly to apps.
> 
> Please have a look at the patch in [1], it has to reopen the file
> to read the unaligned part in upper layer, which doen't look
> gracefully.
> 
> I guess I'm not the first one who brings it up, there must be a reason
> to stop this porblem being addressed. unaligned write seems to be
> addressed in [2] and [3]. Side effects or complexity, I would like to know.
> 
> This is just a draft of RFC, I haven't taken care of ubuf properly yet,
> please let me know if you like this idea or not, then I can drop it or
> go further, like introduce helpers to split iov_iter in lib/iov_iters.c
> 
> [1]:https://lore.kernel.org/all/20240730075755.10941-4-link@vivo.com/
> [2]:https://lore.kernel.org/linux-ext4/20230314130759.642710-1-bfoster
> @redhat.com/
> [3]:https://lore.kernel.org/linux-ext4/20230810165559.946222-1-bfoster
> @redhat.com/
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>   fs/ext4/file.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 21df81347147..a059985d0b16 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -36,6 +36,12 @@
>   #include "acl.h"
>   #include "truncate.h"
>   
> +enum {
> +	SHOULD_NOT_DIO,
> +	SHOULD_DIO,
> +	SHOULD_PARTIAL_DIO,
> +};
> +
>   /*
>    * Returns %true if the given DIO request should be attempted with DIO, or
>    * %false if it should fall back to buffered I/O.
> @@ -52,23 +58,89 @@
>    *
>    * This function implements the traditional ext4 behavior in all these cases.
>    */
> -static bool ext4_should_use_dio(struct kiocb *iocb, struct iov_iter *iter)
> +static int ext4_should_use_dio(struct kiocb *iocb, struct iov_iter *iter)
>   {
>   	struct inode *inode = file_inode(iocb->ki_filp);
> +	unsigned int len_mask = i_blocksize(inode) - 1;
> +	unsigned int addr_mask = bdev_dma_alignment(inode->i_sb->s_bdev);
>   	u32 dio_align = ext4_dio_alignment(inode);
>   
> +	/* inode doesn't support dio, fall back to buffered IO*/
>   	if (dio_align == 0)
> -		return false;
> +		return SHOULD_NOT_DIO;
> +
> +	/* addr is misaligned, fall back to buffered IO*/
> +	if (!iov_iter_is_aligned(iter, addr_mask, 0))
> +		return SHOULD_NOT_DIO;
> +
> +	/* pos is misaligned, fall back to buffered IO*/
> +	if (!IS_ALIGNED(iocb->ki_pos, len_mask))
> +		return SHOULD_NOT_DIO;
> +
> +	/* length is misaligned*/
> +	if (!iov_iter_is_aligned(iter, 0, len_mask)) {
> +		/* if length is less than a block, fall back to buffered IO*/
> +		if (iov_iter_count(iter) < i_blocksize(inode))
> +			return SHOULD_NOT_DIO;
> +		/*direct IO for aligned part, buffered IO for misaligned part*/
> +		return SHOULD_PARTIAL_DIO;
> +	}
>   
> -	if (dio_align == 1)
> -		return true;
> +	return SHOULD_DIO;
> +}
>   
> -	return IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), dio_align);
> +/*
> + * First of all, truncate the length to block size aligned and start
> + * a direct IO. If it goes well in iomap_dio_rw, fall back the rest
> + * unaligned part to buffered IO.
> + *
> + * At the end, return the sum bytes of direct IO and buffered IO.
> + */
> +static ssize_t ext4_mixed_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct iov_iter to_misaligned = *to;
> +	struct iovec iov;
> +	ssize_t ret, ret_dio, ret_generic;
> +
> +	/* truncate iter->count to blocksize aligned and start direct IO */
> +	iov_iter_truncate(to, ALIGN_DOWN(to->count, i_blocksize(inode)));
> +	ret_dio = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
> +
> +	if (ret_dio <= 0) {
> +		ret = ret_dio;
> +		goto out;
> +	}
> +
> +	/* set up iter to misaligned part and start buffered IO*/
> +	iov.iov_base = to->__iov->iov_base +  ret_dio;
> +	iov.iov_len	 = to->__iov->iov_len -  ret_dio;
> +
> +	to_misaligned.__iov = &iov;
> +	iov_iter_truncate(&to_misaligned, iov.iov_len);
> +
> +	iocb->ki_flags &= ~IOCB_DIRECT;
> +	ret_generic = generic_file_read_iter(iocb, &to_misaligned);
> +
> +	if (ret_generic <= 0) {
> +		ret  = ret_generic;
> +		goto out;
> +	}
> +
> +	ret = ret_dio + ret_generic;
> +
> +out:
> +	iocb->ki_flags |= IOCB_DIRECT;
> +	inode_unlock_shared(inode);
> +	file_accessed(iocb->ki_filp);
> +
> +	return ret;
>   }
>   
>   static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
>   	ssize_t ret;
> +	int dio_supported;
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   
>   	if (iocb->ki_flags & IOCB_NOWAIT) {
> @@ -78,7 +150,8 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		inode_lock_shared(inode);
>   	}
>   
> -	if (!ext4_should_use_dio(iocb, to)) {
> +	dio_supported = ext4_should_use_dio(iocb, to);
> +	if (dio_supported == SHOULD_NOT_DIO) {
>   		inode_unlock_shared(inode);
>   		/*
>   		 * Fallback to buffered I/O if the operation being performed on
> @@ -91,6 +164,9 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		return generic_file_read_iter(iocb, to);
>   	}
>   
> +	if (dio_supported == SHOULD_PARTIAL_DIO)
> +		return ext4_mixed_read_iter(iocb, to);
> +
>   	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
>   	inode_unlock_shared(inode);
>   
> @@ -537,7 +613,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	}
>   
>   	/* Fallback to buffered I/O if the inode does not support direct I/O. */
> -	if (!ext4_should_use_dio(iocb, from)) {
> +	if (ext4_should_use_dio(iocb, from) != SHOULD_DIO) {
>   		if (ilock_shared)
>   			inode_unlock_shared(inode);
>   		else


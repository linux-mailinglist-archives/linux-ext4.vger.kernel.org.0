Return-Path: <linux-ext4+bounces-3510-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60E940364
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 03:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F27C28303F
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE08BE8;
	Tue, 30 Jul 2024 01:21:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00921442C;
	Tue, 30 Jul 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302474; cv=none; b=itQT8vUiDRIKvN/O0wkAq7+Pdx6i/ZMTZyB3q4yoEtAwl4TIIXIo5g5W/qdeWm3sHt5pl4n+dr1q3illjSZSc3Euq1a1KQrLZsMQNa0aTZHl5pSNCTEJejIUMbXPXzkgOnNcjJ+pB2nuk7ULdhkgjijVzdPjlU+VNOoybVYbB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302474; c=relaxed/simple;
	bh=hcPJG6k+j9ygJ3clDIY1cNkDZMFquFiCRVTu5NdrBb8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fk3mHmaEzHjsLq4Hqj8X8dfPk7cM0vC+MADISMYwy+zpHWCkgetYfhOy7BZJanRkc2yPMZ6nDykvxQYjFAakjIkst39kzams3C03/eBAiGFFMVBnk+jrZm5lEHZ4ZIzI/GHb+7FNMn3xcYYA8vLPifemrv2vezSqJ+SFER4+VLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WXy9066fTz1L9BW;
	Tue, 30 Jul 2024 09:20:52 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id 52D801800A2;
	Tue, 30 Jul 2024 09:21:02 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemd200022.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jul 2024 09:21:01 +0800
Subject: Re: [PATCH] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <kees@kernel.org>, <gustavoars@kernel.org>
References: <20240729110454.346918-3-thorsten.blum@toblux.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <66A83FFC.7020802@huawei.com>
Date: Tue, 30 Jul 2024 09:21:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240729110454.346918-3-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200022.china.huawei.com (7.221.188.232)



On 2024/7/29 19:04, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> Remove the now obsolete comment on the count field.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   fs/ext4/xattr.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index bd97c4aa8177..e14fb19dc912 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
>   };
>   
>   struct ext4_xattr_inode_array {
> -	unsigned int count;		/* # of used items in the array */
> -	struct inode *inodes[];
> +	unsigned int count;
As the comment says, 'count' is the number of items in the array that 
have been used,
not the total number of items in the array. So I think this check was 
added incorrectly.
> +	struct inode *inodes[] __counted_by(count);
>   };
>   
>   extern const struct xattr_handler ext4_xattr_user_handler;



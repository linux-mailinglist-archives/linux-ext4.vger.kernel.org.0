Return-Path: <linux-ext4+bounces-4009-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CB969621
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C9B20DD5
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E11D54ED;
	Tue,  3 Sep 2024 07:52:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E11865F0
	for <linux-ext4@vger.kernel.org>; Tue,  3 Sep 2024 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349927; cv=none; b=Pnzu9bVCXduLj2cou7/2lILUl0m+Ujowd4oJpn1x7k9G8XgYmq86OdGUzfrRvrCs1Xn1SmRIcTA78QEDx9MDW3Inl3x79G+zi3YgkfyVNJ8YLEYlt9AxZYPYhZRE2hCLqokghPcsNeNqNL+QPer9usUs4EXFiQbYNWH54jCb2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349927; c=relaxed/simple;
	bh=Y6OYy2hpcSaq9gJ/835XlUBunmn9fIXdnY7o5Ftx4Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pJDcXaZNgxgHoCZx4XKZGRv6i5mS3tCZS81h9nCkP54KCC0Iq04nvHHoDge+0i0a5nufgbNTAyS0sZb1Kdgf7LacUT/n83iNN4lXuZWaGbxsC4EdzRiEDG8MLop8ptTrysdWk+eVJwJmpaiRgInf0SQb0y8JEqBr0x/ADU5mKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wyd9p2XkLz1S9mg;
	Tue,  3 Sep 2024 15:51:42 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id D0F821A016C;
	Tue,  3 Sep 2024 15:52:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 15:52:01 +0800
Message-ID: <628a0278-6809-4d2e-94f3-14a882bfa34b@huawei.com>
Date: Tue, 3 Sep 2024 15:52:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: Remove redundant null pointer check
To: Li Zetao <lizetao1@huawei.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20240820013250.4121848-1-lizetao1@huawei.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240820013250.4121848-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100021.china.huawei.com (7.185.36.148)

Hi Zetao,

On 2024/8/20 9:32, Li Zetao wrote:
> Since the ext4_find_extent() does not return a null pointer, the check for
> the null pointer here is redundant. Drop null pointer check for clean
> code.
>
> No functional change intended.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   fs/ext4/extents.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e067f2dd0335..12f0771d57d2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -6112,7 +6112,7 @@ int ext4_ext_clear_bb(struct inode *inode)
>   			break;
>   		if (ret > 0) {
>   			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> -			if (!IS_ERR_OR_NULL(path)) {
> +			if (!IS_ERR(path)) {
>   				for (j = 0; j < path->p_depth; j++) {
>   
>   					ext4_mb_mark_bb(inode->i_sb,

Thanks for the cleanup patch.

But the change is already included in the patch:

  https://lore.kernel.org/all/20240710040654.1714672-21-libaokun@huaweicloud.com/


Thanks,
Baokun


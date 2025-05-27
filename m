Return-Path: <linux-ext4+bounces-8205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B35AC4822
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 08:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52B1178C22
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2A1E51E1;
	Tue, 27 May 2025 06:12:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79608B652;
	Tue, 27 May 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326320; cv=none; b=GhRWF3lPX+yIXOZxrKC1/ZZTV1slpOsfA1Tl0oeNWKiY7dI77joVuanyS/wHE/bbk3xDIB2DXmW9Etc/hN8KTp7Xjozbq/w96sN+o1rrs9JVtKeE96k7xfKJzQCxm0StOx+z87EiA0b7I0HMhDDGHOthCT3OpYJt5wUYjJqTDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326320; c=relaxed/simple;
	bh=gRdJv37lrMrcCZ+KWi5q9/Izfk6U28QqmceU4zJjZIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q0PlWJZF7QZbslTVBIppbS9Z8HqIiw0EH7wL/M7truRdgCQjtfxgely9qGAbI/6nUzaP89L0A+v5JnKODjPQdRdoMDp9z53HMyzC28W3XWbAidpZ8LEIRtNg5mIqYWEC/ylqJc1WMm5hzsaaE2yqQZEuXy/rUGLQTTPILqeCRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b62Kl757lz1d1KP;
	Tue, 27 May 2025 14:10:03 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 834511402E0;
	Tue, 27 May 2025 14:11:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 May
 2025 14:11:44 +0800
Message-ID: <2e0a6686-f953-4a38-87e1-612a61825103@huawei.com>
Date: Tue, 27 May 2025 14:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: remove unused EXT_STATS macro from
 ext4_extents.h
To: Baolin Liu <liubaolin12138@163.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Baolin Liu
	<liubaolin@kylinos.cn>, Yang Erkun <yangerkun@huawei.com>
References: <20250527053805.1550912-1-liubaolin12138@163.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250527053805.1550912-1-liubaolin12138@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/27 13:38, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
>
> The EXT_STATS macro in fs/ext4/ext4_extents.h has been defined
> but never used in the codebase since its introduction. This patch
> removes it.
>
> Analysis:
> 1. No references found in fs/ext4/ or other kernel code.
> 2. No impact on compilation or functionality.
> 3. Git history shows it was never utilized.
>
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
Good spotting! Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/ext4_extents.h | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
> index 26435f3a3094..c484125d963f 100644
> --- a/fs/ext4/ext4_extents.h
> +++ b/fs/ext4/ext4_extents.h
> @@ -30,13 +30,6 @@
>    */
>   #define CHECK_BINSEARCH__
>   
> -/*
> - * If EXT_STATS is defined then stats numbers are collected.
> - * These number will be displayed at umount time.
> - */
> -#define EXT_STATS_
> -
> -
>   /*
>    * ext4_inode has i_block array (60 bytes total).
>    * The first 12 bytes store ext4_extent_header;




Return-Path: <linux-ext4+bounces-2896-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CD90E216
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5BA1F23A61
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40A224D4;
	Wed, 19 Jun 2024 03:53:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFD5588B
	for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769217; cv=none; b=liSE6zkqXSSJPA2HGsWnszaKiChfqxEbr/WYbSSJLr8JS22f2NiIDrDzUSHya8tdk/1j/2s/ftnfjUHMxmIDBhpT3fe5s+7W/h4D6J5yIZHwkihtiH8iTzHr+yIbri9c2z1/hz8VGYO1Od5wTAxUZJ899XL/HdHhKgsYivhYLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769217; c=relaxed/simple;
	bh=FQejKGLKPbE+lWMoxK0BfgN2R15W0qVH0q6HMQaPK1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=OJ1BIQXq3kCjvkkl6HxhFY8NHjYmvP18/3g2qYkJczqrPCc5K/UTIpiM9I/fK05lGLtYodwOB/lsbabbc6Cmv/aHmf61wBmhq+b5pO5IrjPkJb503SSf09a/7a0iGqszcOIOydVCnQTHXFcz1OBFH0q/aRB2XgwFrmOXqMMB+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W3qP84vxtzwTQc;
	Wed, 19 Jun 2024 11:49:16 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8AB140257;
	Wed, 19 Jun 2024 11:53:31 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 11:53:30 +0800
Message-ID: <ee3df746-901c-40bd-95b5-2a2b7340395f@huawei.com>
Date: Wed, 19 Jun 2024 11:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel bug at fs/ext4/resize.c:324! (6.8.12-amd64 on Debian)
To: <mikael@djurfeldt.com>
References: <CAA2Xvw+HXg7=qHpHC+hfjUr2cOGSmgEY4nUdGzr+8wG8VWAS_w@mail.gmail.com>
Content-Language: en-US
CC: <linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>,
	<yangerkun@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAA2Xvw+HXg7=qHpHC+hfjUr2cOGSmgEY4nUdGzr+8wG8VWAS_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/6/19 3:17, Mikael Djurfeldt wrote:
> Hi,
>
> While trying to do a resize2fs to fill up an extended volume, I got
> the dump attached to this message.
>
> Best regards,
> MIkael Djurfeldt

[416875.741485] kernel BUG at fs/ext4/resize.c:324!

BUG_ON((flexbg_size > 1) && ((src_group & ~(flexbg_size - 1)) !=
         (last_group & ~(flexbg_size - 1))));


The src_group and last_group are not in the same flex_bg triggering
this BUG_ON(). It looks like flex_gd->count or flex_gd->resize_bg are
outliers? Could you use `dumpe2fs -h /dev/yourdevice` to get the
details of the disk that was resized in order to further locate the issue?

Regards,
Baokun



Return-Path: <linux-ext4+bounces-3733-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2C952EE7
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977DF1C24092
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6E19DF9E;
	Thu, 15 Aug 2024 13:17:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB017C984;
	Thu, 15 Aug 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727842; cv=none; b=MuJ84LB2Nk3ux8U8e4JKObUM0G01cffDwRyyk0kPr48YXbAxjY2C5QFVsAFrrx7GVGK8uvLW/9tFOBpbgVbiUiFnSYNqOswLquYALYpwGxIKM0sKTkyzGkaIkKF6Z/zShnDc1ArUQ25RqTqrfva/WemHrQ82IZZ6TgcvDl7LrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727842; c=relaxed/simple;
	bh=8jSrqs/ttZ3XYQ4hBjYpXMRRoxshAmgWAE1/Ah8aamo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JyQiUMCs0DhhXBWw/J33dFwBnRVJI4oKXzesZur940u0TyQkQ2iKN7/ratvNkpGbcdBvDUzmXU+0GO2Fxmc0uSdyC9DElvcSKpLGXbbyaKmNcbEO2H6SDTvGx6UeUofTrdv7VQzSBwjaaw195/LphZ42Y3kIqdLkEjcaCvf4FBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wl5Hw59y3z4f3jHg;
	Thu, 15 Aug 2024 21:17:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 89ABB1A018D;
	Thu, 15 Aug 2024 21:17:14 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAHtrTX_71mvh_SBg--.17524S2;
	Thu, 15 Aug 2024 21:17:12 +0800 (CST)
Subject: Re: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
To: Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
 <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5d75ab7f-0fad-07ef-bbcb-3fed16a5170e@huaweicloud.com>
Date: Thu, 15 Aug 2024 21:17:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHtrTX_71mvh_SBg--.17524S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw45XFyUAF1rZw18JrW7XFb_yoWfXFX_WF
	97Cr1ktw4UK3WfXan8KrsxCrZ3Ca47W3WFv3y0gF4xAw1fJa98Xan7WF9Yy3s7Xr93Crsx
	uFs3XwnYq3W29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUU
	UUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/15/2024 5:55 PM, Markus Elfring wrote:
>> Release inode_bitmap_bh from ext4_read_inode_bitmap in
>> ext4_mark_inode_used to avoid buffer_head leak.
>> By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
>> is NULL.
> 
> 1. I suggest to split such changes into separate update steps.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc3#n81
It's acceptable to me, but I'm not sure if it worth separate patches
to others. I will do separate in next version if no person is against
this.
> 
> 2. How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> 
> 3. Would you like to append parentheses to any function names?
Thanks for remind me of these. I will improve the series in next
version.

Thanks,
Kemeng
> 
> Regards,
> Markus
> 



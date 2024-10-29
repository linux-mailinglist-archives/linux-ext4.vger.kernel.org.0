Return-Path: <linux-ext4+bounces-4840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C369B4055
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEA21F22A3B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D312FF70;
	Tue, 29 Oct 2024 02:20:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA740855
	for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168435; cv=none; b=ouj5ZVhAwbYdDvsqPkO7XhzS+55+riFqWwTsKt9H4H9G3IkPwKvPRkL7Jl+DG1k7ln4+b+AIOj1/xYEgbI2BqqljKeq3mKmM4RrrpyHZ4OkpzT8qOJEinuKB2yPRXxN22ieqU9Ib16AbihnW0xUgBXtmzp+2zIGarApjaRa5pDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168435; c=relaxed/simple;
	bh=vNo6diumlyVpnrqA/smKg/DJrAOE58cAqFf1Ko/DtOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf/qbj6nMW22sDnwHr2aIKRhTHbAnBG05qE7uLmaciIUtxA8smuSzc97HW/luUc5/lHMLLHBLggDOKOdj3GOqvbEUL02DB5562mg8Z19xdbTeX4zAgXXZoJzQWoMVz8IkSOsw0gVIP1p9+ep4c7ECNmhhXozOvEDstrVNi/ZmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xcv9K5KWMz4f3lVs
	for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2024 10:20:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 39C961A018D
	for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2024 10:20:24 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4dmRiBnQI30AA--.39008S3;
	Tue, 29 Oct 2024 10:20:24 +0800 (CST)
Message-ID: <54c0efff-2b7d-457b-ba31-788d77de14e7@huaweicloud.com>
Date: Tue, 29 Oct 2024 10:20:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20241023135949.3745142-1-tytso@mit.edu>
 <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>
 <20241025154213.GD3307207@mit.edu>
 <6bb74ccc-25e2-45c1-8a88-cfd093a194c7@huawei.com>
 <20241028035922.GC3842351@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241028035922.GC3842351@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXc4dmRiBnQI30AA--.39008S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1kKry3Xw4fuw4xGw1fXrb_yoWDKwb_uF
	W7Z3ykGwn7Aa1fWanrtF1YqrsFkrZxt34rWrZ3trs0vw1rAFWvkayvyrn8ZwsIvFWxKa98
	K3ykXwnIq3WUCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbO8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/10/28 11:59, Theodore Ts'o wrote:
> On Mon, Oct 28, 2024 at 09:47:46AM +0800, Zhang Yi wrote:
>>
>> IIRC, at the moment, fixed metadata does not appear in the middle of
>> the block group.
> 
> The mke2fs from e2fsprogs will not create a file system like that
> normally, no.  *However* it is possible for fixed metadata to be in
> the middle of the block group:
> 
>    * If resize2fs does an off-line file system growth without a resize inode
>      or the reserved blocks in the resize inode has been exhausted
>    * If e2fsck needs to reallocate some fixed metadata blocks as part of
>      repairing a (very badly) corrupted file system.
>    * If there are blocks reported to mke2fs when the file system is created
>    * If a non-standard mkfs.ext4 is used by some other operating system which
>      reimplemented mke2fs for some reason (for example, because they wanted
>      to avoid using GPL'ed code).
> 
> So while these cases are quite uncommon, they *can* happen in the
> wild, and we want GETFSMAP to be able to handle these file systems
> correctly.
> 
> Cheers,
> 

Ha, I see, thank you for the correction.

Cheers,
Yi.



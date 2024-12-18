Return-Path: <linux-ext4+bounces-5724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD19F5D74
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D34188F340
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 03:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA2146D57;
	Wed, 18 Dec 2024 03:27:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90713C908;
	Wed, 18 Dec 2024 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492422; cv=none; b=rwn6ipfz72NMvDeOKoxQ4IdDI5GOELdZ0bfcYEH+b/+GeXx4NVWuTfmQpzgg46PGKP8JM6J4JFR3InjNbm02ok2mEfF6ZEvcHpTBdJc+JZz9+oPUv2MGQ0uQBUOJEPInl5SX2b4WrwAQk1OK1qm60HqYRidC6ZJfGaFMeA23nuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492422; c=relaxed/simple;
	bh=uvCGLyGk/ewAdPBU9FMW28KMMdNJ1HM6rWOFiizyXRY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aZzAkjvmRB2gBj7dPJEK1W6uXBkxXOy9WDtjnFuHUXwSWwXpi80m9t33K+Gb/i/7F4AIekW9f6hREyhDsFE2/3QtGwYU/ryUG2QIL/CNmoGr+XT2qKAQHO9H5RXz5ATncBXKVmfykP3uMu0KhqBObuuoeL5CtrhypI4AhSmkkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCfGs3prRz4f3lff;
	Wed, 18 Dec 2024 11:26:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 12C251A058E;
	Wed, 18 Dec 2024 11:26:50 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgCHZcL4QGJn48QZEw--.58087S2;
	Wed, 18 Dec 2024 11:26:49 +0800 (CST)
Subject: Re: [PATCH 2/3] jbd2: remove unused transaction->t_private_list
To: Matthew Wilcox <willy@infradead.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
 dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-3-shikemeng@huaweicloud.com>
 <Z2G8ujYUUDGSpbGl@casper.infradead.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a659421b-b05b-c009-a8df-c0f5dfda18b9@huaweicloud.com>
Date: Wed, 18 Dec 2024 11:26:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z2G8ujYUUDGSpbGl@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHZcL4QGJn48QZEw--.58087S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUKw1UWry3Ww1DXr48Xrb_yoW3WFb_ua
	1fAF1DKw1DKF47Ja17Cr15uF45Cw4jg3WUZr1vy3yIk3s5ta929w4qq3s3Awn7GrWSkrs0
	kFn7Z3s8Kw17tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/18/2024 2:02 AM, Matthew Wilcox wrote:
> On Tue, Dec 17, 2024 at 08:03:55PM +0800, Kemeng Shi wrote:
>> +++ b/Documentation/filesystems/journalling.rst
>> @@ -112,8 +112,6 @@ so that you can do some of your own management. You ask the journalling
>>  layer for calling the callback by simply setting
>>  ``journal->j_commit_callback`` function pointer and that function is
>>  called after each transaction commit. You can also use
>> -``transaction->t_private_list`` for attaching entries to a transaction
>> -that need processing when the transaction commits.
> 
> I think this also needs:
> 
> -called after each transaction commit. You can also use
> +called after each transaction commit.
> 
Sure, thanks for correcting. Will fix in next version.



Return-Path: <linux-ext4+bounces-5842-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA99FBD25
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126AB16245C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430CE1BF7E8;
	Tue, 24 Dec 2024 12:11:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164001B87F5;
	Tue, 24 Dec 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042282; cv=none; b=RA1BU5MTcGiSrNvcTiimToVQEcCOsxztKQ26peLDDOOA6NMgQCdigt/NGKztw0hvUSfsDOq55Em5ODVyLnqg/AQk/VNGwedDLh6jeaU50A4xeYi/f7OMr/0+tOhMPCcmNKEOljYxnZAiGLCiktWj6U2SoO5eNmGVO0I1qv53+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042282; c=relaxed/simple;
	bh=SAB5jfCd/UmmvGEV3axQed/VnAlSpVNZQ0yn4DzXmZE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TT1DHzGPAf9kPNL+mwOnGi5dfdl62htH64cPON0Lqst0tf7xsVPKrInOdNJV+ZdFQKDVK4Z49AqCKZWCyV3vy0/4pMchqucWw/rCjj8ygTfT29pmJS15/IiDIm/UqaopBSWRgClUFUT7hmCH3DvaJaW/ctMbl/V/LmAafQ8GohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHYdK11pfz4f3jtD;
	Tue, 24 Dec 2024 20:11:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B8F5F1A018D;
	Tue, 24 Dec 2024 20:11:15 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgCnN8TgpGpnQsdmFQ--.24065S2;
	Tue, 24 Dec 2024 20:11:13 +0800 (CST)
Subject: Re: [PATCH 1/6] ext4: add missing brelse for bh2 in ext4_dx_add_entry
To: Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
 <2474b3df-1e58-49f5-a3b3-6cfd6e57372d@web.de>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e6173110-7225-6cff-762f-f49bc0df30cb@huaweicloud.com>
Date: Tue, 24 Dec 2024 20:11:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2474b3df-1e58-49f5-a3b3-6cfd6e57372d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnN8TgpGpnQsdmFQ--.24065S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1Uuw17Kw4xuF13Zw1UWrg_yoWDArb_Gr
	ykAa1fZ3WxCr1Sk3Wakr4UAFy3Kw43XF1Ig3W8KFZF9w13JayDZa1UKrZYyw1jqryFkr4Y
	krsFvwn5t3ZrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URKZ
	XUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/20/2024 9:15 PM, Markus Elfring wrote:
>> Add missing brelse for bh2 in ext4_dx_add_entry.
> 
> * I propose to append parentheses to function names.
> 
> * How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.13-rc3#n145
Sure, will handle these in next version.

Thanks,
Kemeng
> 
> 
> …
>> +++ b/fs/ext4/namei.c
>> @@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>>  		BUFFER_TRACE(frame->bh, "get_write_access");
>>  		err = ext4_journal_get_write_access(handle, sb, frame->bh,
>>  						    EXT4_JTR_NONE);
>> -		if (err)
>> +		if (err) {
>> +			brelse(bh2);
>>  			goto journal_error;
>> +		}
>>  		if (!add_level) {
> …
> 
> I suggest to add another jump target instead so that a bit of exception handling
> can be better reused at the end of this function implementation.
> 
> Regards,
> Markus
> 



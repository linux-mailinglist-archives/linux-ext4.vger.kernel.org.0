Return-Path: <linux-ext4+bounces-11932-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE701C72180
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 04:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF1E334EBF0
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 03:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3422D7B6;
	Thu, 20 Nov 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hSnd9uhn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4841A294
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610352; cv=none; b=F7yhcU22F2MQmb6JAb0Bd01WIrafLxiAgATltDuP/wL02gh/02nflKtbvWpyPS8vWHwmrRvATtFOJ4SOJW9wrgZb7+NdMz2ev8ytd1hd7+DT01ouYCu+Anz7OAaYfaxX2lbM8vTXqtv+LK1L81+eHxQfpePJ2OWPoyr13RyE5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610352; c=relaxed/simple;
	bh=P+LLEH7OR4YgfTqQvIthGh2XjTJnL9lB6iRVKmM1wm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dh3BghWUy1fI0ns0LnSlolPxufAHlLbVUtCgq6isk++iTurPMXvFIReRc3u2Xriw+ojQZKaNsmLdjt5SLjXPsbQ9tG5Ile64Nfjpvu6vaVlLoyeFcNcg7hge1TZAG+2Yfd1iKFRSde9itP2Ajw9odII4C3ptCItFm+eTNBj2NKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hSnd9uhn; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZbrMz7A3Q4Uh6HQHCPQ2dbXA3qEurA57rARCJ4H5+JI=;
	b=hSnd9uhnWT4vw3E6o+AHQx4v9aoKPfJXPbry8/g9FGDBcznSfQnrVXjMxp35vf+7b+BOauWJA
	ND5T/018hV0wQJPk0eqXC29X4oQoq4m5Fjv7LOqMuEVhDxGEMXC1xPW1W1NhO8K4N5jmaIrvYo/
	SX0OMBqqglRSuDY3UT5DyCA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dBkjY4QwHzmV66;
	Thu, 20 Nov 2025 11:44:01 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 009AF180044;
	Thu, 20 Nov 2025 11:45:46 +0800 (CST)
Received: from [10.174.187.148] (10.174.187.148) by
 kwepemj500016.china.huawei.com (7.202.194.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 11:45:45 +0800
Message-ID: <c081f098-27dd-739c-4468-5c0197937cc4@huawei.com>
Date: Thu, 20 Nov 2025 11:45:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] resize: fix memory leak when exiting normally
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-3-wuguanghao3@huawei.com>
 <20251118182919.GP196358@frogsfrogsfrogs>
 <b77146eb-f2cf-f2eb-b0c2-561879c23475@huawei.com>
 <20251119062614.GB196391@frogsfrogsfrogs>
From: Wu Guanghao <wuguanghao3@huawei.com>
In-Reply-To: <20251119062614.GB196391@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500016.china.huawei.com (7.202.194.46)



在 2025/11/19 14:26, Darrick J. Wong 写道:
> On Wed, Nov 19, 2025 at 09:52:19AM +0800, Wu Guanghao wrote:
>>
>>
>> 在 2025/11/19 2:29, Darrick J. Wong 写道:
>>> On Tue, Nov 18, 2025 at 09:26:01PM +0800, Wu Guanghao wrote:
>>>> The main() function only releases fs when it exits through the errout or
>>>> success_exit labels. When completes normally, it does not release fs.
>>>>
>>>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>>>> ---
>>>>  resize/main.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/resize/main.c b/resize/main.c
>>>> index 08a4bbaf..71711229 100644
>>>> --- a/resize/main.c
>>>> +++ b/resize/main.c
>>>> @@ -702,6 +702,8 @@ int main (int argc, char ** argv)
>>>>  	}
>>>>  	if (fd > 0)
>>>>  		close(fd);
>>>> +
>>>> +	(void) ext2fs_close_free(&fs);
>>>
>>> You might want to capture and print an error if one is returned, because
>>> ext2fs_close_free will also flush the new metadata to disk.
>>>
>>> --D
>>>
>> This is not an error, but a normal process exit. If there is an error,
>> it will follow the errout tag.
> 
> I can see that, but I'm talking about capturing errors returned by
> the new ext2fs_close_free call itself.
> 
> --D
> 

OK, I misunderstood. I will add a check in the next version.

>>>>  	remove_error_table(&et_ext2_error_table);
>>>>  	return 0;
>>>>  errout:
>>>> -- 
>>>> 2.27.0
>>>>
>>>>
>>>
>>>
>>> .
> 
> .


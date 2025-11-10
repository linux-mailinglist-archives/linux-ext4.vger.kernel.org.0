Return-Path: <linux-ext4+bounces-11720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933BC4679B
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 13:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F8054E9D46
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C530F543;
	Mon, 10 Nov 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l3oQ412n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96330E0EB;
	Mon, 10 Nov 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776553; cv=none; b=F8iMtLrbOMv4I9IYFQrEvUJQw2VShd8xQZBg1Ah8pEUR4rlqLtuLla1dzvnSinZQOh3BhxprLD6ihGIdB7TCpEATmWczDhWTydnfq2yV9uMj4qKimTSp+IvUOrZ5BITytbvmm6YNbR1L+f6iRw/fTqsT4iRsi1SqQ7ZUu1QGk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776553; c=relaxed/simple;
	bh=wAxgJBYGwoDSZb5hfNyKWteHhF4+zFD+4XO9Wrvw84A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hT/32iRBZ99yTMbqEtdKB9JiI+HpUAQ7SlWvMaKmT6GitcN3RtIYbXvK/w9cPceCDvusdFaROvg8h0EsNmPGNli7GyIp9HjiEgXBrbfwmaoR29Q7uYQkAMOL/ApmufZVvjNS7SLiL7e/fuYsZT7Qol8h0OmIGOJFj4+SxxbfVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l3oQ412n; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dpr0clA3/b4+Xp5u9Y8yrX10+2A/jOXibdQOlE+wxHU=;
	b=l3oQ412nH1fuO9oM0/uvt5tXULfRiSyzZSKhuQa23tPFZhA2othjJDOEtM+cUIw1szvpIadhQ
	qYDBKiD/Shaqei/MtnbnK/O17H+xEvqOrQp7Im9AgOaotNHjK8l+s0GiSXHvtPQciOsjUrD5W6r
	nL35AokzoWzfoasQNjij1og=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d4pMJ3W6Rz1T4Fv;
	Mon, 10 Nov 2025 20:07:40 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DF291402DB;
	Mon, 10 Nov 2025 20:09:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Nov
 2025 20:09:00 +0800
Message-ID: <1360a439-8c95-41e4-840c-163685751110@huawei.com>
Date: Mon, 10 Nov 2025 20:08:59 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] ext4: support verifying data from large folios
 with fs-verity
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>, <libaokun@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-23-libaokun@huaweicloud.com>
 <tyeh5ds2dezr4hrqxs46riwi3ps7ugwhcx46fqmpzarughiokz@q26eyruagm6v>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <tyeh5ds2dezr4hrqxs46riwi3ps7ugwhcx46fqmpzarughiokz@q26eyruagm6v>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-10 17:54, Jan Kara wrote:
> On Fri 07-11-25 22:42:47, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Eric Biggers already added support for verifying data from large folios
>> several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
>> data from large folios").
>>
>> With ext4 now supporting large block sizes, the fs-verity tests
>> `kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.
>>
>> Therefore, remove the restriction and allow LBS to be enabled together
>> with fs-verity.
>>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Nice!
>
>> @@ -5175,7 +5173,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
>>  		return;
>>  
>>  	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
>> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) ||
>> +	    ext4_has_feature_verity(inode->i_sb))
>>  		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
>>  	else
>>  		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
> Is there a reason why fsverity needs the folio order to match the block
> size? I didn't find any by a quick glance. If yes, please state it in
> the changelog. If no, then I'd just use EXT4_MAX_PAGECACHE_ORDER() because
> it will give us some performance e.g. for mmapped executables protected by
> fsverify...
>
> 								Honza
>
There is no real limitation that prevents verity from using
EXT4_MAX_PAGECACHE_ORDER(). The reason I did not enable it by default
is that none of the filesystems supporting fs-verity had large folios
support at the time, and thus fs-verity with large folios has not yet
been tested in practice. For this reason, I only enabled it when LBS
is turned on.

As you pointed out, turning it on gives some performance gains. And
it also lets fs-verity get more testing. I’ll switch to
EXT4_MAX_PAGECACHE_ORDER(inode) in the next version.

Thank you for your review!


Cheers,
Baokun



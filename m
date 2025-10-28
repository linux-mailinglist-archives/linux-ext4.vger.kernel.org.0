Return-Path: <linux-ext4+bounces-11110-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CAC1463E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 12:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EED1886B6C
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED053081AC;
	Tue, 28 Oct 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KypOQ6kh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4531DFD9A;
	Tue, 28 Oct 2025 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651282; cv=none; b=i+jqPcarDGrXAiHHnf876MygidiWW+FXnefmOaVCPHjRranyEw2NequAnv+3mYGXzMc2REcsBGbyULTHrt3sr+S0g1amAw624E38WOgyBwxeF9NOvG4/glC7aX5Gxzwlm1aLm/etxt5MO1SRYurw2RFH+mvclx+/Ld+HO5VfDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651282; c=relaxed/simple;
	bh=gQZZM4lcznGRZS8I3IWM/tDcOEPQ6eY9N2gX1znop88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JZBP262BfYVyaMzH8dNPaViwkU8OfStME0nCyrUpNuwqcv+OJQJZn8nmvzXwFEs0SUqLNpA+W9eWyJIHncS69ovyXD4CKm9cN6IUkem92mPfVMp92guv1oK3VykZ7lEODrafwEp3htUloHS4yV/vmrRilxNkWRmPRrfKHzhcz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KypOQ6kh; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1GjYzMJtxwUYSJRrlX1Q50Z/DZctAh99tRfgcgS2498=;
	b=KypOQ6khyprwh08G51e/Y8KM8U16zTA7ml2b+k+yEzQZvqcpxDLrqNeY7f1m/9a6lhBRykTuK
	QdqGSk0J+AiAc70h1k7RugQFg2gZGD4NslizyTxs31yBt75Lzj8oJ+IOELrzXApeCf5pL7r+q4x
	cSj+ApnFGY5V3yE60V744Tg=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cwpCg2FBtzpStg;
	Tue, 28 Oct 2025 19:33:19 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF38180493;
	Tue, 28 Oct 2025 19:34:36 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 19:34:35 +0800
Message-ID: <7bb8d73b-6394-4cb2-9e36-76cfbd584a76@huawei.com>
Date: Tue, 28 Oct 2025 19:34:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/048: Fix hangup due to no free inodes
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: Zorro Lang <zlang@redhat.com>, <fstests@vger.kernel.org>, Leah Rumancik
	<lrumancik@google.com>, <linux-ext4@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <20251028071743.1507168-1-ojaswin@linux.ibm.com>
 <89dbd368-4e76-45b5-8c82-9102db9f302e@huawei.com>
 <aQCPQ1V8DuAMpmVc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aQCPQ1V8DuAMpmVc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-10-28 17:39, Ojaswin Mujoo wrote:
> On Tue, Oct 28, 2025 at 03:57:00PM +0800, Baokun Li wrote:
>> On 2025-10-28 15:17, Ojaswin Mujoo wrote:
>>> We currently mkfs a 128MB filesystem, which gives use ~2048 free inodes
>>> on 64k blocksize. The test then keeps adding new files to a directory to
>>> trigger an htree split. For 64k this takes more than the total free
>>> inodes, which causes touch to return -ENOSPC. This leads to the while
>>> loop in induce_node_split() to never finish.
>>>
>>> To fix this:
>>> 1. Format a 1G FS which gives us atleast 16K inodes to work with.
>>> 2. _fail if there's any error while trying to induce node split, so we
>>>    dont get stuck in loop
>>>
>>> Fixes: 466ddbfd1151 ("ext4: add test for ext4_dir_entry2 wipe")
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>> Yeah, I also hit this issue when testing LBS — file creation kept failing
>> without breaking out of the loop, which resulted in the test case spinning
>> endlessly.
>>
>> Looks good to me. Feel free to add:
>>
>> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> Hi Baokun, I was planning to CC you since I thought you might've hit it,
> but missed it while sending the mail.

No worries, the mailing list can see it as well.

Thanks for testing and fixing this. 🤝


Cheers,
Baokun



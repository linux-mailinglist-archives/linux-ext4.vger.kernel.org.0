Return-Path: <linux-ext4+bounces-11906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F44C6C3DE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 02:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035E74E9F10
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2307A22D9E9;
	Wed, 19 Nov 2025 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ahi+zxZ4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4D22C32D
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515513; cv=none; b=L/zgqagxIyrM63ER/CoHfzmSqiLUdAUI2WP25hNPRx7GoCdqAmb4vOIG6P2oxgSWmxP8acudQuptjeMfmNmm/fPZ+Q3tv65C0N9twOSmLv8zBnzPR4C8m0YdLLtgy8eFUksltjRBI34ZuNhSPM3sDEqKCAnfl7lXLBEm/TV0AGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515513; c=relaxed/simple;
	bh=Q2D+pg05P+sC7S5XlGWDY4GzVYZufvras19SLxokCko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ELQ+z31T2gRzeKT0h/Zesx+D96NRejHPHDtG0VElJeVDf2oXLCrj6/yxOMiznJwb2syjcuZxtbsXlQhtbve8UjFxyi29Bi2ii2PTK6y7azieVNN2TAoBNM8pY61uRx1HOxWWPt5DKWbSpWCEiPYuBGtk/qNrZ0Diy6Z5SBTxtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ahi+zxZ4; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N/E39z2iSXXYn8p+9PCOKKf3AkblJfRvsVh1kyihgpc=;
	b=ahi+zxZ4Fiq6cJd1PrY5cyCk6z3BRWbPx+ksfefpRpj+F6cS4dI4KDQUy1Z2q7dgs+EBlR0af
	T/10uxYMveNM7OMR4CfuUyHWpSEXZ5s+5HdzlLrpuWoKB9laBv27OQ+xRnK+ul5HVfU+UZOqUzV
	Koy90yybdKXl5+Mv2vxlnxw=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dB3dd6q37zRhQR;
	Wed, 19 Nov 2025 09:23:17 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 278641402C7;
	Wed, 19 Nov 2025 09:25:01 +0800 (CST)
Received: from [10.174.187.148] (10.174.187.148) by
 kwepemj500016.china.huawei.com (7.202.194.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 09:25:00 +0800
Message-ID: <3a3e1417-3f59-5bb9-337c-518ae2f43f49@huawei.com>
Date: Wed, 19 Nov 2025 09:25:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] fsck: fix memory leak of inst->type
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-2-wuguanghao3@huawei.com>
 <20251118183021.GQ196358@frogsfrogsfrogs>
From: Wu Guanghao <wuguanghao3@huawei.com>
In-Reply-To: <20251118183021.GQ196358@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500016.china.huawei.com (7.202.194.46)



在 2025/11/19 2:30, Darrick J. Wong 写道:
> On Tue, Nov 18, 2025 at 09:26:00PM +0800, Wu Guanghao wrote:
>> The function free_instance() does not release i->type, resulting in a
>> memory leak.
> 
> Does anyone still use this wrapper?  I thought everyone used the
> /sbin/fsck from util-linux...
> 
> --D

The issue was discovered while running the ext4 test cases in xfstests.
I cannot confirm whether other users are encountering the same problem,
but the issue definitely exists.

I also pushed a patch to fix a memory leak caused by duplicate memory
allocation in xfsprogs. If you have the time, could you please review it?
Thank you.

> 
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> ---
>>  misc/fsck.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/misc/fsck.c b/misc/fsck.c
>> index 64d0e7c0..a06f2668 100644
>> --- a/misc/fsck.c
>> +++ b/misc/fsck.c
>> @@ -235,6 +235,7 @@ static void parse_escape(char *word)
>>  static void free_instance(struct fsck_instance *i)
>>  {
>>  	free(i->prog);
>> +	free(i->type);
>>  	free(i->device);
>>  	free(i->base_device);
>>  	free(i);
>> -- 
>> 2.27.0
>>
>>
> 
> .


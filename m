Return-Path: <linux-ext4+bounces-2902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E727690FB9C
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068B91C2155A
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 03:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFB1CD2F;
	Thu, 20 Jun 2024 03:19:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0402139C7
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853577; cv=none; b=mdLHiwKQNNUkBScws611k68BKFUhT9C/2FhY5VYdrWKM1YLhaEITStUsZDLV/rvdTC3g4mhtYF79BYJ1vc6yiNbb1jwOpv4Zt54RjK/Tp/AeIEA1SvZdhT+pGhjBpv/PEkRDpdGOOsO67P9AzvthR4vZ6WqH/W7u5JwKmPjADmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853577; c=relaxed/simple;
	bh=OAMtOat3YDKGPkX72MjjGeHsAQ4vVFE8dzrn+58BRP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lKLWcOxWtEuuBnSRm+Ta/fbZNAq4IubKPnTHyEFLhZUhyd6rq8hVJVyTnYHj+sYuG5fjKSXTiX882+XZ8d/Ct09ZsQzgWwAga8L6NRqCiOB65GkmKBwbgCUUtQP3fKGDf3TJY2YKke+lmH3IJoRltdMPd601AN9iQDIQmlpGxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W4QcH1YjNz1ytSh;
	Thu, 20 Jun 2024 11:15:59 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 48CA21A016C;
	Thu, 20 Jun 2024 11:19:32 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 11:19:31 +0800
Message-ID: <0c296005-c607-431d-a696-b5b165c83856@huawei.com>
Date: Thu, 20 Jun 2024 11:19:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Add a comment for incorrect tag size
To: Theodore Ts'o <tytso@mit.edu>, Wang Jianjian <wangjianjian0@foxmail.com>
CC: <linux-ext4@vger.kernel.org>
References: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>
 <20240619233655.GC981794@mit.edu>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240619233655.GC981794@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/6/20 7:36, Theodore Ts'o wrote:
> bd2: fix descriptor block size handling errors with journal_csum
 > in 2016 --- a full eight years ago.  So it's probably not worth adding
the comment at this point.

Hi Ted,
Thanks for detailed information, but is it better to put it in document 
in case any other one confuse about this when read code.
-- 
Regards



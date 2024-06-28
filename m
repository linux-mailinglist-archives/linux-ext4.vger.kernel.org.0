Return-Path: <linux-ext4+bounces-3013-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D191B4FB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 04:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DD0283E87
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1D2139C8;
	Fri, 28 Jun 2024 02:15:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D37FF
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540933; cv=none; b=BtDWB+ZfKDv8bzWwCm9sBGytLeJ4VVwWOuNdNA1vnAchghbQS2VnnfH7LJvyr7MJuYnHe5iGL9VShexdHbX8a6PosT8UrwziVADhEjdZVmrNRD1Tf7HK1CTFrVe/BYUACDlkV0jBSkCwFSkl/pish/Vh8LUU0I6mCYo+Rcoe2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540933; c=relaxed/simple;
	bh=ExELgvv4H7AHLVnv9FbD4TbZGBjF2SSFNyj0GpNOXcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iOOdqSenEUpZ/TcVpl7Q55BlOLhzJHjpBgKDLfbYRxngsDYtXnZe08nEaY1XFxFCTyQeotF1OXI9yolXD6jsHLIQ4uzMfZqj0E3fBZAwyBPp6wp7MmJlMAHCV41cDe4eY/8MO2vgCRnIJwBL1BLTtKnYZ5/keU3HlFJBoMc7Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W9Jp64HVGz1j5qP;
	Fri, 28 Jun 2024 10:11:26 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id D7227140381;
	Fri, 28 Jun 2024 10:15:27 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Jun 2024 10:15:27 +0800
Message-ID: <f3473286-cf5f-4708-8a84-524b967772a0@huawei.com>
Date: Fri, 28 Jun 2024 10:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Add a comment for incorrect tag size
To: Theodore Ts'o <tytso@mit.edu>
CC: Wang Jianjian <wangjianjian0@foxmail.com>, <linux-ext4@vger.kernel.org>
References: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>
 <20240619233655.GC981794@mit.edu>
 <0c296005-c607-431d-a696-b5b165c83856@huawei.com>
 <20240627133156.GC412555@mit.edu>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240627133156.GC412555@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/6/27 21:31, Theodore Ts'o wrote:
> On Thu, Jun 20, 2024 at 11:19:30AM +0800, wangjianjian (C) wrote:
>> On 2024/6/20 7:36, Theodore Ts'o wrote:
>>> bd2: fix descriptor block size handling errors with journal_csum
>>> in 2016 --- a full eight years ago.  So it's probably not worth adding
>> the comment at this point.
>>
>> Thanks for detailed information, but is it better to put it in document in
>> case any other one confuse about this when read code.
> 
> The comment would probably make things more confusing, since there's a
> much larger context involving the fact that csum_v2 is an obsolete
> format that in practice is never used.  Sure, we could make the
> comment even more verbose, but perhaps it would be better to simply
> completely remove csum_v1 and csum_v2 from the code.  That will
> probably make the code even more simpler to read.

Agree with that, if it is ok, I can submit a patch do that.
> 
> Cheers,
> 
> 						- Ted
> 
-- 
Regards



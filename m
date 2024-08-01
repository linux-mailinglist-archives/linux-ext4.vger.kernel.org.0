Return-Path: <linux-ext4+bounces-3592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C251B944487
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB20284998
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE1158547;
	Thu,  1 Aug 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b="qij6TaJg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from spornkuller.de (spornkuller.de [89.58.8.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367015821D
	for <linux-ext4@vger.kernel.org>; Thu,  1 Aug 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.8.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493943; cv=none; b=EuskieqMvDDTpw05s7K20Hu6p5yFEf+NMpA4CqQmUTnw2k+6QswiSJeiwgu/zW0adDCXfuRlcORFnrs07Rqm3/fKvA2IRFKtIiKOMwCMpRwQr07MQ1po5McvkYFUVXzgmyLryp6SZnRphUxciWpFS1+z26+MFlF7fg1LPSSB3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493943; c=relaxed/simple;
	bh=onRi1dRWOB/9MfK8J49zdMwwhI8L1zQr91WZQYP7TEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmQl7/4xXrfDvd3a3oR19VyoaVZn8u8lvW77Df4QFGUpoXOew6pzz+bHvomQTRZVvQUt+WU8neGV7aGzCZOddPPlS/Q68P2I7IxG6+ylZYkqgqDQv24EzHquYkycCEIviHuWrpmDAGNwumx7RzsBy3EH3G2SOgXdfZQg4vZvNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de; spf=pass smtp.mailfrom=spornkuller.de; dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b=qij6TaJg; arc=none smtp.client-ip=89.58.8.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spornkuller.de
Received: from [IPV6:2a00:79c0:74e:4001:9dcc:927a:42a3:4b74] (unknown [IPv6:2a00:79c0:74e:4001:9dcc:927a:42a3:4b74])
	by spornkuller.de (Postfix) with ESMTPSA id C0E72636FCB;
	Thu,  1 Aug 2024 08:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spornkuller.de;
	s=dkim202204; t=1722493938;
	bh=onRi1dRWOB/9MfK8J49zdMwwhI8L1zQr91WZQYP7TEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qij6TaJgP02Kx+T9vQXbQSH/j1KmbKWwQSxRGP8pM3V3UCZ13fNSzMelQKzRe2sgI
	 InIncr6lcgAn0mYPj2p9lSEAlWJgeuImaexEppBqzBkVZf/DzoCil9OpGxDqRqLIwJ
	 Pujf7ddEvTCiS75iQTeY4BSNm3MP6EzbDevfWIz9Ik4zUcrxtqw1IVCbpx3W5TdY+2
	 4ExNMHh5t+u8FqkaqjNdqIorS6xk0+iEJzZWkEa3UccWNrI+IdsBU06XP4PDCpXqY1
	 mN9zF4gBgQC+D8DvMtWBz1pqzcnnWNJp6zWWVvyIj0kvJOhqK7G68zk+afDgnDb+Kd
	 UmQczp7/ta/qQ==
Message-ID: <1cd11635-4015-43e6-8c8c-db5e2f029536@spornkuller.de>
Date: Thu, 1 Aug 2024 08:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modification of block device by R/O mount
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org
References: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
 <Zqrqo1lIrsxdm7AP@dread.disaster.area>
 <bdf2626f-580a-4af2-9fb0-5e3ebe944f95@spornkuller.de>
From: Johannes Bauer <canjzymsaxyt@spornkuller.de>
In-Reply-To: <bdf2626f-580a-4af2-9fb0-5e3ebe944f95@spornkuller.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.08.24 um 08:18 schrieb Johannes Bauer:

> But my point is, that is what I am doing -- creating the losetup mapping 
> R/O:
> 
> # losetup --read-only --show -f image.img
> /dev/loop35
> 
> # echo foo >/dev/loop35
> bash: echo: write error: Operation not permitted
> 
> I.e., the block device is write protected and *yet* it changes content. 
> This is what I find so extremely puzzling, that the file system should 
> not have the capability to change the underlying block device, yet it does.

To expand on this, it also happens when I create a dmsetup linear 
mapping that has been explicitly marked as read-only:

# dmsetup create --concise "linear,,2,ro,0 131072 linear /dev/loop28 0"

# md5sum image.img /dev/loop28 /dev/mapper/linear
56f56801923108d241947024926fea53  image.img
56f56801923108d241947024926fea53  /dev/loop28
56f56801923108d241947024926fea53  /dev/mapper/linear

# mount -o ro /dev/mapper/linear mnt

# md5sum image.img /dev/loop28 /dev/mapper/linear
56f56801923108d241947024926fea53  image.img
56f56801923108d241947024926fea53  /dev/loop28
d804867eab0106f9659c02a6add2f5da  /dev/mapper/linear

It is my understanding that while mounting (even -o ro) might modify the 
block device, a R/O block device should never be modifiable my anything. 
This does not seem to be the case?

Best regards,
Johannes

-- 
"A PC without Windows is like a chocolate cake without mustard."



Return-Path: <linux-ext4+bounces-1339-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699985E361
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517B4281D8B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DB81AA5;
	Wed, 21 Feb 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ebgqonxa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCD78B70
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532999; cv=none; b=tknupndtQg5epxhoAUHqqPV72BXplssL/9zGqDeQsLdHmOa/CIbqqgtBxuMWtcAbcUEIzsw7CWD/iFtx26ujI+N655gveNJmPLPsJUFko6ltCa7dwDwyyPvDNe4oxqRn9d8mqb4QOsam4LswtEYwbLppujtoT5buL+bc0O6b31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532999; c=relaxed/simple;
	bh=Y7URgRuEKDSG5g+QGtB64+MjSdE5uQUFsuGKCJ6Dd0s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T8KEdIuHyby8PxELmwWLTpz07t7pGMALebrAVqT7mzHyRuD6vPck1X8GM29NbLHLRtQmZW4ME8ldjCPxOBH7sB2geppofqta59sSjK3MrsakXaLy5hbP0TmL56U++5+2SSwayYLcK5cchuHSwsGPi6+jgQVEXCjsNicP+XVo49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ebgqonxa; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F33F160003;
	Wed, 21 Feb 2024 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708532989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzqS1O6GFXVim1dhqJFiuZBdEHIQXtFLaHrhk29p1O0=;
	b=ebgqonxaJytyY9bObRxMdOcm96zliu1nNeNTFY5hbLpTzmOar02BRcKX1B36GrUMD4XIzl
	IcipDFp9TmyWGBlrOEtupMuvQEfBzWLbAMxwm3Pq8BIRrMv+KoGL0tpaSSNNUC1X9g+RWv
	Ow9eX8VeTXkNxL4gWdbAdqNQZXNSs8L7rhSKpZxOC8W75LbWUYZ4AOLxgiEKUO9nzIfpDD
	p3QUwML4zt9AH14IkBVn/wplYt/3gvAcaybljEQC+qPswr/ewbQlgef4/i72rHU71GrN8e
	bgOzc1d6hBxo8IenMwfm7h1j/vqJ/aGeoB0ZiMl7Qebw8vXsygZDg619ILRKyQ==
Message-ID: <192cb320-2ded-4761-b0c9-3e273931f6f6@bootlin.com>
Date: Wed, 21 Feb 2024 17:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240221110043.mj4v25a2mtmo54bw@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Honza, all

Thanks for sharing all these details. See my follow-up questions below...

On 2/21/24 at 12:00, Jan Kara wrote:
> Hello,
>
> On Wed 21-02-24 10:33:04, Michael Opdenacker wrote:
>> I'm wondering why ext2 isn't marked as deprecated yet as it has 32 bit dates
>> and dates will rollover in 2038 (in 14 years from now!).
>>
>> I'm asking because ext4, when used without a journal, seems to be a worthy
>> replacement and has 64 bit dates.
>>
>> I'll be happy to send a patch to fs/ext2/Kconfig to warn users.
> For all practical purposes I agree we expect users to use ext4 driver on a
> filesystem without a journal instead of ext2 driver. We are still keeping
> ext2 around mostly as a simple reference filesystem for other fs
> developers. I agree we should improve the kconfig text to reference users
> to ext4.

I can submit some changes to the Kconfig file along these lines, thanks!

>
> Regarding y2038 problem - this is really the matter of on-disk format as
> created by mke2fs, not so much of the kernel driver. And the kernel will be
> warning about that when you mount ext2 so I don't think special handling is
> needed for that.

So, if I understand correctly, it's mke2fs that should be creating a 
filesystem with 64 bit dates, which the ext2 kernel driver could happily 
support, right? However, I made an experiment by using "mkfs.ext2 -I 
256" and I still got the warning:

[  689.213780] ext2 filesystem being mounted at /mnt supports timestamps 
until 2038-01-19 (0x7fffffff)

"tune2fs -l" also confirmed I had 256 byte inodes. Anything else I 
should pass to mkfs.ext2 to get 64 bit dates in ext2?

By the way, the code shows that the warning is issued 30 years ahead of 
time!
https://elixir.bootlin.com/linux/v6.8-rc5/source/include/linux/time64.h#L43

I also could check, with "busybox ls",  that if I cross the 2038-01-19 
03:14:07 date barrier, all the new files I create on an ext2 filesystem 
stick to that date, instead of rolling over to 1901 as I expected. 
That's better :)

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



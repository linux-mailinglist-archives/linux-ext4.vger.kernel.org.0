Return-Path: <linux-ext4+bounces-1906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62689A5A8
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C81C21958
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CA174EDC;
	Fri,  5 Apr 2024 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lRYHItRp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1617278B;
	Fri,  5 Apr 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348989; cv=none; b=Psx3Fkqqh0q0kRrWYuFTrsKJHHr0oe9ByYEfDs/yL3+0tenq3U0apMDUx9coJqVO8qDCr2bocl2UPhmrifOZ4UurTqTk7G3gU8KpYQeDlzFZI+jVWHEIZHcz3YuciU+M9HpYPznBm9I/rX1z5nlccTn7HV29qXzKMEcPKTQSuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348989; c=relaxed/simple;
	bh=FrkwMKdTLjy553kBEEHGyp8iLLC2aDtK4qcMOzTAKfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC2nmlMhmwHaEU4mI247WQMFgNoc2PnoQMUq5ZA8h3GoaAWWM05yQZtJK5auZRkf1Os6tYP4BYcCpEejsiNTVoxpT882IborrOqQ+nLtymvVfkXk8rsLrB6lYO45ixf2k57WzDaSr12iS97+HrK6nDwvDXIlmW5YTvwrlvpdpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lRYHItRp; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 16E59661A6;
	Fri,  5 Apr 2024 23:23:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id CC649608F1;
	Fri,  5 Apr 2024 23:22:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sMcFhw0lE4Y0-rVL2Tocs;
	Fri, 05 Apr 2024 23:22:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712348576; bh=Fiv4kNSSUynv2Vg99FokftEQCvQjNaiHjCpd1Qa91RQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=lRYHItRpRgjibTTIpGiW07FoFtQPJ+hltg2Y+u5Rprzm1P6qFMm2ILbXdMV+iv07q
	 IXZMJb0bErZALr+bIgE0x6HhAHwHh0qgyD0a6zMvc+3Y1rr13tdAW6r59sPHx1ne4w
	 4wcN39RwVS9KaWC9pEtJaepbOAtxSHQn9L1noth4=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d2283045-7a51-4fe0-b302-37fdaed12758@yandex.ru>
Date: Fri, 5 Apr 2024 23:22:54 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michail Ivanov <iwanov-23@bk.ru>,
 Pavel Koshutin <koshutin.pavel@yandex.ru>,
 Artem Sadovnikov <ancowi69@gmail.com>, stable@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <87frw1azf4.fsf@gmail.com>
Content-Language: en-US
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
In-Reply-To: <87frw1azf4.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.2024 19:02, Ritesh Harjani (IBM) wrote:
> It will be good to know what was the test which identified this though?
>
> -ritesh


Unfortunately syzkaller was not able to generate a reproducer for this 
issue.


- Ukhin Mikhail.



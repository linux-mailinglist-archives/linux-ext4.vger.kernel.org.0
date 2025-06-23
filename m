Return-Path: <linux-ext4+bounces-8607-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AAAE4230
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FD1891C27
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269E24EA85;
	Mon, 23 Jun 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="DKr7cJWN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287624DCF8
	for <linux-ext4@vger.kernel.org>; Mon, 23 Jun 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684499; cv=none; b=uSna+qOtZZbv9+U+D4uOUlc7HkLG0hPlIVTnugwxIIJ/VJZg7S5fWccRNLNoODy+UbMNuuAD0xTOTfrAz9WcgamBCioCQI5lCR1U++DzWTXAyq1uMmnJdTjUIwkbQWpUbp4GRh4c3YX2x0/0Y69WXzpBsyhTU1MdK+rkd3qCFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684499; c=relaxed/simple;
	bh=6qYl+9K94MArScvDkx2csar76iVMr2NoJxcy5eSDeoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGQPPYLcoNGuJTBJIfEnQpYstVpb8tj1N8y03MmY1np5eWDmurXZgbVxejZ6bEAaCz/nfTuz/77RmqW0QoRXN4RIAEKoE0ia9h9BWc6AyjFop/2BQWQOmViCG04IapMmD7ZCwaRyTVC3TbWTp5ELReOS8KnaMEYrTdQPnG6Albg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=DKr7cJWN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bQpTN5fRfz9swp;
	Mon, 23 Jun 2025 15:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750684488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCO58AACiWjBtGwZS2EJVxx/q+IiXMJ4OY+PBJMsPWo=;
	b=DKr7cJWN4HMDw+jqe2/VbPlxAv0A061/dj7TXvMImmKcSgS0hh5Hvy2fnqx5TqAI2ddarx
	8nzdgAYm1JuKHJ0C1IhoSmRR61ne5BK6XhgxEVFiL+gq+1h0VsdCH0BsYsBupsAMF93oZM
	dy+ZaSj8fAhvd6veHp8cI5KqDRZjnqmLlFw4AMnbcWDp1VUC7151Xfw/uAFpTB1HEbsNvY
	kQdWXU/e+hTrpMq1bo0XWWUZmc7laNpkahvTXXdIDQqxfyLGBab3UvJZ4Ch528s/rweJV8
	n36MmT8GsgkdF/m+BFiPBz70BFodJkvA8Ft50l/TGeVQOdBukXAJWzchxC6uAg==
Message-ID: <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
Date: Mon, 23 Jun 2025 15:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: LBS support for EXT4
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org,
 Zhang Yi <yi.zhang@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks a lot Jan, Zhang and Baokun. I think now I have a clear idea on IOMAP and LBS efforts
for EXT4.

>> The reason I am asking is, should I take up the challenge to add LBS
>> support with buffer heads in EXT4, or should I wait until iomap patches
>> are merged.
> 
> I think better spent time would be to help with the iomap conversion. I
> don't think there will be that much coding left (perhaps some more exotic
> features need attention) but there's definitely testing needed and review
> is always welcome and most needed...
> 

We will definitely help reviewing and testing the IOMAP and LBS patches. :)

--
Pankaj




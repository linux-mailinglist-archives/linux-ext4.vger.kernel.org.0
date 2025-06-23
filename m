Return-Path: <linux-ext4+bounces-8609-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8836AE4310
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A1418998AC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0B24678E;
	Mon, 23 Jun 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kqgNCyrC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724424BD00
	for <linux-ext4@vger.kernel.org>; Mon, 23 Jun 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684981; cv=none; b=kdM9Cq+8Xok4zO7DUM0ti+RgALfmyVcxjxPCOSkoovS4OTn/fLep1itjx2GbJdsxxehD8rjPLLfk6bBg3B7bvqJGSzsJiPVFWcp9DT+po3NKzfFjWqFZKTfUB2oiAxYRCYj+mIVCa7fea77vrMapx6lpJeckjMWPLg9U0DUwIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684981; c=relaxed/simple;
	bh=46tfPDxsTfj+YTFKkH6yes5XZYnX5TFRAE6ulLVtlLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKAguxAA7JeaHT/Y9hFt844tbdxk76wtBpREhL3qRcaBlge5nVft/wfDnkqvOA8vclauufT4d6+Ipf9iyDFrbZV6A4tDasx1WO/edXE9/na4/foWKfDIK4/ynPG4J493rm5UHQ0MTu/LUbYU3OleTG3Ljn/UyXBz/Aa9jEdSBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kqgNCyrC; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bQpfd4xDfz9sWY;
	Mon, 23 Jun 2025 15:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750684969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkfu5En4avsEI1MIR5TarcpVfKlOK6QvpMc/okSvHnE=;
	b=kqgNCyrCjNhY47S93ECaROhd0Tq7PWtHAyUeQN3xO5e4hQc3m7yD1QqQgzzaP5q+Ajadf7
	TGQrHfGfY976jR0daOjqq15WnMeylJSHH2uRM2ub0oj8XrOVx0oG7bnzKogwKsmWT1KRAx
	EI5cpnLBjzPiy8304G+vuLohz1W/+VnzmfGHA/Zibvzaf7wzEo+IbNe3oaYVdf4rc2oyOI
	Vz7xk0lN/2WXhNojdhdaxke3yeRrB7c6D5lPbLacmLtZnroU88muaWScOSBD7SgUsTiRnO
	WXzOg8BBpW38GZgREMCarAmIS+piyQ7ZWJMuweWE8jQID8TJLcsecJ5wf6d3YA==
Message-ID: <d05d37eb-9f03-4bcd-940a-bcc1389d4717@pankajraghav.com>
Date: Mon, 23 Jun 2025 15:22:46 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: LBS support for EXT4
To: Zhang Yi <yi.zhang@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <23915ba3-5c00-4628-a22a-3fdcd4ad0b62@huaweicloud.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <23915ba3-5c00-4628-a22a-3fdcd4ad0b62@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4bQpfd4xDfz9sWY

>> I think better spent time would be to help with the iomap conversion. I
>> don't think there will be that much coding left (perhaps some more exotic
>> features need attention) but there's definitely testing needed and review
>> is always welcome and most needed...
>>
> 
> My colleagues, Baokun and Zhihao, have been working on LBS support for a
> couple of months, based on my two large folio series (buffer_head and
> iomap convesion) and the bdev large folio series form Luis. They will
> release the first version after testing as soon as possible.
> 

That is great. Feel free to CC me and Luis. We can help with reviewing and testing
the patches. :)

--
Pankaj


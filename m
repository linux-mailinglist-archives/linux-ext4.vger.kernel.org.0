Return-Path: <linux-ext4+bounces-11729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6863C4796B
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 505EB4ED5A7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA8257841;
	Mon, 10 Nov 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BP4u4OZ+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6D19F41C;
	Mon, 10 Nov 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788902; cv=none; b=nObfPzv+UtD0ps1dCwtd1g1KGYZZRMy7epg3K+0LlDoJi3N5YraG90DUqF5Kd7lkMgCsQvS1Kss8Nwi2s955HPB63XmD6DwQ36gCpaEkTS8jhgEFE6NrQdNFvBmbF4nEFgxfjbD3fyAW9Tm9UOitszd5pgzjLGyuWgp+SQgpzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788902; c=relaxed/simple;
	bh=ZWjJD/1xH/fH/g6Z2KPOz2SHy5oPswPbHfvVgre9lho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUlh3G+uBDtY1Wxi0JclM8+yGGPhCOT3bYgR6t7ptKPiP70E/FiolFXqqRF6fzfDwwMwIMiyKr5qmxRDlA64H8G494iCv32F3RytSi068mJr3aD0mALagJ17yUB18Zi881pzolI55Et/JhDwr7Sr18ASsT8kyMGbkaMVNHklga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BP4u4OZ+; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4tyS1s4Fz9tnx;
	Mon, 10 Nov 2025 16:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1762788896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1KeoCbtv75IlU4XoXDiuWf8VyMocOvzgZGay5xD3M8=;
	b=BP4u4OZ++RbvrdZGXlvL6nkwYIZu1vFtvKhEfQaIoLn3htMmnKxnSDlNvMqIwzPoGSyMYr
	bVgyV07WHq6gls3khUNbU9x0oMYqFEWtTwUh3q4+O+01X4cIN97C9XHK9HIwlZttPv19Sn
	EVe9xkmh+kWhk2mrGkij6GnJBCQn7+C6eXNUyjC/K72NbvqrhWNHTBJ2tLhMAnJcPiyJN7
	d/TbT5zFKeEKxr0RgJk+6dSVc/wnuJO+r5WAgytk+3R4uEgVv6cj4HzJuS2/UsnqOFhMSW
	c92zUNb+GUB1LwLRsg7BHPB5f5hKzX2aH4jrLNQEchS9J9Z+Koz/ndnscj1LVA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <4bbea425-e896-4047-b30d-6598ff7e9165@pankajraghav.com>
Date: Mon, 10 Nov 2025 16:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
To: Theodore Ts'o <tytso@mit.edu>, libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, ebiggers@kernel.org,
 willy@infradead.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251110043226.GD2988753@mit.edu>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20251110043226.GD2988753@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4d4tyS1s4Fz9tnx

On 11/10/25 05:32, Theodore Ts'o wrote:
> I've started looking at this patch series and playing with it, and one
> thing which is worth noting is that CONFIG_TRANSPARENT_HUGEPAGE needs
> to be enabled, or else sb_set_blocksize() will fail for block size >
> page size.  This isn't specific to ext4, and maybe I'm missing
> something, but apparently this isn't documented.  I had to go digging
> through the source code to figure out what was needed.
> 
> I wonder if we should have some kind of warning in sb_set_blocksize()
> where if there is an attempt to set a blocksize > page size and
> transparent hugepages is not configured, we issue a printk_once()
> giving a hint to the user that the reason that the mount failed was
> because transparent hugepages wasn't enabled at compile time.
> 

I added something similar for block devices[1]. Probably we might need something
here as well as a stop gap.

> It **really** isn't obvious that large block size support and
> transparent hugepages are linked.

Funny that you mention this because I have talk about this topic:
Decoupling Large Folios from Transparent Huge Pages in LPC under MM MC [2].
You are more than welcome to come to the talk :)

But just a small summary: When large folios were introduced, it used
THP infrastructure for splitting the folios (for example when we do a truncate).

I hope we will soon be able to sort it out so that we don't have
to sprinkle CONFIG_THP everywhere.

--
Pankaj

[1] https://lore.kernel.org/all/20250704092134.289491-1-p.raghav@samsung.com/
[2] https://lpc.events/event/19/contributions/2139/>
> 					- Ted
> 



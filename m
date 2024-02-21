Return-Path: <linux-ext4+bounces-1335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF09085D743
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 12:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717FA1F239E0
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646B45010;
	Wed, 21 Feb 2024 11:40:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D64176C
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.118.73.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515601; cv=none; b=bSBfeMR78hrbsjOZABV7y+G7HtN+ch2weFXrT/4kUPG1pomf/52OrRFR2q7wRNrUjw3RrWjr+syWilbCKsI5olH9yBykcQP6GnRpoolWasmetEvsjwLwK9Gc1/BYX+gm/hWwKSL3epfs5FsV7EYi5VqfviivBwnK78tzcXqJ8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515601; c=relaxed/simple;
	bh=LK5N98RAL9ZnNVq4NNRJKmXZHVHDgxWHV2h9/TAJ4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=supAjkEi5Q8YxwmX9ECsu89B6HbO8/6K3rM8jpRorrzJ6b/c8Ehbe3g45V4kz9xGxeqqVc/pn7sXK09l7C2Bu9+f17R41FLI5CmI6YofseMK+9aqi/t/SINc9efL6Ade4oI4veqdOA/vbHfhpFQ4zzpiNSmGXqVjJ/UNDA0wRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net; spf=pass smtp.mailfrom=thelounge.net; arc=none smtp.client-ip=91.118.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thelounge.net
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: h.reindl@thelounge.net)
	by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4TfvT70nn4zXLP
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 12:39:55 +0100 (CET)
Message-ID: <4b40056d-9b55-48b2-86f0-b91207e9abb7@thelounge.net>
Date: Wed, 21 Feb 2024 12:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why isn't ext2 deprecated over ext4?
Content-Language: en-US
To: linux-ext4@vger.kernel.org
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
From: Reindl Harald <h.reindl@thelounge.net>
Autocrypt: addr=h.reindl@thelounge.net; keydata=
 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
 K4rYsjPimkSIVdrNM//wVKdCTbO+
Organization: the lounge interactive design
In-Reply-To: <20240221110043.mj4v25a2mtmo54bw@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.02.24 um 12:00 schrieb Jan Kara:
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
> 
> For all practical purposes I agree we expect users to use ext4 driver on a
> filesystem without a journal instead of ext2 driver. We are still keeping
> ext2 around mostly as a simple reference filesystem for other fs
> developers. I agree we should improve the kconfig text to reference users
> to ext4.
> 
> Regarding y2038 problem - this is really the matter of on-disk format as
> created by mke2fs, not so much of the kernel driver. And the kernel will be
> warning about that when you mount ext2 so I don't think special handling is
> needed for that.

you shouldn't create filesystems with a on-disk format that don't 
support 64bit timestamps no matter how small the filesystem is

the arguments on this list where "such a small filesystem isn't expected 
to be still used in 2038" which is nonsense in case of a /boot FS in a 
virtual machine

our whole servers already survived 16 years and 30 dist-upgrades


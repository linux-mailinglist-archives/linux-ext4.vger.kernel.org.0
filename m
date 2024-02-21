Return-Path: <linux-ext4+bounces-1355-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E181085EC16
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 23:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7511C22A70
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 22:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FC535DC;
	Wed, 21 Feb 2024 22:57:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19C5232
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.118.73.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556249; cv=none; b=mTZ7xhZ1qLG4eCfMNMF0hHHBUxbBi0PEaPhTtpVaUGi640Xrp/1a+Yp/3QO66CaVBJDvEnEIVLqgwa6MkLcTXHBM0LLduva2/ZMh2yRXqwQFQtddppLbrNhC4E9/Ow4geHIWHaZDX2P2OzNTXqNHJCOLBqVl2SgIITys1OwE860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556249; c=relaxed/simple;
	bh=6UYsi8NhuPXE/U/n23Y/9s3V2oUqmMgksIokblvLj8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u7tJHV3q9ru1WyWtFCVivVO1VIBXkbpvVVlnM3S11EW6/1Cvy/S1hfIr0m+fsfgGjA0JWlZOlS5Vb+kEOiFqsgFQrffnVRv27/YpypJE4thwqff8rVotVnHz5PWD5ExkeBlP/HjFi0CLMDTGKoXG4WrQwdNX7UKlvhW7LoVIUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net; spf=pass smtp.mailfrom=thelounge.net; arc=none smtp.client-ip=91.118.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thelounge.net
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: h.reindl@thelounge.net)
	by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4TgBVp2wwQzXLP
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 23:57:22 +0100 (CET)
Message-ID: <26213f05-2727-45de-8917-da54430d2d19@thelounge.net>
Date: Wed, 21 Feb 2024 23:57:22 +0100
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
 <4b40056d-9b55-48b2-86f0-b91207e9abb7@thelounge.net>
 <20240221154858.GA594407@mit.edu>
From: Reindl Harald <h.reindl@thelounge.net>
Autocrypt: addr=h.reindl@thelounge.net; keydata=
 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
 K4rYsjPimkSIVdrNM//wVKdCTbO+
Organization: the lounge interactive design
In-Reply-To: <20240221154858.GA594407@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.02.24 um 16:48 schrieb Theodore Ts'o:
> On Wed, Feb 21, 2024 at 12:39:54PM +0100, Reindl Harald wrote:
>>
>> you shouldn't create filesystems with a on-disk format that don't support
>> 64bit timestamps no matter how small the filesystem is
>>
>> the arguments on this list where "such a small filesystem isn't expected to
>> be still used in 2038" which is nonsense in case of a /boot FS in a virtual
>> machine
>>
>> our whole servers already survived 16 years and 30 dist-upgrades
> 
> This is an individual system administrator's decision.  The defaults
> will not create file systems with 128 byte inodes.

it was *not* my decision in 2019 after create a small /boot partition to 
get a welcome message at boot that it will not survive 2038

> However, there are situations where it *does* make sense to use ext4
> file systems that can not express timestamps past 2038.  For example,
> at my employer, 128 byte inodes on HDD's because we do *not* preserve
> file system images across hardware upgrades. 

*this* should be an individual decision instead create outdated nonsense 
these days

> Using 128 byte inodes
> means that there are 32 inodes per 4k inode table block, as opposed to
> only 16 inodes if you are using a 256 byte inode.  There are
> performance benefits if you are concerned about reducing the 99.99%
> latency on heavily loaded disks, and reducing the TCO costs for bytes
> and IOPS for my employer's cluster file system.

irrelevant on a very small partition

> Furthermore, from an ecological perspective in terms of power and
> cooling perspective, even *if* hard drives would survive for over 8-10
> years, it would be irresponsible to keep those systems in service.  So
> my employer knows what it is doing when it uses explicit mke2fs
> options and/or mke2fs.conf settings to create file systems with 128
> byte inodes.

in my world drives don't matter and the systems are moved between 
hardware because hardware don't matter at all

what exactly is irresponsible in keeping a up-to-date system in service 
which was originally installed 10 or 15 years ago? this isn't microsoft 
windows and i haven't installed any Linux from scratch in my whole lifetime

in fact i created a small partition without touching mke2fs.conf and it 
ended with a filesystem not surviving past 2038

Fedora for sure didn't invent the nonsense in "mke2fs.conf" falling back 
to such pervert settings for very small martitions


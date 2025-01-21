Return-Path: <linux-ext4+bounces-6186-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15753A1855A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9709C188739E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2171F4E2C;
	Tue, 21 Jan 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="ZK5rIK5i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455A1F1527
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737485257; cv=none; b=jREJFpFw5w7gUnjX2MMXkt1sXV5XBErQneCYQcYwtTzlQNDgyDFpYShMSeCBVpUoQcs0Yo0QThcIme+waczPWGb9HjBSUl++uyiX2wr2DwnHs2LSq2OfR1qsGSDa2rhoH/sM5Z8FnoaHPWV33UZZ203JiIw9CWAwmA+qpPeuW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737485257; c=relaxed/simple;
	bh=Mgbh5yKkxCPA9vAsgwaIwaQ/VSx9dRPQPxQlEETS0M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t08UVw9pJaK+HFpm2dn0UjCutSxUK8JebAinJzbwFZzjkWmDaQHtXbyTtMlNm1xj09bn7DveZYPGby6oRCgM3/Rl6NOoA6ivUOB5iz4o0bjOSoNqbCSEM5V5CCpFQ0XVYuvAq42lgndpS8PDPkXN3YTOGyS2abVeTpw08CXqadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=fail (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=ZK5rIK5i reason="signature verification failed"; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id E04699F1C2;
	Tue, 21 Jan 2025 19:47:25 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 50LIlOLw132404
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 21 Jan 2025 19:47:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 50LIlOLw132404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1737485245;
	bh=snBL1MUJb/UAxs/Q4p65hesSr2nG5faJzOpt98yaupE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZK5rIK5iC2SVGuLUvFU6AefoCYs6sZ7PNSGn+ypO9rfLJjiypBj6PHXUYJf4EDazg
	 CBdnZWkILAAHtyCBmdyoFqQW9eXjBs6LHJ7TXzWeH+PukNC77PzX1LiPgDyb5nolAC
	 c4aursfZg8Ji1PdABHyJX82q3yKb/ksrYdHjQOua+hB/YGox+TwMwlw7jtg+ofkGVl
	 lySar0epyVIk+GTWwBHTGbtJrXAS03jL+nUY0B9wWjw0NBGNqrXZkNaMq2TNAwjpoV
	 gXdc/XC0zySVDFRaEXKTn9nSOdpnUFsCvoGotGB7dtuK3n+SY9Se5lamG2ItM4fioA
	 Noq2YHPMZhN+hYpXqzKI+lunc/8VqD6+Z1pelpitbueF8do+OiRiAWvml8s2LNTmqk
	 4+D30xQ3K4MGkkszBCvz+RdccMdpKK5L1Pgm2KuwNZzfX2LunF7Wyn2EUWblWgd2AO
	 NSUmTd7NaJOVHe6Phm1lViTNuTMM6qoVR4OE83ZxyU/jzpt+gzE/bqdKu1ISemhqDu
	 jOyCEheAHRPI2HNWXou0Ix11jdyGJYB1MvPQLqT8pYgPOQhq4Cqzwa6GNYVFg5vOlI
	 3AWFA403lE/pJOHTjFaFhXJKSyJ8hNmYjlaiSrhbtrqJ722QS58gnV+88IHX+G/fgu
	 uz6BWEOU5DBVcCkt/EOf8h9A=
Message-ID: <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
Date: Tue, 21 Jan 2025 19:47:24 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Transparent compression with ext4 - especially with zstd
Content-Language: en-US
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <20250121040125.GC3761769@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.01.2025 05:01, Theodore Ts'o wrote:
> On Sun, Jan 19, 2025 at 03:37:27PM +0100, Gerhard Wiesinger wrote:
>> Are there any plans to include transparent compression with ext4 (especially
>> with zstd)?
> I'm not aware of anyone in the ext4 deveopment commuity working on
> something like this.  Fully transparent compression is challenging,
> since supporting random writes into a compressed file is tricky.
> There are solutions (for example, the Stac patent which resulted in
> Microsoft to pay $120 million dollars), but even ignoring the
> intellectual property issues, they tend to compromise the efficiency
> of the compression.
>
> More to the point, given how cheap byte storage tends to be (dollars
> per IOPS tend to be far more of a constraint than dollars per GB),
> it's unclear what the business case would be for any company to fund
> development work in this area, when the cost of a slightly large HDD
> or SSD is going to be far cheaper than the necessary software
> engineering investrment needed, even for a hyperscaler cloud company
> (and even there, it's unclear that transparent compression is really
> needed).
>
> What is the business and/or technical problem which you are trying to
> solve?
>
Regarding necessity:
We are talking in some scenarios about some factors of diskspace. E.g. 
in my database scenario with PostgreSQL around 85% of disk space can be 
saved (e.g. around factor 7).

In cloud usage scenarios you can easily reduce that amount of allocated 
diskspace by around a factor 7 and reduce cost therefore.

You might also get a performance boost by using caching mechanism more 
efficient (e.g. using less RAM).

Also with precompressed files (e.g. photo, videos) you can safe around 
5-10% overall disk space which sounds less but in the area of several 
hundred Gigabytes or even some Petabytes this is a lot of storage.

On evenly distributed data store you can save even more.

The technical topic is that IMHO no stable and practical usable Linux 
filesystem which is included in the default kernel exists.
- ZFS works but is not included in the default kernel
- BTRFS has stability and repair issues (see mailing lists) and bugs 
with compression (does not compress on the fly in some scenarios)
- bcachefs is experimental

Regarding patents: IMHO at least the STAC patents are all no longer 
valid anymore.

Thnx.

Ciao,
Gerhard


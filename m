Return-Path: <linux-ext4+bounces-6117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B38A1223A
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 12:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886AF165198
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB748248BDF;
	Wed, 15 Jan 2025 11:14:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674C236EDC
	for <linux-ext4@vger.kernel.org>; Wed, 15 Jan 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939645; cv=none; b=kzGARqLk9Yl4+LoTEq51NoB5SimKuYZG10rHbYMZG5FWeIucZ3hukM5+jJRyulwNO4M6CpN+hNmbICNUKm2MQpxZi31kCJvvMxCIJctjauAl6chCCZsQ2fCP9Ajf1nZH6ZrGA2//hjWvssFQJCzRGThaHdGdfrK6jQWrbeNWRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939645; c=relaxed/simple;
	bh=vnHtL12CIdiEAuYH/S50GBJct+v7BCturM/Gj3QW9Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BntUSX6FImV82R5sfGByGYCsn4TBlZQ40rQkX0jWOFeU/k46WD1f0ZCxAgqZJOC83cZjllk5H+PzmXS1NxRJSjXCoUnLZ89A64hfmbfaxsWTr1Y07zWoCq0S19TtYaZcNFLYF/gH0MxEiEoqT1xAVS8iRL/RPh6ttQrJKBm5KXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 633C43F1AA;
	Wed, 15 Jan 2025 12:04:06 +0100 (CET)
Message-ID: <8e3e26bb-289d-46ac-958d-7084fb7169a9@hogyros.de>
Date: Wed, 15 Jan 2025 20:04:03 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Two questions on sparse files
To: Andreas Wagner <thewand@web.de>, linux-ext4@vger.kernel.org
References: <f20639eaa10eaa327dc9a294164b731215d5212f.camel@web.de>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <f20639eaa10eaa327dc9a294164b731215d5212f.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/15/25 17:34, Andreas Wagner wrote:

> 1. Do they really - as media and Wikipedia suggest - reduce allocated
> filesize if the file is sparse?

Yes. Unless explicitly requested, blocks are allocated to a file when 
they are first written, and the file size updated at the same time. So 
when you open a file and write 8192 bytes to it, on a file system with 
4096 byte blocksize, the write operation will allocate two blocks and 
set the file size to 8192.

If you seek to an offset of 8192 before writing, then the write will 
still allocate two blocks to hold the data, but the file size is set to 
16384, and the first 8192 bytes read back as zeros. Because no blocks 
have been allocated for this, the allocated file size is now smaller 
than the visible file size, and you have created a sparse file.

So there is no special procedure involved in creating a sparse file, it 
just happens if you're not writing the file from start to finish.

> 2. Are the blocks of the file in random order?

Because block allocation happens when the data is written, there is no 
guarantee that consecutive data in the file is stored in consecutive 
blocks on disk, regardless of whether the file is sparse or not.

If you use a file as backing storage for a virtual machine's harddisk, 
the access patterns involved will likely create a sparse file with 
suboptimal on-disk layout, but the only way to avoid this is to allocate 
the blocks before they are used.

If you want a good chance of getting consecutive blocks, you can use 
posix_fallocate(3) to request that file system blocks be allocated at 
once. This will grow the file to the requested size immediately (you 
cannot have allocated but inaccessible blocks), and since it is a single 
request, there is little chance of interference from other file system 
accesses that may also want to allocate blocks at the same time.

There is no guarantee though. Only LVM exposes allocation policies, if 
your desired performance or some other constraint requires contiguous 
allocation, you need to use a logical volume. For typical use cases, 
using fallocate is sufficient to produce a minimal number of allocations.

    Simon


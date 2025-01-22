Return-Path: <linux-ext4+bounces-6192-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD0A18C49
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 07:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65757A4A20
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43001A9B4E;
	Wed, 22 Jan 2025 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="kEVf+SKG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15119259F
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528449; cv=none; b=J9a6CXIv8uU3usRHbR8S5zJl2P5yBAKW0azv+DHIzNrwgj5yRz9hS4Rj5gVfgeRWlpv4dw0P/smDqZu8NvZx0aEgqGd1Pwramnv8+/V5IFHkoA6xqWUsf6um0PAOfgGkGRZx5FtSBcRIhrIOfYmxPJdAgosKTlkYIuisbz5RP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528449; c=relaxed/simple;
	bh=GfplVllHgoMKWDJ+VN3OfvWTrck0zB83XUJASB9+VmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPfnMKXaBGx3dViAob+Iz7EZRJ2uWCLAEocfMR5aNfol798/0Gl1JvbbIgSwx66mM5ldq+FtYfhxy8SZ6AbLzXCMTarAk81aUSFfdwqYvv0eaw0devF4UWkbsPRqRv+m0iz2N66IgDaJ3g0WL2VbX9G5n4MzUoDhS3Dx/SduM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=fail (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=kEVf+SKG reason="signature verification failed"; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id E71839F1F5;
	Wed, 22 Jan 2025 07:47:24 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 50M6lMFU201365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 22 Jan 2025 07:47:23 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 50M6lMFU201365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1737528443;
	bh=7xncz7kgiowiISMcMLS88ko3f7YyYmuY6grSvSBQAtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEVf+SKGzyOen6pV1/9wu2/EyM+5eXFGXR3OtkuoUmledMnugZNz2mHQVoilwSS8x
	 7bL7Rq2dwrNcHpvwywJ37iHj6pbbrJUxMfwZ+jndrWuffomvveQsDl2gOw9QK0G5oY
	 XqoouzA8/S7neEdV2D1QK5wcXv8ddfJ96Z8wAFwZWE9zv0V9OYl4GUzUbTy6f3GOLe
	 s/WhNVE9OT7CzAWvV9pvGvY5waoUCSkrZrVnPuoX5hTvsroYeFFGtWExqSB9Kq2kh2
	 sCRg6AvA5IzZdx/2D/TovP0MoKWBYLgoZebZDfR2/M7RUFMMEzfPTf8s6OTfGU5mXR
	 LJPwIPYaQJe/UZhgwmx0yDV+1sxOMRXKw9Ezz3V8TdRoqlUBTRfC6tzgZOWxV0Qjcj
	 L0Q76yyde98sBmAZAJaxiSaGNg7YNsgHX2auFGMTYlJsvgKig8t4xgqQ8yG9rVNZ5L
	 RArqxR5n5XwmDuoG0DzddY592Uaq9zKU67R3bqEPY7HDGTyGjWrCgB6v9JOQdywqn5
	 PZCEhERccZCwOmnqLL8Q8lpARUrmmeyNcD6R/d3iyCLDlfCSE8EHy5qqVk/ZhqkClV
	 9XsGo/IxL7e6ANLEICFeLvgld4cRdt40baoXRrx/giFaN3PCwQo0Cy3Dd5aCP17wmW
	 qB+XmS2wFpmhFG15G/4heEJE=
Message-ID: <656f001e-bd9d-4299-9b8a-65efd62714e6@wiesinger.com>
Date: Wed, 22 Jan 2025 07:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Transparent compression with ext4 - especially with zstd
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <Z5AQ_Sq5CdsRb2i-@dread.disaster.area>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <Z5AQ_Sq5CdsRb2i-@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.01.2025 22:26, Dave Chinner wrote:
> On Tue, Jan 21, 2025 at 07:47:24PM +0100, Gerhard Wiesinger wrote:
>> On 21.01.2025 05:01, Theodore Ts'o wrote:
>>> On Sun, Jan 19, 2025 at 03:37:27PM +0100, Gerhard Wiesinger wrote:
>>>> Are there any plans to include transparent compression with ext4 (especially
>>>> with zstd)?
>>> I'm not aware of anyone in the ext4 deveopment commuity working on
>>> something like this.  Fully transparent compression is challenging,
>>> since supporting random writes into a compressed file is tricky.
>>> There are solutions (for example, the Stac patent which resulted in
>>> Microsoft to pay $120 million dollars), but even ignoring the
>>> intellectual property issues, they tend to compromise the efficiency
>>> of the compression.
>>>
>>> More to the point, given how cheap byte storage tends to be (dollars
>>> per IOPS tend to be far more of a constraint than dollars per GB),
>>> it's unclear what the business case would be for any company to fund
>>> development work in this area, when the cost of a slightly large HDD
>>> or SSD is going to be far cheaper than the necessary software
>>> engineering investrment needed, even for a hyperscaler cloud company
>>> (and even there, it's unclear that transparent compression is really
>>> needed).
>>>
>>> What is the business and/or technical problem which you are trying to
>>> solve?
>>>
>> Regarding necessity:
>> We are talking in some scenarios about some factors of diskspace. E.g. in my
>> database scenario with PostgreSQL around 85% of disk space can be saved
>> (e.g. around factor 7).
> So use a database that has built-in data compression capabilities.
>
> e.g. Mysql has transparent table compression functionality.
> This requires sparse files and FALLOC_FL_PUNCH_HOLE support in the
> filesystem, but there is no need for any special filesystem side
> support for data compression to get space gains of up to 75% on
> compressible data sets with the default database (16kB record size)
> and filesystem configs (4kB block size).
>
> The argument that "application level compression is hard, so we want
> the filesystem to do it for us" ignores the fact that it is -much
> harder- to do efficient compression in the filesystem than at the
> application level.
>
> The OS and filesystem doesn't have the freedom to control
> application level data access patterns nor tailor the compression
> algorithms to match how the application manages data, so everything
> the filesystem implements is a compromise. It will never be optimal
> for any given workload, because we have to make sure that it is
> not complete garbage for any given workload...

MySQL/MariaDB isnt't an option for me. But will look into this.

>
>> In cloud usage scenarios you can easily reduce that amount of allocated
>> diskspace by around a factor 7 and reduce cost therefore.
> Same argument: cloud applications should be managing their data
> sets appropriately and efficiently, not relying on the cloud storage
> infrastructure to magically do stuff to "reduce costs" for them.
>
> Remeber: there's a massive conflict of interest on the vendor side
> here - the less efficient the application (be it CPU, RAM or storage
> capacity), the more money the cloud vendor makes from users running
> that application. Hence they have little motivation to provide
> infrastructure or application functionality that costs them money to
> implement and has the impact of reducing their overall revenue
> stream...

Right, therefore we want to make the storage usage as small as possible 
either on appication level or filesystem level.

>> You might also get a performance boost by using caching mechanism more
>> efficient (e.g. using less RAM).
> Not true. Linux caches uncompressed data in the page cache - caching
> compressed data will significantly increase the memory footprint and
> CPU consumption as it has to be constantly uncompressed and
> recompressed as the data changes. This is not a viable caching
> strategy for a general purpose OS.

AFAIK ZFS caches compressed data in the ARC cache. zstd really has a 
very low overhead on decompression with a very good compression ratio 
(even better than gz and bz2).

>> Also with precompressed files (e.g. photo, videos) you can safe around 5-10%
> Video and photos do not compress sufficiently to be a viable runtime
> compression target for filesystem based compression. It's a massive
> waste of resources to attempt compression of internally compressed
> data formats for anything but cold data storage. And even then, if
> it's cold storage then the data should be compressed and checksummed
> by the cold storage application before it is written to the
> filesystem.

ZFS uses with zstd the lz4 "early abort" feature which detects with very 
low CPU ressources that not compression is necessary and aborts the 
compression and stores it uncompressed. If lz4 doesn't abort early, zstd 
compression is used. So there are solutions for low ressource usage.

Reagarding rations: In my case 3%:

zfs list -o name,compressratio,compression big/shares/fotovideo
NAME                  RATIO  COMPRESS
big/shares/fotovideo  1.03x  zstd-3


>
>> The technical topic is that IMHO no stable and practical usable Linux
>> filesystem which is included in the default kernel exists.
>> - ZFS works but is not included in the default kernel
>> - BTRFS has stability and repair issues (see mailing lists) and bugs with
>> compression (does not compress on the fly in some scenarios)
> I hear this sort of generic "btrfs is not stable/has bugs" complaint
> as a reason for not using btrfs all the time.

That's my practical experience. I tried BTRFS several times and failed 
on testing and production. Had a storage topic where some blocks 
(several thousand 4k blocks were damaged). On top several VMs were running.

All other filesystems (XFS, ext4, ZFS, UFS2, ) except BTRFS and bcachefs 
(which is experimental) were repairable to a consistent state (of course 
with some blocks lost).

You can repair BTRFS "forever" without getting it into a consistent state.

A friend of mine had also the experience that it was not mountable and 
crashed immediately after a reboot ...

Find the details here on the mailing list: 
https://marc.info/?l=linux-btrfs&m=172519149923874&w=2

>
> I hear just as many, if not more, generic "XFS is unstable and loses
> data" claims as a reason for not using XFS, too.

I'm not having that experience. But I try to use ext4 primarily as it is 
best for "repair" scenarios.

>
> Anecdotal claims are not proof of fact, and I don't see any real
> evidence that btrfs is unstable.  e.g. Fedora has been using btrfs
> as the root filesystem (and has for quite a while now) and there has
> been no noticable increase in bug reports (either for fs
> functionality or data loss) compared to when ext4 or XFS was used as
> the default filesystem type...

That are not anecdotal claims that's my practical experience that BTRFS 
is not stable and repairable to a consisent state. Reproduceable, you 
can try for yourself.

I'm using Fedora since Fedora FC1 for all production systems.


>
> IOWs, I redirect generic "btrfs is unstable" complaints to /dev/null
> these days, just like I do with generic "XFS is unstable"
> complaints.
>
Try it and you will see it that it is non repairable. You can find 
details and testcase (simulation of what I had on overwriting random 
blocks) in the link.

As with Fedora I'm using latest and "fresh" stable kernel versions as 
well as filesystem utilities. I'm still having that "unrepairable" 
original BTRFS filesystem and will try to repair it to a consistent 
state from time to time. Until now not successful.

Find the details here on the mailing list: 
https://marc.info/?l=linux-btrfs&m=172519149923874&w=2

So you should't redirect the complaints to /dev/null to get BTRFS better :-)

Thnx.

Ciao,

Gerhard



Return-Path: <linux-ext4+bounces-544-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E3881D051
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 00:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EE2B221B6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Dec 2023 23:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5855E33081;
	Fri, 22 Dec 2023 23:06:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from lists.tip.net.au (pasta.tip.net.au [203.10.76.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6833064;
	Fri, 22 Dec 2023 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tip.net.au
Received: from lists.tip.net.au (pasta.tip.net.au [203.10.76.2])
	by mailhost.tip.net.au (Postfix) with ESMTP id 4SxjSL5Zp3z9R3h;
	Sat, 23 Dec 2023 10:00:18 +1100 (AEDT)
Received: from [192.168.2.7] (unknown [101.115.64.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4SxjSK60j3z9QyH;
	Sat, 23 Dec 2023 10:00:16 +1100 (AEDT)
Message-ID: <c4f84de0-ee0e-4e29-a9f5-346823bb3d53@eyal.emu.id.au>
Date: Sat, 23 Dec 2023 10:00:05 +1100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parity raid and ext4 get stuck in writes
To: linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 carlos@fisica.ufpr.br
References: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Content-Language: en-US
From: eyal@eyal.emu.id.au
In-Reply-To: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/12/23 07:48, Carlos Carvalho wrote:
> This is finally a summary of a long standing problem. When lots of writes to
> many files are sent in a short time the kernel gets stuck and stops sending
> write requests to the disks. Sometimes it recovers and finally sends the
> modified pages to permanent storage, sometimes not and eventually other
> functions degrade and the machine crashes.
> 
> A simple way to reproduce: expand a kernel source tree, like
> xzcat linux-6.5.tar.xz | tar x -f -
> 
> With the default vm settings for dirty_background_ratio and dirty_ratio this
> will finish quickly with ~1.5GB of dirty pages in ram and ~100k inodes to be
> written and the kernel gets stuck.
> 
> The bug exists in all 6.* kernels; I've tested the latest release of all
> 6.[1-6]. However some conditions must exist for the problem to appear:
> 
> - there must be many inodes to be flushed; just many bytes in a few files don't
>    show the problem
> - it happens only with ext4 on a parity raid array

This may be unrelated but there is an open problem that looks somewhat similar.
It is tracked at
	https://bugzilla.kernel.org/show_bug.cgi?id=217965

If your fs is mounted with a non-zero 'stripe=' (as RAID arrays usually are),
try to get around the issue with
	$ sudo mount -o remount,stripe=0 YourFS
If it makes a difference then you may be looking at a similar issue.

> I've moved one of our arrays to xfs and everything works fine, so it's either
> specific to ext4 or xfs is not affected. When the lockup happens the flush
> kworker starts using 100% cpu permanently. I have not observed the bug in
> raid10, only in raid[56].
> 
> The problem is more easily triggered with 6.[56] but 6.1 is also affected.

The issue was seen in kernels 6.5 and later but not in 6.4, so maybe not the same thing.

> Limiting dirty_bytes and dirty_background_bytes to low values reduce the
> probability of lockup, probably because the process generating writes is
> stopped before too many files are created.

HTH

-- 
Eyal at Home (eyal@eyal.emu.id.au)



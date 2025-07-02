Return-Path: <linux-ext4+bounces-8780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62345AF5D4F
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075E4A349D
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E32E7BB3;
	Wed,  2 Jul 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b="a5gJLpiR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from apollo.dupie.be (apollo.dupie.be [51.159.20.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE872E7BAF
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.20.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470369; cv=none; b=P6fb6Gqjp2mVLZrbSJMpu7+u1mDBHx23Cb6s9FqJvO9kNfWVOCTRzVvyO+KahOeSvJNHoNU8vaelKiNBgQb18GBYIyWR+59EGK15ZJkMM+DtOsdBrazzOMuWo4RNAELSEN0z+HLcmAmuQBkXokFgOyTMEZ9LVTN4VwEm7G8ZRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470369; c=relaxed/simple;
	bh=Y96G2LREaqNw26lyE4YYwuutmeI4u7TdvVmwVRvP6lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN0cqpZB0moQgFAG0OnpC3KUrTdkEWL/T/yXTLkhegijRxuoXkoVEQ37/1IOejcK45tWDQMiVty+MkyixB2tYCjGi0FtPlS0oS41AFMDtJ75m4ZHKunK+pE0aZNn70yXpYNK1gzwL3ecMaNMt3p9/rI3Dlx1AgIChq8F4+xmYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be; spf=pass smtp.mailfrom=dupond.be; dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b=a5gJLpiR; arc=none smtp.client-ip=51.159.20.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupond.be
Received: from [IPV6:2a02:a03f:fafa:dc01:d858:164:afdb:5295] (unknown [IPv6:2a02:a03f:fafa:dc01:d858:164:afdb:5295])
	by apollo.dupie.be (Postfix) with ESMTPSA id 478001520E66;
	Wed,  2 Jul 2025 17:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
	t=1751470363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6JrXT6MVlEWGGqdsjRZT2hinyGFr9fTp/+7I/mWhOw=;
	b=a5gJLpiRso8VCS3h006wKSGeOU9JWzVruJRTMJA4QVAGE86h+ErjVGp4SPM8keMkq2JAW8
	RQ5B+d6nf8zGW9SD9D+EthlNgpTBcWcM7nULnIZjNH04kaUUw4OINbGIj1MCuFgOIGC/V+
	DReUIG2UfbZKxUtxRLI9Z7yd/RSTLX7rwRSJiaC6h6EQKeh2UKDivghgmkXO/Q0FBZIig3
	LAnoG2BY/uYXtNAVKSpwTKAz2RqTgGIH909Sq0qwdD7rVY03A8ma9L08ZKMWqIbYvx/E8H
	66Ft9t1KktvnqJA5Iqw9jCI79TB1FKxgUn/uN3rzbi90OGIRCPzmhsVKIz/oyQ==
Message-ID: <23e0b748-57b4-452c-9a39-04f941aef996@dupond.be>
Date: Wed, 2 Jul 2025 17:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4 metadata corruption - snapshot related?
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
References: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
 <7b9c7a42-de7b-4408-91a6-1c35e14cc380@dupond.be>
 <20250702143755.GB3471@mit.edu>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20250702143755.GB3471@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/07/2025 16:37, Theodore Ts'o wrote:
> On Wed, Jul 02, 2025 at 03:43:25PM +0200, Jean-Louis Dupond wrote:
>> We updated a machine to a newer 6.15.2-1.el8.elrepo.x86_64 kernel, and the
>> same? bug reoccurred after some time:
>>
>> The error was the following:
>> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
>> inode #44962812: comm imap: deleted inode referenced: 44997932
>> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
>> inode #44962812: comm imap: deleted inode referenced: 44997932
>> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
>> inode #44962812: comm imap: deleted inode referenced: 44997932
>> Jul 02 11:04:03 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
>> inode #44962812: comm imap: deleted inode referenced: 44997932
>>
>> Any idea's on how this could be debugged further?
> If it's correlated to snapshots, then I'd certainly be trying to
> looking at potential bugs on the hypervisor.  We've also had a bug
> where people were trying to look at bugs on the guest kernel, but the
> bug ended up being root caused to a bug on the host kernel.
That is something we are surely investigating.
But for some reason we only see the bug on our CloudLinux machines, not 
on Debian machines (where we have 20 times more of them on the same 
platform).
The fact that it only happens when running snapshots could also be 
related to the small freeze during snapshotting and then causing some 
race somewhere when IO is flushed after the freeze.
>
> If moving from 4.18 Cloudlinux 8 kernel to a 6.15.2 RHEL8 kernel shows
> the same problem, then it does suggest that the problem isn't with the
> guest kernel, but rather in the part of the setup which didn't change
> (e.g., the host kernel and hypervisor).
Well it still shows 'corruption', but the message sometimes differs.
For example previously we also had:
htree_dirblock_to_tree:1036: inode #19280823: comm lsphp: Directory 
block failed checksum

error message etc.

The strange thing here is we only observe ext4 metadata corruption.
For now we didn't had (or see) any corruption within files.
So if it would be a hypervisor issue for example, I would suspect random 
corruption and not only metadata corruption.
>
> Without a whole lot more details about what your workload might be,
> what the host OS software might be, etc., it's really hard to make any
> further suggestions.  Are you running this on some kind of cloud
> infrastructure (e.g., Microsoft Azure, Amazon AWS, Google Cloud, etc?
> Something else?  Have you tried running your workload on some kind of
> alternate infrastructure and see if the problem gets solved if you use
> a different Cloud provider?
The workload is a typical all-in-one webserver with mail and db.
So MySQL/PHP/Apache/Postfix/...
This runs on CloudLinux 8 with the LVE Kernel module (which could be a 
cause also of course).

We are running those VM's on our in-house platform based on Qemu + Libvirt.
The hypervisors are running AlmaLinux 9 with Qemu 9.1.0.

>
> 						- Ted
Thanks for having a look!
Jean-Louis


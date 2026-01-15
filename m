Return-Path: <linux-ext4+bounces-12861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE2D24CB3
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAD63061622
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21413314C2;
	Thu, 15 Jan 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b="e9SrwM7q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from apollo.dupie.be (apollo.dupie.be [51.159.20.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88C246335
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.20.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484820; cv=none; b=juNfWsGU15Z8B5uoab/nyWVKq0ixAc5SSdlAZ0FlpSjUvkVlTU4XxQqBrAmpr19BpknDN54hoMVrX48kiaIMtfeheZ2q3d/riiMt78M815cECM/eTZluFrwMakuclfNRD5Crp/S2+v2J3+2zp4StDvdtTrtnSjOzYaIvLjAtb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484820; c=relaxed/simple;
	bh=lthXyJvdvx72cjOyUsqP9YDAaAkJZgcfevQNrLAVeB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UX/zeh8rMzs8jdNwn56Q5joPykHLmwoz0b/JvrH2alPHBVYURqyc7dh29g/NTP98HvAv9q9nEKM8XNrBaOE60QVO8Zs7fJDIaROw5ZH81+LRvpSf8dzXz29J0Jkb4+yO4z+jpAnLKJxtYCTbAHJBplr/eP1WSCCXq3iOpo8Wtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be; spf=pass smtp.mailfrom=dupond.be; dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b=e9SrwM7q; arc=none smtp.client-ip=51.159.20.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupond.be
Received: from [IPV6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57] (unknown [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
	by apollo.dupie.be (Postfix) with ESMTPSA id 441CD1520BA9;
	Thu, 15 Jan 2026 14:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
	t=1768484353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKEGQNHlkFkFoT1JPHtVSdOuwZtU+eIcdZqAFF63gYU=;
	b=e9SrwM7q5+kkrOmnkwZPH/a9KhVHSYXnCgHWbpROQlAgMOMCoLwxAKgOuXpawBv1xwkpfo
	rfne25cAOBWXMMvWZau95aH+SW9wlg0TTS/8hbW8PyYiHaAw8ZWJjiKhSOeunamGibHj/Y
	6JE0I4jQWiW4jLKX2gggASft2Do1SL+XIAqB5shPvpq+X3wPDq4YLP1y706M2SwTpQbzGr
	pEkzClYm8Jtu1rDZVFHtRrSkHTP1nUjL9QW25Bh8jVhRUPEoiT3638XGPmQciZtxXDCEvB
	QcqsvKntHABXTZ2+b5ANmy3ZbD3IIMlZ2vDlGX/mD/up01nD1eEpZb5exxu5+A==
Message-ID: <dfd63baf-6eb5-435e-afb4-db7ea37b13a1@dupond.be>
Date: Thu, 15 Jan 2026 14:39:12 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4 metadata corruption - snapshot related?
To: Friedrich Weber <f.weber@proxmox.com>, linux-ext4@vger.kernel.org
References: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
 <ce935905-cc96-4a12-8779-5380c535b9b4@proxmox.com>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <ce935905-cc96-4a12-8779-5380c535b9b4@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 14:27, Friedrich Weber wrote:
> Hi,
>
> On 12/06/2025 16:43, Jean-Louis Dupond wrote:
>> Hi,
>>
>> We have around 200 VM's running on qemu (on a AlmaLinux 9 based hypervisor).
>> All those VM's are migrated from physical machines recently.
>>
>> But when we enable backups on those VM's (which triggers snapshots), we notice some weird/random ext4 corruption within the VM itself.
>> The VM itself runs CloudLinux 8 (4.18.0-553.40.1.lve.el8.x86_64 kernel).
> I'm currently looking into an issue that sounds similar (some more details below)
> and wanted to ask: Did you have any luck in debugging this further?
We still haven't found the root cause of this unfortunately.
We thought it could be 
https://gitlab.com/qemu-project/qemu/-/commit/8eeaa706ba73251063cb80d87ae838d2d5b08e9a 
, but that didn't solve it on our end.
> The affected user is running different QEMU+KVM VMs on Proxmox VE on different
> hosts, and occasionally (every few weeks), a VM will report some kind of ext4
> metadata corruption. Two examples from different VMs:
>
> kernel: EXT4-fs error (device dm-1): ext4_validate_block_bitmap:420: comm kworker/u24:3: bg 1923: bad block bitmap checksum
> kernel: EXT4-fs (dm-1): Delayed block allocation failed for inode 15601703 at logical offset 0 with max blocks 517 with error 74
> kernel: EXT4-fs (dm-1): This should not happen!! Data will be lost
Exactly the same as we see.
>
> kernel: EXT4-fs error (device dm-1): ext4_validate_block_bitmap:420: comm logrotate: bg 30: bad block bitmap checksum
> kernel: EXT4-fs error (device dm-1) in ext4_mb_clear_bb:6170: Filesystem failed CRC
>
> Similar to your case, so far no actual data corruption has been noticed.
We have cases where we actually saw (mysql) data corruption.
So we shifted focus a bit towards the qemu part, as it might be caused 
there.
>
> The hosts are on different kernel versions, e.g. downstream kernels based on
> 6.5, 6.11 or 6.14. QEMU versions also differ, some downstream builds are based
> on 9.2.0, some on 10.0.2.
>
> All disks of affected VMs are backed by SAN storages (each VM disk is an LVM LV
> in raw format on top of a LUN accessed via iSCSI+multipath) We initially
> suspected some issue with the SAN and ran some tests in that direction, but so
> far didn't notice anything off.
We had the issue on local storage also. So it's most likely not caused 
by that.
>
> So far, affected VMs have been Ubuntu and Debian VMs, with ext4 on top of LVM.
> Since the issue happens so sporadically, it's difficult to see a pattern
> separating affected/unaffected VMs. As you mention quota as a potential factor,
> I checked some recently affected VMs, none had quota enabled. Disk size doesn't
> seem to be a factor either, some affected disks are ~15GB, some are multi-TB
> disks.
>
> No storage-level snapshots are taken of the VMs, but daily backups are enabled
> (with fsfreeze via qemu-guest-agent).
The backups triggers a snapshot? Cause it all seems to correlate with 
taking a snapshot.
We were already able to reproduce it more quickly by just creating a 
snapshot create/delete loop.
>
> Perhaps there is an unfortunate interaction between host/guest kernel and QEMU
> that could trigger this and that only affects ext4 metadata for some reason?
It also happens without guest agent. So then no fsfreeze is executed.
So then guest should not be aware there was some kind of snapshot taken.
If you do a fsfreeze/fsthaw loop, no corruption is observed.

Might still be some qemu bug after all ... But we will only find out 
when its fixed I believe.
>
> Best wishes,
>
> Friedrich
>
Thanks
Jean-Louis


Return-Path: <linux-ext4+bounces-12860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C367D24C23
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D4A430101E0
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D702397AC0;
	Thu, 15 Jan 2026 13:36:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414920C029
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484207; cv=none; b=Fk5VBpAVkYVV7/I18SmrlL9rVA0qwm+JkKyemg+RJ7MnOEam1B4dV60PqkcSiZk5FFRUMT0z7IIvx4aJtzwAWAgo74i1PvQY4lmpTOtFysyZ701kReuTHBjY6JTkiUdBL0m7LowX4u9/9jOdGpjMwHzrViMUtZDktemoJV5VLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484207; c=relaxed/simple;
	bh=SFhCuWgwwFC2sMbBJbyRK+w4Yrim5JBES9m6vPMWa64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+0QdKzLEJCJW5ZTVsrL+bl018tK5b7ZbN4oGpH4EF7lJJ2LkraN7adlKVdMbe/2+cLFzVaqF0efgcakWFKpGbZ2RSpby2cCjlUCyzvrQYJ4oXVtZqn/ffrzLw1lTVNrT9Os7rZYF+xncF1IY/9EDTPRC53d/LPJeZToqpK60v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9608C4780B;
	Thu, 15 Jan 2026 14:27:48 +0100 (CET)
Message-ID: <ce935905-cc96-4a12-8779-5380c535b9b4@proxmox.com>
Date: Thu, 15 Jan 2026 14:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4 metadata corruption - snapshot related?
To: Jean-Louis Dupond <jean-louis@dupond.be>, linux-ext4@vger.kernel.org
References: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768483619975

Hi,

On 12/06/2025 16:43, Jean-Louis Dupond wrote:
> Hi,
> 
> We have around 200 VM's running on qemu (on a AlmaLinux 9 based hypervisor).
> All those VM's are migrated from physical machines recently.
> 
> But when we enable backups on those VM's (which triggers snapshots), we notice some weird/random ext4 corruption within the VM itself.
> The VM itself runs CloudLinux 8 (4.18.0-553.40.1.lve.el8.x86_64 kernel).

I'm currently looking into an issue that sounds similar (some more details below)
and wanted to ask: Did you have any luck in debugging this further?

The affected user is running different QEMU+KVM VMs on Proxmox VE on different
hosts, and occasionally (every few weeks), a VM will report some kind of ext4
metadata corruption. Two examples from different VMs:

kernel: EXT4-fs error (device dm-1): ext4_validate_block_bitmap:420: comm kworker/u24:3: bg 1923: bad block bitmap checksum
kernel: EXT4-fs (dm-1): Delayed block allocation failed for inode 15601703 at logical offset 0 with max blocks 517 with error 74
kernel: EXT4-fs (dm-1): This should not happen!! Data will be lost

kernel: EXT4-fs error (device dm-1): ext4_validate_block_bitmap:420: comm logrotate: bg 30: bad block bitmap checksum
kernel: EXT4-fs error (device dm-1) in ext4_mb_clear_bb:6170: Filesystem failed CRC

Similar to your case, so far no actual data corruption has been noticed.

The hosts are on different kernel versions, e.g. downstream kernels based on
6.5, 6.11 or 6.14. QEMU versions also differ, some downstream builds are based
on 9.2.0, some on 10.0.2.

All disks of affected VMs are backed by SAN storages (each VM disk is an LVM LV
in raw format on top of a LUN accessed via iSCSI+multipath) We initially
suspected some issue with the SAN and ran some tests in that direction, but so
far didn't notice anything off.

So far, affected VMs have been Ubuntu and Debian VMs, with ext4 on top of LVM.
Since the issue happens so sporadically, it's difficult to see a pattern
separating affected/unaffected VMs. As you mention quota as a potential factor,
I checked some recently affected VMs, none had quota enabled. Disk size doesn't
seem to be a factor either, some affected disks are ~15GB, some are multi-TB
disks.

No storage-level snapshots are taken of the VMs, but daily backups are enabled
(with fsfreeze via qemu-guest-agent).

Perhaps there is an unfortunate interaction between host/guest kernel and QEMU
that could trigger this and that only affects ext4 metadata for some reason?

Best wishes,

Friedrich



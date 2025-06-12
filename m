Return-Path: <linux-ext4+bounces-8396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F8AD7498
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7623B3D59
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328A1A3160;
	Thu, 12 Jun 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b="ET0HjE8w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from apollo.dupie.be (apollo.dupie.be [51.159.20.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229711C7015
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.20.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739854; cv=none; b=otRhujk7lrKRcX3/1qqNDgAmJ/A5661X4NYh0uZtyWiwbir3ZBvgqvLgGIqVLGruPWmvYVPvk2MghfYbuKUMPJ7vCOzml7dbTf8Y/LFDtTh+vKzpjBJ9h8G63njYsLqHWjTBrTWLnoVJaT+3sfqceb7H7pZlVB5u/vuiDoFSQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739854; c=relaxed/simple;
	bh=eadKk0mDVOEU6QzXDQpg30pPt7Wrg16aVbD9/y0CatM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RXR8TpVqSzNP5f7z9fEKqSRxX/012LFawLXHqdq6HG4awrzkRlGAywb/S9MGLYUEJy1ZaU5WQQPeBkCTfdbikH9njA/Om5i1ksPJ0KBlVqQ4mr+5F+Tqkgi0hBji7+942/eMRokwiv52IpvR687k+rikgoHq95w7q8kC82ndbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be; spf=pass smtp.mailfrom=dupond.be; dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b=ET0HjE8w; arc=none smtp.client-ip=51.159.20.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupond.be
Received: from [IPV6:2a02:a03f:fafa:dc01:d858:164:afdb:5295] (unknown [IPv6:2a02:a03f:fafa:dc01:d858:164:afdb:5295])
	by apollo.dupie.be (Postfix) with ESMTPSA id 3B9561520F57
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 16:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
	t=1749739398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IKnrvGOmGJh2sEXYzsi0ev1ZDtvFQJoybGRjwSFx4cE=;
	b=ET0HjE8wJlafVQBaPMcVxGJAcYqVw7nakPEb/wvG5ESDTKXAJky1+QgfQXd/TX3mQLLRWx
	AfIg4+FIJFDihZrPf3+sVLlIjdthu7zpA7ATlL7ivvMXHJZkR1HJFW+yy3kjQkyuYJaLwO
	C4kHuJLfXwZnTIy0b0qq9lE0TIbNOwjmtzbx1BwlqR5zLFvHAZMD88mhaBXVC9f0i05cXo
	7BGpAiMe9ngLn8KsUUXbLGKmXqWP/r4ZjU5NjlJ0u0DpcDb78aRyxwgJ8cqSxqGude/b5d
	2P8iTgupV9575EoJDQ7TH2N5lOw3OYZcYpNK3+AEHRInoB/JNSXiA91O0L9gxQ==
Message-ID: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
Date: Thu, 12 Jun 2025 16:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ext4@vger.kernel.org
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: ext4 metadata corruption - snapshot related?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We have around 200 VM's running on qemu (on a AlmaLinux 9 based hypervisor).
All those VM's are migrated from physical machines recently.

But when we enable backups on those VM's (which triggers snapshots), we 
notice some weird/random ext4 corruption within the VM itself.
The VM itself runs CloudLinux 8 (4.18.0-553.40.1.lve.el8.x86_64 kernel).

This are some examples of corruption we see:
1)
kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1036: inode 
#19280823: comm lsphp: Directory block failed checksum
kernel: EXT4-fs error (device sdc1): ext4_empty_dir:2801: inode 
#19280823: comm lsphp: Directory block failed checksum
kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1036: inode 
#19280820: comm lsphp: Directory block failed checksum
kernel: EXT4-fs error (device sdc1): ext4_empty_dir:2801: inode 
#19280820: comm lsphp: Directory block failed checksum

2)
kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode #49419787: 
comm lsphp: deleted inode referenced: 49422454
kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode #49419787: 
comm lsphp: deleted inode referenced: 49422454
kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode #49419787: 
comm lsphp: deleted inode referenced: 49422454

3)
kernel: EXT4-fs error (device sdb1): ext4_validate_block_bitmap:384: 
comm kworker/u240:3: bg 308: bad block bitmap checksum
kernel: EXT4-fs (sdb1): Delayed block allocation failed for inode 
2513946 at logical offset 2 with max blocks 1 with error 74
kernel: EXT4-fs (sdb1): This should not happen!! Data will be lost
kernel: EXT4-fs (sdb1): Inode 2513946 (00000000265d63ca): 
i_reserved_data_blocks (1) not cleared!
kernel: EXT4-fs (sdb1): error count since last fsck: 1
kernel: EXT4-fs (sdb1): initial error at time 1747923211: 
ext4_validate_block_bitmap:384
kernel: EXT4-fs (sdb1): last error at time 1747923211: 
ext4_validate_block_bitmap:384
kernel: EXT4-fs (sdb1): error count since last fsck: 1
kernel: EXT4-fs (sdb1): initial error at time 1747923211: 
ext4_validate_block_bitmap:384
kernel: EXT4-fs (sdb1): last error at time 1747923211: 
ext4_validate_block_bitmap:384

4)
kernel: EXT4-fs (sdc1): error count since last fsck: 4
kernel: EXT4-fs (sdc1): initial error at time 1746616017: 
ext4_validate_block_bitmap:384
kernel: EXT4-fs (sdc1): last error at time 1746621676: 
ext4_mb_generate_buddy:808


Now as a test we upgraded to some newer (backported) kernel, more 
specificly: 5.14.0-284.1101
And after doing some backups again, we had another error:

kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: inode 
#34752060: comm tar: Directory block failed checksum
kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
inode #34752232: comm tar: No space for directory leaf checksum. Please 
run e2fsck -D.
kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: inode 
#34752232: comm tar: Directory block failed checksum
kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
inode #34752064: comm tar: No space for directory leaf checksum. Please 
run e2fsck -D.
kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: inode 
#34752064: comm tar: Directory block failed checksum
kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
inode #34752167: comm tar: No space for directory leaf checksum. Please 
run e2fsck -D.
kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: inode 
#34752167: comm tar: Directory block failed checksum


So now we are wondering what could cause this corruption here.
- We have more VM's on the same kind of setup, without seeing any 
corruption. The only difference there is that the VM's are running 
Debian, have smaller disks and not doing quota.
- If we disable backups/snapshots, no corruption is observed
- Even if we disable the qemu-guest-agent (so no fsfreeze is executed), 
the corruption still occurs

We (for now at least) only see the corruption on filesystems where quota 
is enabled (both usrjquota and usrquota).
The filesystems are between 600GB and 2TB.
And today I noticed (as the filesystems are resized during setup), the 
journal size is only 64M (could this potentially be an issue?).

The big question in the whole story here is, could it be an in-guest 
(ext4?) bug/issue? Or do we really need to look into the layer below 
(aka qemu/hypervisor).
Or if somebody has other idea's, feel free to share! Also additional 
things that could help to troubleshoot the issue.

Thanks
Jean-Louis


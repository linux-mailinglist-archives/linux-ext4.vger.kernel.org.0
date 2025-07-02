Return-Path: <linux-ext4+bounces-8765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC3AF5A2D
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83B3522127
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0128469A;
	Wed,  2 Jul 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b="NZxlJkyF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from apollo.dupie.be (apollo.dupie.be [51.159.20.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60122155CBD
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.20.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464264; cv=none; b=qF7Q68sYSH8pNrkVkAy2qXl/oOzouv1ZhlrugseFn/B1fXQpfFc47rpTHkfq/56fsrXeXNq6q4yWyHnwKNzNn/LWPw0wdAvBAlMlYTua2BfQkHXUehu73HpHikMmOhlq5GlaAYs5rEnDfjYKsDhkX9lwG2KJE9ntJVjAzS+3G0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464264; c=relaxed/simple;
	bh=GEaXeFvdVsuZnmxzlTdIA/g2tB41gytlNWok7ywd5Ig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=d/OkcHo3qAX2YOebQ12Eyfn0pq92xoeW+tAYZFQyrPTdnS5VcWq+CSPz8c4f/CAu8vwpVYTJ01x6km0CgnXki52iCnCPS/qvIRZSwkiTQZDTdryiHsj0K33LPEfK39XBs5lVq/ZovCNJFO0sSxVeGgACCZbqD7ULPanDcn6kv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be; spf=pass smtp.mailfrom=dupond.be; dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b=NZxlJkyF; arc=none smtp.client-ip=51.159.20.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupond.be
Received: from [IPV6:2a02:a03f:fafa:dc01:d858:164:afdb:5295] (unknown [IPv6:2a02:a03f:fafa:dc01:d858:164:afdb:5295])
	by apollo.dupie.be (Postfix) with ESMTPSA id 76FDF1520E66
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
	t=1751463805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGJk8jPlGt6R5FVC2XZeaeCJmAP5+XVtS10FskLInaU=;
	b=NZxlJkyFkBO5eVZpw2WrTduf5BAvJu0NLkSKUyuqQpEDDyBmt2ladjwHnwaSjvL3fv/jBd
	h+RBeeIa8prshbE8iBKW2nwbnIZ90WsmvNz4wtCtKlqcS5UactPq+OcxYgwEp5oiAuEqFJ
	GF52U/YXoAahCSunW28a3hS3B2jR9crLmu3Gdmf/jIv5ZLvWB/yZenw3HzWNGFcJ8Wt09k
	sXnxqEyWZ3agkTnpHDO2BiBU5FM3k+PORfcTNojtmhBrrfdYxoaQVkSjTOfJm0fpjjOlie
	OP2ciTELpeYoYZ+JrcUeCYpEaQ+FWXF/82kUWdye5nh3/9YANeW6+iSSxXtWdQ==
Message-ID: <7b9c7a42-de7b-4408-91a6-1c35e14cc380@dupond.be>
Date: Wed, 2 Jul 2025 15:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4 metadata corruption - snapshot related?
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: linux-ext4@vger.kernel.org
References: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
Content-Language: en-US, en-GB, nl-BE
In-Reply-To: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

We updated a machine to a newer 6.15.2-1.el8.elrepo.x86_64 kernel, and 
the same? bug reoccurred after some time:

The error was the following:
Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): 
ext4_lookup:1791: inode #44962812: comm imap: deleted inode referenced: 
44997932
Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): 
ext4_lookup:1791: inode #44962812: comm imap: deleted inode referenced: 
44997932
Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): 
ext4_lookup:1791: inode #44962812: comm imap: deleted inode referenced: 
44997932
Jul 02 11:04:03 xxxxx kernel: EXT4-fs error (device sdd1): 
ext4_lookup:1791: inode #44962812: comm imap: deleted inode referenced: 
44997932

Any idea's on how this could be debugged further?

Thanks
Jean-Louis

On 12/06/2025 16:43, Jean-Louis Dupond wrote:
> Hi,
>
> We have around 200 VM's running on qemu (on a AlmaLinux 9 based 
> hypervisor).
> All those VM's are migrated from physical machines recently.
>
> But when we enable backups on those VM's (which triggers snapshots), 
> we notice some weird/random ext4 corruption within the VM itself.
> The VM itself runs CloudLinux 8 (4.18.0-553.40.1.lve.el8.x86_64 kernel).
>
> This are some examples of corruption we see:
> 1)
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1036: 
> inode #19280823: comm lsphp: Directory block failed checksum
> kernel: EXT4-fs error (device sdc1): ext4_empty_dir:2801: inode 
> #19280823: comm lsphp: Directory block failed checksum
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1036: 
> inode #19280820: comm lsphp: Directory block failed checksum
> kernel: EXT4-fs error (device sdc1): ext4_empty_dir:2801: inode 
> #19280820: comm lsphp: Directory block failed checksum
>
> 2)
> kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode 
> #49419787: comm lsphp: deleted inode referenced: 49422454
> kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode 
> #49419787: comm lsphp: deleted inode referenced: 49422454
> kernel: EXT4-fs error (device sdc1): ext4_lookup:1645: inode 
> #49419787: comm lsphp: deleted inode referenced: 49422454
>
> 3)
> kernel: EXT4-fs error (device sdb1): ext4_validate_block_bitmap:384: 
> comm kworker/u240:3: bg 308: bad block bitmap checksum
> kernel: EXT4-fs (sdb1): Delayed block allocation failed for inode 
> 2513946 at logical offset 2 with max blocks 1 with error 74
> kernel: EXT4-fs (sdb1): This should not happen!! Data will be lost
> kernel: EXT4-fs (sdb1): Inode 2513946 (00000000265d63ca): 
> i_reserved_data_blocks (1) not cleared!
> kernel: EXT4-fs (sdb1): error count since last fsck: 1
> kernel: EXT4-fs (sdb1): initial error at time 1747923211: 
> ext4_validate_block_bitmap:384
> kernel: EXT4-fs (sdb1): last error at time 1747923211: 
> ext4_validate_block_bitmap:384
> kernel: EXT4-fs (sdb1): error count since last fsck: 1
> kernel: EXT4-fs (sdb1): initial error at time 1747923211: 
> ext4_validate_block_bitmap:384
> kernel: EXT4-fs (sdb1): last error at time 1747923211: 
> ext4_validate_block_bitmap:384
>
> 4)
> kernel: EXT4-fs (sdc1): error count since last fsck: 4
> kernel: EXT4-fs (sdc1): initial error at time 1746616017: 
> ext4_validate_block_bitmap:384
> kernel: EXT4-fs (sdc1): last error at time 1746621676: 
> ext4_mb_generate_buddy:808
>
>
> Now as a test we upgraded to some newer (backported) kernel, more 
> specificly: 5.14.0-284.1101
> And after doing some backups again, we had another error:
>
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: 
> inode #34752060: comm tar: Directory block failed checksum
> kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
> inode #34752232: comm tar: No space for directory leaf checksum. 
> Please run e2fsck -D.
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: 
> inode #34752232: comm tar: Directory block failed checksum
> kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
> inode #34752064: comm tar: No space for directory leaf checksum. 
> Please run e2fsck -D.
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: 
> inode #34752064: comm tar: Directory block failed checksum
> kernel: EXT4-fs warning (device sdc1): ext4_dirblock_csum_verify:405: 
> inode #34752167: comm tar: No space for directory leaf checksum. 
> Please run e2fsck -D.
> kernel: EXT4-fs error (device sdc1): htree_dirblock_to_tree:1073: 
> inode #34752167: comm tar: Directory block failed checksum
>
>
> So now we are wondering what could cause this corruption here.
> - We have more VM's on the same kind of setup, without seeing any 
> corruption. The only difference there is that the VM's are running 
> Debian, have smaller disks and not doing quota.
> - If we disable backups/snapshots, no corruption is observed
> - Even if we disable the qemu-guest-agent (so no fsfreeze is 
> executed), the corruption still occurs
>
> We (for now at least) only see the corruption on filesystems where 
> quota is enabled (both usrjquota and usrquota).
> The filesystems are between 600GB and 2TB.
> And today I noticed (as the filesystems are resized during setup), the 
> journal size is only 64M (could this potentially be an issue?).
>
> The big question in the whole story here is, could it be an in-guest 
> (ext4?) bug/issue? Or do we really need to look into the layer below 
> (aka qemu/hypervisor).
> Or if somebody has other idea's, feel free to share! Also additional 
> things that could help to troubleshoot the issue.
>
> Thanks
> Jean-Louis


Return-Path: <linux-ext4+bounces-6911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B621A6722D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 12:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7891F3AFDA7
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB62080CF;
	Tue, 18 Mar 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a+VXabAO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81888207E04;
	Tue, 18 Mar 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295995; cv=none; b=bzfjqhNZ0EdZhcKGzhxhinN4T+rXbIA/NXEoaYSq+nMChUFgAxkHoLGe8wWJWZSuUMxIsXPZ3PFB28udPNLxB6gf1kpPIzN957VupciYl8uXEEg4Wf64kRiV+B7rGzTJipB0xVtC2A6YXWMwmb1+XTCfHzU7MvVzpIRs/ylQ3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295995; c=relaxed/simple;
	bh=hMVUaEEnjSIJIhvmV0ga9X3gFvreLO6e2cCWdaEsuuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuvO7ktJOj5gCoZQ+SwZLX2TSDB+tC65L7e3t3g5cmVAu+8wV2PLq4TirNrCc73MiPOTZBlArXNrIi21M00nFoIQmXZjvkUUWD70EaSDY2KsDDpwRuMiltlPdk8u4Uw71OGRohGjFPgMzN/ZSiAbgOGlRVdtW4/83p7l1quwwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=a+VXabAO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oIUPjoMpLh1mrSgGOcxlYJiX3bOq+XLNrKaY6AZKFpA=; b=a+VXabAOj3lUHkzW0kr0/rTb0P
	ROjDUDUCtdEt/zBN0GP/UwvsAxteCF7khY8P3aJLmIPH4zS0HgQQ7EqwLt6yIK8ZIbnSJ2YvKkFUh
	wmvp+mxYSpbQ0tKVAYxU3GsbMmhgV3iCt6n0qPfalZ0F02BtiS8rWt/U/Jn2bib3IEaijG1GcjO+0
	RlOeYg595g2kFsbOcGX37I4cwzYXFq7WKQKgzaio0O482eze2wSxv2W1Yg+33wPbwhgxnxc4UMw6m
	PpExXnSgQV6UBVT8QdUQTd6eYzhE8EKORF0rKJbL5eIQvfQukuhEuV2IzEv0gwCakkX3356r4aSLM
	HhJ0A9jA==;
Received: from [223.233.71.8] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tuUm9-002fjZ-FQ; Tue, 18 Mar 2025 12:06:25 +0100
Message-ID: <61221d19-a8df-4ee0-6123-2abde5eaaadd@igalia.com>
Date: Tue, 18 Mar 2025 16:36:20 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] fs/ext4/xattr: Check for 'xattr_sem' inside
 'ext4_xattr_delete_inode'
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Bhupesh <bhupesh@igalia.com>
Cc: linux-ext4@vger.kernel.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, revest@google.com, adilger.kernel@dilger.ca,
 cascardo@igalia.com
References: <20250128082751.124948-1-bhupesh@igalia.com>
 <20250128082751.124948-3-bhupesh@igalia.com>
 <20250317151728.GC954365@mit.edu>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <20250317151728.GC954365@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ted,

On 3/17/25 8:47 PM, Theodore Ts'o wrote:
> On Tue, Jan 28, 2025 at 01:57:51PM +0530, Bhupesh wrote:
>> Once we are inside the 'ext4_xattr_delete_inode' function and trying
>> to delete the inode, the 'xattr_sem' should be unlocked.
>>
>> We need trylock here to avoid false-positive warning from lockdep
>> about reclaim circular dependency.
>>
>> This makes the 'ext4_xattr_delete_inode' implementation mimic the
>> existing 'ext2_xattr_delete_inode' implementation and thus avoid
>> similar lockdep issues while deleting inodes.
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> This patch is causing a failure of test ext4/026, and also exposed a
> bug in e2fsprogs[1].  With the e2fsprogs bug fixed, the file system
> corruption which is induced by ext4/026 is (when running e2fsck -fn on
> SCRATCH_DEV):
>
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Regular filesystem inode 14 has EA_INODE flag set. Clear? no
>
> Unattached inode 14
> Connect to /lost+found? no
>
> Pass 5: Checking group summary information
>
> /tmp/kvm-xfstests-tytso/vdc.img: ********** WARNING: Filesystem still has errors **********
>
> [1] https://lore.kernel.org/20250317144526.990271-1-tytso@mit.edu
>
> So what appears to be happening is this patch is resulting in ext4/026
> failing to clean up a no-longer-used EA inode, which is unfortunate.
>
> Without the e2fsorigs bug fix, ext4/026 will fail but the error
> message will be much less edifying:
>
> e2fsck 1.47.2 (1-Jan-2025)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> ext2fs_write_inode: Attempt to write to filesystem opened read-only while writing inode 14 in pass4
> e2fsck: aborted
>
> So I'm going to drop this patch (2/2) from the ext4 tree, but I'm
> going to keep patch 1/2 from this series, since it is fixing a real
> bug.  I presume that without this patch, the syzbot reproducer will
> trigger a false lockdep warning, but we can fix that later.

Sure, many thanks for your help.

Regards,
Bhupesh


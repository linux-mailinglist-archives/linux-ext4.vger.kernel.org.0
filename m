Return-Path: <linux-ext4+bounces-11844-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583DC557FF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 04:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046933B03C5
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 03:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8F224D6;
	Thu, 13 Nov 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GUiHs4uc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C73197A7D
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002947; cv=none; b=DE5BJuk93L8XbqLstXOE+DJfS/6mK31Hgh0oyeEKbc0ZDLJdf0CsgVh9EwnmNicd0fWlIpCf9fc8RplRF1tqVE/+p4MeO41XfbKMtHZSfO9RUlMlfA/IkquWt+GBLu0YXtPVXI+SgeMGM/fx5svTa0FeQPTL6fSnOey1r+CYh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002947; c=relaxed/simple;
	bh=K6I9AA9cDKrGRb+qHkoYi7B1fTcIFWKDzN+z4J5gaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r6KPejtIn2OtEhYcZINcITgLBmZ6PYA62PYPhTuDciv9aqW7jdmbTIy4DbMfDVmakfXMOurQpgsTgNAz+Qcpy9emfCSEudRv5pCBJdMQ0KD64RoMXhZAfJJBCw7URDBNWkxSVUQptTrjxO36W4RLuvaweHjO0qn5gq0XL3NWn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GUiHs4uc; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9OvrviWtrCs6FQStPbTwA55305yww4tanbp7OXkVuW0=;
	b=GUiHs4uc2jzPx2piAQtdLUbSbt4fow5aVDD9dFZ6dG8SuUgPsv4KEtEBgf4kmbMRv3QYzU8Z4
	qBLQ+qsZ2MpIyLuMh/540HT0El0gtu1vjWQAUK/Iw2dOYS4IysrhmebD8cwGttbZtebA9FNnwv4
	5qZWbRGd2nBg0FnQhv01kSo=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d6Q4T58ZtzcZyB;
	Thu, 13 Nov 2025 11:00:25 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B775140136;
	Thu, 13 Nov 2025 11:02:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 11:02:15 +0800
Message-ID: <03821d96-78a3-4a49-bf72-7e8bf65a7877@huawei.com>
Date: Thu, 13 Nov 2025 11:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH e2fsprogs] libext2fs: fix orphan file size > kernel limit
 with large blocksize
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
CC: <libaokun@huaweicloud.com>, <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20251112122157.1990595-1-libaokun@huaweicloud.com>
 <20251112183609.GN196358@frogsfrogsfrogs>
 <gqpzieqatnjndg64ui3rwaxzaq4bym34hydf6qnevrbk5jk73n@in4zjfln4ahs>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <gqpzieqatnjndg64ui3rwaxzaq4bym34hydf6qnevrbk5jk73n@in4zjfln4ahs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-13 03:55, Jan Kara wrote:
> On Wed 12-11-25 10:36:09, Darrick J. Wong wrote:
>> On Wed, Nov 12, 2025 at 08:21:57PM +0800, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
>>> limits the maximum supported orphan file size to 8 << 20.
>>>
>>> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
>>> blocks when creating a filesystem.
>>>
>>> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
>>> than the kernel allows, so mount prints an error and fails:
>>>
>>>     EXT4-fs (vdb): orphan file too big: 8650752
>>>     EXT4-fs (vdb): mount failed
>>>
>>> Therefore, synchronize the kernel change to e2fsprogs to avoid creating
>>> orphan files larger than the kernel limit.
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>>>  /*
>>>   * Find reasonable size for orphan file. We choose orphan file size to be
>>> - * between 32 and 512 filesystem blocks and not more than 1/4096 of the
>>> - * filesystem unless it is really small.
>>> + * between 32 filesystem blocks and EXT4_DEFAULT_ORPHAN_FILE_SIZE, and not
>>> + * more than 1/fs->blocksize of the filesystem unless it is really small.
>>>   */
>>>  e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
>>>  {
>>>  	__u64 num_blocks = ext2fs_blocks_count(fs->super);
>>> -	e2_blkcnt_t blks = 512;
>>> +	e2_blkcnt_t blks = EXT4_DEFAULT_ORPHAN_FILE_SIZE / fs->blocksize;
>>>  
>>>  	if (num_blocks < 128 * 1024)
>>>  		blks = 32;
>>> -	else if (num_blocks < 2 * 1024 * 1024)
>>> -		blks = num_blocks / 4096;
>>> +	else if (num_blocks < EXT4_DEFAULT_ORPHAN_FILE_SIZE)
>>> +		blks = num_blocks / fs->blocksize;
>> If the number of blocks in the filesystem is less than the default
>> orphan file size in bytes?  I don't understand that logic, particularly
>> because EXT4_DEFAULT_ORPHAN_FILE_SIZE == 2<<20 == 2097152 == 2 * 1024 *
>> 1024.
> Yeah, these were just more or less ad hoc constants picked by me to make
> sure orphan file doesn't consume too much space and they are unrelated to
> the constant I've picked in the kernel limiting orphan file size. And I
> agree making sure blks isn't larger than EXT4_DEFAULT_ORPHAN_FILE_SIZE
> makes sense but otherwise I don't think we need to change anything here.
>
> 								Honza
>
Okay, in the next version I will revert the changes in
ext2fs_default_orphan_file_blocks(), keep only the check
in ext2fs_create_orphan_file(), and add some comments.


Cheers,
Baokun



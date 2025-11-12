Return-Path: <linux-ext4+bounces-11802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4DC50B37
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 07:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CD39348AE5
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 06:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B12DC348;
	Wed, 12 Nov 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NlA8x3YU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB42D7818;
	Wed, 12 Nov 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928853; cv=none; b=md3Om1iw2v6doYdbhQ50V+D4nijiKU1fcGkUiQhQsPfs0P2PF/AOGMbpVGsMjrxlec3r8egARwS5FXLvIjDxoCx1ABsncNbiWa1BBhtCpO/kimRycdDWfluc398Q7yMRLsAXaXsgCcTP/cjJcQYQpF1RSBHOqNSybSqOegk0x38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928853; c=relaxed/simple;
	bh=s9eFlodwgeafLMC+k9IpaX3BxvXzU+E4w7LZ82PAoyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8R9oVTClDSeFJ/mKoh8FMfYGH+CfGhxWxVkbmgj7MIJp4Pvzox+mnaXHAlROq31kFzAL8CpRh7clDCEHFziFXFDLgaN2/KrsmpjoqCkVvwxtn5kZI+DmwgsSp0BgOW4CPbbStgt7lK6m6lWmOwpKVkENXJ6trhzLj80T7aRi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NlA8x3YU; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mj7+88DMlG12jwejTb95ywDm+ONWgn6IUgAnm79v/0g=;
	b=NlA8x3YUr33sbz4J/iNTpGsfRCeL2xlJvO6Ti13J2tmcw8xo+xarCL2OcS7lqPgptPkHpgYEf
	E7+TTPOLvQ4iaGkXIcdGMhS/6rz6L1d9/eJI+58Gan+M6zKvUvyt1uQCiGV0UnFba3c2bc8KCSL
	hLO8h2clpzfxcJoCj2ULq3g=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d5tgn4JMcz1cyNs;
	Wed, 12 Nov 2025 14:25:41 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CFE01A0188;
	Wed, 12 Nov 2025 14:27:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 14:27:20 +0800
Message-ID: <21efa577-a577-48ce-a82b-bce446539fba@huawei.com>
Date: Wed, 12 Nov 2025 14:27:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Content-Language: en-GB
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>
References: <20251112040220.GO2988753@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251112040220.GO2988753@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-12 12:02, Theodore Ts'o wrote:
> On Wed, Nov 12, 2025 at 10:19:06AM +0800, Baokun Li wrote:
>> I am using a slightly older version of xfstests, and when running the
>> 64k tests I also encountered similar failures. The cover letter stated
>> "no Oops" for the 64k tests rather than "no new failures," meaning that
>> some cases did fail, but no severe issues such as BUG_ON or softlock
>> were observed.
> Sorry, I misread your cover letter.  It's good you are seeing similar
> failures.

Sorry, my description wasn’t clear enough.

>
>
> On Wed, Nov 12, 2025 at 10:49:19AM +0800, Baokun Li wrote:
>> I checked the code of the swapon syscall in mm/swapfile.c, and currently
>> the swapfile does not support LBS. Therefore, some failing test cases can
>> be filtered out based on this.
> Ah, OK. What's happening is with XFS the swap tests are being skipped
> automatically if the swapon fails.  From _require_scratch_swapfils:
>
> 	*)
> 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> 			_scratch_unmount
> 			_notrun "swapfiles are not supported"
> 		fi
> 		;;
>
>
> But ext4 has different logic:
>
> 	# ext* has supported all variants of swap files since their
> 	# introduction, so swapon should not fail.
>
> << famous last words >>
😄
>
> 	case "$FSTYP" in
> 	ext2|ext3|ext4)
> 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> 			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
> 				_scratch_unmount
> 				_notrun "swapfiles are not supported"
> 			else
> 				_scratch_unmount
> 				_fail "swapon failed for $FSTYP"
> 			fi
> 		fi
> 		;;
>
>
> I guess we could add logic to _require_scratch_swapfile in common/rc
> to also _notrun if swapon fails and block size is greater that page
> size.  Or I might just add an exclusion in my test appliance runner
> for now for all tests in group swap.

Darrick’s reply in another thread has already made a similar change,
so we can apply that patch first for testing.


Cheers,
Baokun



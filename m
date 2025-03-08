Return-Path: <linux-ext4+bounces-6715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C871EA57718
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7EA17826F
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576EADDCD;
	Sat,  8 Mar 2025 01:09:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D2F30;
	Sat,  8 Mar 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396183; cv=none; b=VP7lFLX+47vYv2s4sSpIGyTtcFh4Klt70Y6N5jnAaqdOVI1H2GDYPzdiYRP8Vi63XT0nWy6Ep8pS6OaUWKZP8VxjD9wLW1DS1Wo2+HwIqVWEs2QzV+9HQw/FlNDWA9SBIsgRgNxZFwb7NOuyjfKaNXaWwt8IIc5Cre1B5yYdYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396183; c=relaxed/simple;
	bh=XoL3MCMqaSyBFiZUsFNBsRSZqQJXhK/OZFNeft7zbI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSrJhwi5Va9ALj3aOh8f4XlFCBc+qRtyzrDM6mR1JZfb46nNFDy/pbcyj++VlSIGwhloeHEqEr8BrdI41PEcckyCjLXrICVYpqJIYs+xLWL1lyzlf4TW8cNMSLFnJSsHMaAstoe0Zc/su9rmccq1aqNGpmh/ONl37iTUEWVZqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z8lSW4jQcz17NTH;
	Sat,  8 Mar 2025 09:10:03 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 86E241402CC;
	Sat,  8 Mar 2025 09:09:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Mar
 2025 09:09:28 +0800
Message-ID: <692ab4aa-ff90-4b6f-980d-bfd6c1ca7619@huawei.com>
Date: Sat, 8 Mar 2025 09:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix a BUG_ON crashing the kernel in
 start_this_handle
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <cover.1741270780.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> ** Changes since v1 [1] **
>
>   * Picked up RVBs from Jan and Ritesh
>   * In patch 2/3, we now use a flag in sbi instead of SB_ACITVE
>     to determine when to journal sb vs when to commit directly.
>   * Added a prep patch 1/3
>
> [1] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#m5e659425b8c8fe2ac01e7242b77fed315ff89db4
>
> @Baokun, I didn't get a chance to look into the journal_inode
> modifications we were discussing in [2]. I'll try to spend some time and
> send that as a separate patch. Hope that's okay
>
> [2] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#mad8feb44d9b6ddadf87830b92caa7b78d902dc05
>   
That's fine, it's not a priority. And if this patch set makes sure we
don't crash when things go wrong, I'm okay with leaving it as is.

It's possible that jbd2_journal_commit_transaction() could call
ext4_handle_error() in other places as the code evolves. Fixing known
problems and protecting against potential ones is always a good thing.


Cheers,
Baokun
> ** Original Cover **
>
> When running LTP stress tests on ext4, after a multiday run we seemed to
> have hit the following BUG_ON:
>
>   [NIP  : start_this_handle+268]
>   #3 [c000001067c27a40] start_this_handle at c008000004d40f74 [jbd2]  (unreliable)
>   #4 [c000001067c27b60] jbd2__journal_start at c008000004d415cc [jbd2]
>   #5 [c000001067c27be0] update_super_work at c0080000053f9758 [ext4]
>   #6 [c000001067c27c70] process_one_work at c000000000188790
>   #7 [c000001067c27d20] worker_thread at c00000000018973c
>   #8 [c000001067c27dc0] kthread at c000000000196c84
>   #9 [c000001067c27e10] ret_from_kernel_thread at c00000000000cd64
>
> Which comes out to
>
>    382   repeat:
>    383           read_lock(&journal->j_state_lock);
> * 384           BUG_ON(journal->j_flags & JBD2_UNMOUNT);
>    385           if (is_journal_aborted(journal) ||
>    386               (journal->j_errno != 0 && !(journal->j_flags & JBD2_ACK_ERR))) {
>    387                   read_unlock(&journal->j_state_lock);
>
>
> Initially this seemed like it should never happen but upon crash
> analysis it seems like it could indeed be hit as described in patch 1/2.
>
> I would like to add that through the logs we only knew that:
>
> - ext4_journal_bmap -> ext4_map_blocks is failing with EFSCORRUPTED.
> - update_super_work had hit the BUG_ON
>
> I was not able to hit this bug again (without modifying the kernel to
> inject errors) but the above backtrace seems to be one possible paths
> where this BUG_ON can be hit. Rest of the analysis and fix is in patch
> 2/3. Patch 3 is just a small tweak that i found helpful while debugging.
>
> That being said, journalling is something I'm not very familiar with and
> there might be gaps in my understanding so thoughts and suggestions are
> welcome.
>
> Ojaswin Mujoo (3):
>    ext4: define ext4_journal_destroy wrapper
>    ext4: avoid journaling sb update on error if journal is destroying
>    ext4: Make sb update interval tunable
>
>   fs/ext4/ext4.h      | 11 +++++++++++
>   fs/ext4/ext4_jbd2.h | 22 ++++++++++++++++++++++
>   fs/ext4/super.c     | 35 +++++++++++++++++------------------
>   fs/ext4/sysfs.c     |  4 ++++
>   4 files changed, 54 insertions(+), 18 deletions(-)
>



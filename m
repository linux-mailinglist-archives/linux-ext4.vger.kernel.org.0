Return-Path: <linux-ext4+bounces-8710-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606CAEE1D7
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0533A70EA
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286B28D8C8;
	Mon, 30 Jun 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5FcmFti"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CE28C2C7;
	Mon, 30 Jun 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295705; cv=none; b=NImeCTZVwcoW6wu3vBFWEpYsVZm96blYIlW9KY7dozCG7dIPkkT1hKReIRZB8qoA4zmvokkkLMMXc0GWZgsoOn7aQH0r9PgpcBbV9J7zkdr/0trYSuX7AedHocr1V4bkZbaV2WfzFjNYj6z10eDck/TunN/RGkwAmpZWk86hKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295705; c=relaxed/simple;
	bh=w9MfvAx89K2O+0I4paKkLnEviET5iBYuUnorptpspYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/D1uKpCNNn7tNBFPMjNWkW6rkUOGntngCtWD3M+Yr2TePEuMNkvrM72NnGnbigyzeqgcGagONlXu97FDVL8Z9aOrkk9UeeceT/VZZd6r4EviR6BwInns7rTmxLC2hSy04dsCRsGdR8ngsWVtAYEprZCkvOwmUzD1fet1q5HOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5FcmFti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C31C4CEEF;
	Mon, 30 Jun 2025 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751295703;
	bh=w9MfvAx89K2O+0I4paKkLnEviET5iBYuUnorptpspYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5FcmFtieBiJOPPwvbDM1N3cU/8xhfwzu4R42Xgstoziz4zDO7rWdpwi5NbESRFRO
	 UddIslKFqyfm5miuUeAZ7KZMyhQ4GCCNwtw+RQHdM7Hdz+BGPAsBL1StD5q2d8huq0
	 qySJaTxlZMLbvxhFneERTyy5jfVgUaBdFeuZ2GPv0EuhC81mxk0bVzwGv8Town74rr
	 D2Ms5cQroYjjH9S+VrmuTr5UoGcWI+6vFI0f7sXOcSPByTGST6XcDh6Ph9P6nN0Ysh
	 zvy81nFBa3wcvf36m752033ECUHhznyV+7c+8LMwsmrSc14j3WOlJPIUSxzFpV/O7n
	 RPwUSRw6tKlnQ==
Date: Mon, 30 Jun 2025 11:01:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: fix JBD2 credit overflow with large folios
Message-ID: <aGKm1W71BP636aWd@lappy>
References: <20250630131324.1253313-1-sashal@kernel.org>
 <0d7b0731-88c3-4114-a401-e6aa8a085c5f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0d7b0731-88c3-4114-a401-e6aa8a085c5f@huaweicloud.com>

On Mon, Jun 30, 2025 at 09:58:52PM +0800, Zhang Yi wrote:
>On 2025/6/30 21:13, Sasha Levin wrote:
>> When large folios are enabled, the blocks-per-folio calculation in
>> ext4_da_writepages_trans_blocks() can overflow the journal transaction
>> limits, causing the writeback path to fail with errors like:
>>
>>   JBD2: kworker/u8:0 wants too many credits credits:416 rsv_credits:21 max:334
>>
>> This occurs with small block sizes (1KB) and large folios (32MB), where
>> the calculation results in 32768 blocks per folio. The transaction credit
>> calculation then requests more credits than the journal can handle, leading
>> to the following warning and writeback failure:
>>
>>   WARNING: CPU: 1 PID: 43 at fs/jbd2/transaction.c:334 start_this_handle+0x4c0/0x4e0
>>   EXT4-fs (loop0): ext4_do_writepages: jbd2_start: 9223372036854775807 pages, ino 14; err -28
>>
>> Call trace leading to the issue:
>>   ext4_do_writepages()
>>     ext4_da_writepages_trans_blocks()
>>       bpp = ext4_journal_blocks_per_folio() // Returns 32768 for 32MB folio with 1KB blocks
>>       ext4_meta_trans_blocks(inode, MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp)
>>         // With bpp=32768, lblocks=34815, pextents=32768
>>         // Returns credits=415, but with overhead becomes 416 > max 334
>>     ext4_journal_start_with_reserve()
>>       jbd2_journal_start_reserved()
>>         start_this_handle()
>>           // Fails with warning when credits:416 > max:334
>>
>> The issue was introduced by commit d6bf294773a47 ("ext4/jbd2: convert
>> jbd2_journal_blocks_per_page() to support large folio"), which added
>> support for large folios but didn't account for the journal credit limits.
>>
>> Fix this by capping the blocks-per-folio value at 8192 in the writeback
>> path. This is the value we'd get with 32MB folios and 4KB blocks, or 8MB
>> folios with 1KB blocks, which is reasonable and safe for typical journal
>> configurations.
>>
>> Fixes: d6bf294773a4 ("ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hi, Sasha!
>
>Thank you for the fix. However, simply limiting the credits is not enough,
>as this may result in a scenario where there are not enough credits
>available to map a large, non-contiguous folio. I've been working on this
>issue[1] and I'll release v3 tomorrow if my tests looks fine.
>
>[1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/

Ah perfect, I haven't seen your work, thank you for that.

Please ignore my patch.

-- 
Thanks,
Sasha


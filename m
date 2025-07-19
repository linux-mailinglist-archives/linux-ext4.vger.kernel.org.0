Return-Path: <linux-ext4+bounces-9117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2477B0B1FD
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8CD3A2DE2
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EA193079;
	Sat, 19 Jul 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LcuCEes6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756B8BF8
	for <linux-ext4@vger.kernel.org>; Sat, 19 Jul 2025 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961594; cv=none; b=bes+ijqyaIfpnrxblyUu9WOSR/dR9Ihn18mfSCR1uxQZZVhgxbkcCzjX31dDcbr6Qb//ca3T7n7oZ4k71eSjjGRyoAiUVTUlJrRttOtkzn6XlimGAMwPDmriQlHxSFADeme+bqdr6OJCynA/xkZRkSvZ4bT9mN4wagM5mA0Cwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961594; c=relaxed/simple;
	bh=MHiCBSNW2MSFaHp6WYlTcmRAzoi6mLH81cnRX91BgmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxH7nEUEEVBLMW7tU0++hJyAv7tt088q/wOd7ces3HdcRhBIcbNQoglGEUQFmQNgc7pjhbH/69e850bpuPNogGDy4fqcklHgxr6YoiWLT/Ig28YLw1L3xdR0e5scqZLGRLKdbLbK+14uepdg9MrsiHbC1EgqiG0VCuCvoWDJRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LcuCEes6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1TI009671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961565; bh=oDA/2owfp3b6eC4ZauUySYEg3jK5MAbzenIvtYlz4FY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LcuCEes6Uyfj+vMutj4fho0k8zWkR9G9Cbq6XwIE8D7Cz3wgnt7FVb+BYipmHZl0a
	 rxW2XLTQjjUWzWbS/ZTYkYSTeeDqCfqQyZPP0KUYVkQDPKGWFpy/AtRaGtOpLnkKXq
	 R3NbpFxLSBjzj9c8m1e/1GNY83XrvnbYoSuuinDeAIdYhek5vL5K33FTgaSiOJMpxb
	 iSjkB8GPk6Sv56ktHd4fWj2aYO+oghsnkmJSjEyPu6Vq372yiLfLg67/kc10hKq+7j
	 hu9A8VPKsr79uKHCHRdS0k1i+3fs68Ynd3pGTObvDJuDmRxea/W6CLbArnDd4mqZlf
	 v8CO5ZsGOvg1w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 22B022E00D7; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: fix inode use after free in ext4_end_io_rsv_work()
Date: Sat, 19 Jul 2025 17:45:54 -0400
Message-ID: <175296153001.397842.8711554475973554905.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708111504.3208660-1-libaokun@huaweicloud.com>
References: <20250708111504.3208660-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Jul 2025 19:15:04 +0800, libaokun@huaweicloud.com wrote:
> In ext4_io_end_defer_completion(), check if io_end->list_vec is empty to
> avoid adding an io_end that requires no conversion to the
> i_rsv_conversion_list, which in turn prevents starting an unnecessary
> worker. An ext4_emergency_state() check is also added to avoid attempting
> to abort the journal in an emergency state.
> 
> Additionally, ext4_put_io_end_defer() is refactored to call
> ext4_io_end_defer_completion() directly instead of being open-coded.
> This also prevents starting an unnecessary worker when EXT4_IO_END_FAILED
> is set but data_err=abort is not enabled.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix inode use after free in ext4_end_io_rsv_work()
      commit: c678bdc998754589cea2e6afab9401d7d8312ac4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


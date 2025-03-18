Return-Path: <linux-ext4+bounces-6858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4AA667A2
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100B93B59F6
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5721CCB21;
	Tue, 18 Mar 2025 03:42:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413C1C6FFA
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269333; cv=none; b=C6l1mQjxS9g1FqZenauGvYiTZTfvma12M9Jwnh3m/9OHYY5diroMeBpjFCMsTZmh5QJTHTXqw3LcM8Vs9A0EpUICTZUInHq95yRyKcwwmPo9fcEegQhT5ZT3HPkqxsmDF4selnlsQRBB0bcXKw9C5KD4J0UDNFcDAbpaJ3If9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269333; c=relaxed/simple;
	bh=GrWM37g8fr6c8W93iOM2ekIcu4MYclPaSvyhQRM595g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK9PHHScOZB/VeQmfc3zd0UJoCiHYvioQuoTptL6tU3b9RH4AVOS5ko30chOoyxus9m1GAevtIRDvS+Z80WNw4dHhwIVWu74rRVRaPf8phjoMD3De4eDO+Z+oxiHY3I3cx+bLoj606IcYvexiN2fvIaVM6mVhLus4CEfxaa50gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fm4l012144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E45FC2E0115; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v3 0/9] ext4: fix issues caused by data write-back failures
Date: Mon, 17 Mar 2025 23:41:23 -0400
Message-ID: <174226639132.1025346.12727969246066778652.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250122110533.4116662-1-libaokun@huaweicloud.com>
References: <20250122110533.4116662-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 22 Jan 2025 19:05:24 +0800, libaokun@huaweicloud.com wrote:
> Changes since v2:
>  * Add patch 6.
>  * Patch 4: Use the new name ext4_has_journal_option().
>  * Patch 5: Use the new name EXT4_IO_END_DEFER_COMPLETION and
>             ext4_io_end_defer_completion().
>  * Collect RVB from Jan Kara and Zhang Yi.(Thanks for your review!)
> 
> [...]

Applied, thanks!

[1/9] ext4: replace opencoded ext4_end_io_end() in ext4_put_io_end()
      commit: 2f94b537c48db155f5aa68d63b747f9d82248341
[2/9] ext4: do not convert the unwritten extents if data writeback fails
      commit: e856f93e0fb249955f7d5efb18fe20500a9ccc6d
[3/9] ext4: reject the 'data_err=abort' option in nojournal mode
      commit: 26343ca0df715097065b02a6cddb4a029d5b9327
[4/9] ext4: extract ext4_has_journal_option() from __ext4_fill_super()
      commit: b1a49bd8132089ff84a96fc2508fd18731fe5690
[5/9] ext4: abort journal on data writeback failure if in data_err=abort mode
      commit: ce51afb8cc5e1867ea0dfdf5e92ddbe31a1fad5d
[6/9] jbd2: drop JBD2_ABORT_ON_SYNCDATA_ERR
      commit: 6e969ef3d7cff494118205c85a21e05b046ac6c6
[7/9] ext4: update the descriptions of data_err=abort and data_err=ignore
      commit: 62c3da1eaccac4b184981ca394b3c870121f286b
[8/9] ext4: remove unused member 'i_unwritten' from 'ext4_inode_info'
      commit: 5a1cd0e975c75d4292a9d93e00c84d40b6c0b114
[9/9] ext4: pack holes in ext4_inode_info
      commit: bd29881aff6db23f0acde1a6c28c19017fd3115a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


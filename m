Return-Path: <linux-ext4+bounces-6856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF19A66798
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A44E176A5E
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18941C5D58;
	Tue, 18 Mar 2025 03:42:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD91C173D
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269330; cv=none; b=ot94vIVegS5SzEWi05T42H0Ux22vl13kREyHLrotqPRuvHg87vmsyh6EuV3cfP5AhLc6lkOu/2YoamZ5ViTh0Vx2R0EgPZ51rJJtFXnwACnTZd2NvJ0vDMQ8VNACRHxfCsWbrhw8ZZj8FtAHnSqO77pOXR2tCHX9QfBwrzjBjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269330; c=relaxed/simple;
	bh=lYjJIy5xT7t6GlnklDUYaxbUNJnjnqxiNt6Jaq9kfqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiOjKMfPJG8iS+QEWXwN782JBpLharnV7pICH6RJROltJBcYbJsgbohH/gi1+P/mceKe+OOf8ONzzMgk1a57NmlEZ/8TZufujMhds9CcZ45gXOFjU1VSMUQA1EIEhqHgBh3NarxOvxP1/NKXbxbmhnLYfgP+WHDfrs+oZgYWrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fmEq012145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E15A12E0114; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 0/7] ext4: correct behaviors under errors=remount-ro mode
Date: Mon, 17 Mar 2025 23:41:22 -0400
Message-ID: <174226639132.1025346.7866968818864119556.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 22 Jan 2025 19:41:23 +0800, libaokun@huaweicloud.com wrote:
> Changes since v1:
>  * Patch 1,2: Add comma after the last enum member.
>  * Patch 3: Rename ext4_is_emergency() to ext4_emergency_state().
>  * Patch 4: Instead of adding an ext4_sb_rdonly() helper, add additional
>             ext4_emergency_state() checks.
>  * Patch 5: Replace sb_rdonly() with ext4_emergency_ro() in
>             ext4_handle_error() and keep the SB_RDONLY comments.
>  * Collect RVB from Jan Kara and Zhang Yi.(Thanks for your review!)
>  * Rebased on link[2] to avoid context conflicts with Patch 3.
>   (ext4_forced_shutdown() -> ext4_emergency_state() in ext4_end_io_end()).
> 
> [...]

Applied, thanks!

[1/7] ext4: convert EXT4_FLAGS_* defines to enum
      commit: 99708f8a9d30081a71638d6f4e216350a4340cc3
[2/7] ext4: add EXT4_FLAGS_EMERGENCY_RO bit
      commit: f3054e53c2f367bd3cf6535afe9ab13198d2d739
[3/7] ext4: add ext4_emergency_state() helper function
      commit: 0a1b2f5ea98764221ccc1043b8dc27a8c0225476
[4/7] ext4: add more ext4_emergency_state() checks around sb_rdonly()
      commit: 5bc27f4d73d3dadc5c71fb47ea741d31d92f41b1
[5/7] ext4: correct behavior under errors=remount-ro mode
      commit: 8f984530c242c569bafecfa35bce969a9b8fb0dd
[6/7] ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
      commit: 6b76715d5e41fc332b0b879e66fad6ef3db07a3f
[7/7] ext4: show 'shutdown' hint when ext4 is forced to shutdown
      commit: 5855c3519463e9ac4d10424bb49953047a04c602

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


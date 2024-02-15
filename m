Return-Path: <linux-ext4+bounces-1249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D259C856896
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 16:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912BE285783
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8013343E;
	Thu, 15 Feb 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y3EeusM2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDC12DD9A
	for <linux-ext4@vger.kernel.org>; Thu, 15 Feb 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012522; cv=none; b=q8hZybKCv9IVYkZiPtR3Phs2Mc7GZBwq5asAAZ9w8Mlv/ElxwCKaTLeRj+Q9JDB13JJWxvvkxbMNBxuKyJXxDGGC3wVj8TtKBLIo7NCsITYUkkIzV6aYy7UFYv90mBzJFzkO047OAsTipiKMzFmTrb7bBFHJJzEwSeaz4zhT3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012522; c=relaxed/simple;
	bh=GMId7W0PrQ0whWmPApxgCiHvZzi6kkCj7omfHgTU/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G28OVj6jmHU2W7j6NuWdQRyPwJRlU0ABH+fvNLitgHEu0I58NHIBcro+WgcRD5bEEoQTUQdFKaUVtRkmYWEzfZKCtDEqPQVW1MKTbuE8NvOoNBykWIgnT3xycyuIw7Q814IlfEzyMH/0wFhyzsZE2okbhcXdHQW5vOHyYigEVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y3EeusM2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41FFskfV022770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708012489; bh=vDaxyTl3C7Q+Aro2Gof7P0Cntk+LnNVRNpHp28P5C1w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Y3EeusM2fVH4C9e4100wnMKEBRCq+GqFzQx26fl+BjeNBvppxW/RFX1sS1CtiPFQ6
	 gea3soxuBmt6vdKB6sdA/5DRDcGkHgCfCg8XniDs+gIu2li+MHS3xRjL7tGFMwIo4I
	 se5jHPQA6J+R54JXcV+3r6OgpAwnXwQ3qxwH9lv5OiwK2Xb5Daz3/YCtcnQSIgbaT5
	 9QaFjncp6gOziTQUNsteMgLm5U7MW5t8Sv8a7eNiW3hpW3C2l95/j6xWa1q+M7XqG3
	 SNdpE53VBFVUpZHIq4QyKZHr58b6nlE3C3e9UvWd86NcvhTpTqb4qBPytwntKMRf/k
	 YCJihj6u3H2cA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B068415C0336; Thu, 15 Feb 2024 10:54:46 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@whamcloud.com,
        Jan Kara <jack@suse.cz>, linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, libaokun1@huawei.com
Subject: Re: [PATCH] tune2fs: check whether filesystem is in use for I_flag and Q_flag test
Date: Thu, 15 Feb 2024 10:54:36 -0500
Message-ID: <170801246691.553311.17221609995584467282.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <28455341-ca26-d203-8b54-792bae002251@huawei.com>
References: <28455341-ca26-d203-8b54-792bae002251@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 Mar 2023 13:04:34 +0800, Zhiqiang Liu wrote:
> For changing inode size (-I) and setting quota fearture (-Q), tune2fs
> only check whether the filesystem is umounted. Considering mount
> namepspaces, the filesystem is umounted, however it already be left
> in other mount namespace.
> So we add one check whether the filesystem is not in use with using
> EXT2_MF_BUSY flag, which can indicate the device is already opened
> with O_EXCL, as suggested by Ted.
> 
> [...]

Applied, thanks!

[1/1] tune2fs: check whether filesystem is in use for I_flag and Q_flag test
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


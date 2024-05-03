Return-Path: <linux-ext4+bounces-2275-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8388BA5E0
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 06:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80BC1F2291D
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7395208D4;
	Fri,  3 May 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="j3nrADLd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9018C22
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708942; cv=none; b=frfSfcZ7wXxcKzP8/EUAY1Wga9UAw5BwU27z8guZaRRwUN6m6ghIwoF4UZ7zUeZ+AD42w+QZYkNEafA+xyDnE0DCcYi/bRoV0kMT6wFfuXxQERRTg+phCUC2X8qPFeIr+tLszvzm2v4cJnYdsjNFHqHyvc6+l/7wWvyCkuq3eCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708942; c=relaxed/simple;
	bh=PumxDRHyHX7yBdHa2tlF1tUV5lC/cGgMQLp3mZF0ufE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGs8xXWav83oico2qkm9xDJDJ9KYpwZ32VpBgpfYfWYDxSOYIlitpydCSOEt+n5BhIi1XldKxOCjSf1XDuomJUR1/y7pW8j0r+ECpNEDHgaSugwe9NEGIxHA3kDLXJ8QzixOI1306EDe3TrkCOFgxoEioT5OX3QklDWm4OGTTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=j3nrADLd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44341pnQ020174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714708914; bh=o48wK3kfm/cWNdCnI+3ZfLeQp4GGmXLq5cg2NGf3u+s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=j3nrADLdlY9ZBrzmgUgIeJrjDvgyCOtKqul6jRQy+vkTzNsdczoYzldVoaDBzU+6p
	 EmbbnG1DK8M3C6RDvqvJsk7D0xJefRYsaOe1U9ktxUqsearzue43fFa+nRsulH9nWu
	 xnYuq6Ox47Rk+EAFbNDBWvRqFsmj5zJaFXyN9gIQY38USqSrTlVG6XOHY77D6zBn2R
	 ZZzoWTXcgwRWi4jzFKHhN4TtteY7wuHuoYWGVHzLNoLTon0vdKtIwQ862cb9bHJ2rZ
	 5fMD5Cw1TJvXm+bX86ZDOpf1gxu5PQVfBa+tN2M4DzqpDLW7WCc82sSwRxXmncAxOA
	 tmJtIpS0yhjiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 83D7515C02BD; Fri,  3 May 2024 00:01:51 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing BUG_ON/SOOB
Date: Fri,  3 May 2024 00:01:48 -0400
Message-ID: <171470889035.3010818.10968009452859195191.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319113325.3110393-1-libaokun1@huawei.com>
References: <20240319113325.3110393-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Mar 2024 19:33:16 +0800, Baokun Li wrote:
> This patchset is intended to avoid variables that can be modified via sysfs
> from overflowing when stored or used and thus causing various problems.
> 
> "kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.
> 
> V3->V4:
>   Patch 4: Corrects WARN_ON_ONCE added in V3.
> 
> [...]

Applied, thanks!

[1/9] ext4: avoid overflow when setting values via sysfs
      commit: 9e8e819f8f272c4e5dcd0bd6c7450e36481ed139
[2/9] ext4: refactor out ext4_generic_attr_store()
      commit: f536808adcc37a546bf9cc819c349bd55a28159b
[3/9] ext4: refactor out ext4_generic_attr_show()
      commit: 57341fe3179c7694c92dcf99e7f836cee4c800dd
[4/9] ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()
      commit: 13df4d44a3aaabe61cd01d277b6ee23ead2a5206
[5/9] ext4: add new attr pointer attr_mb_order
      commit: b7b2a5799b8fafe95fcd5455c32ba2c643c86f99
[6/9] ext4: add positive int attr pointer to avoid sysfs variables overflow
      commit: 63bfe841053f8dda09c9d059d543486d9dc16104
[7/9] ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
      commit: 9a9f3a9842927e4af7ca10c19c94dad83bebd713
[8/9] ext4: set the type of max_zeroout to unsigned int to avoid overflow
      commit: 261341a932d9244cbcd372a3659428c8723e5a49
[9/9] ext4: clean up s_mb_rb_lock to fix build warnings with C=1
      commit: e19089dff547c9e1f09712acc3536d7b0aa9ce3d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


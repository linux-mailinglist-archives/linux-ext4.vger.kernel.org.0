Return-Path: <linux-ext4+bounces-749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE6827D12
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2B4B237B5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234E29D05;
	Tue,  9 Jan 2024 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PrXtT0cq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2529417
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rSJU010557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768811; bh=XCQxnqBSboJZiKMl447tY+hmTGpXedyOAMVXLwgQDCc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PrXtT0cqhvwmSoO+GvgYOn6F8TrqmVHujZHpsiwL7ulIrBEDk+vRnsJa5y8jVKgFY
	 bseIDUjurPINbG1N82yLZaEVOIHNcBHLvxClCskWab2qNi/8vtGKPPAUw7vN+C9olM
	 TffflU/ssphph9b3mhBA6I+7zu7LZaf10eW5F0pvDNZ/MPkm6rEAb+Dx76+SvTImD/
	 /EzHHbzGo9QuZX0neY6xWyECDBJszTiir3NYbRcasYMhJ/NPDsdipO/d5cOrujvBuu
	 GJ95q9+NbmFWnVC1GViOSh6vXAcGTPoedfYHbmP5O0UOkOHhREnWwI6YmGoDOATmNF
	 dCCTECBo5Q58A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1FA0215C028F; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/4] ext4: fix WARN_ON in alloc_flex_gd()
Date: Mon,  8 Jan 2024 21:53:17 -0500
Message-ID: <170476879009.637731.1586655538249198326.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231023013057.2117948-1-libaokun1@huawei.com>
References: <20231023013057.2117948-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 23 Oct 2023 09:30:53 +0800, Baokun Li wrote:
> Changes since v1:
> * Modified the comments in patch 4.
> 
> Baokun Li (4):
>   ext4: unify the type of flexbg_size to unsigned int
>   ext4: remove unnecessary check from alloc_flex_gd()
>   ext4: avoid online resizing failures due to oversized flex bg
>   ext4: reduce unnecessary memory allocation in alloc_flex_gd()
> 
> [...]

Applied, thanks!

[1/4] ext4: unify the type of flexbg_size to unsigned int
      (no commit info)
[2/4] ext4: remove unnecessary check from alloc_flex_gd()
      (no commit info)
[3/4] ext4: avoid online resizing failures due to oversized flex bg
      (no commit info)
[4/4] ext4: reduce unnecessary memory allocation in alloc_flex_gd()
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-ext4+bounces-2351-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F688BF143
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52F31C220FA
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234612C53D;
	Tue,  7 May 2024 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lnt6+R0P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94982496
	for <linux-ext4@vger.kernel.org>; Tue,  7 May 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123071; cv=none; b=udz0NJoSzJfke3+ssj4bBYo/FA2Ko5XDuN0tIiFgtEW4MIoNi8kgflDVaFuIlvtc16ETTU224b3u7Hx44yLIrjMG+ACFF25vtCrFKKzUkOR2ahhq2UT5XFzbVjkbqhozMTA17l4RWE0T+Ni1bz6899I7W6SbzaQl/7rZ0xeSfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123071; c=relaxed/simple;
	bh=C0lVToXizTOCeeLZKFN26dUSIliKn/ymFwnx6C+r534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oharPxr+A4AiM+ZYx67R/PrT0IZkit0KP0P53pzeZ65E45NOYe0yad+z/YY7z+A0QACti1TYjvsk4NFcGnF/zX7/ai0ukXPOuHnS9NWMRL4YG8TOPHGGfVj2DE0Kb7WpJ2UxD2qf/EkiVEVg4QPiNM7xBrcdWjCKRqAfI3M/lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lnt6+R0P; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N40wL026171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123044; bh=DQqW/hCyo7mvjV/dGy7n7kmFBaqtZN/JOoqHLk9yFmw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lnt6+R0PTdfAdtqrx5LgLYS3UZm6OhkpRId+IZfrrl08vB5jqfqWL0n14BEJcPgJF
	 DBdlgC++FXCn6hlpiOWD90KPDldqVyiJ5mxf6LU0c82EKjbhp10cdKn/2CDiNG2V8m
	 ZJbhSULRngBYDnpCV0XtU4H038N1rtbeURi8byhYyoL0LfLjUu2QJDuMKNA5wehYl2
	 W1VD2GczDw++jOSA/MBYAUsMAFE8oRHcE/BhgWxOFnjG5Bc/vFXbbHmrASXX/5fpx3
	 FcPjfdFHK6wFX3G3qMEKgPSauDRD0oUH2v1CCn4qXkDCrIoI0qDOn3KTFHV7U9ZPdv
	 E4BiRJ1pDenlw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0DA8515C0270; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 0/2] ext4: fix WARNING in mb_cache_destroy
Date: Tue,  7 May 2024 19:03:51 -0400
Message-ID: <171512302202.3602678.10418698281997771278.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504075526.2254349-1-libaokun@huaweicloud.com>
References: <20240504075526.2254349-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 04 May 2024 15:55:24 +0800, libaokun@huaweicloud.com wrote:
> Baokun Li (2):
>   ext4: fix mb_cache_entry's e_refcnt leak in
>     ext4_xattr_block_cache_find()
>   ext4: propagate errors from ext4_sb_bread() in
>     ext4_xattr_block_cache_find()
> 
> fs/ext4/xattr.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()
      commit: 0c0b4a49d3e7f49690a6827a41faeffad5df7e21
[2/2] ext4: propagate errors from ext4_sb_bread() in ext4_xattr_block_cache_find()
      commit: dc1c4663bc493f323d6b2f9dd55c044ea920dacf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-ext4+bounces-1092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01436848B1A
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 05:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267C01C21E5C
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Feb 2024 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365A63D5;
	Sun,  4 Feb 2024 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="darvrA/D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3A6119
	for <linux-ext4@vger.kernel.org>; Sun,  4 Feb 2024 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707022684; cv=none; b=VxdjgcScL01fqyz0utAReUGCwSgAzcvEfPMKcInMv/WaoCbxQLADMtAldGR2eZqxDXn4EHuNjnxvluJ5BgRaq/BbP8lMLW9Hpb6Mvmzt2YYxDzj6MfoRAIeY28BQe39HKjuThDURDevMj0vFce4cEz2SkdSPPVEywJv96jXnPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707022684; c=relaxed/simple;
	bh=z/Ty4oLUEibodQayGyHkoMLL75ruikL2AjVqRp74xjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms0vJFmGGcTJqXt2r8B4Po045LMPahke4tDO+bil+2CdoBUY0nrEZa3A8dZVhjj/GrwV8oc115k4W4Hw58XXHC0d0vQ8SbHqnKykNhsvmv51hqNEmMjsSJcK2dspY4sjRekooCEFS5YqOJkkWMl7/hSjZn6OKyYrhRu0U9ivsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=darvrA/D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4144vfKj014318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707022666; bh=In8gyICBmiZi3iWtOBrYVpSbaXDvol70zQdqBzUpq1c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=darvrA/DCeTsg0S1DDg5QI1jNwUiV8z9ABJYIGQxbgj5YH/UlR5jndbz7UE4VMZxr
	 dk420IuhQCHwJHfIqDiYBShd4G92KgJ9pN13qe+eUZeKonlaooHtUdUBHxlJvuIYQQ
	 hSxI0k2L017CLa3zcgUgkw5fkufI2yaz+u2n99xLH6CICbEu6j1akOPBdgWWzq5vrC
	 3ZZA6U55tleOmfYPG4UKdOnNzq91rhtuS3DcebyvdCmFnmDK4+rYOd+hq4QUK7ORUE
	 I5m+EyFIInecV5IpSsFVKSGp8afWKr+gSI5TlYNjBlGPmiuUMQlip77C06j/B0m09S
	 q09khGSt7RJRw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A7FA715C02FE; Sat,  3 Feb 2024 23:57:41 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Some random cleanups to mballoc
Date: Sat,  3 Feb 2024 23:57:37 -0500
Message-ID: <170702219298.205725.11888277677998251531.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105092102.496631-1-shikemeng@huaweicloud.com>
References: <20240105092102.496631-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Jan 2024 17:20:53 +0800, Kemeng Shi wrote:
> This series contains some random cleanups to mballoc. No function change
> is intended except patch 8 may fix a potential memleak if non-used
> preallocation spaces of inode could be greater than UNIT_MAX.
> More details can be found in respective patches. Thanks!
> 
> v1->v2:
> -Collect RVB from Jan.
> -Remove 'needed' in trace_ext4_discard_preallocations.
> 
> [...]

Applied, thanks!

[1/9] ext4: remove unused return value of __mb_check_buddy
      commit: 133de5a0d8f8
[2/9] ext4: remove unused parameter ngroup in ext4_mb_choose_next_group_*()
      commit: 438a35e72d09
[3/9] ext4: remove unneeded return value of ext4_mb_release_context
      commit: 11fd1a5d6423
[4/9] ext4: remove unused ext4_allocation_context::ac_groups_considered
      commit: 97c32dbffce1
[5/9] ext4: remove unused return value of ext4_mb_release
      commit: 908177175a2a
[6/9] ext4: remove unused return value of ext4_mb_release_inode_pa
      commit: 820c280896ea
[7/9] ext4: remove unused return value of ext4_mb_release_group_pa
      commit: 20427949b9b5
[8/9] ext4: remove unnecessary parameter "needed" in ext4_discard_preallocations
      commit: 2ffd2a6ad1d3
[9/9] ext4: remove 'needed' in trace_ext4_discard_preallocations
      commit: f0e54b6087de

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


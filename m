Return-Path: <linux-ext4+bounces-4065-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92A96DCB2
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0137E28D0D7
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D511A00D1;
	Thu,  5 Sep 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QhzpWd/F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49F19F41B
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548065; cv=none; b=uIEgudWOUTwgzKzIcA6WPh7ZeHz2AbZR0qGAbCl/gvTZEtjQ57MGd88Ac6VGM6x20vQFCAOddLnkwVf/Duw6+Y1PoH/cmXYD4XGtHoKLuOF4iCyvZNE0r6shwq7ntvyetTZP/b46f84MamN2uLbNeqs6MauD81/acfFz+YLIFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548065; c=relaxed/simple;
	bh=+nMHaN+vUcn9GAfND8VLXS4PFw4yYhXIH4cYW8aAHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsNWxmrMhtii9jYu/idPzOKe2yah0yDBzTn50JvnYQtrceyaSf/Fh8d6QHaPhpnhCIhnh2GM7hBChEPQOsLBibXmxUtxdf9//es1Cff4XiKIQym53EUr584ZvW4HHU4O/tCUcqZaTHcGcRffOOz8UUic4pT5rsYNJQlI+g61v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QhzpWd/F; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485Erx74004724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548040; bh=H5+XlYS6aGUyrNhHAkGwEKnq01SOLKI2a7v4EFA5880=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QhzpWd/FHoMvZzl1eTm/BMhDo4pCVs+mkJl9lrA2rECHOizpEG18O/E9YA7RX0qeL
	 GbbFWQIHvs9QwPNCLwwlQmkvj0q9A2gt+MUb/G/f2SY+11Sdurx1nYADOxTbs0Mu3L
	 Utw/PUdU3y+QODvtgWEgo3WqLtBhtKW1dFq+lLrfQbdIqzaGGJVVp7CCaI35vCgFVU
	 HI7ZZv9g3Zh6m++a3VBGFYJKJ4Ws09QewsoSdYKloDwMZxXim+0LNDDnGaGDBIDIiQ
	 1zqOCBYMl+jxa7pNHLZvoQ96s/LvMEkFKHr4CHw3j8JnAFjbPcXJrP0HytD6+ruAcP
	 ItqgiGfzCHtMg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E97AE15C1C63; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.cz, yangerkun <yangerkun@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH v2] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard
Date: Thu,  5 Sep 2024 10:53:47 -0400
Message-ID: <172554793830.1268668.15796910397193830249.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240817085510.2084444-1-yangerkun@huaweicloud.com>
References: <20240817085510.2084444-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 17 Aug 2024 16:55:10 +0800, yangerkun wrote:
> Commit 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in
> ext4_group_info") speed up fstrim by skipping trim trimmed group. We
> also has the chance to clear trimmed once there exists some block free
> for this group(mount without discard), and the next trim for this group
> will work well too.
> 
> For mount with discard, we will issue dicard when we free blocks, so
> leave trimmed flag keep alive to skip useless trim trigger from
> userspace seems reasonable. But for some case like ext4 build on
> dm-thinpool(ext4 blocksize 4K, pool blocksize 128K), discard from ext4
> maybe unaligned for dm thinpool, and thinpool will just finish this
> discard(see process_discard_bio when begein equals to end) without
> actually process discard. For this case, trim from userspace can really
> help us to free some thinpool block.
> 
> [...]

Applied, thanks!

[1/1] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard
      commit: 20cee68f5b44fdc2942d20f3172a262ec247b117

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


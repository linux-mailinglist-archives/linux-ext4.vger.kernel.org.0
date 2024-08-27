Return-Path: <linux-ext4+bounces-3913-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D626960B02
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF931C21DEB
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00431C57AD;
	Tue, 27 Aug 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="It++mg58"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66F1C462C
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762884; cv=none; b=JCvp6fWsDVAZUA1z0gRogSU7q3e8UsWpUcVmbzq01lVVhd4w1cDkvTAyQznZbrRNvCJ+c4YQMz+r1WURjIUzXZdwyZ/ANsKXYb1nVE9r8StipO4ISM7Y7icOIAzlC2NubdIZtW+9Fsa3wRgToLC0ZDzSZFp7nVdugMu5issVw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762884; c=relaxed/simple;
	bh=LI7vPSdSkJR6uJTu2bQt0dKtx5Z8FF8kYPyzhck8zoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBPi/V1wocqXyWcDQLOkSFDtvmtQxsmbx/5Ka6u4sff31C5B0/GWKoAiW6OmLW5N+QzRRRuDpNMBUUzRrug2EB0dBp+i3rld/CdF6sNByVqK50Jdi46uJIFbuSzEYNjNB1KHuhgP5p3cCZcWJd6w2JGjR5W5xCFZWKf9uy6BO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=It++mg58; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClcHW021452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762861; bh=oTYlK1YyIwI2rNA0zoIgoTS4jm/2IDp5tKAWA/G9+Hs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=It++mg58YPuVJ/jdxzuO8m4RKcKLC1RzF0AsNmS3eT76PhNRAls9iI8JkfHM14Cf4
	 B10v7nZxm/El1zjGjt4k4qq9jGGtuiXCk7bQvMUFs79rPYGbYgNLfD4IF7DZpiuw3x
	 fSSwnA4TkVXN/8eViHUesvdEoy1Bzhq7NEUzpkelCOgSIbNszhPCJcI+I93Sju6R3d
	 cDjH2aTV+ke2jdWb1pLJZMNrYkWEXttWJQADGHozJ6XLuBalukC9zUJnfRckJFC9YD
	 ADwUVHT4XvYJqNeILoo9s9kWukEqBKh08534Mamwbh33MkaEcm5XeR4HtwZ8Dbvz41
	 1hnu6aHwcfTAA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AF17C15C02C1; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.cz,
        Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengzhihao1@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: dax: Fix overflowing extents beyond inode size when partially writing
Date: Tue, 27 Aug 2024 08:47:21 -0400
Message-ID: <172476284024.635532.4541598386517901728.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809121532.2105494-1-chengzhihao@huaweicloud.com>
References: <20240809121532.2105494-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 09 Aug 2024 20:15:32 +0800, Zhihao Cheng wrote:
> The dax_iomap_rw() does two things in each iteration: map written blocks
> and copy user data to blocks. If the process is killed by user(See signal
> handling in dax_iomap_iter()), the copied data will be returned and added
> on inode size, which means that the length of written extents may exceed
> the inode size, then fsck will fail. An example is given as:
> 
> dd if=/dev/urandom of=file bs=4M count=1
>  dax_iomap_rw
>   iomap_iter // round 1
>    ext4_iomap_begin
>     ext4_iomap_alloc // allocate 0~2M extents(written flag)
>   dax_iomap_iter // copy 2M data
>   iomap_iter // round 2
>    iomap_iter_advance
>     iter->pos += iter->processed // iter->pos = 2M
>    ext4_iomap_begin
>     ext4_iomap_alloc // allocate 2~4M extents(written flag)
>   dax_iomap_iter
>    fatal_signal_pending
>   done = iter->pos - iocb->ki_pos // done = 2M
>  ext4_handle_inode_extension
>   ext4_update_inode_size // inode size = 2M
> 
> [...]

Applied, thanks!

[1/1] ext4: dax: Fix overflowing extents beyond inode size when partially writing
      commit: dda898d7ffe85931f9cca6d702a51f33717c501e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


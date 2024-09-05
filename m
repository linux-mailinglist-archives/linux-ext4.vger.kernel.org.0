Return-Path: <linux-ext4+bounces-4064-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC696DCB0
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35F31F22F11
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC319F489;
	Thu,  5 Sep 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="juisWDZn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BD17ADFF
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548062; cv=none; b=HNvBLUqqWGOXHr2JRGUE3JdIw8rMbM0QhuOGfLN5JPiPPA/FPNshffZP2Nuk8vYj4roSdnj+w62IV3HoJyfH5gkQO57F6YcaOw2i/Yaw3UbYxnG6Gtf446kdq1WubfCpOe7KCs0O+wneWacmHz1A6cZhOA7Tdk63ipqA4BrrcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548062; c=relaxed/simple;
	bh=i3IkJZ8CVvslUAGx/dB+0f+mJECIBoFQBahEYT71yEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbbmPM8a9nX06LePRluP6R36jb8xtSYyr34lmj0AhfpqhAiD0NeeUInBLWSbZjv6WQb3s/RTlVVG4bvw2oBFNPM6UM3Bl/ne0WYHlcvtgSFZbc0VaFZiyK+3Lvhd//isepkX31IVWAdinNce9bsC64v1Fn19tCs9Qe5zO/nIy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=juisWDZn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErsHX004659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548040; bh=bPePAcmEsqxs7gy1FbVzMnCjjwWUf7FZa+kBRyOnqgk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=juisWDZn/Cu0EYVSmTg1OoHtGUVGBgmnJuyjyWHd1cJDWJtnvHJALCIODORWo9+Bd
	 HTx8HAWRQXe+LkIgMRPwpotlx3xWr6bk3ym8iiDJvdeZN19YO79Yg2vUnPmrKmXAPi
	 ydyBG72pLzwajtZzFOM0LHYgtWJ7ovqiPavKdemnx4yyvyIINPphKttVcnhlF4j9XZ
	 B5gfGi8mSBmvJeQ/pJ0Us5113NbCl6vjZRFCxCwbMXU0Ijy1FfHBxW24/qqPG6K0Yy
	 yNI4N3t7fPtENFqQsR8Ey4Pm9CZIMaHIpilRzVHLTC2Bsu57yow9rtf2R+ZMrj9yOq
	 G/94L7EBRK74w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DC0D715C1909; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Tao Ma <boyu.mt@taobao.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
        kernel-dev@igalia.com
Subject: Re: [PATCH 0/4] ext4: avoid OOB when system.data xattr changes underneath the filesystem
Date: Thu,  5 Sep 2024 10:53:41 -0400
Message-ID: <172554793832.1268668.642779330743885621.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821152324.3621860-1-cascardo@igalia.com>
References: <20240821152324.3621860-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 21 Aug 2024 12:23:20 -0300, Thadeu Lima de Souza Cascardo wrote:
> This patchset changes some of the error paths involving dir entries lookups
> and recheck that xattrs are valid after an inode is potentially reread from
> disk.
> 
> Thadeu Lima de Souza Cascardo (4):
>   ext4: ext4_search_dir should return a proper error
>   ext4: return error on ext4_find_inline_entry
>   ext4: explicitly exit when ext4_find_inline_entry returns an error
>   ext4: avoid OOB when system.data xattr changes underneath the
>     filesystem
> 
> [...]

Applied, thanks!

[1/4] ext4: ext4_search_dir should return a proper error
      commit: cd69f8f9de280e331c9e6ff689ced0a688a9ce8f
[2/4] ext4: return error on ext4_find_inline_entry
      commit: 4d231b91a944f3cab355fce65af5871fb5d7735b
[3/4] ext4: explicitly exit when ext4_find_inline_entry returns an error
      commit: 51e14e78b5fb3e6f839393cd2d34386ee7b69af3
[4/4] ext4: avoid OOB when system.data xattr changes underneath the filesystem
      commit: c6b72f5d82b1017bad80f9ebf502832fc321d796

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


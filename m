Return-Path: <linux-ext4+bounces-4986-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83C9C09BE
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D52855D3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83D2139C7;
	Thu,  7 Nov 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fvPa6D/0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F55213141
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992402; cv=none; b=nerOJfTDyxdjrv5bndW+68BsVuqz9iDTFAOdXUrp08JX+J4rDN8UYTSPRFO4a+sZX93QrwafERmXgepRZGBEsyByhns2PhTW0N0zX8L+xH2M2eNOFvQKJpLkaC+ygigrcxoAMKBbL2J6RpIJO5GDHxa8+OYr+K1ayJyg84X9/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992402; c=relaxed/simple;
	bh=yn548mgLILqtfHPW8pR72deoPM37hYmEmbK8YTroekY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOaIYNNVLrurp+xYb4EmI1n4RMEz0/yTgVlfxR2yseOx2IsaSdCeWdpAsJRFiIcsnsgcwd2+HxgGarHe7Z2onMmbZGbG0NUf/aTBX5yC51Fs1Ud3mDnIGM7NIUz5acnQqEh3foqgpqeo2oy2/jtH9Kds6ehSydnv1UCj1gzoRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fvPa6D/0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8SC003577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992390; bh=Z2JralDdMShzBNsdUIkVpK5hL6ru3W3+DM142Jrc1ZE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fvPa6D/0zbbQdE4PZr4Hbmlxl+tzVtgxBMMxM90S6ZxiZWi19yubwJAgV0fqBFv27
	 aihHZH9OHrVHU+FnWTkQsSbq3ued7tnnvoNxxybDoThMAiyQebsXzeiwdHqnSRBO9T
	 SnEbCzTD3mPgc1dHTFRd+oTR6q7+VM1QtPUEE/F+R0Pf0d4XZ9yVdt8VoC7pJkIsl6
	 mNc8KMjsSZqKGyCelF2BdNQlvutiTF2NHia5o4QeaNt/gIjXfnOh+ymcONYrnDxVBS
	 5FRYHD/oFMojFPZumYH1uBNZVUkb8BtIzXhnC1p8hTVS//RItZkXiH1yDNU5hDjvHs
	 zmUDS2jVP3NCg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 46C9615C18B4; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, "j.xia" <j.xia@samsung.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Pass write-hint for buffered IO
Date: Thu,  7 Nov 2024 10:12:57 -0500
Message-ID: <173099237654.321265.6588244483471280365.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919020341.2657646-1-j.xia@samsung.com>
References: <CGME20240919020429epcas5p3ebeff9323bcd95005ce70714bd18421a@epcas5p3.samsung.com> <20240919020341.2657646-1-j.xia@samsung.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 19 Sep 2024 10:03:41 +0800, j.xia wrote:
> Commit 449813515d3e ("block, fs: Restore the per-bio/request data
> lifetime fields") restored write-hint support in ext4. But that is
> applicable only for direct IO. This patch supports passing
> write-hint for buffered IO from ext4 file system to block layer
> by filling bi_write_hint of struct bio in io_submit_add_bh().
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Pass write-hint for buffered IO
      commit: 9783549cb6873bb0b2f6e724bb586e46a6e67e63

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


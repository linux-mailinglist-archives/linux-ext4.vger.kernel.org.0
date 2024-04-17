Return-Path: <linux-ext4+bounces-2121-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A895E8A7A4F
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E8F1C2163E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019046B8;
	Wed, 17 Apr 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ELY0Z0Cn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B01877
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319437; cv=none; b=QQsMhI1n7Aq4PyU6fjaocnZ0Sb0ym6TbSqeOV4faRFC0pJ9dzS1zxP2KSmtUXwpqKY+/m/EaxAr3LFad9UjuT4vO9ktZQrp4DOhj9wRTLshChynYffsggJpBTa6UG19nivS0wJvGH7HBsloJOEFhB/fVGxHETgwJU8gb9ggKMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319437; c=relaxed/simple;
	bh=L1v61Pbl4/tPtPepKr+C5VwAlcqf28c+aDDkMzWiXWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iftm1H7J4YhZswDRf33P41AR+EMlfkZxImtwxQV/Pp3MAQS4qHI7kKUjpnUhWKv4zYg+oUUt0PWxVW1qtAaUULvX0bFwNh/yX4Zq0cMMSDys/Q3Lmdg/srA/UB9PEWSzeDgvS6jOMqDkQnwfa/i6r2gz0eMhkMLS7RH7vfMpza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ELY0Z0Cn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23gC1013702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319424; bh=1Sz4jIMAcc0lUTXU6CbxdzTg1DOXynD6p28/O430Q+E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ELY0Z0Cnt9TLB9MXEGgWuYVYefnm7UCNjpmWn8VjYmtqU86Zrc188L0OyWzkRZH1Y
	 TMTHKIkNEfcy9epCFWh4yaVEhNi2/w0RDUCGLQdq6ahWQcwgEN4S++LG3cigmSNVq0
	 bHPNimN81CC2h/1QfE5wf+CEqq9JyYM41/GCTmLwmuHnUYbO5ap6yrqy5YqVNwsa55
	 VaX/KknSeMHvDPWnYCBCww2ZdMIc11xQXn9MjAbkwbB8gJONc+INGd+JX/MwICmdod
	 Sq2ETedeI8NZADaEZS86OJRhaC4mnYmym4cT+GSAqA+evW+91ajA6BV6EuqR2XOGVW
	 HrRIjbsM1ZQoQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BBCF515C0CC1; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH 1/2] mke2fs: set free blocks accurately for groups has GDT
Date: Tue, 16 Apr 2024 22:03:31 -0400
Message-ID: <171328638215.2734906.7010347972046315896.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230925060801.1397581-1-dongyangli@ddn.com>
References: <20230925060801.1397581-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Sep 2023 16:08:00 +1000, Li Dongyang wrote:
> This patch is part of the preparation required to allow
> GDT blocks expand beyond a single group,
> it introduces 2 new interfaces:
> - ext2fs_count_used_blocks(), to return the blocks used
> in the bitmap range.
> - ext2fs_reserve_super_and_bgd2() to return blocks used by
> superblock/GDT blocks for every group, by looking up blocks used.
> 
> [...]

Applied, thanks!

[1/2] mke2fs: set free blocks accurately for groups has GDT
      commit: ecb37fe311cd67fe7c86eae069551ad15fb20c03
[2/2] mke2fs: do not set the BLOCK_UNINIT on groups has GDT
      commit: 7150bea307a30f393d184d81a80d9a3ae2e78638

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


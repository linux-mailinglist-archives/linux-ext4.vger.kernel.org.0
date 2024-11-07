Return-Path: <linux-ext4+bounces-4992-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0A9C09C6
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A594F2855DF
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA52144B1;
	Thu,  7 Nov 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fcEGuLkS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145C21440D
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992415; cv=none; b=hlnwobzUn710yKE04tFsyoDwr4DTWjQ6O55WZzPccClTiXfguCh8Zk3Ja+B0XeSWOWlVhsPpBcpKzOC9G7FKB1UAUSgu0AqHtrqTc63e5/PdQ91cis+WlG296EF/PDzS9uphNm1LEimbHp6PrUKmhMKpfcyq2yFDnz9Q2jykkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992415; c=relaxed/simple;
	bh=ZfTCWynANJm6wYuOhqjHfqKfXZok1/bWSjfzFNfL2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYWEKjv9/Vc2ubQS297TTLBvlS527Wn3DA80DT6JSLPwQt8IcOQJnEgZqdzPEeK/ZFc51KicFySEcgcR5I0PO1YEqpwFjvt2qNFuj5/yiBaEiiP6DrW2GVY8Bv/hJgosmFzKnqbP3lmYZClXkwde2nrjLnZv1LnCHo5Z7bFEVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fcEGuLkS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8as003578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=q2jO5hPPWsqlkyVTB4AwhM6X38zCdpTHzm0SmDLm7g8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fcEGuLkShz+HWkAr5SMirBj4sBIto0PMayIHaiZRQMDcre5y8Yo/dxwnJxfMmCg7r
	 tXOS33sqTwOPBy789kFmHf0YfuHqSFN8TvAsnnEX06dDhA9B1g7myMb5qsCZVbgp94
	 w/OSbo0pxvYJUc3bC92Ru4VaoVCY4DwLZfY12WkFZHh407pkZvwrW5VfAq9GUAA36x
	 ngIMaH380p1sFu8NiFilJpGh74euns6oWpDSqVAQpkJJCE6KYlhST/MXjHkAJnBGQg
	 i/HX87kFHb53vb6vZP3WMk23qHj8qsYO3l40de/JwM+p9+lMXO+cvlHIcPrORk/DlQ
	 /PY4xqT4dI+lA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 48A8715C1909; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Long Li <leo.lilong@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Fix race in buffer_head read fault injection
Date: Thu,  7 Nov 2024 10:12:58 -0500
Message-ID: <173099237653.321265.5138916597088578297.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906091746.510163-1-leo.lilong@huawei.com>
References: <20240906091746.510163-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Sep 2024 17:17:46 +0800, Long Li wrote:
> When I enabled ext4 debug for fault injection testing, I encountered the
> following warning:
> 
>   EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
>          Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
>   WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix race in buffer_head read fault injection
      commit: 5b27ea893548b283d3d63561b8e651f06aeb0db1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-ext4+bounces-2130-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C88A7B65
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 06:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F931F23115
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE2249FF;
	Wed, 17 Apr 2024 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jemL4u5m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89511EB27
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328450; cv=none; b=RlZhQ/iopUEE+dPlV1UUL3Usj+H0Wf5LoelHDvzeIpPOZwmv7IWnYbXG4x5PbScyTzE/PZVLMB7/MUyZJ5lII2+vjl2O3+vtvx4g28Yy6a2OErRhxKQEbkzQDwgm2JhC0gUq3vAxkQYZoGjuRNhccbMJY5duHVPRmm3i3Z0MSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328450; c=relaxed/simple;
	bh=mCHklNzD7aFKM1Jy2wkRtGcLFuaWlk4OwJJHxGKv4Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xb4MkOiEtg+yR4vndNXoBSTEkwX6bTYNre+PzROMbHrR3URspXeC3W5LtliOgWgOA0Iy0SZbZnNx0nccuuxT5vNs+Rag7h+3OZI0txJQg389TdYOFLmGAtyf+Gl7+dTuOrfWy1BWTaUDX33MLtOvyeP6PfdvKsR2KV8q+gFG5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jemL4u5m; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H4XiKA030663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 00:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713328429; bh=diT/wN+fHLdKUYusj98+kygW/s/U+u7lxu6HU0BKXpA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jemL4u5mMGNUKVuNwbb6ze9dfH7MqfvSL/D2XTPEg7MzyyNFye9fB1no0Oc3VhKae
	 GiNRorUqDfyVTrqh0ULFAAIJPYnW6DwdhjJhIJTq9DAJpObaS/xguK86h62Uj13Luz
	 Soz3AhhiMPSExXp+CyL9qhdCCa+ZobYmraW2sqR6GpWrH/z+bXYkMkiPmW6fQGbJgY
	 y1+Yg+yByN5mb/PTU21rJkqz80agjo7uXnHKJ27nj+M1LAJjCFKdrJGGABFz55XqdV
	 wBefA9auFSaI81W5kyT1OjCrchekKGolOcnMH4Qw8rzEqx5079LWRFONqOdPflv9yZ
	 tkAbKh1RmcEAQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7A0B615C0CC1; Wed, 17 Apr 2024 00:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Wenchao Hao <haowenchao2@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, louhongxiang@huawei.com
Subject: Re: [PATCH] debugfs: Fix infinite loop when dump log
Date: Wed, 17 Apr 2024 00:33:41 -0400
Message-ID: <171332777784.2749069.11433721296273612273.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231117102315.2431846-1-haowenchao2@huawei.com>
References: <20231117102315.2431846-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Nov 2023 18:23:15 +0800, Wenchao Hao wrote:
> There are 2 scenarios which would trigger infinite loop:
> 
> 1. None log is recorded, then dumplog with "-n", for example:
>    debugfs -R "logdump -O -n 10" /dev/xxx
>    while /dev/xxx has no valid log recorded.
> 2. The log area is full and cycle write is triggered, then dumplog with
>    debugfs -R "logdump -aOS" /dev/xxx
> 
> [...]

Applied, thanks!

[1/1] debugfs: Fix infinite loop when dump log
      commit: 272173a300822b5cfe19bef597609523baab0c66

(I renamed reverse_flag to wrapped_flag to make things clearer.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


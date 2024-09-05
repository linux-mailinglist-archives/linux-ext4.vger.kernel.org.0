Return-Path: <linux-ext4+bounces-4067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73796DCB5
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1081C20B2D
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAF1A01B4;
	Thu,  5 Sep 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XDqf7hgS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278E19FA9C
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548068; cv=none; b=LO6LNPwKoboOOxZ1F7pCeqmRMTQKSobJRH5/dcYrswzzBGAcBdTptr0RiMz7vJr1nwKTOPSvnqb2ff/Lrc1qNi8tShN//KqhvwScW9inkIimvuRtvc+bG5uSNfx5qFixbmE3PqYlnYzg9Z7qjjsZYG3p+brDmiNPT0iuyWFqNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548068; c=relaxed/simple;
	bh=3YHk2H+GGjU8XBb/0iN8GpGGLOvnZHplN0Lsbt0txpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkSE3XfcMWTB83UObHEGXOY5SIkmwvx4cVC/qHGsepKnhrJfY4QK8oTVoSq46Z9rgWE72kuq/lf6NfVA0WVrWYq3e6cvo8MG62cVP3POfMsR2QOTxmkNuIjNZXaRF2DbbhDsyi74DGx1Nf2iiAqulsVLlZHEw3mzfWggvMQnCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XDqf7hgS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485Erx7x004731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548041; bh=JtwuRQxMqE3HygVQwQtLaDlAUEJ2RJH/s7B1qaX1Kjo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XDqf7hgSLglw1/eoPyNJXx6usDvLjnqytmtrC72IA6n/Z22zAk7iuFMzNQJx7Yu8V
	 9GeIaxvRD9B0yfqSIbhU1WEqeDZ+zHOv+XR9YaMqeDTSPHdJVLlPxRMWUEg/TEhjQy
	 Ze/uXBWpvjtWTSqaXbc9ywIYes0mUnWEt0DBv2Yy+2wQj+coRRe9pTSkyynqjYWZLR
	 USRvnW/uWgLHRYzKDNy/jikGRAotctvUFQU1SJTIwaXmXjUhZFS3+jMSqZFdmq83iH
	 d+ZJflYhkIxFK04/QSgGPcl9hF9xLbaCKLK8bYTdSZntswDNj9NEmaEqI1p7f25JYQ
	 JOarg2NSuufbQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EB7D815C1CC9; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.cz,
        Yang Erkun <yangerkun@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH v2] ext4: dax: keep orphan list before truncate overflow allocated blocks
Date: Thu,  5 Sep 2024 10:53:48 -0400
Message-ID: <172554793832.1268668.11709771294589119561.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829110222.126685-1-yangerkun@huaweicloud.com>
References: <20240829110222.126685-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Aug 2024 19:02:22 +0800, Yang Erkun wrote:
> Any extending write for ext4 requires the inode to be placed on the
> orphan list before the actual write. In addition, the inode can be
> actually removed from the orphan list only after all writes are
> completed. Otherwise we'd leave allocated blocks beyond i_disksize if we
> could not copy all the data into allocated block and e2fsck would
> complain.
> 
> [...]

Applied, thanks!

[1/1] ext4: dax: keep orphan list before truncate overflow allocated blocks
      commit: 59efe53e380ee305ec11378233adb6aaebe1856c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


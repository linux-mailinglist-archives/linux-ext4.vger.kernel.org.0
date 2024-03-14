Return-Path: <linux-ext4+bounces-1617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD887B6FA
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 04:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18973B23621
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 03:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69845256;
	Thu, 14 Mar 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="f+3wTDTA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DA101DA
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388522; cv=none; b=Rj9QL5KStXcHQGYqqOJN5OUCvlOgdK0FAoE81NzTNA70o6n/D/NVyj2w3afEnHvKNVUtbQsDrAMOhnpLKMPi1hrj5gTHwhKqBsDw9xmpjkjfdupsK01J57Q4qZmSMkUlTKaAK08q6pvsUovioTdr8/giQ53raMy34trx1rPqqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388522; c=relaxed/simple;
	bh=4SeXswDvL4XAtMhH8BZc8ueie2HBGC5GAN0F5wf2WHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgcl4gTEgomhDvOeEihghBnOXgJ3RuZ5Yc/a0X1PrK/1BpBGJsvKmh/dFpEmw4C7M1LZN1njG3sTKORk6Q3Be6TvZJ3Ejz73BA4og9AUjhGkvQUPN/iANyY4F62LwYmv8wWvk/RQdlypOlll51Sn9R12pbtpEXVra3OoIwd0cTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=f+3wTDTA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3sndT003032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388491; bh=xLkTtQYzTyVY/tjTay+2kq3uPSfWUG+sOpzSN8qu/nc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=f+3wTDTAx+xaFeHDZ9v59SBJxn4NWVGvHKH0ar9tA9HVMujysRXXAuYw8JAWjGMz9
	 b6ls7zYjSjm/KsGLrbDbM3d36ZoSvyzunQwRmfUo/P0T8mZofaX807F+jjwben+yri
	 YmhfT+6HHpVpLVtrT4gooN+C7DyFGjh4epNzuD7jG6GraZxLuBbQXDmcPh5T65mq4b
	 Yra6VlB/NmNPEgD3eET24iz7KXYuPHGiBtqs2lAay4OITHBNbd3FNj2KNZjUqscav/
	 LNIPy5adqiBfDbov+PTgOu4G8rAcFD4kG4tTER7L2kBoXI3shhB+z7qp4Jw5nxE83Q
	 JAlBCirXKO3mw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F00D815C0287; Wed, 13 Mar 2024 23:54:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        daniel.diaz@linaro.org, linux@roeck-us.net, brauner@kernel.org
Subject: Re: [PATCH v4 0/3] Fix crashes and warnings in ext4 unit test
Date: Wed, 13 Mar 2024 23:54:44 -0400
Message-ID: <171038847844.855927.13599974785439810131.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304163543.6700-1-shikemeng@huaweicloud.com>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Mar 2024 00:35:40 +0800, Kemeng Shi wrote:
> v3->v4:
> -fix that sbi->s_dirtyclusters_counter is used before
> initialization.
> 
> v2->v3:
> -fix warning that sb->s_umount is still held when unit test finishs
> -fix warning that sbi->s_freeclusters_counter is used before
> initialization.
> 
> [...]

Applied, thanks!

[1/3] ext4: alloc test super block from sget
      commit: 8ffc0cd24c2a3ea340743db18b1a1e999176fbd3
[2/3] ext4: hold group lock in ext4 kunit test
      commit: ad943758e0ebd881d031b657a3f389315bf3a101
[3/3] ext4: initialize sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter before use in kunit test
      commit: 0ecae5410ab526225293d2591ca4632b22c2fd8c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


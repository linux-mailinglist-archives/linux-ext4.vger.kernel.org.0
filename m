Return-Path: <linux-ext4+bounces-3867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C195B934
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 17:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682F4B27B05
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D141CC8A3;
	Thu, 22 Aug 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZS2ZkpAf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E818EAB
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338847; cv=none; b=k5Jjfg/IQv6S3tnDsuZLxjEStu8ar2FQBYLvHsSCqgZgni/cSFJzGaE7E9zPAMBlzTDov9KSI0ppBpdN/Xe2Mnxnonclmi4JmQ7EwnpK/nGQ0S+vRfw/6yXskOqUiS0XhgiCxOhb7py1eBcf0I8tDXgKJdol0MJg2Z4MHTr9b9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338847; c=relaxed/simple;
	bh=70PL5f2MblAyg/FBGlan2qHuC5lm7vOFjRzQYtiH1ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbZoLo8XSv9QqbX4DNXvoDu3I0d2Z5g0l4jC73s3FQ14xQ7IbqszC1CBkPICra1FQ8pr7uR8pySQk1ie0mioGNnLsCSiTkkqcofNx3ov7YHSTRpy72ROETWLCK/P451+0o1PrC2GP/vqJGG5rwr9gWf0QiahufD+Cs5LDsq90vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZS2ZkpAf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0MKa022377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338824; bh=sKAFdZgSvPvrdIUpPT56RTQQlQknRd04letoFd7nzZo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZS2ZkpAfw50GU3CLQGY7XF6QwhlPO64vfflX76Sy3rlKkzkVQCCJnkXWU+MggveWa
	 a0LFogos/ap8qtVY/XhY4iZX0Af3deHuSrKOB2GyzxeGe+q4YNsuPA3YPe47MUE8ig
	 k27T1Neo46XWVVN5tvP2xZfXCuOiujdoS5JceLNbQ3AU3D+AcsiyouJOHCb3x9uxjW
	 /Lie2wOMNivD/HAVoCaU7sGPbfSXEkPQIz0hyPpW8S00zNF+ZKMqR0QExQd1oUiHB8
	 U7CQp2BUMUeZk4deCNCyBBwU8n1d9aatBPpLZcD2FShw1GQTx/JRw9XJfryEAjwhvy
	 76IhY3CIbkzEg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E2AC415C02C3; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Some extended attributes related comments correction
Date: Thu, 22 Aug 2024 11:00:12 -0400
Message-ID: <172433877724.370733.10230780173544926638.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
References: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Jun 2024 20:55:05 +0800, Kemeng Shi wrote:
> Some extended attributes related comments correction. Please see
> repective patches for detail. Thanks.
> 
> Kemeng Shi (3):
>   ext4: correct comment of ext4_xattr_cmp
>   ext4: correct comment of ext4_xattr_block_cache_insert
>   ext4: correct comment of h_checksum
> 
> [...]

Applied, thanks!

[1/3] ext4: correct comment of ext4_xattr_cmp
      commit: 6ceeb2d8fdb19a1b6bb9cc48302e682fb380043b
[2/3] ext4: correct comment of ext4_xattr_block_cache_insert
      commit: 4b14737ce90424179d615cd35f04453f398f8324
[3/3] ext4: correct comment of h_checksum
      commit: 5071010ac3aa32a1b0f0b4c14d3ea6b217ba21ba

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


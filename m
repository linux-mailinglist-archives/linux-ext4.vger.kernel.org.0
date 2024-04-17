Return-Path: <linux-ext4+bounces-2127-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD278A7A54
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BD5B2180E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D74690;
	Wed, 17 Apr 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UZIcaMEg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196F7462
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319445; cv=none; b=Gsdjf2/tFzybXodRAxXAjUGTDXjp0Rk1JjAazLH6Walzhy1oN0Z1Ssn16flJXXpnwzkt2540Ab0ZK9sbUtagHEmJ8cc45xxWVvRf/qNdCV8svQEE4bpdkIeNyk6Iv1KgQ8Hb0Jm4ZwFZWRGpHGDcj1AeIeDLokO/U3+pM1iY28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319445; c=relaxed/simple;
	bh=uDXMAdzmqutv6AL3Y0lhEAyf+St7toGn4D6JcKLHtqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qg+8juztkgK0n7fWwmXShv0Jk8OqvyiPfE3Bivzqg5IlOlEhv1i0ppcgGW+Qyp8WoTdhh0iSGJSJtzfTpAv8olY3fKklXTecdqKykUnYlNn7j1qvtJYJWzV1EcU+qWb7hJpQa1qBG4xuUAQz7QajswpJ9Y7au1GJsrCnxkSoj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UZIcaMEg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23iYV013759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319427; bh=ebwG3cU54BDfRbDdxdvSbZmwTqmIQU6HARNjckPVOpU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UZIcaMEgUVxDHmD5pQB6CAZEtKhomu9Gw74Qa/Xt4B70mz6BVfQjcOx0gNnfM0+tz
	 mnl+Vbo2pF71uSonK4rf71+M31gb47gxFkiSLvW1MOtjPO2yWENNoO9vdn54t39IhB
	 5ZBWPLmw4g9a4WxCqtK7C/xvE4I6OwBaZ0fWW76I6ETd5LthcFdXVESeJd8Xc+U4Fy
	 JLGV5joOBcvHyJ1T2FDm1Xgd3g8PWxiWBDTvBpjmXqJe3Hzb9pbIeYdluziYEilDTO
	 013OhL9pz9WxGr310J9redmEnggu/bU5kTGJb+RoMC7En7+8fD7A++BUtxyPiZL7o8
	 dPhVAQEjzPhIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CA78515C0CF2; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca, djwong@kernel.org,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH v3] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-size values
Date: Tue, 16 Apr 2024 22:03:37 -0400
Message-ID: <171328638216.2734906.9011290838345212383.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403043037.3992724-1-srivathsa.d.dara@oracle.com>
References: <20240403043037.3992724-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Apr 2024 04:30:37 +0000, Srivathsa Dara wrote:
> According to the mke2fs man page, the supported cluster-size values
> for an ext4 filesystem are 2048 to 256M bytes. However, this is not
> the case.
> 
> When mkfs is run to create a filesystem with following specifications:
> * 1k blocksize and cluster-size greater than 32M
> * 2k blocksize and cluster-size greater than 64M
> * 4k blocksize and cluster-size greater than 128M
> mkfs fails with "Invalid argument passed to ext2 library while trying
> to create journal" error. In general, when the cluster-size to blocksize
> ratio is greater than 32k, mkfs fails with this error.
> 
> [...]

Applied, thanks!

[1/1] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-size values
      commit: 87cbb381f2e2fb9aab316187a70acca9f6d5061b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


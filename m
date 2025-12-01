Return-Path: <linux-ext4+bounces-12110-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F84C98598
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5BCE4E5A29
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD53191A2;
	Mon,  1 Dec 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kU+zLRLI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422A334C24
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607453; cv=none; b=DhMUqXX3hOhBWwwMTzuN7AUFovxO9ebOfn8I+3BvsggtbenbGy7VtOiP1g4BjibSi2KVXd0OkKr/X1mIyiIPYo8eCEV19+Le22ML4GQISO1xE/Kv3DapIJce55eE5q2hM/QXAD3xRYOUagCRIQgMridOr2eGjHyp8kzomLU6VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607453; c=relaxed/simple;
	bh=Eqan1lcCS7PhNb7cI4HgmqaYTO6suzk4oCQM1opdpHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByFj8RCvGhK8qWJ8VtwoNx4VIU6ZVCQ3m3gnPkeYDErRzaBdRgmuc3+4oM/mlM4QbTO3ufnD+LvSbTQuDA0jK8VaT7Rz/NY5D3blTMEEUX9QMufB2iKv+wHSPCi3CHhFYxbcGC6dsltf00uhED3R2UTm3pHI2soGGqRCQVRATTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kU+zLRLI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GhiX0028078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764607428; bh=30D1uwVmpUJDMUqwCiius2BLnDO0nEX6+WbV0se7/DA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kU+zLRLIp+HmtfYlDL0OFq1AaG0iFZ4Ym3Tsw0oCnSEoWT/zSATaEBV2RrsWtjG76
	 HfCxpVFdnCOOQTB0vLnj4LsZih1L4U/gTKUJktCidLrqnj0dOEN2ju30YYePsxnSH9
	 kXXgg7D/k0vuMPMUJ0omL4WqJhHQIZ7hT2gDb7KeBVE3evNtdjrkyV+2K1Bat4uFCg
	 4B7KsoaiX2bIerOmlT7samm9YMIC8s8kbzEIPY7pmLQsIPtAXcVM6E6MBCA+bbYWEg
	 wFQ5X/uUPI0gbmLt3fLIj6Y+aEc397DeAf7kMbTC3hjbIo1O6A+TXogM+X5DXCvY6w
	 bAWNVSBxwoofg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4C46E4DB5DFB; Mon,  1 Dec 2025 11:42:44 -0500 (EST)
Date: Mon, 1 Dec 2025 11:42:44 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
        yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v3 00/14] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <20251201164244.GB52186@macsyma.lan>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
 <176455640539.1349182.13217688668593418002.b4-ty@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176455640539.1349182.13217688668593418002.b4-ty@mit.edu>

On Mon, Dec 01, 2025 at 11:23:50AM -0500, Theodore Ts'o wrote:
> Applied, thanks!

n.b.  This is on the dev branch, but I plan to not include it in the initial
pull request to Linus, so it can get a bit more soak testing.  I'll
send to Linus after -rc1.

					- Ted


Return-Path: <linux-ext4+bounces-9010-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284EB05A56
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 14:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DD63AD61E
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84C2E03F6;
	Tue, 15 Jul 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JIovepZd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1392E03E4
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582920; cv=none; b=TBPz2gjmU5WCeCSkCUJ1OPiJRdaSK8t8y5oL2vIt+aMzPbZVHLjXfYPQiB6opor4bwRjfwV3nn6oYqoLJG4jUhMaeuhvCz4Onfj8ex7kx2dSrzg+K490ryEzsItWMIubClDRwrBIs8pSj2Sm47rFVjjREljUnmVVZdCchAUFSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582920; c=relaxed/simple;
	bh=QLo89csj3kq3EH40mhgTDCdEVSZgVt+rpcBpJXUGG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFvxY38R4z2hB1SQCSspOeBSJ3czbaW/+Z9oiMYbRTKvDhYa2lw2fs/P2Q58f3l5yrKfMvjYfaaZrC+p4tRAUeM4KAgBY4ir+4Sw6gJVwzhKXV1Qat88qWawonEl2aLYiJrhkOtjWigHbumrRQtrwfIpa8XWibOKRIgx0+BUhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JIovepZd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56FCYsKf005184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752582898; bh=JEmCrzAwkf+pL0BE8Ts9Gq27U59HE+yr1Fpegkv0wnE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JIovepZdZp+sq9wxOa24YaAKQWfwpYH1SYaeUwfRXHpK8nJQkO+8vCn3RYRiEtTH3
	 81C2l7YkvrB2um8E9Ww1eKXO09w9gg2VjLHpt7VOP/tf3Fnyo7y8wakIpKjiXoqmE3
	 ny4+aiCsgMFiPiAnlQ7HD+BttBiuKBFqUv6ImjvFWlOFEIAVXu43o6Uyg+98AxaAWB
	 IwSyazeqUSQA7u9akobfmwYqAD4I6hFXQiju5tH2AXKgGYMBBckwqIFtkdo1YmhaS7
	 cpwMV5SoyXWzxLnyFnBQe+ELxfkaK7HRwGiaSAQeHTArXiox4HFBTccDNCrWOzIIpY
	 ate9EOnTdKBzQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 98FA12E00D5; Tue, 15 Jul 2025 08:34:54 -0400 (EDT)
Date: Tue, 15 Jul 2025 08:34:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: chuguangqing <chuguangqing@inspur.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported
 flags mask
Message-ID: <20250715123454.GD74698@mit.edu>
References: <20250715043808.5808-2-chuguangqing@inspur.com>
 <20250715064536.12053-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715064536.12053-1-chuguangqing@inspur.com>

On Tue, Jul 15, 2025 at 02:45:18PM +0800, chuguangqing wrote:
> Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
> has no functional modifications.
> 
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>

I'll note that this isn't something which any of the other file
systems (btrfs, xfs, etc.) is doing.

				- Ted
				


Return-Path: <linux-ext4+bounces-1173-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948FE84E450
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3376B1F2809A
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14C7CF2B;
	Thu,  8 Feb 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M7U7blLo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB87C0B1
	for <linux-ext4@vger.kernel.org>; Thu,  8 Feb 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407421; cv=none; b=j6un6KqfTjs8iKYTFx6/tTCNpTSn4nmo/t4Lci72RkJaswjUjb9MmXX4AI7Ej1xpu8yfrQnZl6VS/8nRevYYIGywhpsROc0/tjEmNqF8I8x3oO5tjk5YTOEwNqfewlwrBgYgj0FY7YIpExs36lcAtyoxxM2b2QOylyukWtWveLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407421; c=relaxed/simple;
	bh=WSy+Q3kL6s6Tm7tFF/EMEz4Q1UDDpZkZpnF97BK9YRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXf7fD0Paacqqmbz8r1vGETCbQ959v5gkgdlf7WFkly0OJwg/vnJ/XUiflOogYlcY5XQFc7Z27w3iuhTBGSUakJUD392l+5cBqbF6SLCdauExVLxPnN7wSHoI7tl/ww51RJK2yQp5K5gqSb6sgpLOvjHkZHE94iKUA81Ne4D7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=M7U7blLo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 418Fo8Y6003263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707407411; bh=jjTySAmDWazBdRiROCnsHtSBLtmQJE1TyJgEElvUuLw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M7U7blLoexAxafygQsjGYvwmlDic0VmlQwo7b6iN3mr9eWarfIk1m/H8AaaEoSDpD
	 C+D9W0ata2vr9HUMluq1FBtBcILlqANzUSIkTURPZZUtskkQSa/Sk10t9DBaHomw4+
	 9BvYJJXnRKEQTPh6TohkEKXa/mg8RInV2OusmjuXotvIr1J6j7QM8O6vdGr8575jpi
	 dEoVxnM8HLPJWmxPxAiJYWQ4bhaDkE0mIBxOeKAbDh2LrjGjpIwYqLH0dW3B5Je8bj
	 K5+iFXPBiMPdKBowXXknB7d0MNLP1CAht4s7J83ji33Bb4qC7F9GXYtE9UG+jtFfTx
	 YqRsfrUmF2bUQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DDD9115C02FD; Thu,  8 Feb 2024 10:50:07 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca, emoly@whamcloud.com
Subject: Re: [PATCH] e2image: correct group descriptors size in ext2fs_image_super_read()
Date: Thu,  8 Feb 2024 10:50:05 -0500
Message-ID: <170740737332.1017699.9884744937933019259.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230714005958.442487-1-dongyangli@ddn.com>
References: <20230714005958.442487-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Jul 2023 10:59:58 +1000, Li Dongyang wrote:
> In function ext2fs_image_super_read(), the size of block group
> descriptors should be (fs->blocksize * fs->desc_blocks), but not
> (fs->blocksize * fs->group_desc_count).
> 
> 

Applied, thanks!

[1/1] e2image: correct group descriptors size in ext2fs_image_super_read()
      commit: 633ab26eefe1b037eaba82d9a3555eb712c82345

(Note: this patch was white-space damaged so I had to apply it by hand.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


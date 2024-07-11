Return-Path: <linux-ext4+bounces-3206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88492E932
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F7D1F2435B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175515E5BA;
	Thu, 11 Jul 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="b0LPS3md"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238F15AAD3
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704056; cv=none; b=Evykve1sKck56R6J7XsXSUHcnGHnpO+zo8OR/l2iqSddBzaq4T4aejVVHBzyMjEP9/iSXYW3TbMWj+/2JQY2Vg6yvHzPMmoPeGZ23ZeK8pQvOnlirGq9LwL+81dydkINGXos0XAds5LZRX9CF1gh+ZeRy2pWS8AUePZydvoMoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704056; c=relaxed/simple;
	bh=FbL0TgzT6ocnHHvUX1mSgg+zK778KWtAlQICC7LPCe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUBzZy/P3BwsNPmoWa46ZA42und7B5qwJDJ/GYgvEWi3JG0OH4tt1fm2BqLPuvXKfVltlRNw83dzLqVYzHXpFPxoSkTCPgW1Mu7SrHgTRQz8pVCvZb0+Eow+GQDam7FWPEJQS4OiOH5AugnFjY1H+/UDfRvn/3tlh5uhz0EFueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=b0LPS3md; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46BDKJeO018766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 09:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720704023; bh=BDoQVMXqCNbGq+2qbJID2rkFfVRvdDyFotXLO2VBLys=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=b0LPS3mdL+aX40Dsz/5cj/TeURbuUHsZzTgmNQvGqlWWE1LDkQLfve+ZP0iqgcnpe
	 4a27H7YLYbMmkqnPMbXc1IAjzKNJXkm+1xpJKABpKa+QJTAs8His/16Wdn2quo64z1
	 MI+MbWY0ga0JUGWy8ejhKjFA0W2EJoFEd81Sr+OrOUUGEXcpw8kUT5tiVXfz4BGdtu
	 hXo89yPzNJ/FRoDsglKBoZdLKJHBO0/4oOzMfgl4K30gpaICPXMyP1RquswIgR51ck
	 bSxd2HVOK2Q/ya01gz4agr5Ra0rozizkiZBZPvvABZLwMs0mJxuz4DisEEpn8LP75c
	 JdHN+5FbGdj2Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6E47315C0250; Thu, 11 Jul 2024 09:20:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 0/2] ext4: fix unable to handle kernel paging request in do_split()
Date: Thu, 11 Jul 2024 09:20:16 -0400
Message-ID: <172070399446.484586.7078607418621492382.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702132349.2600605-1-libaokun@huaweicloud.com>
References: <20240702132349.2600605-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jul 2024 21:23:47 +0800, libaokun@huaweicloud.com wrote:
> "kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.
> 
> Baokun Li (2):
>   ext4: check dot and dotdot of dx_root before making dir indexed
>   ext4: make sure the first directory block is not a hole
> 
> fs/ext4/namei.c | 73 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 16 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] ext4: check dot and dotdot of dx_root before making dir indexed
      commit: 50ea741def587a64e08879ce6c6a30131f7111e7
[2/2] ext4: make sure the first directory block is not a hole
      commit: f9ca51596bbfd0f9c386dd1c613c394c78d9e5e6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


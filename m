Return-Path: <linux-ext4+bounces-6852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA3A66790
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D773A927F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443631AA1E4;
	Tue, 18 Mar 2025 03:42:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5715B102
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269326; cv=none; b=lsT5gsggQlVw9UQKWDoDB0b+TNY0mHTdRFoEOmnKHH7dD9uDVRKA/CyBRImfYTkj5tFYvKATYpT/Ruu+XQw5tTI81qvcGfvvMYPuv+dLK35rs1FS9FZxukXuEdwv+VIwrdPBxSRFNlQGKaQM8zSRjvaGYu8VGTBtGIlUwce/SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269326; c=relaxed/simple;
	bh=kzq32IE7lD29gU2wUYjbjI0mdHedGv7cTEm/qpdsfrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd0TuAhmGAyH/DQXn7B5f0odfr9krMI0byESKA5RRPYs4yrbpidyHQ4vwTON2E45FBYJnZksXDMbRNB02zSdKBqh6LnF4T72dnWQhpGmTY/ikq839KXktnAitGRPt6O69Da7mJlySUnXAbkglvLsWMM0TkxYL4x1F+moW4aO5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3foYC012183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:50 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 03A4A2E011C; Mon, 17 Mar 2025 23:41:46 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz
Subject: Re: [PATCH v2 0/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Mon, 17 Mar 2025 23:41:30 -0400
Message-ID: <174226639136.1025346.13786150876375235196.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208063141.1539283-1-yebin@huaweicloud.com>
References: <20250208063141.1539283-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 08 Feb 2025 14:31:39 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> (1) Wrap the arguments in parentheses for PATCH[1];
> (2) Call xattr_check_inode() in ext4_iget_extra_inode() for PATCH[2];
> 
> Ye Bin (2):
>   ext4: introduce ITAIL helper
>   ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
> 
> [...]

Applied, thanks!

[1/2] ext4: introduce ITAIL helper
      commit: 8bffe40e9e9ce7827f318c8cc050d28f1df502fa
[2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
      commit: 850d8d9ff97aa5c45a9efe036ce459dd9f4fb63c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-ext4+bounces-3866-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824795B939
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 17:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7256FB275AE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3567B1CC88A;
	Thu, 22 Aug 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VWFgd0TS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A671CB135
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338845; cv=none; b=L+z/MyWNi6KPMtgX6jGNWgJtzwrXA+A92mHDE5PSmFOLlZMhKjSZGxrzyLynpR9Se3DQ0h7r1dGv+lmzRs3JW/hU5+i7BL2GQGZm97QDJRu1sZgdaR51feiS2YotMmtbcwkdMztJVVVgHa0ntJT6rrfbdn9SYtyW5J5mhHxX6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338845; c=relaxed/simple;
	bh=9MmF3OwinZU57ZeQdvO5q5U9hXfnwUZyKjxWoZmXdSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0yj3kTXe2RWuT4ZATRsTmGcJ26/v0L/5fnaXUSjFKh4WbCZKrLoaAknqTB9L+p4BStDfcC4YNZmckKwKxAhVqeo9b+ZCr68tbWXOrB+C7ksbMfZM8ObKIrs+syw/v2Mm/4NRJpwAhN1tCBGP/OqiTwgnm9nvwKEmrBRUAVV0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VWFgd0TS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0O3b022430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338826; bh=PJeAnoJXdEfUH82I933bZUUEq15CB74p299DfwOQAnE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=VWFgd0TSgw0Z4ia4OQNb+DL1zYavDG+kRxEstqOjlloMzmh8rfHTo/XFbrJtN6CBd
	 nDVI+HtGUj6+M5/Qyalb1cw7NjKvT31XOgp2pWQbRea4tPmHMPfL1l5qXie/PNsMqZ
	 qN5pcuTprbs2Vt/SdUief/ve5tcODukj/8YQvZmGsHPxhxwta1KsIfFh6C/nRPvjdx
	 gXCWqmwIcibId3K+WLyNajiCF3zuTpIacLUA5o1Ggxt9LcaZpY72LDenocQPY1G5zi
	 OgsJyimoc5u3KLx8KGEMWdA025XRz0FGmpz1ejTaRTmLlnlA8rVqdIXO8f8IZTAn1z
	 J5pC4ZXXJSf3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E64AC15C02C6; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, "yao.ly" <yao.ly@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Correct dentry name hash when readdir with encrypted and not casefolded
Date: Thu, 22 Aug 2024 11:00:14 -0400
Message-ID: <172433877725.370733.10136882872193689804.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1719816219-128287-1-git-send-email-yao.ly@linux.alibaba.com>
References: <1719816219-128287-1-git-send-email-yao.ly@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Jul 2024 14:43:39 +0800, yao.ly wrote:
> EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH will access struct
> ext4_dir_entry_hash followed ext4_dir_entry. But there is no ext4_dir_entry_hash
> followed when inode is encrypted and not casefolded
> 
> 

Applied, thanks!

[1/1] ext4: Correct dentry name hash when readdir with encrypted and not casefolded
      commit: 95525bf5b13d28d55fb61400c9e97db6ea7da5f4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


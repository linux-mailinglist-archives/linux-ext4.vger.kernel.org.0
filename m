Return-Path: <linux-ext4+bounces-8070-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D47ABF878
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB3B9E360A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1C2236E8;
	Wed, 21 May 2025 14:51:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B60222582
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839089; cv=none; b=NlLu1OtteqNumb60xDuF0qNWcTAlwXbwACR1k30CGYwd6oZM8YQ5kMuLvCfWBUqcYauFXdopyXUEhKBrO7AHxSBG/CvabL+oudSVig8akRPcI8YheuHa/quMpcuAq2OTQZhLmu7zt7Ppau0Q2wBdf9z9bYy4PIi3tGVjhwgpxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839089; c=relaxed/simple;
	bh=zL1Wfn+C0snj/WedF39Ol206Mx5fsz2wKlTp5R1X74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwnPalyx4ZE4yPShNZEnFkFR8BFa2HpomuZB13BHPiwZ/Rk/cq86eRDebie1NY3An98gi6Hrne/SOUG0VTxUyoNNZaWEgx6TUjvnekoPoS0v7YM9Xz9Z7qpi5nEIOkU5u2rhviT6brtjrzCTh/Ly0MehZgVOTp26AldPjm6OHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpEl0001404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:15 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B3EC62E00E3; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 4/5] fuse2fs: delegate access control to kernel
Date: Wed, 21 May 2025 10:51:04 -0400
Message-ID: <174783906008.866336.15136401398915838196.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174553065332.1161102.2163541286559749682.stgit@frogsfrogsfrogs>
References: <174553065332.1161102.2163541286559749682.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 14:38:46 -0700, Darrick J. Wong wrote:
> To speed up fuse2fs, let's allow the kernel to make the access control
> decisions for mode and acls instead of crappily trying to do that on
> our own.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> [...]

Applied, thanks!

[1/2] fuse2fs: refactor sysadmin predicate
      commit: 36f691d3cea9a8941f84a8065ba7b2e02380a14f
[2/2] fuse2fs: delegate access control decisions to the kernel
      commit: bc76e0f7fe1e919492c035c918cbc9182b776049

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-ext4+bounces-8049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C4ABDD6D
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122327A9FE1
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD424DFF4;
	Tue, 20 May 2025 14:40:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4524A057
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752034; cv=none; b=WfAmEG3IdRrQOpbAdJe/nFgjdSspxD2Qmzd6KrIF1pKSIniU+N3lGd1wThn3SaW/4XKoVcFrUGZBWjcIlfLFCGUHpWAaPOX8jQffFNEiCTPU+hkIV8CDnh2GiG+eSdFWxXRwtFeSAJxv8jBdB5Q3hJzOOYNcTZCrD0LZVTY9DUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752034; c=relaxed/simple;
	bh=y9kcVMZ4nTYJPNMaYNUh1ztMTbSql//rXk7p0pjmQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uml4tbGchz9x1TXQdOuQ/yjz8RZub/KkArXfCMDyGcdkFdsQUIkFKrjqnxaM//mwd2KWeXzV+2gks2DNJf3SBlom2syTh3nPZWwQS+jAfyiRo5o3t8Dhfr1t5Ml1+EAZAXpeg8k6ABC11+lI5E4IkESdwu9Nyd7PFK52WB0CNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEePYg013143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BED772E00E3; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, harshads@google.com
Subject: Re: [PATCH v9 0/9] Ext4 fast commit performance patchset
Date: Tue, 20 May 2025 10:40:14 -0400
Message-ID: <174775151759.432196.3949785753150093426.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 May 2025 17:58:59 +0000, Harshad Shirwadkar wrote:
> V9 Cover Letter
> ---------------
> 
> This is the V9 of the patch series. This patch series is rebased on
> 6.15-rc3. This patch series fixes FSTests errors introduced patchset
> 8. To fix these errors, I have added a few more fixes to "ext4: rework
> fast commit commit path" patch. The summary of the changes is as
> follows:
> 
> [...]

Applied, thanks!

[1/9] ext4: convert i_fc_lock to spinlock
      commit: 834224e81cdc265456f73fed748a349e43e2d8ef
[2/9] ext4: for committing inode, make ext4_fc_track_inode wait
      commit: 4d3266463ed06af2916b306bdb0ebd647726ba49
[3/9] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
      commit: 0b64fd74dd2054834c98867422bc9813e3bba8f4
[4/9] ext4: rework fast commit commit path
      commit: 857d32f2618166765ce9306a246d0745afc76859
[5/9] ext4: drop i_fc_updates from inode fc info
      commit: ed45d331135c317c7f80e8c4e0dad644ca8ca9dc
[6/9] ext4: update code documentation
      commit: 69f35ca189300ddba29a16214159beef45bbd984
[7/9] ext4: temporarily elevate commit thread priority
      commit: 86e07d4b9b0497afef78af773c74258c8f63030f
[8/9] ext4: convert s_fc_lock to mutex type
      commit: 12e64e7f859ed19c5bb497866284d0318c3194a2
[9/9] ext4: hold s_fc_lock while during fast commit
      commit: 6593714d67bab860a733d07895a94404f4ac3039

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


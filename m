Return-Path: <linux-ext4+bounces-6942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F097CA6C76F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 04:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EB21898528
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 03:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8B78F54;
	Sat, 22 Mar 2025 03:36:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3633D8
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614599; cv=none; b=JcqV95nngMRsZExw+0lALWlaijsGcwH5kE4ZZjIoxlOgGcBpy95m89H6ogOhn26gk73zZSYceUtCIlOdFxqitqRo7W59VMFMnIAiwbTQ19mSiFKr8Q19cEWYr4GefYwOHe4CTdWqn/glrpDZGlquOimd1zlbkRUNXbMt/qs43bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614599; c=relaxed/simple;
	bh=RzWxGX0gt0H7R6LSshfnsfipRDDjCoPVTdnFp0GcqTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDypWrtZCHypAajneJEp7jghqzvzZ1hJJd+Y3JdYQQHINpRSgmxcMiKeE/1tJ7f/Eln9tf3QVTL5ga/SgcNxdXkArw4bUXKD8bNxm4rekg7yPyqjudRdcQ24bFHJ6IamIQg4dR7MgfgW7j+bkWR6O9qzAkok2ximT3IQZZg7RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMaA007710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B6F972E010B; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Acs, Jakub" <acsjakub@amazon.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, acsjakub@amazon.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH v2] ext4: fix OOB read when checking dotdot dir
Date: Fri, 21 Mar 2025 23:36:14 -0400
Message-ID: <174261457018.1344301.17270350351088330714.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <b3ae36a6794c4a01944c7d70b403db5b@amazon.de>
References: <b3ae36a6794c4a01944c7d70b403db5b@amazon.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Mar 2025 15:46:49 +0000, Acs, Jakub wrote:
> Mounting a corrupted filesystem with directory which contains '.' dir
> entry with rec_len == block size results in out-of-bounds read (later
> on, when the corrupted directory is removed).
> 
> ext4_empty_dir() assumes every ext4 directory contains at least '.'
> and '..' as directory entries in the first data block. It first loads
> the '.' dir entry, performs sanity checks by calling ext4_check_dir_entry()
> and then uses its rec_len member to compute the location of '..' dir
> entry (in ext4_next_entry). It assumes the '..' dir entry fits into the
> same data block.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix OOB read when checking dotdot dir
      commit: d5e206778e96e8667d3bde695ad372c296dc9353

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


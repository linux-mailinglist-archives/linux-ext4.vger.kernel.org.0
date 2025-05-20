Return-Path: <linux-ext4+bounces-8053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB312ABDDCA
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3E7500335
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF1248F6D;
	Tue, 20 May 2025 14:40:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152F246767
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752051; cv=none; b=LzzultFcgf4b+syX14LH+gK2C+niJLAzte8ZgxKNIa5UjTvTOC7gAFSPCW6j8hxdT3AHTp4IXFcOZ9WJ2BAG6yT7S3LdzL0jZh63+yqG3xyJ/AtawO4dnHmKYe0TBDQ30b3RmYBCtdn3Fir1LQ9z00OoR1a7BlGrjl9HsJE2wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752051; c=relaxed/simple;
	bh=RxEXSvsHhqY0DGAOiz1+rJd7062BJqiB5VbH/Bb7YLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ork+ADqPquAqSUeS34u1f9syTmIeefsXM/tr2X9h8+UAlzp22pZ/tpRNbYO/5txlfyO5PrxUQZL9OLuQaaxp1YddUGJwEjsu0h21/MvbuWM/oesIoznIVrnS07+5AMHGMQDi50VFiLlAgFN3G4q7n5dL9473jBEw7gZYmqqA1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeOut013127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B9FEF2E00E1; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Tao Ma <boyu.mt@taobao.com>,
        Jan Kara <jack@suse.com>,
        Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com,
        syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: fix len overflow in ext4_prepare_inline_data
Date: Tue, 20 May 2025 10:40:12 -0400
Message-ID: <174775151761.432196.4462280436120329643.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
References: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Apr 2025 11:53:04 -0300, Thadeu Lima de Souza Cascardo wrote:
> When running the following code on an ext4 filesystem with inline_data
> feature enabled, it will lead to the bug below.
> 
>         fd = open("file1", O_RDWR | O_CREAT | O_TRUNC, 0666);
>         ftruncate(fd, 30);
>         pwrite(fd, "a", 1, (1UL << 40) + 5UL);
> 
> [...]

Applied, thanks!

[1/1] ext4: inline: fix len overflow in ext4_prepare_inline_data
      commit: 227cb4ca5a6502164f850d22aec3104d7888b270

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


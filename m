Return-Path: <linux-ext4+bounces-6804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FEA61CFB
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B00219C495D
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A42046BA;
	Fri, 14 Mar 2025 20:44:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551E1632D3
	for <linux-ext4@vger.kernel.org>; Fri, 14 Mar 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985077; cv=none; b=n0HJk5A5YLAUdBhwiXj9UTNZCyyMk0ffa9Rl5peruIXQ/4G8e6pHXUMHyMd9XTp5aPAJNAORlFY62lG0U8CU2eaeemuDBlZ9/hnhaV8MuCtBj2caXXg5JaCGod7oLYp6FA7E5mgbT7kBhh7KtCLOV0d/NVIUwjCKZFXfRD6Fp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985077; c=relaxed/simple;
	bh=JTug91DDzeW8Js7CBtR8k4fYK0QGW/tUwjrdF/hdmpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj17TqCTzZ0mg2Hr0Tjiid7UGHc9DfcOgWC9g1YfsqebMcLhrXcaY7gWx/ZDL2Ql99VwNQ1hbCOgQbM7TGnhwc0lLyxWPsB4UpbqDZvc/LNISnpCU6Dx0eWRjIr82I2reiZO8kRy+TT9E8dHeRpaIZ8SRryQUvvUnCgvkLIwCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-144.bstnma.fios.verizon.net [173.48.123.144])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52EKiOQu017469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 16:44:24 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 01EC42E010B; Fri, 14 Mar 2025 16:44:23 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kvm-xfstests: fix wget progress bar support
Date: Fri, 14 Mar 2025 16:44:19 -0400
Message-ID: <174198505157.785222.7149997045581775311.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221115601.170674-1-ojaswin@linux.ibm.com>
References: <20250221115601.170674-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Feb 2025 17:26:01 +0530, Ojaswin Mujoo wrote:
> On fedora 41, running kvm-xfstest for the first time throws the
> following error:
> 
>   Unknown option 'show-progress'
> 
> This is because fedora uses wget2 where the --show-progress flag
> has been replaced with --force-progress [1]. Hence modify the code
> to detect the wget version and use the appropriate flag.
> 
> [...]

Applied, thanks!

[1/1] kvm-xfstests: fix wget progress bar support
      commit: a91591289b55cc3d3d2d730faf024ed986365a0a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


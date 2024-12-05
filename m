Return-Path: <linux-ext4+bounces-5491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01339E5A3F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2024 16:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CF16BCA6
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2024 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0921D583;
	Thu,  5 Dec 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kyOMu0d9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE821C180
	for <linux-ext4@vger.kernel.org>; Thu,  5 Dec 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413942; cv=none; b=E7cwOdVCzS/PPfyiDaGoj6qTswk7rniel+jf0uUJ/LdNhzRDpG6mkguIoFtG/K5CGSYUZCvSXQS25jW+Vi4fmhjNG2ZM3ZN2T+eRr8SvqDhBc0LvPyryu+1aem7kZOCiRaWRTbWb4yEQ6qOSOmbh/PlR1yx93ym4k4Y2m++M+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413942; c=relaxed/simple;
	bh=OFb5pCqE5Vr7UjoXSZwmgRnrIOLjJ2DRdYmdrugZeGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP36qEna7SNCGqvYXuohCrM6qxHi1K1zwwXuOayuA/hX0LlFgONZb9YlGJMGAWW9UrycpgAhZuO6MDp3GiEC2d/UHvxaeIOHkggmcOZ4E+vb9lchs50mk/jYl4f1oijgH9Oec35Zx3RxsRASeK8KxMTEWOfr5ZdbPGGTQYjn2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kyOMu0d9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-114-21.bstnma.fios.verizon.net [173.48.114.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4B5Fq5r8003674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 10:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733413929; bh=V+0iO76D70yJmaHq2EXpsryvs20aeKRqFDwA89qnsTU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kyOMu0d98qQvrKnuMt5LZVssm49cOSHHx+Lk18PI3Io1s9MyyLseOtrkw2nElTzky
	 sQI7OsfacqsszD8/0NZSfTugt5O9syUwHM3K62HZfqtrYLW201/93KfYTeHOEyGuI8
	 tAQT9OXCzpwH8JCXs52gP0MMJkqkHkAWJd5mXzJsCKEcPEuBok5eSHicTzcnVcP7lg
	 MsWiKMrA/f4nRnsLbm7xsWTcyzD3UIhzgMRjHLyiV6s/4MBYDOA6OoEC6rCPgGqInh
	 3lEYJXa0z406YuK2LQaCxOp9ve/Zo1+3bCgCSHyiIgsqACwRQubW9CA8WXTsA4SaS8
	 tssmp2bbFFgLg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 306F915C035E; Thu, 05 Dec 2024 10:52:05 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tdb: fix -std=c23 build failure
Date: Thu,  5 Dec 2024 10:52:00 -0500
Message-ID: <173341390881.1261959.3716122132959734958.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Z0B60JhdvT9bpSQ6@6f91903e89da>
References: <Z0B60JhdvT9bpSQ6@6f91903e89da>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Nov 2024 12:36:32 +0000, Rudi Heitbaum wrote:
> gcc-15 switched to -std=c23 by default:
> 
>     https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212
> 
> As a result `e2fsprogs` fails the build so only typedef int bool
> for __STDC_VERSION__ <= 201710L (C17)
> 
> [...]

Applied, thanks!

[1/1] tdb: fix -std=c23 build failure
      commit: 49fd04d77b3244c6c6990be41142168eef373aef

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


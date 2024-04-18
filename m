Return-Path: <linux-ext4+bounces-2143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B358A9D46
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5121F21D18
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26036161935;
	Thu, 18 Apr 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dwh0Q1Fb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3115AD88
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451176; cv=none; b=C7CS2nn1kgh7wo5paAE2Wttdhdc564UM2txj2sYRGOwbXFFsXj1djrwquF4UkeHkxZv6EAC/zgGhJFLWd7OZSdNAkXoaVQi7v194qsin0B6RTIhtv0yyKqPS5hnQvkD7YoIYYXnXQh2Q1m/YBZjAW3EDPB1Qkjfzvu/lKz7139Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451176; c=relaxed/simple;
	bh=9onWRlQXZ6y8wf9f3R0IimZTzT926H8muDPhJ2fcPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTL3w+RgJuYME/sLmDMlUcMBsdbDiBsBDWCjb0aOnpK/CkQQD73QdnGS5tjxYg0mNC0cWgFAvhcgoRfOXrkYYmeef26ueksxZBe1UYZUCjfu+UOiUe4r35RgJSb+Tpvj4X+xe4Dj0Y9AeUWA4AaFTH6Hlw/QSnrf965PIdWU7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dwh0Q1Fb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43IEdMMW010585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713451164; bh=u5kBnX8uW7WJccju1kpTUs0+vfktGb4ko5jTKCnLiG0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dwh0Q1FboIcdbvbBNVBZxFmy4I1eouNFfH0EKfUJ8zrSQBmz+hEZDqvVVP4mDBwCS
	 o1QOv/AK+yuAQkuAPnl7yKpkO9NhRsSyWBy4PT7G3vtK7ph5Z8Qt5vpVVMLqe8eil4
	 fTdsqWskoyXg/UmPuL4TV7m057smNlEVuAH1nqsM4Aed6RZlZBnLO/tfoSXAHewe5m
	 i4HWJj+hVPwzINZCf6v/PCpwiICTkV63sJteJjWljzI3IEWvvCJA83x5ZWDLg45SDg
	 qE3XD8zi7ycjF1GKyH2pYQwvxuP+IFLFrusLfid14ubcQbbOSLNZAMyuP2ueG/tINv
	 fM121S6cbuMRQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5CF8415C0CBA; Thu, 18 Apr 2024 10:39:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakub Wilk <jwilk@jwilk.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs] e4crypt: fix spurious "Success" error message
Date: Thu, 18 Apr 2024 10:39:17 -0400
Message-ID: <171345110558.3373948.7028509495340755466.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227080805.6801-1-jwilk@jwilk.net>
References: <20231227080805.6801-1-jwilk@jwilk.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Dec 2023 09:08:05 +0100, Jakub Wilk wrote:
> Before:
> 
>     # e4crypt set_policy 0000000000000000 /dev/null
>     /dev/null is not a directory
>     /dev/null: Success
> 
> After:
> 
> [...]

Applied, thanks!

[1/1] e4crypt: fix spurious "Success" error message
      commit: 1275bbaaea7ffd42346789f945c2f4dcddbfbbc8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


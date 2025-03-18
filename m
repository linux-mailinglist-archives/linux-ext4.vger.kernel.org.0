Return-Path: <linux-ext4+bounces-6848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A5A6678C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84DE1768AC
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA87017A2E0;
	Tue, 18 Mar 2025 03:42:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4E1865E5
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269320; cv=none; b=g2TgAJHoZ7UmHuMZjt9Ur6tOdOmntK7QpeLw2op7XjGFCJTKCv6ex0onq+MfDbrHkGp7niUX6fjjhFbpHDoQ8y36VEayYRJ/stuexeTT2e5p0J5u7vUnibiR8rgQQfDiZB2WfivdthYK1UUNqT7q4j9sxxKMkh2aq+62nLXmRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269320; c=relaxed/simple;
	bh=dBei2C2cQisEz969+xcBnb3veuR5QYmp+2mohJ2Tpxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5149XKgt9/PFEB2vq9Q6C76RS2o6jazWCgDUGxRfWXe3Lb7L613f2MHn7x1SKKk2ULKBBPcN/JFPF0XFC01Amewtl7lOcJ/PLojjUZxLQNKk8nmexesWGZCJyKABaTovyfBkrajt+YShqAWQBmSjgojWuq/l6zGkpFxBMaUPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjfa012115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:46 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D07272E010E; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] jbd2: remove redundant function jbd2_journal_has_csum_v2or3_feature
Date: Mon, 17 Mar 2025 23:41:16 -0400
Message-ID: <174226639135.1025346.15078940445988713322.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207031424.42755-1-ebiggers@kernel.org>
References: <20250207031424.42755-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Feb 2025 19:14:24 -0800, Eric Biggers wrote:
> Since commit dd348f054b24 ("jbd2: switch to using the crc32c library"),
> jbd2_journal_has_csum_v2or3() and jbd2_journal_has_csum_v2or3_feature()
> are the same.  Remove jbd2_journal_has_csum_v2or3_feature() and just
> keep jbd2_journal_has_csum_v2or3().
> 
> 

Applied, thanks!

[1/1] jbd2: remove redundant function jbd2_journal_has_csum_v2or3_feature
      commit: f6fc1584f500e0c036190f235b0857c6b05ee0d1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


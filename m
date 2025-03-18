Return-Path: <linux-ext4+bounces-6850-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C263A6678E
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CED189ABEB
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78861A08B1;
	Tue, 18 Mar 2025 03:42:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE61A8F89
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269324; cv=none; b=LyL0W/wA5vlrykJy4tOYuzCGSrsV6U2GH/F0r2ep+0yj+bMUAh5Gq9Qzkq1EpyuYkLElSuk5QuXQrm+EudjVSlGka8bZjnXjG87nI78Qgc66//dXteWvo1r3r3V0QgWjfT+YdJlaXxYDlb1m9gSY0/JoNlG4jNY5X2Mte0Qagek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269324; c=relaxed/simple;
	bh=9eJd2c2jI8tonpAzZVV70wU8FI0H8wvqVyfQSv+Q5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjmLt283gLA/zCyq6lyw/16qK5y19lBbuqUf1JzbcuguGRrVzO2hYeekIO3cEHJmZBIBLQ/fGKaSGdy50JBgdj3GWGpbTjmm8oUnHhcXUfea+nh/ARwKPH4v+TNirVYRzCx5yInIkNpc6NUkn4TCjR+K/aXPxdOrFd/WjBaFibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnxO012168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F21AF2E011A; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove references to bh->b_page
Date: Mon, 17 Mar 2025 23:41:28 -0400
Message-ID: <174226639137.1025346.16102247341347415028.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213182303.2133205-1-willy@infradead.org>
References: <20250213182303.2133205-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 13 Feb 2025 18:23:01 +0000, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> 

Applied, thanks!

[1/1] ext4: Remove references to bh->b_page
      commit: a5a1102f81be238f21a1fbff00f6229078d44daf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


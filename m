Return-Path: <linux-ext4+bounces-3909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567CE960AF5
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB61F2209C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B01C32ED;
	Tue, 27 Aug 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zl7YOZGO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004741C0DE8
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762877; cv=none; b=NkzyGCeicSNe/k0rcOdm6Kfsxrm+fuQZIMOfqeZrcxgrvYgNncRh5TKVmNV+Nlv1h+WCLrVoka+EFEDIvgpKOfp4p+FpIlLZ7rSEzj87Mm96CRJ1k9DBvg2yQnevhMCUahAvcWPe3V/C7LOu0yZJ8Z7dP00m64Y4mezcf0d8wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762877; c=relaxed/simple;
	bh=BkR66Rxn7CKsiWyF0wNqTkgsLKmrndjLEiy0BCV1+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5qEtPd5zLp+2FNXVNQUCuwWnK+in4mxUU2vUF4KtaBeafA26gPKsweSWh0JR1ONsaObWiOaO5kzt2AvoPxrgPhEJyvVZVz5IEOaAzZvdkzhb7KN3JvPoTovknObS4KT6DZXGotKkyEOH3XD2qFFXCkRCFbSZIrf+0kEDA2Tbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zl7YOZGO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RCleQ2021490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762862; bh=Tdbr3erC3C87Tpj+QDL7eRkJIWDz+3mi2LufyrVfNDA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Zl7YOZGO/IslKoA8cjDhypYMDnbWqO/+nFzTMtkT0xg61I7dc1VqxDWqs63JGIOYu
	 p+ODCAioieveZ8MK6B5ToqZcgHIIvTuY05PKm3RZ5bmmZlz77KudXgdp6uhuNGAxvF
	 ey118KiSoasck8U+XKAl1Y8YI3KXjIBYF2rXgLzuWUF7B2WHIVvmH10zyBBasSg38e
	 iVU/ngR8zhIdyFPXFJsFt2X5pFsQFvbQPzV7r8bGFbjvr1junU9GHgWVqFUfSNvqJx
	 i1yZCu7gS+tyKsLsspnC6NsxkSjWIIvdI/DF9YDIm8CBje/1qyECIdlsD711Cwd+mx
	 IoK62EISz4fDQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B812F15C1909; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Tue, 27 Aug 2024 08:47:26 -0400
Message-ID: <172476284018.635532.11127658295639985238.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717172220.14201-1-luis.henriques@linux.dev>
References: <20240717172220.14201-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Jul 2024 18:22:20 +0100, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> [...]

Applied, thanks!

[1/1] ext4: fix fast commit inode enqueueing during a full journal commit
      commit: 6db3c1575a750fd417a70e0178bdf6efa0dd5037

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


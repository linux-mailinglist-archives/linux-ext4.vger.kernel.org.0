Return-Path: <linux-ext4+bounces-9375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4DB26A35
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BF5A27D5A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103F2192E5;
	Thu, 14 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DxLbOwF2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFB20CCCA
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182973; cv=none; b=pgl418TutCrqu193n1SJ3IN/Zk130VFbtI8iyJqVI+yRbmv1yZTxGi0oXUxEu6qQ8qcWJ1prmRqcO3OEqHaBubwqMfv1XoQpBWaRtw3g7X63qmYKKEBNiXhW+Zkux3QkxaWe8tF01bDBJSloP45K/HIQlpsqrT+ZXi5BVBwmaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182973; c=relaxed/simple;
	bh=65Qlw9mCW05HC8nqjf7hl/PAv94A3ewrr0LGuyxTuWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWmFbYeVD72TwQ8S5n4MNCCctvEBrymDMX/GJQQf1IWSDOS6esLCGkPb+4Ehk9qDmX8E37dtsKD9pgxQkqo+292yco4gdZwON7/U+NW1f/H6zjSSzocAia5zmwnwRD2hkaoe7mkyhWFpdxcM2immkf3p2LpR+l2OdRIKyPUhAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DxLbOwF2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmpOT028598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182937; bh=X/u7DAPn1uapDj6cV4WX9wukkt3WAmbf0bAmypGYwn4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DxLbOwF2wOAIgSdNMjLPzoCrm1YWIoDJHscecnFT++52pfsyzVZP0zrWAGMjLnQSe
	 WoZQ5u7w+vYbN9ZKOwtaANDvjg4i1VU0INNxwXd86oBXawBBRfD3hNukhttLyAVCEE
	 IH3A6wlIAlq8uMxLstBEfE8b/wL21H1ZpBW4Hq3q2DbwYjvLLYfmfuoBBMZub4dUEK
	 n5nrstD1rRLwR89coaGflmoFe7CDxf31whUEviOdzu39mbxOwNzBm1IT/i0tw77ABx
	 zdB6m+xyEJaGQjFTttKVayFhP35NMXZxFxfnnNcQz0+gYehsv2mNf4payN80Duaei7
	 iH5jasYMiRy7w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D7AB72E00DE; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, willy@infradead.org
Subject: Re: [PATCH 0/4] fs: Remove redundant __GFP_NOWARN
Date: Thu, 14 Aug 2025 10:48:46 -0400
Message-ID: <175518289076.1126827.2391485209969195669.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250803102243.623705-1-rongqianfeng@vivo.com>
References: <20250803102243.623705-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 03 Aug 2025 18:22:38 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[3/4] ext4: Remove redundant __GFP_NOWARN
      commit: 4ba97589ed19210ff808929052696f5636139823

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


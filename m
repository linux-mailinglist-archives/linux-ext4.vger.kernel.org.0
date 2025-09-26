Return-Path: <linux-ext4+bounces-10444-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89864BA53FD
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40F5560B25
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC5298CC7;
	Fri, 26 Sep 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="a6YhqvOl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B4286D4B
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923285; cv=none; b=e58pCvMlTiW63popLhJoNGVdDQdSxtShI7jdwYk1MYiV1xtATUEEBxwAWF+scLCAhXObnUguC9R7DLT+9qsyiDHz+XGUivfiV6d3+vD82rIt8AloIo0e9GuqbIeRVt80hCqH0j6Hci3/meoYg8JF8bIT7SQYwtGqbWgxRSSehk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923285; c=relaxed/simple;
	bh=PrirZ8DwHxYOKiKvv6l5QCUtmPNPWKAhnoYsv9+LeUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LN/XMg9SY6usfVrmbUBJUCSGqEfxwMqSRxxzwcnJjtg1L4y8HAwmke6faYGDY4V7Gpdbf2swWEPI2Ux+gY0SXYEzlIvoCG8c/qEoZKed9PHX5KMe/uRh7+yFzBt+1lwDZ8UcfX4rEPTBBiiytUPMNEld4x9D9c6I+Xz2gjkxy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=a6YhqvOl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlv64014794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923279; bh=jYCaPO50HXjjJPUVno9CgyqTQ1U5Se94RTPV31moWL8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=a6YhqvOlcKHv77hRYsjN28x1W+bJ8Si5fS/RfR1dw8KDsZmhCDaljgTJ0yGeANuj5
	 6djOIq9Un8c1jIUqwblaBJfdwU0GhUJQiqgu9vgSKbJmuqrz96DY3eSLm+aRWuCHaN
	 CRCuujtdKedoU7Iz1BHnQfpSxbd/Xb7Pttx3tRdjccPslYFrZwWMC/tg7TIB4h4dCe
	 V/ojsRprwMP9oCUQRK6zH5vIzrCjV4bRM5fnP6u3dX0WXnTg8RD5QWOMHuyz1tkjoe
	 MMWyVOKV6TTgH/bPcVWyinPG7z6SgGgRECf5mDnWVIYP9VjieheBZwfOflE9nUHLJm
	 9lejb5aBHHZhw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 043982E00E8; Fri, 26 Sep 2025 17:47:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Xichao Zhao <zhao.xichao@vivo.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: replace min/max nesting with clamp()
Date: Fri, 26 Sep 2025 17:47:49 -0400
Message-ID: <175892300639.128029.16772861472569556620.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250818072859.468081-1-zhao.xichao@vivo.com>
References: <20250818072859.468081-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 15:28:59 +0800, Xichao Zhao wrote:
> The clamp() macro explicitly expresses the intent of constraining a value
> within bounds.Therefore, replacing max(min(a,b),c) with clamp(val, lo, hi)
> can improve code readability.
> 
> 

Applied, thanks!

[1/1] ext4: replace min/max nesting with clamp()
      commit: 981b696faf2d59a58d1dc8e258bba00b12e5de93

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


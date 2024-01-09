Return-Path: <linux-ext4+bounces-747-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468A827D0E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1670B1C210C8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105C4422;
	Tue,  9 Jan 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="S8ASTDJw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567528E15
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rS4A010559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768811; bh=xxCiXh6+90OQQa6h13ZMbbjv8glnSyW3gmHzwsuWjrA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=S8ASTDJwQWTcL3DYvkPT1fXbJ50omnZmme8y4bVjs+BGDDOew2ZO5b7kL7UnrH3dO
	 d1DeVsi7SxTh2+WzjUB9D+oqGK1PpPADLPa6yksk0lEOcMJzWlSADHCHsIa11u3MgB
	 eGQRoHhaArt8xRb5SrTQvI7d45tv+fScdmhr7iUaPnjz2fjxI3jQ87/JjM3Zi2U3Kr
	 cOXnPYUEJVYbGs+bJyfUT8YOq4UYrp8cmp3HVOdiFaJJpKsE8X51r9ph9jvCW98zRm
	 ouh9j+RphumPDyyv/MKs6f9Z4k54ybjRatKvXpZ94+wd++osyWzzReyYx+QbUAJJdz
	 GR/j/UiEoP8+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1AF7B15C0278; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, jack@suse.cz, alex@clusterfs.com,
        linux-ext4@vger.kernel.org, Gou Hao <gouhao@uniontech.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        gouhaojake@163.com
Subject: Re: [PATCH] ext4: improving calculation of 'fe_{len|start}' in mb_find_extent()
Date: Mon,  8 Jan 2024 21:53:15 -0500
Message-ID: <170476879011.637731.10342594755395696779.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231113082617.11258-1-gouhao@uniontech.com>
References: <20231113082617.11258-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Nov 2023 16:26:17 +0800, Gou Hao wrote:
> After first execution of mb_find_order_for_block():
> 
> 'fe_start' is the value of 'block' passed in mb_find_extent().
> 
> 'fe_len' is the difference between the length of order-chunk and
> remainder of the block divided by order-chunk.
> 
> [...]

Applied, thanks!

[1/1] ext4: improving calculation of 'fe_{len|start}' in mb_find_extent()
      commit: 2bf5eb2a7c22fc3dd011fda2722fd369b1c4608b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


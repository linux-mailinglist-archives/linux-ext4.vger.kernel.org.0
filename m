Return-Path: <linux-ext4+bounces-742-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E10827D06
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CBF1C233D7
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76763A4;
	Tue,  9 Jan 2024 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eR+8wtya"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455824680
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rVGL010644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768813; bh=UXhuEBuXDwLotKDGSEMTd6ASaj351WFs7d8iaB5s+uM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eR+8wtyam50HwGclMNTIYF+gfDuEowo9N0gAN5+WIdtzwN7QmWbW943zhdIIUSQhJ
	 3QxKS7Qtxdba1E2E1Z4EnEjEVH4W9uOnlnI7imQssD2YvUWyvyuSdk2TcpfQ9O1oU/
	 YLPVpJjRZ+DzLHd2EvVo4IaF9W2JPjuUl88mOASDdk71cHqysg7bRGIUHD+JcBTu2W
	 zKS0RhCtsSmAwDXe9k4KwpQU25JXlN+JDBVZpfHUxMu87mKfEvRG4Lnp6GQVATD53w
	 IM/VA+4LDus50zvX8RvAxD4yFwvPLYfKKA7ADwvm48F9UDiNSrdgIev+Kk2f3KGycB
	 SLdzg6c4YBc4w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 29BA515C0312; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert ext4_da_do_write_end() to take a folio
Date: Mon,  8 Jan 2024 21:53:22 -0500
Message-ID: <170476879010.637731.3816879496253053607.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214053035.1018876-1-willy@infradead.org>
References: <20231214053035.1018876-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 05:30:35 +0000, Matthew Wilcox (Oracle) wrote:
> There's nothing page-specific happening in ext4_da_do_write_end();
> it's merely used for its refcount & lock, both of which are folio
> properties.  Saves four calls to compound_head().
> 
> 

Applied, thanks!

[1/1] ext4: Convert ext4_da_do_write_end() to take a folio
      commit: 05f240655f03fd7fcdbfc6129b6fb7dcc3f64e0e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


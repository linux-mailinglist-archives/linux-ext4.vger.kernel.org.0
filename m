Return-Path: <linux-ext4+bounces-2348-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8678BF13C
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023E91F22354
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC881ADA;
	Tue,  7 May 2024 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HIg3FcpB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237857E78E
	for <linux-ext4@vger.kernel.org>; Tue,  7 May 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123057; cv=none; b=nBDMJl//dOE2Z0uNgOdCA/19csIwX72mQmHbdb7CFFXVT1veqTUag52K0P3/AoNM+bNRAm79aaaduV3Sge1lbwvz/fYeG0rYP2+zzlXNoeLsVY8B5263bkiMHOr4qvDveXKjHCOuenFin/wQPSXCGYDn6CKWy0E7GcNkEGyOH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123057; c=relaxed/simple;
	bh=S3gsdECHmN4Js+sJvFkNyzwilpYGfVlhu9MhtetIZbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZvCg+CwOHghuA06OwQtOBUOPyLiUy0ILz3b22h1f27bKE7YzPlQFD6Sw/k3pyR8+3wy13bQItq4WCju7EmXxbW4zin3LaNYtkq3X0FH7un7x0VhikgGCCEkoChlKubIjQ+8mwp7vo4QbRwQ0s1guthLrntYwaEvnWoUpPMTqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HIg3FcpB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N40sq026155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123044; bh=glLqZ0gngY4PYE4xr8ieN07eXW6Xjb7+6EMfO27p7tY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HIg3FcpBp23tsSwLCSAsB8BpkhDSD4oKl+F+aKABueWCGUTrC09v8YOzEBpL9BkFy
	 3EbkTyuObgsPOxE82Fn0kx9vyF7+p7SOkxky1mfU0pdFpqYwzEq6AnIPjETV1qBR7r
	 mZeVu2kBuaSP4DatOttog1iiE9Zj0ilTZljO/OwHnkwh0WIwSAOjJNGO+/UdVoSiTh
	 uUQ06VplysZV8fHiq483Ys7jtIrqkFhyyNwlqEJc4RN2Fn3Cjw7mDzrCK4kqHOYVDY
	 gLFJ9LtCbJP/OdNyFywd6Sl5VCkp3IdRbE5A250h6aj/LUnED4m2xE37PFB1mrdUJE
	 GgwdTa5JqM4oQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 122C415C02BA; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert ext4's mballoc to use folios
Date: Tue,  7 May 2024 19:03:53 -0400
Message-ID: <171512302195.3602678.13595191031798220265.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416172900.244637-1-willy@infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 16 Apr 2024 18:28:53 +0100, Matthew Wilcox (Oracle) wrote:
> These pages are stored in the page cache, so they're really folios.
> Convert the whole file from pages to folios.
> 
> Matthew Wilcox (Oracle) (5):
>   ext4: Convert bd_bitmap_page to bd_bitmap_folio
>   ext4: Convert bd_buddy_page to bd_buddy_folio
>   ext4: Convert ext4_mb_init_cache() to take a folio
>   ext4: Convert ac_bitmap_page to ac_bitmap_folio
>   ext4: Convert ac_buddy_page to ac_buddy_folio
> 
> [...]

Applied, thanks!

[1/5] ext4: Convert bd_bitmap_page to bd_bitmap_folio
      commit: 99b150d84e4939735cfce245e32e3d29312c68ec
[2/5] ext4: Convert bd_buddy_page to bd_buddy_folio
      commit: 5eea586b47f05b5f5518cf8f9dd9283a01a8066d
[3/5] ext4: Convert ext4_mb_init_cache() to take a folio
      commit: e1622a0d558200b0ccdfbf69ee29b9ac1f5c2442
[4/5] ext4: Convert ac_bitmap_page to ac_bitmap_folio
      commit: ccedf35b5daa429c0e731eac6fb32b0208302c6b
[5/5] ext4: Convert ac_buddy_page to ac_buddy_folio
      commit: c84f1510fba9fb181e6a1aa7b5fcfc67381b39c9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


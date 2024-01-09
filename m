Return-Path: <linux-ext4+bounces-741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190A827D03
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 03:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5607B20B2A
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789A2907;
	Tue,  9 Jan 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pbAc6Kiw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC106104
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-211.bstnma.fios.verizon.net [173.48.82.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4092rUnU010608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 21:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704768812; bh=yp00xbaWzeH4N3p2LgMmquYQTuCSfzsYizut9ku8EtI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=pbAc6KiwpBjhiZmRXkTw8RgwcNIZoaP8muqYn1QUqiOKWK0kkZS26acqYurnw+75X
	 Y+n74vPL/l1uunSUw/nDNP41elMZwcSUvouIAp0XrDIzBTPUGY1OckWwYDsQ3LgoEk
	 rcNfs1Fv1auCyR2yAGyBQaglWv72yLF7a7q37S6SdmP4JVL8w1nUbkC1Qlg4/FyJ75
	 us1dKZDqIAN5MWx0MlS6y1VQc9uFPTBzb+eVgJqI1LZRL6/v0nEoro0ap2Q71PO3OB
	 MMgf9TdE5zpT6UHHCZ7X1GD5Pnz4ychOLeNiBfugDJ51YDr54cIRlLNsY9cAqfyK9V
	 8w7RwyaXR8hCA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 259E315C030D; Mon,  8 Jan 2024 21:53:28 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/2] Document handing of unwritten bh in ext4_block_zero_page_range()
Date: Mon,  8 Jan 2024 21:53:20 -0500
Message-ID: <170476879010.637731.8229125857073324497.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1698856309.git.ojaswin@linux.ibm.com>
References: <cover.1698856309.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 01 Nov 2023 22:08:09 +0530, Ojaswin Mujoo wrote:
> ** Changes v1 -> v2 **
> 
> * Instead of exiting early in ext4_block_zero_page_range() for unwrit
>   bhs like in v1, lets let the current logic be as it is and instead
>   document the handing of unwritten buffer heads to make the intent
>   clear
> 
> [...]

Applied, thanks!

[1/2] ext4: treat end of range as exclusive in ext4_zero_range()
      commit: 92573369144f40397e8514440afdf59f24905b40
[2/2] ext4: Clarify handling of unwritten bh in __ext4_block_zero_page_range()
      commit: c6bfd724098457a1162a7b9fef07af176720055b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


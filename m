Return-Path: <linux-ext4+bounces-4865-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A119B7D01
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 15:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F39C1F21F00
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD6181B8D;
	Thu, 31 Oct 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bFc3ERBv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C5175BF
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385376; cv=none; b=c8qtdarp6ly9kVs1gV3Upsf2hsSR76H1fFx5EpVnMAveA5wLsp5FPYddMZRYqZ5NWX6CyLy5Rq0dUT7nx/Tna1f9QrJpo6GJs9vzHArVeee3+x239OnI+Ja7lRw8e8D45QuPsK/Ppuaazk7S4pefvlX3TG0atvW+UoROIkpxf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385376; c=relaxed/simple;
	bh=H/U/2So2do/YYnXze4Kj+Rf/vu1sXBmtHPew0AY5ivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7DxnscT7EogNSoIgNcNSapRTfXK7IXo/vrESSYdJ9VE+4y3BFuUhGeEz+RyzNmvXOJNgR/hrsyTcXSfiVLPggTDDbUPa/In+FFKQywBb6NWLzuqEwZ/mlxY2MQc6WLpmEsWy+Q6AzKWzpN8lCnUsHLPCFnMW1WDkVt0umQG+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bFc3ERBv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXiG9026372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385228; bh=Y44wOU4vZOBR8hlmuLa7nwup8lvBgfMaaCxepL1HeN4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bFc3ERBvClafjQzNC/ekWkB1WNTupK39TSWndHN5KF8zk7wlrbRHhNJi80XDlufbV
	 qmKwrwoQakjq0xpiCCIiWzfRukMxljL8C9BO4KjWaJOSU/KRHphgGgXV/OwoS31Lje
	 v11p+AUxTAaRWP35LN50OnCuqPnNfFmnfyIbVsK9mi9UdwLr+hGKaWore+G3fESzap
	 hzOjQ+jLrJKxokVyElcbvH71E/SiXrLYOyJY5O9x7b0KrjTjBhJ4EULHw9iJb+gMPD
	 0KoypM3klLx72XD0fxaSqhWBuVdKkicq3lApL+lse6zcoKGN874k4oyps3yxB6P2Di
	 eZahITclGfvkg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8042815C05FE; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: WARN if a full dir leaf block has only one dentry
Date: Thu, 31 Oct 2024 10:33:40 -0400
Message-ID: <173038521048.99135.542508175692910978.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008121152.3771906-1-libaokun@huaweicloud.com>
References: <20241008121152.3771906-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Oct 2024 20:11:52 +0800, libaokun@huaweicloud.com wrote:
> The maximum length of a filename is 255 and the minimum block size is 1024,
> so it is always guaranteed that the number of entries is greater than or
> equal to 2 when do_split() is called. So unless ext4_dx_add_entry() and
> make_indexed_dir() or some other functions are buggy, 'split == 0' will
> not occur.
> 
> Setting 'continued' to 0 in this case masks the problem that the file
> system has become corrupted, even though it prevents possible out-of-bounds
> access. Hence WARN_ON_ONCE() is used to check if 'split' is 0, and if it is
> then warns and returns an error to abort split.
> 
> [...]

Applied, thanks!

[1/1] ext4: WARN if a full dir leaf block has only one dentry
      commit: 4748df069284704b166b98737352677c525076bd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


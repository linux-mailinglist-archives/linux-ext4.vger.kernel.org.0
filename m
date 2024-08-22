Return-Path: <linux-ext4+bounces-3868-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7E95B93C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43944B2763F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476321CC8BD;
	Thu, 22 Aug 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PgG6EJSW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759A1CC89B
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338848; cv=none; b=Ik5gwEAilCb1Pio2jKoGHUjn3MyXTEw0MwnacI9lnpMfl7cIBoLzviml6xOZ/RZPSGnDUIF+SwR9J7xe5qs7xRSOETe67AKRNWWrEnJiZsnMAmrUfC7LQj7Gkcru18tXHUugcoRYqMyHOpFgF+zY7OgfnmXOREolCH3qwgYQ9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338848; c=relaxed/simple;
	bh=9aSLyOJdmHSqVw3/coJTFlHSwc5kpoTJtbeOOZOeBps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJAOB1mDmXfvifOVgk3pa3Ltl2Oqoshd1eKhXoA4GRV31drDVWaxqChqoRvxYgxeTmSk4BtnmLV3/aVayHtcc/Mk/HhE/e/f653TGvu0DkO5alIeld5Q2lzQkU0lDwIJAeAG9HtRnnlzCfUEb0z9jfYX9eUH099opUW3Rg8Qq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PgG6EJSW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0MTF022376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338824; bh=JrpiEckP9t37bN+DFJMwwOWZ6R8Yem8inOpwnzbKReI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PgG6EJSWCoxCEgzE6p5a7bol1v4h+cdkAQz/EJVr5O04tFnNziWki97ZxgcVbwxdd
	 tjdBGyiSST+JEV4iJPGrjAiM2U7FaknrPGFO7D5jgdlEI4ut6KBpqCjDX7moAYcURn
	 JlgmZtlMfMMmJqrMkzNc4tDNCYVHlavQzHmspVsbyc/A47VZI2gIZ0yTj9TdSDcGJn
	 oOMejQkbvUsvdAzrhbUPUY02mNkGaCsBZK4J9vDZUI4q0i3+LLbobWjKQjMJS797pk
	 5/uLOrrsZqTwZN7+KREesAsiuk+v0G8e+SdxjLn13ydfxWltzJ3mYXjiVRlBZXyIdI
	 QWiUe9M0vZDkQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E48D515C02C4; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Junchao Sun <sunjunchao2870@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: Adjust the layout of the ext4_inode_info structure to save memory.
Date: Thu, 22 Aug 2024 11:00:13 -0400
Message-ID: <172433877722.370733.3983248767114654089.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240603131524.324224-1-sunjunchao2870@gmail.com>
References: <20240603131524.324224-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Jun 2024 21:15:24 +0800, Junchao Sun wrote:
> Using pahole, we can see that there are some padding holes
> in the current ext4_inode_info structure. Adjusting the
> layout of ext4_inode_info can reduce these holes,
> resulting in the size of the structure decreasing
> from 2424 bytes to 2408 bytes.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Adjust the layout of the ext4_inode_info structure to save memory.
      commit: a3c3eecc7c876c7f2b09d9ee1acf5b8b85996cff

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


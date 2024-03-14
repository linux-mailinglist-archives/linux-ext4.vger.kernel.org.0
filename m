Return-Path: <linux-ext4+bounces-1616-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AC87B6F9
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 04:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116921F22041
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 03:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FC1078F;
	Thu, 14 Mar 2024 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZabXn/OF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E23101C5
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388521; cv=none; b=gmmhbN2a/l5c5IjRb6qfvUpWGgjhQMMQ3YbGQDCkyw28GRvjpInNXa+1J6lXLtgH/8za6mIQzAT4fQY12bVBuaXidP34b92Mw7Fdioc2gDipSOOALRGetn5iEj4z6xm1lgOeEgC43Ysu9OG4FuxlSJhS4EP47jLWxRNMlUWaTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388521; c=relaxed/simple;
	bh=o0u4X2jNDbOyRKysJjoIWsJgSwgTwIvOc0vUAWG6eqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRmUl/KS6Ebwm5vcb9Y634KWfXudCW4TXNJ1AZY4Fn3auVfvX5uPlVTA/vvdp9pJuexW/q6xhpzdcE4dCUAcMM7WUG7+1MFSXsgSTRUAzWhp3+bzxo0Ugjug53PYVToLV0vt2NpnuN1rwwgzVMOx7OyVwS+s3H0En8GFkIs9uBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZabXn/OF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3sni5003034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388492; bh=YVbFWRJQkDqctnAz51Shq00+jF2NkfwWusf8wTaeR6I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZabXn/OFXZSjveLkcQrmlB6GEhy76220sVRpm/XUCEWvMnmugNW345qUrdlQi4WvX
	 koYxBbkMkCHEveLMRTzjPMTcHfHgAyiVJgS88wqo6XE76a+zOy6P9R4I4uFr5ytW0Q
	 7JOYXqE1brIknKGx6n+BJYKoFvMmcSaLl7nGX7nnK5LHqTTfqYWf6fmQB2tZd8Fzp9
	 Pbcyba/fRRokaoFoYDJ8KMgK0oVRQ54c2w2WVGoj/WMflwMptRUbw79DmGEZB5t4Pc
	 JMzQONy2n+ckYRHThroRnnqSh8WHyBDBrORQHXB5mpaHDJ+w6byODTui3vzVUUTgPS
	 k8b8ryrrpfbXQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EB70D15C0276; Wed, 13 Mar 2024 23:54:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, chengming.zhou@linux.dev
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] ext4: remove SLAB_MEM_SPREAD flag usage
Date: Wed, 13 Mar 2024 23:54:42 -0400
Message-ID: <171038847843.855927.15942631846474053923.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224134822.829456-1-chengming.zhou@linux.dev>
References: <20240224134822.829456-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 24 Feb 2024 13:48:22 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Applied, thanks!

[1/1] ext4: remove SLAB_MEM_SPREAD flag usage
      commit: 708623737b0a28aff33bff0237862a2e08bc5c97

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


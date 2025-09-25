Return-Path: <linux-ext4+bounces-10428-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184ABA082F
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0D07B2B50
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E7305068;
	Thu, 25 Sep 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UL7ks/JG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C7303C87
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815942; cv=none; b=ksae8e/50OXa3nvDWRYgKHmNUl0rXHAwTAJryMwIcm6mMcOqYIree/j2tcaIv+fdhfNk6zc1hcdFK7C8jADWMyhgCMrAUx/G6m2V/QWc7pd7qp7Keg7BQuy8gi/DDYP+CDFAsisSdkmsrRRfHpz7JjYu4qelnIgnVtEo8cdDOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815942; c=relaxed/simple;
	bh=uYZfLBh3Uu5yp59uhky38gba+B+xQMgrUvlRmQabgRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prhne6PbHr30i7JOhCl75m9iQQiedOAT5XPLcexEggjg9F1IcKnyxJcsftCiaPB64vw3Hrt+1/gYScEThw5gfJgT+XYUMn7UPyPSDYD9ahWY3q8qEvtmORlyN7jXVcMugJ3v0WhawWHsluwKCJyv/psD61Pq+92x0pC/U7P0Vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UL7ks/JG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cXdgN64RYz9t3C;
	Thu, 25 Sep 2025 17:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758815936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD3zABApuHjfRKMlDkYYC1pY9w6EcmJb1FZv6a3wrw0=;
	b=UL7ks/JGNJR7KhYSvSuS/msti1uJNa8CdEY0sZY2E+MOhyJFCOQMMieslWYXoI0Z+xdWAD
	2iT15TPr4GL9E1ngL3QcyHjNxmhQnFlhLdkzO844FZP6LGNl+SnB75Gyadl9X0Bje/qDws
	1x2oM11HIr/OMeWswNpDgpJVdV0Tx1beMM6tSbSieUTBqM2wDTNxyVkY0h1jw28N9RRfNa
	+Xs4jKd08v2WtHcjHE+R7sdnVGsyPBdiQWacnj851fRV5xttz1ytoHVWE9BYmHe60PvVCn
	8opSZu9AU4mhWZGQMZKNG2x6GHVwZ02Th+LukbcSKb2xKzWKihQfAU1Hbhqqdw==
Message-ID: <fb756477-b6b8-4b4a-be63-3a5f18241166@mailbox.org>
Date: Thu, 25 Sep 2025 17:58:55 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ext4: Question about directory entry minor hash usage
 (documentation error?)
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
References: <51a89ced-228d-4fd0-9613-3b4d027d9162@mailbox.org>
 <20250924193712.GD19231@mit.edu>
Content-Language: en-US
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <20250924193712.GD19231@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 41tq9bc3rq1s39dd45t3mo14dgb1yq1h
X-MBO-RS-ID: 5c42351b41814d5979b

Theodore Ts'o wrote on 24.09.25 21:37:
> On Wed, Sep 24, 2025 at 06:04:08PM +0200, Zeno Endemann wrote:
>>
>> The documentation of hash tree directories claims that interior nodes are
>> "indexed by a minor hash".
> 
> Yes, that's incorrect.
> 
>> However from my current understanding of the code, it seems to me the node
>> splitting works somewhat like regular B-trees, and there is no re-sorting
>> with a minor hash going on. The minor hash doesn't influence at all the
>> on-disk data structure, and is only used for sorting in a kernel internal
>> rb-tree. Is this correct? If so, I could offer to write up a patch for the
>> documentation.
> 
> The hash is used as the directory cookie for the puroses of telldir(2)
> and seekdir(2) on 32-bit systems.  On 64-bit systems, we use the hash
> plus the minor_hash to form a 64-bit cookie, or "directory offset".
> This is also used for nfsv2 (which suports a 32-bit directory cookie),
> ad nfsv3 (which supports a 64-bit directory cookie).
> 
>> As a side question, I was wondering a bit why the kernel differentiates
>> between htree-indexed dirs and others when simply iterating over it (as in
>> e.g. ext4_readdir), and what the point of that rb-tree there is, i.e. why one
>> would want to iterate over the entries in hash tree order.
> 
> The reason for this is POSIX requirements for how readdir(), telldir()
> and seekdir works.  When your use readdir() it must return each
> directory entry once and only once.  And if while you are calling
> readdir() a directory entry gets deleted or added, the added or
> removed directory entry must be returned zero or one times, and all
> other directory entries exactly once.  If you use telldir() to save a
> position in the readdirt() stream, and then go back to it using
> seekdir(), the rules of "exactly once unless entry is added/removed in
> which case it is returned zero or one times" apply.
> 
> If you are using a linear directory structure, like the old V7 Unix,
> this works fine.  But if you are usig a b-tree, where an interior node
> might get split, with half of the directory entries getting moved to a
> newly allocated block, the POSIX readdir() semantics are extremely
> difficult to implement *unless* you interate over the directory in
> hash tree order.
> 
> (There are other solutions, but they are much more complicated.)

I see, that makes sense. Thanks for the explanation.




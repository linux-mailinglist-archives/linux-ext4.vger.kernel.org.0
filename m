Return-Path: <linux-ext4+bounces-14670-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdSHnPAqWnNDQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14670-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 18:42:11 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9869216633
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F313043010
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4C384236;
	Thu,  5 Mar 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VkxTPXr/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C53D564B
	for <linux-ext4@vger.kernel.org>; Thu,  5 Mar 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732355; cv=none; b=Pw32H7cx+lArI4YuH5TasuCDZM5QVkMKn0kjmbdesEGWgtiv0hI5UfGAJQF6YGCgFgdYfn4pROoZqFvxPCuB0S6xWujJPwzLz22lYQaqit1WtDVzA0/E1yBS7HFBth6A69U9VHj0NPAeit31zx1wqQYI7sEf4DOBd+Umt/tFKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732355; c=relaxed/simple;
	bh=2R0KvXqR4FX2R6DeROyfuIu10i8WoS2OleB2jssmkfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWVj6mGnN1aL+wU7qEo4ZeUhGwwkgfakmx4pSELWnSe3Q4ne447lmjqQJmtYb0b+AVS3ZusXpZuTaHI4wREQ1nUB0F++zJSrNeUPcQk58AHq0GxwHa5XC7xfujNeIuXIgmzbQ9Ab+4Qhnf57VbGNmZHCmf2pT8MtkIe5RLiE+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VkxTPXr/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.148.192.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 625HcaoJ029500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Mar 2026 12:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772732318; bh=zRT4a6EBrtdJAf35DygVPZLe/g7FuVuwwLmjYJKQX98=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=VkxTPXr/zsiIZQgYaod/5g+xMN+picAilTHp60Jr3atNMrYfti3LnsRXq26iOvAwk
	 5GqwrfEA3iG/0unIJK06Uzc86d+F4gsGL2HsPvTyXXZxt6WUwR1zUDKFC19EvoXTJb
	 qgpGg3tKaRjlAwA/OoGJGyI/Acyr5mkndu4h/FRlJKwGliOQr7gy2ZZxsYFjAYUJIw
	 hpitYiPyZtn66K0oitA3KuV3OLDGMtgp41Yr2mHHDSXnQuBoWF5i9M5feVf5VOZ8EA
	 +Ac8b25keHvku/nc1i+prPOYQqBDfkDslB/NyqR7YHHTApzlFKiusMhCVSMfFBibKM
	 ZlHApkEA2XV3A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 683895BC4E0F; Thu,  5 Mar 2026 12:38:35 -0500 (EST)
Date: Thu, 5 Mar 2026 12:38:35 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, djwong@kernel.org,
        yangyun50@huawei.com
Subject: Re: [PATCH v2 2/2] resize: fix memory leak when exiting normally
Message-ID: <20260305173835.GA9095@macsyma.local>
References: <20251121033612.2423536-1-wuguanghao3@huawei.com>
 <20251121033612.2423536-3-wuguanghao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121033612.2423536-3-wuguanghao3@huawei.com>
X-Rspamd-Queue-Id: D9869216633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14670-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,macsyma.local:mid]
X-Rspamd-Action: no action

On Fri, Nov 21, 2025 at 11:36:12AM +0800, Wu Guanghao wrote:
> The main() function only releases fs when it exits through the errout or
> success_exit labels. When completes normally, it does not release fs.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>

I'm guessing you only tested the online resize code path?

	if (mount_flags & EXT2_MF_MOUNTED) {
		retval = online_resize_fs(fs, mtpt, &new_size, flags);
	} else {
	       ...
		retval = resize_fs(fs, &new_size, flags,
				   ((flags & RESIZE_PERCENT_COMPLETE) ?
				    resize_progress_func : 0));
	}

The reason why I ask this is that resize_fs() frees fs on the success path:

	rfs->old_fs = fs;
	...
	ext2fs_free(rfs->old_fs);
	
... although if we return when an error, we do *not* free ext2fs_free(rfs->old_fs).

So if you were to test with this applied when resizing a non-mounted
file system, I believe you'd get a double free failure.

Cheers,

							- Ted


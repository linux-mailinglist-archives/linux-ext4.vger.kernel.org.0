Return-Path: <linux-ext4+bounces-12589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F35CF8488
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 13:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334CE300F9C5
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862531AAAA;
	Tue,  6 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="d5drhk7c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AE2F60A7;
	Tue,  6 Jan 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701687; cv=pass; b=URumPiUPNQPruXIgnDz3nw1ZYU8G0PtC8EKAzdtyXZKW8JG0IfDCvq7W5wu+uXYVJuWggrp2lK2K/JXxxNbxfBRadZ70U62Eje/i7rgUwi6edzAldrbDAFnlpyh71Xzya58R+Kx5aGwdUbZ94W6+FIazNdkdRTjQlLMfVNBaMtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701687; c=relaxed/simple;
	bh=L+cPUunJyUczSsUMUqweWdRT6/iK0hftagAGv3bPTlw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EuSXtzpjel1zVtr5EDT7mf8/S7tBkSEN6NVBNYfjIQPIqUokhKu3C5fp+YonPGImPVkVbrvCsP4KAfnnB2pweOjFKY9Syx8pE1Oc5KtsQcTCp1yjrH92nPSJujbZjKFnOpW4GTYURktVjCPGl1woGo/XYVEtaeR0hzgdMmSXZlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=d5drhk7c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767701679; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VGFwda5odeyyxg03ZmCiFsEtKznT05HZEKrsy39L/o0Vz79mQgK0Xy9N6LbKEAM2+dRNPktsfQ5qVeXRJZukwD3Gy7enn5jRulC8qMOaAPa4v86cS2OQYILKO5xNEDvn01DyuMhKj2RMLWodHmQB6QGb/6NzP8ZsOEs48HixRPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767701679; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pJ+ArRU8D906CTjqf5+1vkOn75CQCwgY8G33sxrV56o=; 
	b=BE/ryhc/0oE/dZXAAbLwJ5Q5/1NRiRRHe9GjHFow/DM7BGfPAQzt5bryPIGHk0y+GVlYQLgsJLzQSB4Y2UowqQlApULpQ172IgNG/AFhtSvDawEMtdmS0NkoiKsFj/YmRV40ZYaFLkE6ZQ4mb19vd0cjqaqNb70TiDDB6vjqNHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767701679;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pJ+ArRU8D906CTjqf5+1vkOn75CQCwgY8G33sxrV56o=;
	b=d5drhk7cByMScYMRx9OwJwno7Bm2Ye6GcvOwI6VW3DBOwmCQDwSgGjj3tMFk3Qzn
	wjODUmFJC4EXiIRnt3/tWGO1LzkaqQcyZn6dCL06PC/UHBp3HGvIG8RLmaumZuT1N6R
	oggezzXGl7gIZsYWCd5JTxUBLhE/5KIgadnpk+DU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1767701677226258.8258063880021; Tue, 6 Jan 2026 04:14:37 -0800 (PST)
Date: Tue, 06 Jan 2026 20:14:37 +0800
From: Li Chen <me@linux.beauty>
To: "Jan Kara" <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	"Andreas Dilger" <adilger.kernel@dilger.ca>,
	"Harshad Shirwadkar" <harshadshirwadkar@gmail.com>,
	"linux-ext4" <linux-ext4@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19b933b0448.619d63104490112.7140925865813405260@linux.beauty>
In-Reply-To: <jdssgnr44c6scnzhpbl7gwgcpo2f25n3cxaaw6fo2uzh3bdwda@ograleyyoyot>
References: <20251223131342.287864-1-me@linux.beauty> <jdssgnr44c6scnzhpbl7gwgcpo2f25n3cxaaw6fo2uzh3bdwda@ograleyyoyot>
Subject: Re: [PATCH] ext4: fast commit: avoid fs_reclaim inversion in
 perform_commit
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jan,

 ---- On Tue, 06 Jan 2026 00:17:31 +0800  Jan Kara <jack@suse.cz> wrote ---=
=20
 > On Tue 23-12-25 21:13:42, Li Chen wrote:
 > > lockdep reports a possible deadlock due to lock order inversion:
 > >=20
 > >      CPU0                    CPU1
 > >      ----                    ----
 > > lock(fs_reclaim);
 > >                              lock(&sbi->s_fc_lock);
 > >                              lock(fs_reclaim);
 > > lock(&sbi->s_fc_lock);
 > >=20
 > > ext4_fc_perform_commit() holds s_fc_lock while writing the fast commit
 > > log. Allocations here can enter reclaim and take fs_reclaim, inverting
 > > with ext4_fc_del() which runs under fs_reclaim during inode eviction.
 > > Wrap Step 6 in memalloc_nofs_save()/restore() so reclaim is skipped
 > > while s_fc_lock is held.
 > >=20
 > > Fixes: 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > Thanks for the analysis and the patch! Your solution is in principle
 > correct but it's a bit fragile because there can be other instances (or =
we
 > can grow them in the future) where sbi->s_fc_lock is held when doing
 > allocation. The situation is that sbi->s_fc_lock can be acquired from in=
ode
 > eviction path (ext4_clear_inode()) and thus this lock is inherently recl=
aim
 > unsafe. What we do in such cases is that we create helper functions for
 > acquiring / releasing the lock while also setting proper context and usi=
ng
 > these helpers - like in commit 00d873c17e29 ("ext4: avoid deadlock in fs
 > reclaim with page writeback"). Can you perhaps modify your patch to foll=
ow
 > that behavior as well?

Thanks a lot for your suggestion, I have added helpers here: https://lore.k=
ernel.org/linux-ext4/20260106120621.440126-1-me@linux.beauty/T/#u
Please take a look, thanks.
(But I didn't add v2 reroll count there, because I mistakenly remembered th=
at this was an RFC, sorry for this)

Regards,
Li=E2=80=8B



Return-Path: <linux-ext4+bounces-10298-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36CB8A0F4
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD84E1306
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896B253F13;
	Fri, 19 Sep 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="am6klZks"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D419E7F7
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293164; cv=none; b=DK9qApIaW/Lw7wwfvvtp/PInVQJRjD76oZyoT0yrhcO3uH15HOEoq5srAlLRhJ08IZ49HdnX8YnTuMwc50uUa9QzEy3BpG7ZnrjHuFM0LkHsmkQa+wFZwK0NhMEPyB0+rC8/tGM0a2LsqBnFmXkjKxgaDUWTG+1pzjg6LpnjvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293164; c=relaxed/simple;
	bh=2MTK23vuo2CKjb7oozhaqOgEaFFuCN+amqxDrseDFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvtX18BTzx7Mzw6AUmK/j0EY+zfnyEJrik2nsY3FLugObI5IVFo0Mz1lwLEnf9xOGqVdqicJFh6PfYFol3C2b5MfHASv2E+X0czd92QJajnMzIAGjK7R5vVCGcf7N/7i6aD4Yv3eE82LEr7NYx2d2R8PfqdVq6ivnwU+DfkKSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=am6klZks; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58JEjmDl025285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758293151; bh=/uU8JB3lnEDct4CiuBwq0NtIG+7u6ORH4LbnEydmI40=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=am6klZksCSxOzCs/veCZ/BQm0/jo0WROhYwaT6NRgzX5LZU7Cef3Du4mTB0rNjRH2
	 R47QqL2GjGtFtTRPH6CpxTW0UxgrA5KLOeulsRC8cU8KV+vwZLofZJEmJ2gB3yAjM7
	 YtiPbxM4Vyp/3e0hrtNpb03mAkQ0gTzA4s1NzAzO1LMIqsxzc/Cw0XCEMhtoCsS3BE
	 F/oTIm8kt9Hkrvj3wjinjojGkLu3960904WypXyImOwv0hwCIx0UJXkAguQqjLvzKn
	 xCMv1zPKbgCyx4ajH+VDPR56iaLBNC9zuWniZlpkuYcyTFsbnM3JHgDQltHwWKhf55
	 UlxtEZVL5c0WA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7F06E2E00D9; Fri, 19 Sep 2025 10:45:48 -0400 (EDT)
Date: Fri, 19 Sep 2025 10:45:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: guard against EA inode refcount underflow in
 xattr update
Message-ID: <20250919144548.GE416742@mit.edu>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
 <20250918181801.GI8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918181801.GI8084@frogsfrogsfrogs>

On Thu, Sep 18, 2025 at 11:18:01AM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 5a6fe1513fd2..a056f98579c3 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1030,6 +1030,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
> >  
> >  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
> >  	ref_count += ref_change;
> > +	if (ref_count < 0) {
> 
> Shouldn't this check ref_count >= ref_change *before* updating it?

As Ahmet pointed out, so long as we don't actually update the on-disk
data structure, it's fine.  The issue I'm more concerned about is that
if ref_change is +1, we could also have an overflow where we go from
an ridiculously large positive number (~0) to 0.

Your change might fix one potential syzbot-discovered issue caused by
a maliciously fuzzed file system, but we should harden it against
similar problems going in the opposite problem.

Cheers,

						- Ted


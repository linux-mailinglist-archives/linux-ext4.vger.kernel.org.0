Return-Path: <linux-ext4+bounces-7326-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249DA92922
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CC61B62B8D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2D257459;
	Thu, 17 Apr 2025 18:37:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AB25743D
	for <linux-ext4@vger.kernel.org>; Thu, 17 Apr 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915049; cv=none; b=Qo2Loy7gaXGQGt1S+L55m7IZ+rN4xsV9Pa0m0buVj5tNsj0tYBVEV19Pq4wESNPMi4lBWsfFDROZELnmEvgtf6wJPX+gB4En96BzwzYGmLftQ6MmxADU075Lf9B/DRsmoZ+11Ow+hAVnrX/E6g+4Dh3DCOCUCFmW/Ssnb0Y2xgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915049; c=relaxed/simple;
	bh=7/TYR7hjxw8uI7CKx4Li6ruOBe6Uxmmo1zXWVc4ImzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwDe7+PBDK+g9CUWR0HNkatPK1QVuUxWq7u4B1njQktznz3lwpoKEj4iAcIo/BBcUkttVTPZn/6EOvVSgEsDXvov3x95hruw5xH0JJPTnsgnZzxiZeAITvAam875rmECByP4D3svGS9fbTt/NCEV67WuuyZ/IOkPTnYwTZuJH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53HIbBa8025010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:37:13 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 302F2340A4B; Thu, 17 Apr 2025 13:37:11 -0500 (CDT)
Date: Thu, 17 Apr 2025 13:37:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, kdevops@lists.linux.dev, dave@stgolabs.net,
        jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250417183711.GB6008@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417163820.GA25655@frogsfrogsfrogs>


On Thu, Apr 17, 2025 at 09:38:20AM -0700, Darrick J. Wong wrote:
> 
> generic/04[456] fail with a bunch of...

Yeah, this is known.   I have an ext4-specific exclude file:

// generic/04[456] tests how truncate and delayed allocation works
// ext4 uses the data=ordered to avoid exposing stale data, and
// so it uses a different mechanism than xfs.  So these tests will fail
generic/044
generic/045
generic/046


> ext4/043 seems to fail because it tries to create 128b inodes with
> project ids and fails.

Yeah, I don't enable project id quotas by default in my test setups.

And _scratch_mkfs will fallback to using just the tests's mkfs option,
so if -O quota,project are specified in MKFS_OPTS, then the fallback works:

Start test timestamps with 128 inode size one device /dev/vdc
** mkfs failed with extra mkfs options added to "-q -O quota,project" by test 043 **
** attempting to mkfs using only test 043 options: -I 128 **

I suppose we could explicitly add something like -O ^project to the
test, but enabling -O project isn't in the default e2fsprogs
mke2fs.conf, and there are probably all sorts of oddball mke2fs.conf
configurations that might cause tesets to fail.


> ext4/053 I suspect fails because built-in quota conflicts with the quota
> mount options.

Hmm, I can't reproduce this with "kvm-xfstests -c ext4/quota
ext4/053", which will configure xfstests with:

MKFS_OPTIONS  -- -F -q -O quota,project /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc

Can you send me the out.bad and full files for that test?

Hmm... maybe this is another one of these "it fails if a non-standard
mke2fs.conf is used, although I don't see how."


> generic/{633,697,696} fails with:
> 
> --- /run/fstests/bin/tests/generic/697.out	2025-01-30 10:00:16.953276275 -0800
> +++ /var/tmp/fstests/generic/697.out.bad	2025-04-16 15:54:39.173837150 -0700
> @@ -1,2 +1,4 @@
>  QA output created by 697
> +utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create
> +utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create
>  Silence is golden
> 
> No idea what that's about.

I don't have any idea either.  I assume there's nothing in the dmesg
for that test?  Those tests are passing for me, so I got nothing.

    	 	      	    		    - Ted


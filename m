Return-Path: <linux-ext4+bounces-11799-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E685C50796
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 05:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F944E4D9D
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9B258CE5;
	Wed, 12 Nov 2025 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UUoLRRKn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973FDDAB
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920209; cv=none; b=tsEh0kQIGHfJ9+60YK4oomXN4vegwbI1tHRbHehTfglEZDc4glBuEKhYUp+htJfEsj+4l33MWHw5JXiQcuePWQzvY2/0Lb80WSoeeviIZsOsXvuZJosrGj+yaMs8Zddi0GFlz09KeGgb6xtOPLMaeCwYUue7arD5GlCK7UoEjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920209; c=relaxed/simple;
	bh=3mixZ/Eqs2zCRIMcT+JDA/EdfO0L47B9K9/552r1Hzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J5X8l/J1bgSMcq2KkOtZqNp9MDNSHqq7JEdDAMoLAT/++iK9qOqxSR2WKlsGCBdQsUzD0mZgqhrjYY5ioWOovcxalQPdVmStg6BKs+9SjQBhbDnCPBLau9dJUvvoxfE7jfgA+AmczYiDw6ChJMkGNMP/NP4f09uwoa2fqJnjm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UUoLRRKn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AC42Kkm012001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 23:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762920145; bh=MdYQaNBF5C+0T4NeR/HbUMr089NM0EeyD/zyuQ7i8JU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UUoLRRKnClDx1ZBzjNUzSbEg7pqzX05LithF2OpHNktq82FP6W0qukQ7FCk/yo0Rr
	 4eG0C7oPpIT10po/U7fYdQaNXY35U1ie/aS7doISN7lzuFsjg2UMP+8shD1N8q52bK
	 q+WcZnIu1cj/WZIXgwwOFe9OJCrs511SETipWGeT67rcmhm5da2keryZxvLEqMK9PP
	 dEagI2AL0xXiSAt+zIt8csmUsDd42cNxR4c4AfcXx7pKQxG6DQ0UYo7w6s92j92A2+
	 U9c4R2bwQFlI+Km/hCnkIxoxRKJ0lKT4Mu5B4+7j5yV6aFApRgNPl6WptbFCgo/nZB
	 BgpntJCONxI8w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 10AF52E00D9; Tue, 11 Nov 2025 23:02:20 -0500 (EST)
Date: Tue, 11 Nov 2025 23:02:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251112040220.GO2988753@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2201c9-ff7f-4cfd-acfc-2bba265b3a29@huawei.com>
 <44d3fbd7-1c53-4f94-a4c8-586873a47146@huawei.com>

On Wed, Nov 12, 2025 at 10:19:06AM +0800, Baokun Li wrote:
> I am using a slightly older version of xfstests, and when running the
> 64k tests I also encountered similar failures. The cover letter stated
> "no Oops" for the 64k tests rather than "no new failures," meaning that
> some cases did fail, but no severe issues such as BUG_ON or softlock
> were observed.

Sorry, I misread your cover letter.  It's good you are seeing similar
failures.


On Wed, Nov 12, 2025 at 10:49:19AM +0800, Baokun Li wrote:
> I checked the code of the swapon syscall in mm/swapfile.c, and currently
> the swapfile does not support LBS. Therefore, some failing test cases can
> be filtered out based on this.

Ah, OK. What's happening is with XFS the swap tests are being skipped
automatically if the swapon fails.  From _require_scratch_swapfils:

	*)
		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
			_scratch_unmount
			_notrun "swapfiles are not supported"
		fi
		;;


But ext4 has different logic:

	# ext* has supported all variants of swap files since their
	# introduction, so swapon should not fail.

<< famous last words >>

	case "$FSTYP" in
	ext2|ext3|ext4)
		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
				_scratch_unmount
				_notrun "swapfiles are not supported"
			else
				_scratch_unmount
				_fail "swapon failed for $FSTYP"
			fi
		fi
		;;


I guess we could add logic to _require_scratch_swapfile in common/rc
to also _notrun if swapon fails and block size is greater that page
size.  Or I might just add an exclusion in my test appliance runner
for now for all tests in group swap.

						- Ted


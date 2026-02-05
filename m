Return-Path: <linux-ext4+bounces-13550-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E44MpzQhGk45QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13550-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 18:17:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845CF5C89
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62D383004600
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1012D8372;
	Thu,  5 Feb 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXC8As9s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD1244675;
	Thu,  5 Feb 2026 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311832; cv=none; b=ZdHOgfjx9mOhJByHf2evt8ogXl15FvZCwW1BuVxeb00xPE/oTfrBcYYKJ+XGbI0c7jaYZ5Qqn8y2X5cvase3smtYuACTcEVgBb/TKWogo/Vr2E8qC2yffRqVER0ThhQsebK1h/SPAM+WejrFyeNV0tblxqp+9bxszteLKfyTEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311832; c=relaxed/simple;
	bh=gO/89uPgJr1PKZxothOfQ8gZFjjL+AuATUUG/3oilm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3TLm1lZwU0iLiblMMqQ5kOeN/NLqeigdEJmpP9iMQanNeAXmTYq0yWGwSNUsLKVksNZJ4aEsrc+72iS0L6/+/6uHQcsILyonp7cI3ZgdyPd/j4CwQC2gHM0E1XQHaYoxw4Bf/Ou6ZrrCkC9J0JBJ4WaqdLQAkvXTpjShDqeZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXC8As9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA4FC4CEF7;
	Thu,  5 Feb 2026 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770311832;
	bh=gO/89uPgJr1PKZxothOfQ8gZFjjL+AuATUUG/3oilm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXC8As9sqatOU6GbnO+zc8gtTWOQD4sznj2p6/V4qT7Zk2nX7WeP0rDz/KpuyZFsi
	 5OQtZWbfoWvuCIn5d6id/ookCTzS0h70qtpJ7/vFlJwaMkw9G3r9M0/UCYN2U7tO6W
	 VemiDbrCegv/Iqgp6TnwOkumLwhfo+/lqEvFb00RDJnDz6iTpj0GkT4kJPAJ4/eVlO
	 aThS70Gc5DjcBYspdDHOd6LPR/w80PuQUmmVveMFaRew0ifZ/Y6lozPrgddQwUa1A1
	 S7FFO0ufdmbfgn67LWFWsY1p3nqu8X3nUU3qfEzrsD4U9H9zdbmPtrHmj4/wbkvO5R
	 zwXRDU8l3SLeA==
Date: Thu, 5 Feb 2026 18:17:08 +0100
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/749: don't write a ton of _mread output to
 seqres.full
Message-ID: <aYTQTiXamR3Bq4Zf@nidhogg.toxiclabs.cc>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945334.2432878.12923613447146396794.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005945334.2432878.12923613447146396794.stgit@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13550-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Queue-Id: 5845CF5C89
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:11:44AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Something went wrong with this test when testing with fuse4fs, but I
> couldn't tell what because this test writes so much data to seqres.full
> that it completely filled the log partition.  Most of that output was
> from checks that actually succeeded, so let's reduce the amount of
> logging from _mread (which passes -v) by writing to a tempfile and only
> dumping the output to the .full file if something breaks.
> 
> Cc: <fstests@vger.kernel.org> # v2024.06.27
> Fixes: e4a6b119e52295 ("fstests: add mmap page boundary tests")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/749 |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> 
> 
> diff --git a/tests/generic/749 b/tests/generic/749
> index 7af019ddd7f98f..01e3eac0ff73be 100755
> --- a/tests/generic/749
> +++ b/tests/generic/749
> @@ -163,17 +163,20 @@ do_mmap_tests()
>  	new_filelen=$(_get_filesize $test_file)
>  	map_len=$(_round_up_to_page_boundary $new_filelen)
>  	csum_orig="$(_md5_checksum $test_file)"
> -	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
> +	_mread $test_file 0 $map_len > $tmp.out 2>$tmp.err
>  	if grep -q 'Bus error' $tmp.err; then
>  		failed=1
> +		cat $tmp.out >> $seqres.full
>  		cat $tmp.err
>  		echo "Not expecting SIGBUS when reading up to page boundary"
>  	fi
>  
>  	# This should just work
> -	_mread $test_file 0 $map_len >> $seqres.full  2>$tmp.err
> +	_mread $test_file 0 $map_len > $tmp.out 2>$tmp.err
>  	if [[ $? -ne 0 ]]; then
>  		let failed=$failed+1
> +		cat $tmp.out >> $seqres.full
> +		cat $tmp.err
>  		echo "mmap() read up to page boundary should work"
>  	fi
>  
> @@ -205,9 +208,11 @@ do_mmap_tests()
>  	fi
>  
>  	# Now let's go beyond the allowed mmap() page boundary
> -	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) >> $seqres.full  2>$tmp.err
> +	_mread $test_file 0 $((map_len + 10)) $((map_len + 10)) > $tmp.out 2>$tmp.err
>  	if ! grep -q 'Bus error' $tmp.err; then
>  		let failed=$failed+1
> +		cat $tmp.out >> $seqres.full
> +		cat $tmp.err
>  		echo "Expected SIGBUS when mmap() reading beyond page boundary"
>  	fi
>  
> 
> 


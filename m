Return-Path: <linux-ext4+bounces-5883-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B8A00B70
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2A418843C3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F971FBCB4;
	Fri,  3 Jan 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IfUQa1wA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DF1FA8C8
	for <linux-ext4@vger.kernel.org>; Fri,  3 Jan 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918254; cv=none; b=GZoeir+1vVLocsd6mmyomFUVkoSL2oMgTJ4d1NkQ8BxUDTe2UQgERZpL4cSiBqGJDZulA1Qo4UQp/KE+0i0MOM3g/HVV/D4Laf6bNJErSPA4Jab07yaPMig/Df7B/Z5L5PnVRiAfNNHP/HbnFXgFsnUwu+3hJmZf0nNouSNbXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918254; c=relaxed/simple;
	bh=I3dDZvdqOHI9Ad+UdhLKSRhj/wArXqRchm3jzly6xHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVtvJ9omGQE8oajB9wzwKaGtg5eE53Y+3duDyF246ej6OJzKxWEpv2b1SjZT9MOIBlpodRtFk2jVHsxhCpVX90alHJCxyV3yCorr+tM2M8yBy6fkCabqYmahfFvp9IhLve71KiIGwwm34Hcz44G4klPjtKNrgtVVx+e9iARJs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IfUQa1wA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-149.bstnma.fios.verizon.net [173.48.117.149])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 503FRJUZ012125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 10:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1735918041; bh=rsKR8Dt/DfI2RHkaQmQy5cw7HE2KCBG8yTXmkyh/VUE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IfUQa1wA6znurzTPFAyBdGHsUTnlmC5/rH+ifMbwVY2OiG4kSs/q7OUxrQUZErbyE
	 1TSm0/Laszti22JC+lW5sZoYIV0nDwO4A0jes6FDVqgJ5tx8D6yPmMiLWgolYm9Rtg
	 3tWBgUWgDHn7G67lYXweH9wwJnA538opK6PE/pxBcSeTVyHT3vfShlBfjT9RP2gIkA
	 YvyT/kpOWUR8PJ0DHiJT6/qXi+f9voL0q5kmBVjbxMK0rxSh07vOnisiGoAZzG4hGq
	 BqqyR4DEi+JlxuhiVJIUKfO7uD1nCBJ+Uqc//++3DF3yJVqC87G3dKvtgO1SVEWucw
	 I1CIwAy58r3ww==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0535615C0113; Fri, 03 Jan 2025 10:27:19 -0500 (EST)
Date: Fri, 3 Jan 2025 10:27:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: "possible deadlock in corrupted" in Linux kernel version 5.15.169
Message-ID: <20250103152718.GA1284777@mit.edu>
References: <CAKHoSAviexD6O+QuaNya4xsqaW6URLFWee7vgTGOiJO8x1mkJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAviexD6O+QuaNya4xsqaW6URLFWee7vgTGOiJO8x1mkJw@mail.gmail.com>

On Fri, Jan 03, 2025 at 03:37:31PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 5.15.169. This issue was discovered using our
> custom vulnerability discovery tool.

Do you have a reproducer?  If I had to guess, this was caused by a
maliciously fuzzed file system where the quota file was placed on the
orphaned file list.  We have checks for the more modern quota file
support (see the checks for EXT4_IGET_SPECIAL in fs/ext4/inode.c's
__ext4_iget() function), even for antedeluvian kernel versions such as
5.15, however so that's not it.

In any case, with a crazy old kernel version, and no reproducer, it's
not something we're likely to waste any time on.

    	      	    	      	    	     - Ted


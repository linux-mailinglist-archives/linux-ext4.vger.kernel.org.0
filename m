Return-Path: <linux-ext4+bounces-8960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D103B02B6C
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0846DA62DFE
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F81B0435;
	Sat, 12 Jul 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="W6zfCdjG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35D8BEC
	for <linux-ext4@vger.kernel.org>; Sat, 12 Jul 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330906; cv=none; b=ABjrr5QEMr+OfhEm3YTENPfITjJJ4XQRORLlsl8LMMWi2hUyHOgTozHpAZPW/KixBr0ZvUwekm0FmI0Awnxk3SQja2x5T/fqaWLXJTGWc1pu7L15Pkp5vJJ84tefNMiRQdw/QagzX4CTw2fXa4xn0DCVtXslrQdqwChqRS/MrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330906; c=relaxed/simple;
	bh=tM7Ev4LemJjQyizolCHaQBrTklfM0GwrQ9ezOqWMaUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QopdrCxSx7Ebc2LCzVi9TIGwtSXHWyZh5s8h5n6PyptK/LSzvUmEuK0lVhbtviXtZsKGTKPYnYjQy0Bm0o6FZvT4kmmnjuP7VTk9g0MMubsd0omMyjoGOpPF9AhisLrBfEejl8iZH/RlngNF27xoBLc0FOUNkEMAXGMbmRwAous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=W6zfCdjG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.150.10])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56CEYX1H013822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 10:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752330876; bh=ZrDyqAzF3vTo/Q7iEEl0p1Sb4STSCYYZ5nqjxgns/9s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=W6zfCdjGB/YbCvo2LVaq5nN7e0V6ECfEKSUijKhmcFU+J0EIpCEXAN19od7Q6uBWr
	 mPd23WL2XOmNqIkpkRqXnxGlHosPnnGDgoM6RsIZ0awTPKUC42V4aTzf0rFRXi+bj9
	 lDPnsxpu1+kFQiWWBUgk1oqmvC0FdBbWtmj7GVs0vr70bEcA/q5RXLDf27JtHBASkn
	 OIJI8X7S4BsqxQ3ySpZEf1cgaiKIQF84yIwgdlGW+LjO6CztlFij9xQLHVi92ZISIU
	 Bu4Br9X93CwHm/djwAd0er7d4+aoCuatbFxFWgBpmxxTA9d2XUVNEgw/3AJBxm0fdh
	 K9HKsiA8S+lbg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7859E345151; Sat, 12 Jul 2025 10:34:32 -0400 (EDT)
Date: Sat, 12 Jul 2025 10:34:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jiany Wu <wujianyue000@gmail.com>, yi.zhang@huawei.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250712143432.GE4040@mit.edu>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
 <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu>
 <20250712042714.GG2672022@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712042714.GG2672022@frogsfrogsfrogs>

On Fri, Jul 11, 2025 at 09:27:14PM -0700, Darrick J. Wong wrote:
> 
> Honestly it's really too bad that there's no way for an fs to ask the
> block device how much space it thinks is available, and then teach its
> own statfs method to return min(fs space available, bdev space
> availble).
> 
> Then at least df could report that your 500T ramdisk filesystem on a 4G
> /tmp really only has 4G of space available.

I think it would be better if there was an extra field in the statfs
structure that reported bdev space available, and have it show up
as an extra (optional) column in the df report.

The problem is that bdev space available could be highly variable.
For example, suppose you had a few thousand users all sharing thinly
provisioned space.  If a whole bunch of users suddenly all start using
space, the available space at the storage layer could suddenly
plummet.  And if the available space starts getting low, this might trigger
automated, central fstrims on all of the volumes, causing the free
space to go back up.

Having the free space on a file system as reported by df go up and
down randomly would very likely cause users to get very confused
and upset, especially when it wasn't under their control.  Even for a
single user system the free space in tmpfs could go down suddenly when
some huge process suddenly started, and then go up suddenly when that
process gets OOM-killed.  :-)

     	   	    	      	      	   - Ted


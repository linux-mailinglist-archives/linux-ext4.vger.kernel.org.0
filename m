Return-Path: <linux-ext4+bounces-7513-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9BA9D6C2
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Apr 2025 02:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD527B4C2E
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Apr 2025 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A921E32BE;
	Sat, 26 Apr 2025 00:41:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B665A79B
	for <linux-ext4@vger.kernel.org>; Sat, 26 Apr 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745628105; cv=none; b=nkbbrd/Fty6sUukHZHrwv3twFBE3uFDKqBa02QV7J1F4lKy/9h6F/Jz8ehHsfRMTKvL6kMsBt3qG5kbVUIjuh4CcK7fSBHPEgnqUgoou9deskVcQTbnzf+XC66buoo6AL4xB2W2U57a2F5O6khhJdzOqXMryZkoLSrN9ZFhF1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745628105; c=relaxed/simple;
	bh=kEfyxvi6rLBQjmgOqLS1OIWlXFYo7Z02xoFnNBQqfA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRBbUgfakiHamulBhVyOmtKk9kscHy9KVg+39oui3jnk7C+ZDpmkhX6FZ2+GQPp8nj+1gW7Yaf+6Nq0QVvVlZzN6suleWdaPCcARUzqK6LCJmYvENDfggM1kgX4ZNgTFuejXBWewigtzfx1gAx74rabk9Ww3R2exyug94G1HZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53Q0fYwe013500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 20:41:35 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 32E693459D2; Thu, 24 Apr 2025 09:59:11 -0500 (CDT)
Date: Thu, 24 Apr 2025 09:59:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, harshads@google.com
Subject: Re: [PATCH v8 0/9] Ext4 Fast Commit Performance Patchset
Message-ID: <20250424145911.GC765145@mit.edu>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>

On Mon, Apr 14, 2025 at 04:54:07PM +0000, Harshad Shirwadkar wrote:
> V8 Cover Letter
> ---------------
> 
> This is the V8 of the patch series. This patch series contains fixes to
> review comments by Jan Kara (<jack@suse.cz>). The main changes are as
> follows:

Hi Harshad,

I tried applying your patch set on top of 6.15-rc3, and a number of
tests: generic/127, generic/231, generic/241, generic/418, and
generic/589 are causing the kernel to OOPS, wedge, or reboot.  Most of
the test flakes and test failures were there without your patch set,
and we need to figure them out.... but Errors are new, and are
regressions.

I can send you the test artifacts under separate cover, or you can
just try running those tests using kvm-xfstests or gce-xfstests.

Thanks,

							- Ted

TESTRUNID: ltm-20250423233632
KERNEL:    kernel 6.15.0-rc3-xfstests-00009-gac4ab1811bb3 #22 SMP PREEMPT_DYNAMIC Wed Apr 23 14:28:04 EDT 2025 x86_64
CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c ext4/4k,ext4/fast_commit,ext4/fast_commit_1k -g auto
CPUS:      2
MEM:       7680

ext4/4k: 587 tests, 55 skipped, 5243 seconds
ext4/fast_commit: 602 tests, 20 failures, 3 errors, 55 skipped, 4564 seconds
  Failures: generic/506 generic/737 generic/757 generic/764
  Errors: generic/127 generic/241 generic/418
ext4/fast_commit_1k: 616 tests, 39 failures, 5 errors, 59 skipped, 6169 seconds
  Failures: generic/047 generic/051 generic/455 generic/475 generic/506 
    generic/757 generic/764
  Flaky: generic/627: 80% (4/5)
  Errors: generic/127 generic/231 generic/241 generic/418 generic/589
Totals: 1805 tests, 169 skipped, 59 failures, 8 errors, 15637s



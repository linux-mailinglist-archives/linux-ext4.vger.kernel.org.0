Return-Path: <linux-ext4+bounces-7228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F8A87590
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 03:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B36F7A6DC3
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 01:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7C14A4E0;
	Mon, 14 Apr 2025 01:47:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628118A95A
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595271; cv=none; b=l8QRuoHMk4NXFDShJ85Kk1b7SETtkCpo6JKYYMejkgv0HNVOP2U26wTfjDwGa88Eq+obl+iorl7uq1l+NwOcO6Et7t1yJD447yTXTMaOtOFJctz82HUBnTfBvbMhZoShrpNvxiP1nT5NGWhPiifn91uT6c6jV8BZp50cvSoaUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595271; c=relaxed/simple;
	bh=5k+iwTuy+xrcUMLjSCP+Obud++46WTKcsMGcr7dqciE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coNqBimQVkJuySSGgcxJ+KebKeC0/ikJb+NAgjho7g7+0zct4tzJ85z6akwG0gAq50oJyBeqiWTN5wmyw4NZX1PF2m6mAU0ti3fWNGlxhz4lkcf7p5Lp7xuo9x0DRjWCmmr5hio2UtGjyRIImBHAYjqdZYgehMZl8r2h92YzPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53E1lLNq026151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 21:47:23 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BF5C0345F0A; Sun, 13 Apr 2025 17:48:58 -0400 (EDT)
Date: Sun, 13 Apr 2025 17:48:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH v2 2/3] check: Add -q <n> option to support unconditional
 looping.
Message-ID: <20250413214858.GA3219283@mit.edu>
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
 <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>

On Thu, Apr 03, 2025 at 08:58:19AM +0000, Nirjhar Roy (IBM) wrote:
> This patch adds -q <n> option through which one can run a given test <n>
> times unconditionally. It also prints pass/fail metrics at the end.
> 
> The advantage of this over -L <n> and -i/-I <n> is that:
>     a. -L <n> will not re-run a flakey test if the test passes for the first time.
>     b. -I/-i <n> sets up devices during each iteration and hence slower.
> Note -q <n> will override -L <n>.

I'm wondering if we need to keep the current behavior of -I/-i.  The
primary difference between them and how your proposed -q works is that
instead of iterating over the section, your proposed option iterates
over each test.  So for example, if a section contains generic/001 and
generic/002, iterating using -i 3 will do this:

generic/001
generic/002
generic/001
generic/002
generic/001
generic/002

While generic -q 3 would do this instead:

generic/001
generic/001
generic/001
generic/002
generic/002
generic/002


At least for all of the use cases that I can think of where I might
use -i 3, -q 3 is strictly better.  So instead of adding more options
which change how we might do iterations, could we perhaps just replace
-i with your new -q?  And change -I so that it also works like -q,
except if any test fails, that we stop?

					- Ted


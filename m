Return-Path: <linux-ext4+bounces-7341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F6A94505
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Apr 2025 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149A33BF83A
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Apr 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5661DE8A2;
	Sat, 19 Apr 2025 18:23:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296129D0E
	for <linux-ext4@vger.kernel.org>; Sat, 19 Apr 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745087033; cv=none; b=Pp09KyaaGhRhvGoAcCShUojo+8BWi/9pxrR159fwxeyewkKJLMIGp9KKGo76N4SakvgGJUorWV0x+4ZqopUd64CN7/MrAT7FjiHqZ1aB/4Kh8fPlz8MIwKHdska8a/3oxyF4JojwEEFOXebqjkePT9/peRQePtXYEaFfMQqgKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745087033; c=relaxed/simple;
	bh=MQ/lAuOAINMLp3+NyBnwVts20fbhitzdLD4DT5GgikE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9Hp+5T0EDQy/ZX2j/YMB4fYNeZ1cH9nokbanIwJFkmqojAIPlOSqutPi2cHX8Z97ZdnN555Y3nmDGnci9714wixQ4FLHmqi0GSu0ksixzUTZmfMbYCy4dt6vBcZ7aAKk/Il0w3YWvlhWc4Dd0LCeFwZ0opbIgW3kSLkajy8b/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53JINQ9L007901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:23:28 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0A0163458E4; Sat, 19 Apr 2025 13:22:49 -0500 (CDT)
Date: Sat, 19 Apr 2025 13:22:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, kdevops@lists.linux.dev, dave@stgolabs.net,
        jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250419182249.GC210438@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
 <20250417183711.GB6008@mit.edu>
 <aAFq_bef9liguosY@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAFq_bef9liguosY@bombadil.infradead.org>

On Thu, Apr 17, 2025 at 01:56:29PM -0700, Luis Chamberlain wrote:
> 
> Perhaps something like (not tested):
> 
> From a9386348701e387942e3eaaef8ee9daac8ace16a Mon Sep 17 00:00:00 2001
> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Thu, 17 Apr 2025 13:54:25 -0700
> Subject: [PATCH] ext4: add ordered requirement for generic/04[456]
> 
> generic/04[456] tests how truncate and delayed allocation works.
> ext4 uses the data=ordered to avoid exposing stale data, and
> so it uses a different mechanism than xfs. So these tests will fail
> on it.

No, you misunderstand the problem.  The generic/04[456] tests are
checking for a specific implementation detail in how xfs works to
prevent stale data from being exposing data after a crash.  Ext4 has a
different method for achieving the same goal, using data=ordered,
which is the default.  So checking for data=ordered isn't necessary,
because it is the default.  But how it achieves thinigs means that
these tests, which tests for a specific implementation, doesn't work.

Fundamentally, these tests check what happens when you are writing to
a file and the file system is shutdown (simulating a power failure).
Exaclty how this handled is not guaranteed by POSIX, so testing for a
specific behaviour is in my opinion, not really that great of an idea.
In any case, the fact that we don't do exactly what these tests are
expecting is not a problem as far as I'm concerned, and so we skip
them.

Cheers,

						- Ted


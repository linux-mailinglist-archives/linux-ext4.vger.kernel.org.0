Return-Path: <linux-ext4+bounces-4597-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222B9A1A15
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 07:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FB4281B38
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8470813A257;
	Thu, 17 Oct 2024 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Jmkb1pi8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271D21E3C1
	for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142307; cv=none; b=fF0W01jmVsnzUw5LbnBv4radDA4K113E9aBiUoEkVFVZzhNce+yOOXvW1npeZ50r6tempzs4l9hAobZ5sp/TdMAlLmD8A59WZPOr8WacpKpXAlT/hW2jRJ9gunqlCnEzi+kDUsxkQNQJb9qN6TR+kAY/iyeIdprKqAWRsWg/9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142307; c=relaxed/simple;
	bh=qH5K5VZdbBkl/3KF8/roHKcsJHrbOfV8fjLUA8S/gps=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uBX2Kakrw+JOcTydCqve8G102c9KrrUia/ThgFcEVi/O6IIcaOnRf7pW/yFkv0nNTnXT2In/kR91KJaJxhI1k9rTkDsmSiX2dZTnL0l2MkWZbMH8FwVxVf60t2ICKvT8U/NzOOGtP+eJ8IQyVd3+oqUXjVsbkJjYxezi1RQNy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Jmkb1pi8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-108.bstnma.fios.verizon.net [173.48.118.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49H5IFNW006426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729142297; bh=7KMlPHoJ0a6Hbnzq/npi6q3EyuB5a3mM3KyLP9OsRRE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Jmkb1pi8xLBxzhuyZjJYKaOkwAuVSD3MSIt49x9Ksklcuy3/Km9yW1clvo0D3ffSk
	 yxVSkU3chtuz50f0cYfc7+c1QfjD+29at0hYs+MlouQWszlkADqxPXUZpYR0Rosia/
	 UE710YDOCFDVII718aNQfOOX2Q/Q1ZvfYQv0ErVHDPU5q1HoHeYeMmA6aNUWqo68/m
	 fYXhaR03/mgatfHno2HF2cZ14a7bhYOldqWNPV60s6FBXo2wp0JLMrIgHzvLlJVzA1
	 UwlnpL7uFjptNuYOsSyux0+PCyaPxtONoTYpQl3cUtKrpDKfS5dsLy48bJnfasZEv4
	 RXPoMOLtSqhOQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C810015C02DB; Thu, 17 Oct 2024 01:18:15 -0400 (EDT)
Date: Thu, 17 Oct 2024 01:18:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org, Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: New {kvm,gce}-xfstests appliance released
Message-ID: <20241017051815.GA3232770@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've pushed out a new version of the test-appliance used by
kvm-xfstest and gce-xfstests.  The kvm-xfstests appliances can be
found here:

     https://kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests

The gce-xfstests images can be found in the xfstests-cloud project in
Google Compute Engine with the image name
xfstests-{amd64,arm64}-202410151341.  Most people who request their
gce-xfstests image from the xfstests-cloud project will get the latest
version automatically.

A new feature added since the last released appliance (a while ago),
the Lightweight Test Manager (ltm) will resume a VM after it crashes
or after it hangs, and will mark the test as being in state "error"
(as opposed "failed").

In addition, if $2 USD for 24 VM hours (2.5 hours of wall clock time
if run in parallel using ltm) when testing of all 12 of the ext4 file
system configurations with "gce-xfstests -c ext4/all -g auto" is too
rich for your blood, a new feature I've added to gce-xfstests is the
optional use of GCE preemptible instances.  This will reduce the cost
by 60-91% (depending on your geography and VM type), with the tradeoff
that if the capacity of GCE zone you are using gets too busy by
customers willing to pay full price (for example, during Black Friday
and the Christmas shopping season more generally), the test VM will
get aborted.  The ltm test manager will automatically attempt to
restart the test VM (after a capped expoential backoff) and the
xfstest will resume where it was preempted once low-cost cloud capcity
becomes available again.

The arm64 kvm-xfstests test appliance can also be used on MacOS, using
the qemu built from MacPorts.  So for those people who want to run a
quick test on their Macbook Air while on an airplane flight, without
paying the double-virtualization penalty, this is now a possibility.  :-)


BTW, I'm currently running:

    gce-xfstests ltm -c ext4/all,xfs/all,btrfs/all,f2fs/all -g auto --repo https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next --watch fs-next

which runs daily test runs of the fs-next branch.  I've also started
experimenting with:

   gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6.6.y
   gce-xfstests ltm -c ext4/all,xfs/all -g auto --repo stable-rc.git --watch linux-6.1.y
   etc.

My plan is to try to make the daily reports available via e-mail to
interested parties.  Let me know if this would interest you.


For detailed information of the version of components used in the test
appliance, please see:

     https://kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/README

Documentation and more information is available at:

     https://thunk.org/gce-xfstests
     https://github.com/tytso/xfstests-bld/blob/master/Documentation/00-index.md

Cheers,

					- Ted














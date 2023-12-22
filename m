Return-Path: <linux-ext4+bounces-543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1881CF63
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Dec 2023 21:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9F0B216A3
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Dec 2023 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29F2C1A7;
	Fri, 22 Dec 2023 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b="tKCqG+cS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [200.238.171.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F472EAE1;
	Fri, 22 Dec 2023 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fisica.ufpr.br
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
	s=201705; t=1703278082;
	bh=q3OzFWPO+ENYkqlKVON5NJjRKEPNk55kel2L5hD2Hy4=;
	h=Date:From:To:Subject:From;
	b=tKCqG+cSTYg034mNMHyiwb+uOmqDyE4SvLD0SbyrF9IPT759RNU0y9r+6qV+Dny6D
	 +Hi+OcJqeiyXwN9iwzp9zmj+R3DsWkJiJAvuJ5zUGJ7DhUqbvAwOIpJ24p0zoCqvdn
	 +hlwcIamQMiBsDOPs539URbcn1z4DrU2ecyK//3ktzP3lToaOwkRZtIz2oYCQdcUo+
	 M4t41GEv5Sdxw41Qsml9TcasJ64EPjSXJAQp7LtEmaOHWGF5crM8vRVLfUO9yAFHyx
	 o2cdVldQJX1wuKl4NyT3oKIaXefK6MisqRD65xUg0Bh6eCPG2R+7RTKv7yQVJoMHiC
	 TnKaHWDWpigNw==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
	id 11BD59A0B4A46; Fri, 22 Dec 2023 17:48:01 -0300 (-03)
Date: Fri, 22 Dec 2023 17:48:01 -0300
From: Carlos Carvalho <carlos@fisica.ufpr.br>
To: linux-ext4@vger.kernel.org, linux-raid@vger.kernel.org
Subject: parity raid and ext4 get stuck in writes
Message-ID: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is finally a summary of a long standing problem. When lots of writes to
many files are sent in a short time the kernel gets stuck and stops sending
write requests to the disks. Sometimes it recovers and finally sends the
modified pages to permanent storage, sometimes not and eventually other
functions degrade and the machine crashes.

A simple way to reproduce: expand a kernel source tree, like
xzcat linux-6.5.tar.xz | tar x -f -

With the default vm settings for dirty_background_ratio and dirty_ratio this
will finish quickly with ~1.5GB of dirty pages in ram and ~100k inodes to be
written and the kernel gets stuck.

The bug exists in all 6.* kernels; I've tested the latest release of all
6.[1-6]. However some conditions must exist for the problem to appear:

- there must be many inodes to be flushed; just many bytes in a few files don't
  show the problem
- it happens only with ext4 on a parity raid array

I've moved one of our arrays to xfs and everything works fine, so it's either
specific to ext4 or xfs is not affected. When the lockup happens the flush
kworker starts using 100% cpu permanently. I have not observed the bug in
raid10, only in raid[56].

The problem is more easily triggered with 6.[56] but 6.1 is also affected.

Limiting dirty_bytes and dirty_background_bytes to low values reduce the
probability of lockup, probably because the process generating writes is
stopped before too many files are created.


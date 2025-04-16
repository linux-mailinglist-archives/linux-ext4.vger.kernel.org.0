Return-Path: <linux-ext4+bounces-7320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC3A90FA9
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 01:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6F13BB0DB
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE82356C3;
	Wed, 16 Apr 2025 23:35:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC02309AF
	for <linux-ext4@vger.kernel.org>; Wed, 16 Apr 2025 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846530; cv=none; b=nr9UqSnEgjZnVaGND25JFG+YncIHipOXV+G37AM2fQrX+JuIU7c1dSCcnIHou2oTQQoxp9Xk0pAGLAWc9honO6a52jEwi8QEXGBDOT7ezKGjnqLciZCJ7NBtED7HHcKt5uoQiA4cuXeZkUZtT0tY1GWN32Y8S+V5L4rHHYC2J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846530; c=relaxed/simple;
	bh=qunDa/3rAisoNuQT59Wgv/d6fYkkkGHGdiVzHa5bS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo7ZaiCCMRbel/LuS9aY8sCC3wP29x2ZPqLebrzWgTXUh64IAFPz0ULF0BPwt7WUoBRPn+zEGOirnoq5osl5cCawoVL6zqnt9QR05ktUmfqyUSgr+Xq0rIIsmlQYTdxvPTvBgFX4xcuLJRaSNiA7aeXODU6nZ+Fw7/WCUqxFPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([204.26.30.8])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53GNYvhW012145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 19:34:59 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E3DBD340298; Wed, 16 Apr 2025 19:34:15 -0400 (EDT)
Date: Wed, 16 Apr 2025 18:34:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250416233415.GA3779528@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SatIC/TzEOAOjj/1"
Content-Disposition: inline
In-Reply-To: <Z__vQcCF9xovbwtT@bombadil.infradead.org>


--SatIC/TzEOAOjj/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2025 at 10:56:17AM -0700, Luis Chamberlain wrote:
> ext4 developers,
> 
> kdevops has run fstests on v6.15-rc2 across the different ext4 profiles
> it currently defines, and the results are below.

Hmm, there are quite a lot of failures that aren't in my baseline.  In
particular, I work very hard to make sure the 4k profile is clean, and
as you can see in the attached file, it is.  But here's a short
summary (for the full set, including the versions used for the full
test run, see the attached file.)

ext4/4k: 587 tests, 55 skipped, 5340 seconds
ext4/1k: 581 tests, 59 skipped, 5700 seconds
ext4/ext3: 579 tests, 1 failures, 149 skipped, 4715 seconds
  Failures: ext4/028
ext4/encrypt: 562 tests, 175 skipped, 2982 seconds
ext4/nojournal: 579 tests, 127 skipped, 3955 seconds
   ...

I'll have to take a look at your test results tarball (I assume it
includes the NNN.out.bad and NNN.full files, right) to see what's
going on.

There are some exclude files[1][2] which I use to reduce noise, but
that doesn't seem to explain many of your failures that you have reported.

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/global_exclude
[2] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/exclude

>  - Is this useful information?

Maybe; the question is why are your results so different from my results.

       	   	       	       	    	    - Ted

--SatIC/TzEOAOjj/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext4-baseline-6.15-rc2"

TESTRUNID: ltm-20250414133140
KERNEL:    kernel 6.15.0-rc2-xfstests #22 SMP PREEMPT_DYNAMIC Mon Apr 14 12:18:46 EDT 2025 x86_64
CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c ext4/all -g auto
CPUS:      2
MEM:       7680

ext4/4k: 587 tests, 55 skipped, 5340 seconds
ext4/1k: 581 tests, 59 skipped, 5700 seconds
ext4/ext3: 579 tests, 1 failures, 149 skipped, 4715 seconds
  Failures: ext4/028
ext4/encrypt: 562 tests, 175 skipped, 2982 seconds
ext4/nojournal: 579 tests, 127 skipped, 3955 seconds
ext4/ext3conv: 584 tests, 57 skipped, 5164 seconds
ext4/adv: 580 tests, 2 failures, 63 skipped, 4873 seconds
  Failures: generic/757 generic/764
ext4/dioread_nolock: 585 tests, 55 skipped, 5538 seconds
ext4/data_journal: 592 tests, 8 failures, 1 errors, 135 skipped, 4464 seconds
  Failures: generic/127
  Flaky: generic/032: 20% (1/5)   generic/475: 40% (2/5)
  Errors: generic/475
ext4/bigalloc_4k: 558 tests, 1 failures, 58 skipped, 5128 seconds
  Flaky: generic/234: 20% (1/5)
ext4/bigalloc_1k: 559 tests, 69 skipped, 4965 seconds
ext4/dax: 571 tests, 2 failures, 160 skipped, 3111 seconds
  Failures: generic/344 generic/363
Totals: 6941 tests, 1162 skipped, 34 failures, 1 errors, 52426s

FSTESTIMG: gce-xfstests/xfstests-amd64-202504110828
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 236edfd (Tue, 18 Mar 2025 12:56:26 +0900)
FSTESTVER: fio  fio-3.39 (Tue, 18 Feb 2025 08:36:57 -0700)
FSTESTVER: fsverity v1.6-2-gee7d74d (Mon, 17 Feb 2025 11:41:58 -0800)
FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp  20250130-195-ge2bbba0c1 (Fri, 11 Apr 2025 18:06:15 +0800)
FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
FSTESTVER: util-linux v2.41 (Tue, 18 Mar 2025 13:50:51 +0100)
FSTESTVER: xfsprogs v6.13.0-2-gf0d16c9e (Tue, 1 Apr 2025 20:23:42 -0400)
FSTESTVER: xfstests-bld 42bcd9aa (Wed, 9 Apr 2025 07:51:57 -0400)
FSTESTVER: xfstests v2025.03.30-11-g344015670 (Mon, 31 Mar 2025 13:50:06 -0400)
FSTESTVER: zz_build-distro bookworm
FSTESTSET: -g auto
FSTESTOPT: aex

--SatIC/TzEOAOjj/1--


Return-Path: <linux-ext4+bounces-8017-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF2ABC00C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525D53AC85C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2127A911;
	Mon, 19 May 2025 13:56:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF127FB2E
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663014; cv=none; b=l/ruPRmVfKlMX5C+NTssae+QX3mqogn1lcxdjqIcbdWZryx7bS9xfH20VuBGiSshLLquKYzeyvtbhq3evzC4GzmVUvaUwo11K1nDsDcZoe6zYSLT/zaiF+VVfItkt9cku/bQcrXEcT/zNgKDePImvXdUGBdsmxooObuXq4OoM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663014; c=relaxed/simple;
	bh=3hbqHKmWFsNLHw/fa4d26mjpP3dAYETleGjy1aQoctQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpujYnsAlLVxEcwJf+1P7bZwVgreHa+mZcWaNowtA7vcleUJwSumPcoMPAJQnCQMeB0kObzMJe6wfVtTZjWpy2EiLoTrpxouVwlgE7aXClm0IChVtNhry1Vs/LCv6i6SoOAL9X5C/jPJQI/xlAqqlWiczB1KC6wsuKchEBCoT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JDuX8K016210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 09:56:33 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D84D52E00DD; Mon, 19 May 2025 09:56:32 -0400 (EDT)
Date: Mon, 19 May 2025 09:56:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250519135632.GA38098@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505191316.JJMnPobO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505191316.JJMnPobO-lkp@intel.com>

On Mon, May 19, 2025 at 01:58:02PM +0800, kernel test robot wrote:
> Hi Ethan,
> 
> kernel test robot noticed the following build errors:

Hi Ethan,

I would really appreciate it if you would at least do a build test
before sending out a patch.  In addition, it would also be helpful if
you ran a smoke test, using "kvm-xfstests smoke".  The instructions
for how to use kvm-xfstests can be found here[1], and it was designed
to be as easy as possible for people who are sending "drive-by
patches".

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Running the smoketest only takes about 20 minutes; although if you
want to run more sophistcated testing there is also "kvm-xfstests -c
ext4/4k -g quick", or "kvm-xfstests -c ext4/4k -g auto", or if you
have a 24 hours to kill, there's always "kvm-xfststs full".  (Although
these days I generally use gce-xfstests[2] since this can shard the test
runs across multiple VM's, so it only takes 2.5 hours of wall clock
time.)

[2] https://thunk.org/gce-xfstests

Cheers,

					- TEd


Return-Path: <linux-ext4+bounces-10330-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41922B8EFB5
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 07:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451E017BC00
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 05:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8232264C8;
	Mon, 22 Sep 2025 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BcNVWZn6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70552C148;
	Mon, 22 Sep 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758517333; cv=none; b=WBECRCx1R8F7kTNTcagnzxArnF43MW479u8HGGAMhlZvlB/VjgsqF2ErA6pgUWstKhBs7OqMnqvO6tDR8Zjr/anfAd+C4HygXS9ZnJSXP1zkSn8SuZVmOY1m0qawGdyoLE0DPNl78xR/3St2OGg3xOEO3aqQ8H/w7CORuBTSuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758517333; c=relaxed/simple;
	bh=/nk8xPLOsGXuSw5wS41Jy4q570vGloBiPOCZp2/irX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWoTP1eV0IW5JcNDQIZ3a0JzZCn0kPAtsTpcGxzybql9nw2ENzifIuqgGz2ODAmDzW+iz+kjm83zZHvvV/iuSWlKt/bpuTlt3TA0Ex9esZ0dtq15QIiwr7kRfTCrBCfFZHOVvQJ6dSesO4iJruzIc5OKsPjhYFBO5CKYivzF2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BcNVWZn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A858C4CEF5;
	Mon, 22 Sep 2025 05:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758517333;
	bh=/nk8xPLOsGXuSw5wS41Jy4q570vGloBiPOCZp2/irX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcNVWZn6zT4Gv/IUZ2C0NZn/XQ5pAMMpsZzcS58NBPYxD2oFH/k4xQ1OcYygH2JDO
	 qM8XphYZH6pOzc+c2uakvnfuiVmB28vwfNolajwWxIrag0Gc1iZ0LiKuoKaX4EXv7U
	 h1tGLKcFUdBrn8iKhoSlB6ijAzBdHBAHMrirLbcw=
Date: Mon, 22 Sep 2025 07:02:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"jdike@addtoit.com" <jdike@addtoit.com>,
	"richard@nod.at" <richard@nod.at>,
	"anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"rric@kernel.org" <rric@kernel.org>,
	"harry.wentland@amd.com" <harry.wentland@amd.com>,
	"sunpeng.li@amd.com" <sunpeng.li@amd.com>,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"airlied@linux.ie" <airlied@linux.ie>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"evan.quan@amd.com" <evan.quan@amd.com>,
	"james.qian.wang@arm.com" <james.qian.wang@arm.com>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"mihail.atanassov@arm.com" <mihail.atanassov@arm.com>,
	"brian.starkey@arm.com" <brian.starkey@arm.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"robdclark@gmail.com" <robdclark@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"fery@cypress.com" <fery@cypress.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"rajur@chelsio.com" <rajur@chelsio.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
	"alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"malattia@linux.it" <malattia@linux.it>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"mgross@linux.intel.com" <mgross@linux.intel.com>,
	"intel-linux-scu@intel.com" <intel-linux-scu@intel.com>,
	"artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"dushistov@mail.ru" <dushistov@mail.ru>,
	"luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"pmladek@suse.com" <pmladek@suse.com>,
	"sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
	"yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"fw@strlen.de" <fw@strlen.de>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>,
	"ying.xue@windriver.com" <ying.xue@windriver.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>,
	"herve.codina@bootlin.com" <herve.codina@bootlin.com>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH 00/27 5.10.y] Backport minmax.h updates from v6.17-rc6
Message-ID: <2025092203-untreated-sloppily-23b5@gregkh>
References: <20250919101727.16152-1-farbere@amazon.com>
 <2025092136-unelected-skirt-d91d@gregkh>
 <4f497306c58240a88c0bb001786c3ad2@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f497306c58240a88c0bb001786c3ad2@amazon.com>

On Sun, Sep 21, 2025 at 09:37:02PM +0000, Farber, Eliav wrote:
> > On Fri, Sep 19, 2025 at 10:17:00AM +0000, Eliav Farber wrote:
> > > This series includes a total of 27 patches, to align minmax.h of
> > > v5.15.y with v6.17-rc6.
> > >
> > > The set consists of 24 commits that directly update minmax.h:
> > > 1) 92d23c6e9415 ("overflow, tracing: Define the is_signed_type() macro
> > >    once")
> >
> > But this isn't in 5.15.y, so how is this syncing things up?
> >
> > I'm all for this, but I got confused here, at the first commit :)
> 
> It's a typo.
> It should be 5.10.y and not 5.15.y.
> 
> > Some of these are also only in newer kernels, which, as you know, is
> > generally a bad thing (i.e. I can't take patches only for older
> > kernels.)
> >
> > I want these changes, as they are great, but can you perhaps provide
> > patch series for newer kernels first so that I can then take these?
> 
> So you'd first like first to align 6.16 with 6.17, then 6.15 with 6.16,
> then 6.12 with 6.15, then 6.6 with 6.12, and so on until we eventually
> align 5.10 and even 5.4?

Yes please!



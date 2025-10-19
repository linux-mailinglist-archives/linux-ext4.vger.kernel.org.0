Return-Path: <linux-ext4+bounces-10972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA4BEE4E8
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF06420D36
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068B2E88A6;
	Sun, 19 Oct 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mr7tZ637"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50394A41;
	Sun, 19 Oct 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877464; cv=none; b=feJOt1BBmQqr2VY8wbDIPztP47tXjDLCWkWHS7/NMB3pmNCBvT658W3J/QGk1dPzseCInMqyQNp0Xysq1AQNg3Cr2WSRZEafVP3zPkMbG6pmG2k4BfvzER7LhLCVrcxaS8oAa+Q3YBPqLZMwikSUA3ap4ju1hh37vYLJOeP0iXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877464; c=relaxed/simple;
	bh=dgzA9LsGuiP/mYejoGwFkpon4M45cMihfvBvR4qrSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZR6F4dTdA5UvN2irZqmWrvNZu7D5STaimlzgp1izDXP/XYymavfECXsTK5d+c3uL88e/OPlv1nvlBZVB2x/wF46J5qKJ5tPsgBPhbHumb7E8pA+kbkWa/cIQLot0G0lfF5TP72aSc++lJ5kEFm4/eMMi19Dhck2Uq02n/DFKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mr7tZ637; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54864C4CEE7;
	Sun, 19 Oct 2025 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760877463;
	bh=dgzA9LsGuiP/mYejoGwFkpon4M45cMihfvBvR4qrSRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mr7tZ637v1WDh2Nr8sg19/xoeGzZL3RvlnXfYUykPJk+G6zQteton6Oo+u5wVdnxN
	 ZBC8QPSBVC5hJfXNWgutJHN6QRJ4bxeGe2+hYWxIp2brHCNu/KXcKMeG5P43CM4Fjg
	 vDPDOANq6idL2020QoIIUuWRPKXTuhm7Nf2n5Cxw=
Date: Sun, 19 Oct 2025 14:37:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
	"xiang@kernel.org" <xiang@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>,
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
	"keescook@chromium.org" <keescook@chromium.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
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
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <2025101929-curator-poplar-7460@gregkh>
References: <20251017090519.46992-1-farbere@amazon.com>
 <2025101704-rumble-chatroom-60b5@gregkh>
 <CH0PR18MB5433BB2E99395D2AC8B0E0FBC6F7A@CH0PR18MB5433.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB5433BB2E99395D2AC8B0E0FBC6F7A@CH0PR18MB5433.namprd18.prod.outlook.com>

On Sat, Oct 18, 2025 at 08:07:32PM +0000, Farber, Eliav wrote:
> > On Fri, Oct 17, 2025 at 09:04:52AM +0000, Eliav Farber wrote:
> > > This series backports 27 patches to update minmax.h in the 5.10.y
> > > branch, aligning it with v6.17-rc7.
> > >
> > > The ultimate goal is to synchronize all long-term branches so that they
> > > include the full set of minmax.h changes.
> > >
> > > - 6.12.y has already been backported; the changes are included in
> > >   v6.12.49.
> > > - 6.6.y has already been backported; the changes are included in
> > >   v6.6.109.
> > > - 6.1.y has already been backported; the changes are currently in the
> > >   6.1-stable tree.
> > > - 5.15.y has already been backported; the changes are currently in the
> > >   5.15-stable tree.
> >
> > With this series applied, on an arm64 server, building 'allmodconfig', I
> > get the following build error.
> >
> > Oddly I don't see it on my x86 server, perhaps due to different compiler
> > versions?
> >
> > Any ideas?
> 
> This mainline commit is missing:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ralink/rt2x00/rt2800lib.c?h=v6.18-rc1&id=66063033f77e10b985258126a97573f84bb8d3b4
> 
> This fix already exists in 5.15.y:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/wireless/ralink/rt2x00/rt2800lib.c?h=v5.15.194&id=2d3cef3d7a5df260a14a6679c4aca0c97e570ee5
> …but is missing in 5.10.y.
> 
> I now backported it to 5.10.y here:
> https://lore.kernel.org/stable/20251018195945.18825-1-farbere@amazon.com/T/#u

Thanks,I've queued that up now.

greg k-h


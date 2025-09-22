Return-Path: <linux-ext4+bounces-10332-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72404B903D8
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481E27A013D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCFB3019AB;
	Mon, 22 Sep 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sv99FDLC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9942AA9;
	Mon, 22 Sep 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537944; cv=none; b=dSvbWoXA2HRZ6Ujekl86cZDka3epJp68Uk/E/q6g3AHmevdt5buJ4bihE2Cw6jBsTqhWLbWY+ivxr1IFHPsqIN0MBvT4zf0NAjAVgI0jH1j5iyhUX6AYvNVG6dPeyl74toA3PuA1YpW5szQXUvmowtOXxwqE3h6/pQvUzPPDThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537944; c=relaxed/simple;
	bh=pwDlNzth5nMROXqz5kAkkxuxkWM/ATKQc6A9J9A4BoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Em4B+5Enbh8Gve84nQG/c6f3TmRwyGUI1mDq30HhqmhMpfvzxHV0ouwkVSWhhQQeLgcYr8VoaB0GLr9WE7JtLYB1uQjdqJoTeUlG5ROn7jT4OfvA8fOsnuN/qHY9t45lT3zx+yb7T4U5eQxPM4kB9ZuPrs3NV+7pETzca9EEeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sv99FDLC; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537942; x=1790073942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jHPTQZFCaC0QVf/rAslU2rF+GKEtXGi5htBMXx8M8BI=;
  b=Sv99FDLCJke7R2kkVtUondV85mgv57Pd4ZaGqz37iM3HgwASx20V4P3A
   gFaNPRrqOC7huGzjtnpB2mfIYOr4j8gpMzWXmlG04Zyj9AmeulsnVzR+T
   8WETfPx/1sCchBsRAgmF0fanX8+IiedjGxLEv8FP7vTmQg6DG0sNangCe
   ILlIAQPR387Vj6zpB16WEBW6iyB3JUoVcj4ARcW8dMsme/8mSV2DLwF6k
   XRVl81i6aYl2tSCd9RqZsQ/zfMaJ24WT1DKm8kJQy5gNxTJyLdwtzeapA
   dkUm2S5EopS94zo35BAhKupBenIlCx0kKER+1D+lMXecxMsx/ilOLgWH2
   Q==;
X-CSE-ConnectionGUID: 6hOHCxAKSfC6e+p5CvVdZw==
X-CSE-MsgGUID: YBSxBrJDRxalvxjSB5/Ebw==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2482713"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:45:38 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:29409]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.226:2525] with esmtp (Farcaster)
 id f47c06f5-2d15-4c95-af11-de6ff2958513; Mon, 22 Sep 2025 10:45:38 +0000 (UTC)
X-Farcaster-Flow-ID: f47c06f5-2d15-4c95-af11-de6ff2958513
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:45:38 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:45:37 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Mon, 22 Sep 2025 10:45:37 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "jdike@addtoit.com"
	<jdike@addtoit.com>, "richard@nod.at" <richard@nod.at>,
	"anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "qiuxu.zhuo@intel.com"
	<qiuxu.zhuo@intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org"
	<rric@kernel.org>, "harry.wentland@amd.com" <harry.wentland@amd.com>,
	"sunpeng.li@amd.com" <sunpeng.li@amd.com>, "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "airlied@linux.ie" <airlied@linux.ie>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "evan.quan@amd.com" <evan.quan@amd.com>,
	"james.qian.wang@arm.com" <james.qian.wang@arm.com>, "liviu.dudau@arm.com"
	<liviu.dudau@arm.com>, "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>,
	"brian.starkey@arm.com" <brian.starkey@arm.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "robdclark@gmail.com" <robdclark@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "fery@cypress.com"
	<fery@cypress.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"agk@redhat.com" <agk@redhat.com>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, "rajur@chelsio.com"
	<rajur@chelsio.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "peppe.cavallaro@st.com"
	<peppe.cavallaro@st.com>, "alexandre.torgue@st.com"
	<alexandre.torgue@st.com>, "joabreu@synopsys.com" <joabreu@synopsys.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "malattia@linux.it"
	<malattia@linux.it>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"mgross@linux.intel.com" <mgross@linux.intel.com>,
	"intel-linux-scu@intel.com" <intel-linux-scu@intel.com>,
	"artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "jack@suse.com" <jack@suse.com>, "tytso@mit.edu"
	<tytso@mit.edu>, "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"dushistov@mail.ru" <dushistov@mail.ru>, "luc.vanoostenryck@gmail.com"
	<luc.vanoostenryck@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"pmladek@suse.com" <pmladek@suse.com>, "sergey.senozhatsky@gmail.com"
	<sergey.senozhatsky@gmail.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "minchan@kernel.org" <minchan@kernel.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
	"yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>, "pablo@netfilter.org"
	<pablo@netfilter.org>, "kadlec@netfilter.org" <kadlec@netfilter.org>,
	"fw@strlen.de" <fw@strlen.de>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"ying.xue@windriver.com" <ying.xue@windriver.com>, "willy@infradead.org"
	<willy@infradead.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "herve.codina@bootlin.com"
	<herve.codina@bootlin.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org"
	<freedreno@lists.freedesktop.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org"
	<coreteam@netfilter.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH 00/27 5.10.y] Backport minmax.h updates from v6.17-rc6
Thread-Topic: [PATCH 00/27 5.10.y] Backport minmax.h updates from v6.17-rc6
Thread-Index: AQHcK64HHJftfGNvN0Cy23wGYTG5SQ==
Date: Mon, 22 Sep 2025 10:45:37 +0000
Message-ID: <df8d65b372864d149035eb1f016f08ae@amazon.com>
References: <20250919101727.16152-1-farbere@amazon.com>
 <2025092136-unelected-skirt-d91d@gregkh>
 <4f497306c58240a88c0bb001786c3ad2@amazon.com>
 <2025092203-untreated-sloppily-23b5@gregkh>
In-Reply-To: <2025092203-untreated-sloppily-23b5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Sun, Sep 21, 2025 at 09:37:02PM +0000, Farber, Eliav wrote:
> > > On Fri, Sep 19, 2025 at 10:17:00AM +0000, Eliav Farber wrote:
> > > > This series includes a total of 27 patches, to align minmax.h of=20
> > > > v5.15.y with v6.17-rc6.
> > > >
> > > > The set consists of 24 commits that directly update minmax.h:
> > > > 1) 92d23c6e9415 ("overflow, tracing: Define the is_signed_type() ma=
cro
> > > >    once")
> > >
> > > But this isn't in 5.15.y, so how is this syncing things up?
> > >
> > > I'm all for this, but I got confused here, at the first commit :)
> >
> > It's a typo.
> > It should be 5.10.y and not 5.15.y.
> >
> > > Some of these are also only in newer kernels, which, as you know, is=
=20
> > > generally a bad thing (i.e. I can't take patches only for older
> > > kernels.)
> > >
> > > I want these changes, as they are great, but can you perhaps provide=
=20
> > > patch series for newer kernels first so that I can then take these?
> >
> > So you'd first like first to align 6.16 with 6.17, then 6.15 with=20
> > 6.16, then 6.12 with 6.15, then 6.6 with 6.12, and so on until we=20
> > eventually align 5.10 and even 5.4?
>
> Yes please!

Stable 6.16.8 didn't require any changs.

I pulled the changes for 6.12.48:
https://lore.kernel.org/stable/20250922103123.14538-1-farbere@amazon.com/T/=
#t
and 6.6.107:
https://lore.kernel.org/stable/20250922103241.16213-1-farbere@amazon.com/T/=
#t

Once approved, I'll continue with other longterm branches.

---
Regards, Eliav




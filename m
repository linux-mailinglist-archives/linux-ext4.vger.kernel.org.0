Return-Path: <linux-ext4+bounces-10942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D01BE87ED
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6D4FED44
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D96320CA3;
	Fri, 17 Oct 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSItTMlZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4A332ED1;
	Fri, 17 Oct 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702378; cv=none; b=G7JpNuCNKR2mhPYB8ZwkaT8d9NNwHoKr8HEbg1vCJdTpMtg2BKK0QC0OQ7ydMishGnFPbX5U0cHBcWu6R2uzQmUDzLhXJR54TJ4lfAoHNr+rkEdjCXpItPEAdnpAl7C+Gfzl0fsshjXb+zlNl5LeRw9J0IaCFQnlvPup4/4Q2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702378; c=relaxed/simple;
	bh=38uFLiDTAO+A1PWpRP2bVJ1ijHpCWsegoKBcJwzF2PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRSqkmkyU//E0j9tu3ocppmmZp9yoeSdaF+D/IibHAvxEELpeO/gp0nFLJTngjol7puHPS1LrLq+pfV9gzqTSpTXr7CGp8PkepomT0mdrViS5eBGLimTHRtVfgIHoC6pdu719NNFqOLnkMKSWs/ANV+dCqAo4T/hBgfHOoM4RzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSItTMlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3037FC4CEE7;
	Fri, 17 Oct 2025 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760702377;
	bh=38uFLiDTAO+A1PWpRP2bVJ1ijHpCWsegoKBcJwzF2PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSItTMlZ+xkWo77L3dJDjTz61eq44oatBXCgbcCC5ycxjVd62F5ZBD5t/I/P7IMAl
	 lQe+zy+uvgq1Iphq58yIzjQNmbjsJLGcQk9xMD89Oyn29Qra+kKcuYPJON2XTLg6Wc
	 Tx4/0gvLYtBA9RdvGnygRkoazMU/mLdzs1fx2bZA=
Date: Fri, 17 Oct 2025 13:59:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: stable@vger.kernel.org, linux@armlinux.org.uk, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
	james.qian.wang@arm.com, liviu.dudau@arm.com,
	mihail.atanassov@arm.com, brian.starkey@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robdclark@gmail.com, sean@poorly.run,
	jdelvare@suse.com, linux@roeck-us.net, fery@cypress.com,
	dmitry.torokhov@gmail.com, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, rajur@chelsio.com, davem@davemloft.net,
	kuba@kernel.org, peppe.cavallaro@st.com, alexandre.torgue@st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, malattia@linux.it,
	hdegoede@redhat.com, mgross@linux.intel.com,
	intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, xiang@kernel.org, chao@kernel.org, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	willy@infradead.org, sashal@kernel.org, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com, Jason@zx2c4.com,
	keescook@chromium.org, kbusch@kernel.org, nathan@kernel.org,
	bvanassche@acm.org, ndesaulniers@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Isabella Basso <isabbasso@riseup.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Vlastimil Babka <vbabka@suse.cz>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 01/27 5.10.y] overflow, tracing: Define the
 is_signed_type() macro once
Message-ID: <2025101708-obtuse-ellipse-e355@gregkh>
References: <20251017090519.46992-1-farbere@amazon.com>
 <20251017090519.46992-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017090519.46992-2-farbere@amazon.com>

On Fri, Oct 17, 2025 at 09:04:53AM +0000, Eliav Farber wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> [ Upstream commit 92d23c6e94157739b997cacce151586a0d07bb8a ]

This isn't in 5.15.y, why is it needed in 5.10.y?

thanks,

greg k-h


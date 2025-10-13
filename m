Return-Path: <linux-ext4+bounces-10817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9ABD1614
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 06:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672FA18937A8
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 04:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D4296BB5;
	Mon, 13 Oct 2025 04:28:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05F27F747;
	Mon, 13 Oct 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760329701; cv=none; b=PYgZtWkzDh0N9dey5uLEKcs3VPiGhY0Rlapowr5S3FBU8NlLLs6Kl0P9pEhCsjVU2177c+euePw/M31/gIq8kI+q0I5yTmrf0IYG4/ilE8x1LV85H/L/fyUCTY4fUsWSTnTWFUval754ME1Dq8EH7zrmXfYwxtGhFlLyIIRympI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760329701; c=relaxed/simple;
	bh=D2j4VRk7a14GHI55HmxdAs/3Rt4Jbr/RtZrqE5xz2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsvJhXRo4vBV0qGcIBJjqCwqRpdsjhCjAgj4+kEvjQGSfvNSxe+y8Z4ti8eW5gPPemLRhkNYhYNyLLivG9yE2si+OwBnZJK9yQ6PhhlgHvxTNf5F9w/feQb+Pk4KlpffXv43fXFYvkuJm164osWeLd8yB7fCZgwGZALhQYDXeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-b8-68ec7fdc6e98
Date: Mon, 13 Oct 2025 13:28:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 09/47] arm64, dept: add support
 CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Message-ID: <20251013042807.GB6925@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-10-byungchul@sk.com>
 <aN_fel4Rpqz6TPsD@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_fel4Rpqz6TPsD@J2N7QTR9R3>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH955bTxs7zgoLr/bDTHfLcDpd3HhY3C0m28lwcXMJHxgJduPM
	NkIhBVFmGBUpwSmsuhRCi6yI3KuwUycC6+LYwLFLrEJGdbSIVDqyFqaDEjJod4ox89sv//+T
	3/s8ycuSqkZmA6s3FAlGgzZXwygoRXhd02ZfWUi3tXkaw+JCFQUN3U4GqsR6GiYXqxAs/Wsn
	wdwXo2Bh+Q8ZxNzDCJwXjhDwT0+UAetUgIG62SMUzA69DeHJARpiviAB45EQgtZAlIDV2v1Q
	Z/UgaJrykXBh2I9gNPAojC3OMzBiPc5A+FoDAXM9DDjK3TTUnhYp6LvVL4OJ2lMEdInvwi+W
	M4T0BgO1XyeDve4oAdZzAwQst3bK4NfmCQrsv43SsDK1DWKOfBjuCsrA94WVgvPhqzSM+H+X
	DrlSSUOv6ZYMxBtD0vonZkgQp6XCfXMT1DdOMDDa38CA3xmjwWRfouF6l4eC7qCXgBFbBwVX
	+8/R0DJ+jYBIjRo8J6tp8FruIPhybga9kcMvmWsovtN1keDN11cZ3tnoRPxCy1GSN1sk+iE0
	T/IVroO8O+Kg+J/PYL7P5pPxFd/dlPEO8QBf8WOY5l3tKXzzt7PEe5szFTtyhFx9sWB84bW9
	Ct3tmctUgZh0qP3YSdqEwgmfIzmLue249/i47AF/1VtBxZninsZtkbY1Zrhnsde7TMY5SeIT
	/QtSrmBJrkmN3U7PWpHIZeOVjjEizkouFU+Id4n4kIorR9jUXUXeLx7DI/WBNSvJpWBvdFYa
	YiVW47YoG4/lUtzU9zcd58e5J/Hli1fWPJjzy/HdOTO6v+l6/H27l7IgzvaQ1vaQ1va/1oHI
	TqTSG4rztPrc7Vt0JQb9oS0f5+eJSPq1raUrH15C9zwfDCKORZp1St3AXzoVrS0uLMkbRJgl
	NUnK1MMhnUqZoy35VDDmZxsP5AqFg0jNUppk5YuRgzkqbp+2SNgvCAWC8UFLsPINJlS9983s
	V7LuZUxmvmNK3Ply2cb1cKeydVfm9NDu51MyDD07nxrPHpUv1Rx7HSWESlejRQmVrtOB6vLP
	yiqf+cTu7T7vGXt/Y2MgTRfanTaf9lFBerDouX2JHX9Sb/lte3akcq5HnuBb1D1jP5VmWFZv
	n33p8KWsG1vTs4Lpm745pUxefFVDFeq021JIY6H2P46klOixAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89z73Bc6ul07jDeQJUs3Y8SoM7p4Msxi/KB3LDP7sMTMxGAz
	b2zDm2kRxcUIFCI6o7SzdLSKFEep0AkWlCHpJBjrgFWpVGWOipgKVNoxWYtDSvGWZZlfTn7n
	/3LyfHhYUpGg0llNQZGoLVDlKWkZlu3M0q8dORZWf/T7i9XwoKwHQyxaheFcq5OGKlctBYOX
	WxCMxqoQvJy3klDZtYhhwehhIDr3BwOLbg+CGp+RBGdHGQF/tyVomLo5g8A0FqTBHCrDMG0/
	hcAybmUgdGsHREa7KVgMTBDwcDaMwB5MEBDsOY5goSYXLjS00zDvvUuC2TSIwDYWIGGyTTI7
	PI8RuB3lNDyrvkrCUPBt8MemaegzfUdDxHeOgD/baKgvd1Nw3mpEoL/YSkPNeReGrifXGfBN
	xQkYqTES0OL6Akbt4xgGqhsI6X1S6soKsJr1hDQmCTD91E3AnL2Zgd8ujmCwl64Eq3eIgqcO
	CwPxsQ2wWF8InpYJBgJnTBguR+5SW01IeFl5GgvN7dcIofLeAi0465xImH9lREK0UU8KldXS
	ejM8TQoV7YeExoEwLbyK3acF92w9FvobeMHgXSt0WQKMUPHLI+bLT3bLtuwT8zTFonb9p3tl
	6qfjPfiAK+2w44SBKkWRd06iFJbnNvEXOitwkjG3km+abVpimlvFDw/PkUlOk/jU9aiky1iS
	s2XwbufgkvEul8PHL/mJJMu5zfyI6wWRDCm4csSXtlaR/xrL+L7a4NJVksvkhxMhKcRKnME3
	JdiknCLJtq6/qCQv5z7ge67dJqqR3PJG2/JG2/J/ux6RzShNU1Ccr9LkfbxOl6suKdAcXvdN
	Yb4LSb/SfjRu+BlFh3b0Io5FylS5untKraBUxbqS/F7Es6QyTb7527BaId+nKjkiagtztAfz
	RF0vymCxcoU8e5e4V8HtVxWJuaJ4QNT+5xJsSnopavznkR+fyDkZOHtcf+f5j1lnFRMtX7X2
	RTfKfP2h9DX+eXJLaNuRnbHs3u3esgann+Ft34/1v0cdelY3MGNYvudewKCd+GxyTXnEQXm3
	vu/+nMlMXWa+6nqr88YuWx16/uuxBarzccfMDxXZDl+7L27+8ODXp4n81LmsGY/PXlukxDq1
	akMmqdWpXgMpcDDEkQMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 03:36:42PM +0100, Mark Rutland wrote:
> On Thu, Oct 02, 2025 at 05:12:09PM +0900, Byungchul Park wrote:
> > dept needs to notice every entrance from user to kernel mode to treat
> > every kernel context independently when tracking wait-event dependencies.
> > Roughly, system call and user oriented fault are the cases.
> >
> > Make dept aware of the entrances of arm64 and add support
> > CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  arch/arm64/Kconfig          | 1 +
> >  arch/arm64/kernel/syscall.c | 7 +++++++
> >  arch/arm64/mm/fault.c       | 7 +++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e9bbfacc35a6..a8fab2c052dc 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -281,6 +281,7 @@ config ARM64
> >       select USER_STACKTRACE_SUPPORT
> >       select VDSO_GETRANDOM
> >       select VMAP_STACK
> > +     select ARCH_HAS_DEPT_SUPPORT
> >       help
> >         ARM 64-bit (AArch64) Linux support.
> >
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index c442fcec6b9e..bbd306335179 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/randomize_kstack.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/dept.h>
> >
> >  #include <asm/debug-monitors.h>
> >  #include <asm/exception.h>
> > @@ -96,6 +97,12 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >        * (Similarly for HVC and SMC elsewhere.)
> >        */
> >
> > +     /*
> > +      * This is a system call from user mode.  Make dept work with a
> > +      * new kernel mode context.
> > +      */
> > +     dept_update_cxt();
> 
> As Mark Brown pointed out in his replies, this patch is missing a whole
> bunch of cases and does not work correctly as-is.
> 
> As Dave Hansen pointed out on the x86 patch, you shouldn't do this
> piecemeal in architecture code, and should instead work with the
> existing context tracking, e.g. by adding logic to
> enter_from_user_mode() and exit_to_user_mode(), or by reusing some

I will consider it.  However, I need to check if there are not any waits
and events before enter_from_user_mode(), or after exit_to_user_mode()
since those functions aren't the outmost functions for kernel mode C
code anyway.

	Byungchul

> existing context tracking logic that's called there.
> 
> Mark.


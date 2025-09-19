Return-Path: <linux-ext4+bounces-10266-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD91B88C9B
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A7562669C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A862FB994;
	Fri, 19 Sep 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fjL8z8mj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDC2ECE85;
	Fri, 19 Sep 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277096; cv=none; b=nKI50IrBS4Kx+3gmTVJigXM8JLNghJHaWOrrNkLSEOFRFpuMoVjXrC8Gf6wRIDdp3U82MVLMtgJx2XBon+5rhLqkGtHm++bVlHdnqjjY0P8fH7OHWz6z8DDlJZazZz4fxwLQrWJ1738jZ7KqCbPnOze3O/DC3uBFLKvNpshyjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277096; c=relaxed/simple;
	bh=YJdsYm70lqmrjZhD7jBaV8cdfUCAbDW2tpB1Od6r91s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DV5HPFwZzEqcW5TVIkpvyWdQy6q+0ypsClB6hMR+ftQ9BgO9CVWUGqfVZ7/ZZD0ZoEXX7Hc+gpsG+sn7M6OT0KrlCGSN3kD0vUiNpdo6Y7xP9v55rjUHyfQF2mJzmP752GlLh1gO05IRAbCQXoXtmOlJfC9WZkwwjId/kb/7fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fjL8z8mj; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758277094; x=1789813094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BxXd7aLvDai7evuJPWIvJpLyCQkjko3tn6jQCrrWhJk=;
  b=fjL8z8mj0eMIoChdIs8U9FiBsNbuQUiVVPlT3zrMd2QY4qshSQGFLsCZ
   I3RvurginN0A0zChNMESd2d9w8s3xOy5oVmh614EDqw2yBhb/QmmcPOe3
   wAAtuxQ+v2eRIjVuLFIedVBHsV3Rb12raStNei1WJf2DEDd/aHXHZhmeN
   a76yJ5Nd+Gk7nlpcDtvLOt5sY92VddMIhaXr5b8MVqqxkEyG5Fzb9cBYs
   NZ2BX/TzsOfyqIh85A+I7sEL6a70FKGDlX46GqPiXZuw3OnvDWvZsHlvS
   OHWNraZNTBCZiIHocmYMS/MclFB/5eIGDNbYlGQCbqgvw6N7wcVazh2wF
   A==;
X-CSE-ConnectionGUID: jIqyC7qOQMmU/YsQW+R8ug==
X-CSE-MsgGUID: YteI4yn4Q++iTijrRm1r6A==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2367150"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:18:03 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:23074]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.8.212:2525] with esmtp (Farcaster)
 id 74144341-cb99-482b-a66c-2682d68c7588; Fri, 19 Sep 2025 10:18:03 +0000 (UTC)
X-Farcaster-Flow-ID: 74144341-cb99-482b-a66c-2682d68c7588
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 10:18:02 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 19 Sep 2025
 10:17:34 +0000
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
	<mihail.atanassov@arm.com>, <brian.starkey@arm.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <fery@cypress.com>,
	<dmitry.torokhov@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <rajur@chelsio.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <malattia@linux.it>,
	<hdegoede@redhat.com>, <mgross@linux.intel.com>, <intel-linux-scu@intel.com>,
	<artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>,
	<herve.codina@bootlin.com>, <Jason@zx2c4.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH 00/27 5.10.y] Backport minmax.h updates from v6.17-rc6
Date: Fri, 19 Sep 2025 10:17:00 +0000
Message-ID: <20250919101727.16152-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series includes a total of 27 patches, to align minmax.h of
v5.15.y with v6.17-rc6.

The set consists of 24 commits that directly update minmax.h:
1) 92d23c6e9415 ("overflow, tracing: Define the is_signed_type() macro
   once")
2) 5efcecd9a3b1 ("minmax: sanity check constant bounds when clamping")
3) 2122e2a4efc2 ("minmax: clamp more efficiently by avoiding extra
   comparison")
4) f9bff0e31881 ("minmax: add in_range() macro")
5) c952c748c7a9 ("minmax: Introduce {min,max}_array()")
6) 5e57418a2031 ("minmax: deduplicate __unconst_integer_typeof()")
7) f6e9d38f8eb0 ("minmax: fix header inclusions")
8) d03eba99f5bf ("minmax: allow min()/max()/clamp() if the arguments
   have the same signedness.")
9) f4b84b2ff851 ("minmax: fix indentation of __cmp_once() and
   __clamp_once()")
10) 4ead534fba42 ("minmax: allow comparisons of 'int' against 'unsigned
    char/short'")
11) 867046cc7027 ("minmax: relax check to allow comparison between
    unsigned arguments and signed constants")
12) 3a7e02c040b1 ("minmax: avoid overly complicated constant
    expressions in VM code")
14) 017fa3e89187 ("minmax: simplify and clarify min_t()/max_t()
    implementation")
15) 1a251f52cfdc ("minmax: make generic MIN() and MAX() macros
    available everywhere")
18) dc1c8034e31b ("minmax: simplify min()/max()/clamp()
    implementation")
19) 22f546873149 ("minmax: improve macro expansion and type
    checking")
20) 21b136cc63d2 ("minmax: fix up min3() and max3() too")
21) 71ee9b16251e ("minmax.h: add whitespace around operators and after
    commas")
22) 10666e992048 ("minmax.h: update some comments")
23) b280bb27a9f7 ("minmax.h: reduce the #define expansion of min(),
    max() and clamp()")
24) a5743f32baec ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi
    test in clamp()")
25) c3939872ee4a ("minmax.h: move all the clamp() definitions after the
    min/max() ones")
26) 495bba17cdf9 ("minmax.h: simplify the variants of clamp()")
27) 2b97aaf74ed5 ("minmax.h: remove some #defines that are only
    expanded once")

2 prerequisite commits that adjust users of MIN and MAX macros (to
prevent compilation issues):
13) 4477b39c32fd ("minmax: add a few more MIN_T/MAX_T users")
17) cb04e8b1d2f2 ("minmax: don't use max() in situations that want a C
    constant expression")

1 additional commit introduced to resolve a build failures during the
backport:
16) lib: zstd: drop local MIN/MAX macros in favor of generic ones

The primary motivation is to bring in commit (8).
In mainline, this change allows min()/max()/clamp() to accept mixed
argument types when both share the same signedness.
Backported patches to v5.10.y that use such forms trigger compiler
warnings, which in turn cause build failures when -Werror is enabled.

Originaly I aligned 5.10.y to 5.15.y, but David Laight commented that I
need to pick up the later changes (from Linus) as well.

Andy Shevchenko (2):
  minmax: deduplicate __unconst_integer_typeof()
  minmax: fix header inclusions

Bart Van Assche (1):
  overflow, tracing: Define the is_signed_type() macro once

David Laight (11):
  minmax: allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: fix indentation of __cmp_once() and __clamp_once()
  minmax: allow comparisons of 'int' against 'unsigned char/short'
  minmax: relax check to allow comparison between unsigned arguments and
    signed constants
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

Eliav Farber (1):
  lib: zstd: drop local MIN/MAX macros in favor of generic ones

Herve Codina (1):
  minmax: Introduce {min,max}_array()

Jason A. Donenfeld (2):
  minmax: sanity check constant bounds when clamping
  minmax: clamp more efficiently by avoiding extra comparison

Linus Torvalds (8):
  minmax: avoid overly complicated constant expressions in VM code
  minmax: add a few more MIN_T/MAX_T users
  minmax: simplify and clarify min_t()/max_t() implementation
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: simplify min()/max()/clamp() implementation
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

Matthew Wilcox (Oracle) (1):
  minmax: add in_range() macro

 arch/arm/mm/pageattr.c                        |   6 +-
 arch/um/drivers/mconsole_user.c               |   2 +
 arch/x86/mm/pgtable.c                         |   2 +-
 drivers/edac/sb_edac.c                        |   4 +-
 drivers/edac/skx_common.h                     |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 .../drm/arm/display/include/malidp_utils.h    |   2 +-
 .../display/komeda/komeda_pipeline_state.c    |  24 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   6 -
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/md/dm-integrity.c                     |   2 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  18 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/fjes/fjes_main.c                  |   4 +-
 drivers/nfc/pn544/i2c.c                       |   2 -
 drivers/platform/x86/sony-laptop.c            |   1 -
 drivers/scsi/isci/init.c                      |   6 +-
 .../pci/hive_isp_css_include/math_support.h   |   5 -
 fs/btrfs/misc.h                               |   2 -
 fs/btrfs/tree-checker.c                       |   2 +-
 fs/ext2/balloc.c                              |   2 -
 fs/ext4/ext4.h                                |   2 -
 fs/ufs/util.h                                 |   6 -
 include/linux/compiler.h                      |  15 +
 include/linux/minmax.h                        | 267 ++++++++++++++----
 include/linux/overflow.h                      |   1 -
 include/linux/trace_events.h                  |   2 -
 kernel/trace/preemptirq_delay_test.c          |   2 -
 lib/btree.c                                   |   1 -
 lib/decompress_unlzma.c                       |   2 +
 lib/logic_pio.c                               |   3 -
 lib/vsprintf.c                                |   2 +-
 lib/zstd/zstd_internal.h                      |   2 -
 mm/zsmalloc.c                                 |   1 -
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 net/netfilter/nf_nat_core.c                   |   6 +-
 net/tipc/core.h                               |   2 +-
 net/tipc/link.c                               |  10 +-
 44 files changed, 306 insertions(+), 164 deletions(-)

-- 
2.47.3



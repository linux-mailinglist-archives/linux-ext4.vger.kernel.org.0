Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE17CFFD2
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjJSQmp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSQmo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 12:42:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C611B
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 09:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357EC433C7;
        Thu, 19 Oct 2023 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697733762;
        bh=rF0BRiX64t8aoWsH1ntm/CUWz4Tnl30Pg+AbeCttr24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DS01mPqGmfuhLWNvjote86j5gw4Ko02cL/UyQ1NTYfMWi5O2oTxgWBVVIUljoRKyf
         ZgWU3BaeocNScdBebIbotL7+mFqVQuoRh5SI4ZIhgZ1qMVgruChmKVzIQKyjrG0GOb
         /w3E7qydPb9dI49Fm/1SSB8ToskWgfR3qyhW3JirWH3bVKTqoSjLJDetuyRbHZqrT8
         jyiNZtfNYfqanOsgSgE2pzklHYKlYETkDaiS8dhRgqK3GOpMB8h46yIEj/VfLsBIlO
         3piYfTXhlGAXW9uIl4b4x4bjXeplzrHKa6RhOorHrUYD/KmxdL2pfhgWoTMxdBAulS
         qdd8eUhGLq5Dw==
Date:   Thu, 19 Oct 2023 09:42:40 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231019164240.lhg5jotsh6vfuy67@treble>
References: <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 19, 2023 at 05:44:30PM +0300, Andy Shevchenko wrote:
> So, what I have done so far.
> 1) I have cleaned ccaches and stuff as I used it to avoid collisions;
> 2) I have confirmed that CONFIG_DEBUG_LIST affects boot, the repo
>    I'm using is published here [0][1];
>    3) reverted quota patches until before this merge ([2] - last patch),
>       still boots;
> 4) reverted disabling of CONFIG_DEBUG_LIST [2], doesn't boot;
> 5) okay, rebased on top of merge, i.e. 1500e7e0726e,  with DEBUG_LIST [3],
> 	   doesn't boot;
> 6) rebased [3] on one merge before, i.e. 63580f669d7f [4], voilà -- it boots!;
> 
> And (tadaam!) I have had an idea for a while to replace GCC with LLVM
> (at least for this test), so [0] boots as well!
> 
> So, this merge triggered a bug in GCC, seems like... And it's _the_ merge
> commit, which is so-o weird!

I'm not really a compiler person, but IMO it's highly unlikely to be a
GCC bug unless you can point to the bad code generation.

If CONFIG_DEBUG_LIST is triggering it, it's most likely some kind of
memory corruption, in which case seemingly random events can trigger the
detection of it (or lack thereof).

Any chance it boots with the following?

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 348acf2558f3..29e9e3498902 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -84,7 +84,7 @@ static inline __must_check bool check_data_corruption(bool v) { return v; }
 		if (corruption) {					 \
 			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
 				pr_err(fmt, ##__VA_ARGS__);		 \
-				BUG();					 \
+				WARN_ON(1);				 \
 			} else						 \
 				WARN(1, fmt, ##__VA_ARGS__);		 \
 		}							 \
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..395c4f5d8aa6 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -25,7 +25,7 @@
 #endif
 
 #ifdef CONFIG_DEBUG_LIST
-#define LIST_BL_BUG_ON(x) BUG_ON(x)
+#define LIST_BL_BUG_ON(x) WARN_ON(x)
 #else
 #define LIST_BL_BUG_ON(x)
 #endif

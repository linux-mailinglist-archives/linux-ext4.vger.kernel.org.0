Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0C479DCDC
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjILXuw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjILXuw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 19:50:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468C10FE;
        Tue, 12 Sep 2023 16:50:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19F6C433C8;
        Tue, 12 Sep 2023 23:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694562647;
        bh=k9G6ap+gAojN8vHcoXUXnk1y3u37/KrMImRD4njbitA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMI6XRnSLULEYMPl2XUw2mLkL61xLLN2+ZU6uu5jdT44JmvwtbciGn67BdFmg2qng
         /T1TwuJx89Oh9WYHFD9HPvFXKDdf/RnAiDgXjQff11qLManmXs5Eyeby6QSIHLya3T
         czl232v4CF8cXVf7JD8B2z8vbmcRgLhNchABk3ekYMx3BZ66JwBn3hOquTR/uszmoU
         HDfoMCgWGjfl861Atk0TBVwUylhoowgTWALnT4TPhUYAgShXnnre1dDFIRZtrVGEol
         m8DcWvJXetMrV3itRZdoEn+PYgtxkGBPxBLfbX/Q8Rom2fZnemxTS1BOfseuaukFaE
         OB1wjqGVawyYQ==
Date:   Tue, 12 Sep 2023 16:50:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: Re: general protection fault in ext4_update_overhead
Message-ID: <20230912235047.GA11463@frogsfrogsfrogs>
References: <BL0PR11MB31066DF3F30927A7F82F22FEE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
 <20230912234112.GA1294595@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912234112.GA1294595@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 12, 2023 at 07:41:12PM -0400, Theodore Ts'o wrote:
> On Tue, Sep 12, 2023 at 11:02:35PM +0000, Sanan Hasanov wrote:
> > Good day, dear maintainers,
> > 
> > We found a bug using a modified kernel configuration file used by syzbot.
> > 
> > We enhanced the coverage of the configuration file using our tool, klocalizer.
> > 
> > Kernel Branch: 6.3.0-next-20230426

Also this was from            ^^^^^^^^ four months ago.

Why are you wasting Ted and everyone else's time with this?

--D

> > Kernel Config: https://drive.google.com/file/d/1xpe7qMUUYvHQFzqZGUzcco9jF97EwTqQ/view?usp=sharing
> > Reproducer: https://drive.google.com/file/d/1Q8ix6EiWrzx0bWLyoGTHP721KE4Ei3qf/view?usp=sharing
> 
> The reproducer is a zero-length file.  So I can do nothing with this
> report.
> 
> Note that the official syzbot instance will do automatic bisection,
> and will allow us to test patches.  The official syzbot instance also
> processes the console output so that the stack trace has line numbers
> and clickable links to the kernel sources.
> 
> This report is **much** less useful than the syzbot report, so please
> don't be surprised if people treat this at a significantly lower
> priority.  (Even if the reproducer wasn't a zero length file.  :-P  )
> 
> 	   	    		   	  - Ted

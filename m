Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E942879DCCB
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 01:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjILXlb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjILXlb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 19:41:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638A10C7
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 16:41:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38CNfCmC019110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 19:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694562075; bh=FyTtfg4qgEc24SYu4LBW17g30jtSmbALAwXWhNHhlTQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=fqAzxLw+TSu4JBThOyINgyEJDDrYUdG3Cg5xfO7akcn7xAvMdGZ3mczRuC0my8Ozl
         2vXhzaakJ4/XLvq8yRExN+B3WrXrGcUuAzWdVkFHblEXaYKdvsDvfO3qlil24xYKu0
         kUejmdj0lI5VGhmyON34EfHyhs28RZ4cXwNxkTzyoDsfUd22Btcp4M0iPUkm0+dTsd
         6HYv+a4ltro4SnwxCIR2WTqtJbYEX/FgqUD5wxBpgc2xHR8jDf3gNL7fk1ZuxlV2b7
         Ck+kLIsVgBYqc5xgQZcB8ytgusmqkVBtM64Tm0kXhxAsGcakMeaWZVhN3OXCRPOB6Z
         OqVUMpoyF0jgQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A008C15C0266; Tue, 12 Sep 2023 19:41:12 -0400 (EDT)
Date:   Tue, 12 Sep 2023 19:41:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: Re: general protection fault in ext4_update_overhead
Message-ID: <20230912234112.GA1294595@mit.edu>
References: <BL0PR11MB31066DF3F30927A7F82F22FEE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB31066DF3F30927A7F82F22FEE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 12, 2023 at 11:02:35PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/1xpe7qMUUYvHQFzqZGUzcco9jF97EwTqQ/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1Q8ix6EiWrzx0bWLyoGTHP721KE4Ei3qf/view?usp=sharing

The reproducer is a zero-length file.  So I can do nothing with this
report.

Note that the official syzbot instance will do automatic bisection,
and will allow us to test patches.  The official syzbot instance also
processes the console output so that the stack trace has line numbers
and clickable links to the kernel sources.

This report is **much** less useful than the syzbot report, so please
don't be surprised if people treat this at a significantly lower
priority.  (Even if the reproducer wasn't a zero length file.  :-P  )

	   	    		   	  - Ted

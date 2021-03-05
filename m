Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66C32EF8F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCEQEn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 11:04:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39887 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229560AbhCEQEg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 11:04:36 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125G4PZf002845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 11:04:26 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB65B15C3A88; Fri,  5 Mar 2021 11:04:25 -0500 (EST)
Date:   Fri, 5 Mar 2021 11:04:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
Message-ID: <YEJWiXaZ+9H+2nBx@mit.edu>
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
 <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 05, 2021 at 04:35:47PM +0100, Alexander Lochmann wrote:
> 
> 
> On 05.03.21 16:18, Theodore Ts'o wrote:
> > 1)  I don't see where i_opflags is being read in ipc/mqueue.c at all,
> > either with or without i_rwsem.
> > 
> It is read in fs/dcache.c

So why is this unique to the mqueue inode then?  It might be helpful
to have explicit call stacks in the e-mail, in text form, when you
resend to LKML.

That's because the HTML file is ***huge*** (1.7Meg), and I'm having
trouble with my browser properly rendering it.  In any case, the html
claims to be showing the counter examples and I'm still stuck on the
*example*?

Cheers,

					- Ted

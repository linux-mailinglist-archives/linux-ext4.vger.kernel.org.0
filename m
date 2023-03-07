Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975336AE65A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 17:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCGQXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCGQXE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 11:23:04 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF28F724
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 08:22:04 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 327GLbqL008143
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 11:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678206101; bh=4xLfWNCnwB2PMtjvFaRAm2NjePMCi1bw8Qrqvq4gr4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QoyxfzNkqBvOoIw2DVStpr8dmTJruYjOcSMuXTvFTXhaKk9PyiABDe8YsAF1TOkJm
         hDc6K31AAYLY+teoeQDQeJbW3ruEcFTA+6DCnMXxEq+3RAz80qDRZbrKCtTX9JJ1Sq
         ODv5m4lAOWppczv8vcFo3+LY/z8QvbhahCCuvsFUzRiXowZgzO2XiVat2yV+PPtXRi
         Z+d3rKmfVQapQ3JXdfjHWbe+j0VT+7eAwkffrTBg36r2JK596U7lZ/qtvFl0LD2ZrF
         c02vWya7ZGvkJviDWnQQ415iIWFZfCY5jSgOYu6wTuHqxo3+v7oQjie7SXATTLbvwr
         X6iVgsaPnUIyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0FE4F15C3441; Tue,  7 Mar 2023 11:21:37 -0500 (EST)
Date:   Tue, 7 Mar 2023 11:21:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Jan Kara <jack@suse.cz>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: Re: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <20230307162137.GB960946@mit.edu>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
 <ZAVbZJSyOdF0BxAJ@debian.me>
 <20230306124134.hmeuvjhihs4ubpmz@quack3>
 <20230307090203.56c41488@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307090203.56c41488@oak.ozlabs.ibm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 07, 2023 at 09:02:03AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 6 Mar 2023 13:41:34 +0100 Jan Kara <jack@suse.cz> wrote:
> >
> > To be fair, the data=journal cleanups got held back only partially due to
> > the merge issues. Another problem is that they somehow make problems with
> > filesystem freezing in data=journal mode more frequent and we wanted to
> > understand (and hopefully fix) that. Of course if Ted could look into this
> > earlier or I could earlier debug these issues, we could have merged the
> > cleanups but that's always the case that you have to prioritize and these
> > cleanups don't have that high priority...
> 
> In that case, it would be nice (for me at least) if the ext4 tree was
> now reset to be v6.3-rc1 i.e. get rid of the duplicate commits and the
> new stuff that is still being worked on.

What duplicate commits?  As far as I know there aren't any.  My normal
practice is to send a secondary push to fix a few bug fixes targetted
for upcoming release (in this case, 6.3), and then I'll reset to -rc2
or -rc3 for patches that are targetted for the next merge window (in
this case, 6.4).

The data=writeback patches was dropped from dev before the pull
request, and won't show up on dev until they are ready for Linus.

Cheers,

						- Ted

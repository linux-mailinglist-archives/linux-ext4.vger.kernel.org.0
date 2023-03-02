Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF36A839F
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Mar 2023 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCBNhp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Mar 2023 08:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBNhp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Mar 2023 08:37:45 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5D42BD2
        for <linux-ext4@vger.kernel.org>; Thu,  2 Mar 2023 05:37:43 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 322DbZ1f003468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 08:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677764256; bh=EVmSStDv8NRLrr1zrvb0DYdIXJYT6qNjoC5cNSjW8lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ClbeG4PcUytop4vtEWlyeZf7v+iiG0Pv6EH+tEvetwx5IjNhDNcppmlItfr6IDk/S
         aRS1zpA0RXefsnygWet4f8dkVNjZiugIosn7csrw+GqgTMq4tje6Wll78OXWp6+F4E
         60cXoWWAhwpxA+TbVYyI/iz6fcIAiyVPBVRtHR8o+AMXkuZdIMXu58NaIKd0VMHrmU
         dRlvM+IIBX83HILDnq+d6mVIq5qPoEfqGwID3bxN36ky6Xo9dqVwk6wzVQ7r06inrc
         EVvar5E9slYMrnE0DFJio3OWyIroX0BW6tiGtIuvFWUk1axiLh0yIvqsSJzyW/LtZL
         jwVzt+0ot5+yw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6552B15C3593; Thu,  2 Mar 2023 08:37:35 -0500 (EST)
Date:   Thu, 2 Mar 2023 08:37:35 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH REBASED 0/7] ext4: Cleanup data=journal writeback path
Message-ID: <ZACmnwm9in84kbOB@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
 <20230228135854.ky2zpwal7trz6yg3@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228135854.ky2zpwal7trz6yg3@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 28, 2023 at 02:58:54PM +0100, Jan Kara wrote:
> 
> Regarding the warning somehow there are dirty pages left after the
> procedures freeze_super() goes through to flush all dirty data. That is not
> too surprising since in data=journal mode pages get (as a surprise to
> freezing code) dirtied when transaction commits. I thought we have this
> covered by jbd2_journal_flush() call in ext4_freeze() but maybe there are
> some stranded PageDirty bits left? It needs more debugging...

So the question I have is whether this is a bug that was always there,
or perhaps code changes affected the timing, so that it was much more
likely to happen (although in my testing it's still only triggering
about 50% of the time).

This warning can mean that data can be lost, especially if someone was
doing hibernation, right?  We can discuss this at today's ext4 video
conference, but I'm inclined to wait until the next merge cycle for
this patch series until we can figure out what's going on.  Jan, what
do you think?


	     	     	       	      - Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA506F171A
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjD1MCu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjD1MCt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 08:02:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE12D65;
        Fri, 28 Apr 2023 05:02:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95DB81FFAB;
        Fri, 28 Apr 2023 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682683366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8NFlTAM7TMs+bI3PGeFwmGIdf3UYmFP4iw0BWjYPus=;
        b=ufke+yp0gU03U5C/6+qSlRTGcCaURICp5bV7htT39jbDyXMz41dtUR8yU13nyNANhIikND
        2+OBhL+YB9+pBf1erb6HjUflja/lWEkomJtZ09S4sNEwAtA//jJCfGFcggXQARheA77LxK
        UC/ihit39OixmEABehSjBeDKPmtQuHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682683366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8NFlTAM7TMs+bI3PGeFwmGIdf3UYmFP4iw0BWjYPus=;
        b=JrE+vEggpbe9rm9jHmFdb5GfdjznB6+IB5sOVJBxzUus01kk3I5j/YaL3v4QM1kNDXi81z
        HERSFZQRotZjRkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F371390E;
        Fri, 28 Apr 2023 12:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XC8qIea1S2TcbAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 12:02:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0DDE0A0729; Fri, 28 Apr 2023 14:02:46 +0200 (CEST)
Date:   Fri, 28 Apr 2023 14:02:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Pick commit 2729cfdcfa ("ext4: use ext4_journal_start/stop for
 fast commit transactions")
Message-ID: <20230428120246.hzx6lhkvmfdspy75@quack3>
References: <20230427162459.qb3tnh3be6ofibzz@quack3>
 <2023042804-feed-radiantly-2a07@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023042804-feed-radiantly-2a07@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 28-04-23 09:32:34, Greg KH wrote:
> On Thu, Apr 27, 2023 at 06:24:59PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > recently I've debugged a deadlock issue in ext4 fast commit feature in our
> > openSUSE Leap kernel. Checking with upstream I've found out the issue was
> > accidentally fixed by commit 2729cfdcfa1c ("ext4: use
> > ext4_journal_start/stop for fast commit transactions"). Can you please pick
> > up this commit into the stable tree? The problem has been there since fast
> > commit began to exist (in 5.10-rc1) so 5.10 and 5.15 stable trees need the
> > fix. Thanks!
> 
> This commit does not apply to those branches, so how was it tested?

Hum, I've picked up the patch to our 5.14-based distro kernel and it
applied (and passed testing) without issues so I was hoping 5.15 and 5.10
would work as well. Apparently I was wrong. Sorry for the trouble.

> Can you send us backported, and tested, versions of this commit so that
> we can apply them?

Yeah, I'll look into applying the patch directly to stable branches.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

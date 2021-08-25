Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6636F3F79EF
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhHYQOX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 12:14:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47722 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhHYQOT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 12:14:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D64AC20131;
        Wed, 25 Aug 2021 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629908012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj67jNeZHR6/QCAAVrYyDv+L9NcP2s59OI0Kown82aA=;
        b=ZiltCLxkTBqlZDjuaWyJkIl0IY9HeGMIrYP6Sgx5jW7BRKGNmQTSu+/uZ5SKp6sGKERBgX
        Bbc6KRqFGH2AzApNvmKFgDU86IcGemcH9C9D4TG146j0NgZ+JBAu9CwEyP0X4p3JFFj3u4
        q6m0HjYFVrw41qg9ROGJaqd+6aa+Z4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629908012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj67jNeZHR6/QCAAVrYyDv+L9NcP2s59OI0Kown82aA=;
        b=p5rcPH5XJ+P2D1RHYEgKSA0fsfMoaHYYXzCYUMFDkNGezuSejwqfTB7mC1JbDAF/JifVb3
        UbNDvkdIm2edv8Cg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C1ABEA3B87;
        Wed, 25 Aug 2021 16:13:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 612D01E0948; Wed, 25 Aug 2021 18:13:31 +0200 (CEST)
Date:   Wed, 25 Aug 2021 18:13:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <20210825161331.GA14270@quack2.suse.cz>
References: <20210816093626.18767-1-jack@suse.cz>
 <YSUo4TBKjcdX7N/q@mit.edu>
 <20210825113016.GB14620@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825113016.GB14620@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-08-21 13:30:16, Jan Kara wrote:
> On Tue 24-08-21 13:14:09, Theodore Ts'o wrote:
> > I've been running some tests exercising the orphan_file code, and
> > there are a number of failures:
> > 
> > ext4/orphan_file: 512 tests, 3 failures, 25 skipped, 7325 seconds
> >   Failures: ext4/044 generic/475 generic/643
> > ext4/orphan_file_1k: 524 tests, 6 failures, 37 skipped, 8361 seconds
> >   Failures: ext4/033 ext4/044 ext4/045 generic/273 generic/476 generic/643

So I had a look into the other failures... So ext4/044 works for me after
fixing e2fsck (both in 1k and 4k cases). ext4/033, ext4/045, generic/273
fail for me in the 1k case even without orphan file patches so I don't
think they are a regression caused by my changes (specifically ext4/045 is
a buggy test - I think the directory h-tree is not able to hold that many
directories for 1k block size). Interestingly, I couldn't make generic/476
fail for me either with or without my patches so that may be some random
failure. I'm now running that test in a loop to see whether the failure
will reproduce to investigate.

So overall I don't see any other regressions with my patches (besides that
e2fsck bug). Or did I miss something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

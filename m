Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B914A3DFDF9
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhHDJZx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 05:25:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhHDJZw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 05:25:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D415620119;
        Wed,  4 Aug 2021 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628069139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdKbEglLdUQQM4ePozpWJTHpYxS8WfTxu+jIDcIekxQ=;
        b=wQSIiTlxzKljB0SqlGGueLGp1vW8+2MtTV3tZyWFhoMiT+p8d5cWTxFuw5+AUAjQTuYp7L
        cDisBltz8l5z/Ntv8wQ7TtHqffbjFmKf3fv2C/92CdP+RyjPrRnbsfZtW0PuIuMezGVsD8
        VrPMww8UDfmGYfHrmt/myfIpOgGaNA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628069139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdKbEglLdUQQM4ePozpWJTHpYxS8WfTxu+jIDcIekxQ=;
        b=8/fdHtFRt6Bl6rmSb2QrpZSdacYU/P26b42AAruy88SMiLk3hwXPWBOHlyStJl8eS01PfT
        jiw2kPErz5o2QPCQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id C6F77A3B8C;
        Wed,  4 Aug 2021 09:25:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD25F1E62D6; Wed,  4 Aug 2021 11:25:37 +0200 (CEST)
Date:   Wed, 4 Aug 2021 11:25:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] libext2fs: Support for orphan file feature
Message-ID: <20210804092537.GA4578@quack2.suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-5-jack@suse.cz>
 <YQl1gGwVSB5+IMCW@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQl1gGwVSB5+IMCW@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 03-08-21 12:57:36, Theodore Ts'o wrote:
> On Mon, Jul 12, 2021 at 05:43:10PM +0200, Jan Kara wrote:
> > @@ -825,6 +826,7 @@ struct ext2_super_block {
> >  #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
> >  #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
> >  #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
> > +#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080
> >  #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
> >  #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
> 
> (This isn't a full review of the patch, but just a quick feedback of
> what I've noticed so far.)
> 
> Since Andreas has requested that we not get rid of the
> RO_COMPAT_SNAPSHOT, I'm using 0x0400 for
> EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT in my testing.

Yeah, I'm sorry. Somehow older version of the patch escaped to this posting
(I've checked and this was the only difference between what I have in git
and what I have posted).

> I also noted a number of new GCC warnings when running "make gcc-wall"
> on lib/ext2fs after applying this commit.

I'll check these fix them up and repost. Thanks for noticing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

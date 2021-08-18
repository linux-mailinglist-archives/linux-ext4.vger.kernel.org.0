Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448DA3F06A7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbhHRO0m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 10:26:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbhHRO0j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Aug 2021 10:26:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2F68722076;
        Wed, 18 Aug 2021 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629296762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Zbc/uB0zhyDd1UPDQj6ABNQkkgL7DcrMjSWW5vnxtk=;
        b=RxF8JdkjGfP9OiQj1DGhegz5q4Sm8uyLDO8wToc8vu2+8LyHuXpjjyR9NcczFLEgqG3v2b
        15GL6EpmR6qLvH9t+qJ3oW/poW5GIAih3xZj2p+a8VI1z9ISEoR1H4+GEcmWvrvzW79Vcz
        eqS8MT2Wb4k6vCCIy24K7ejWTfDF+hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629296762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Zbc/uB0zhyDd1UPDQj6ABNQkkgL7DcrMjSWW5vnxtk=;
        b=K2yQrMVx4qUE+w3gA08gpsciZ817nM62gsdu6pelt+b43S+pu9i69CH/dIyASlYbu63C7j
        y09MY0xF5Le0kNAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 23109A3B96;
        Wed, 18 Aug 2021 14:26:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E94461E14B9; Wed, 18 Aug 2021 16:26:01 +0200 (CEST)
Date:   Wed, 18 Aug 2021 16:26:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210818142601.GF28119@quack2.suse.cz>
References: <20210818084126.4167799-1-bxue@redhat.com>
 <20210818114517.kqvfzu2vd45vuhze@fedora>
 <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-08-21 21:20:44, Boyang Xue wrote:
> > > +
> > > +# real QA test starts here
> > > +_supported_fs ext4
> >
> > I'm wondering if this case can be a generic case, there's nothing
> > ext4 specified operations, except this line:
> >
> > "$TUNE2FS_PROG -l $SCRATCH_DEV"
> >
> > Hmm... if we can change this line to something likes _get_fs_super(),
> > it might help to make this test to be a generic test.
> 
> I think this bug is heavily related to "tune2fs", ext4 only. So I
> guess an ext4 only test is enough?

FWIW I agree with Boyang here. For this test to make sense for any other
filesystem other the filesystem would need to read fs metadata through
buffer cache in _get_fs_super(). Furthermore it is somewhat ext2/3/4
specific (due to historical reasons) that reading superblock from the
buffer cache of a mounted filesystem is expected to result in something
sensible. Usually this is plain unsupported use...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

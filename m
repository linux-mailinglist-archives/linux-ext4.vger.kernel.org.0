Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978D811E734
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 16:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfLMP7O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 10:59:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:58436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728073AbfLMP7O (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Dec 2019 10:59:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 091BDADA1;
        Fri, 13 Dec 2019 15:59:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB7771E0609; Fri, 13 Dec 2019 16:59:12 +0100 (CET)
Date:   Fri, 13 Dec 2019 16:59:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paul Richards <paul.richards@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Query about ext4 commit interval vs dirty_expire_centisecs
Message-ID: <20191213155912.GH15474@quack2.suse.cz>
References: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 19-11-19 08:47:31, Paul Richards wrote:
> I'm trying to understand the interaction between the ext4 `commit`
> interval option, and the `vm.dirty_expire_centisecs` tuneable.
> 
> The ext4 `commit` documentation says:
> 
> > Ext4 can be told to sync all its data and metadata every 'nrsec' seconds. The default value is 5 seconds. This means that if you lose your power, you will lose as much as the latest 5 seconds of work (your filesystem will not be damaged though, thanks to the journaling).
> 
> The `dirty_expire_centisecs` documentation says:
> 
> > This tunable is used to define when dirty data is old enough to be eligible for writeout by the kernel flusher threads. It is expressed in 100'ths of a second. Data which has been dirty in-memory for longer than this interval will be written out next time a flusher thread wakes up.
> 
> 
> Superficially these sound like they have a very similar effect.  They
> periodically flush out data that hasn't been explicitly fsync'd by the
> application.  I'd like to understand a bit more the interaction
> between these.

Yes, the effect is rather similar but not quite the same. The first thing
to observe is kind of obvious fact that ext4 commit interval influences
just the particular filesystem while dirty_expire_centisecs influences
behavior of global writeback over all filesystems.

Secondly, commit interval is really the maximum age of ext4 transation.  So
if there is metadata change pending in the journal, it will become
persistent at latest after this time. So for say 'mkdir' that will be
persistent at latest after this time. For data operations things are more
complex. E.g. when delayed allocation is used (which is the default), the
change gets logged in the journal only during writeback. So it can take up
to dirty_expire_centisecs for data to be written back from page cache, that
results in filesystem journalling block allocations etc. and then it can
take upto commit interval for these changes to become persistent. So in
this case the intervals add up. There are also other special cases
somewhere in between but generally it is reasonable to assume that data gets
automatically persistent in dirty_expire_centisecs + commit_interval time.
Note both these times are actually times when writeback is triggered so
if the disk gets too busy, the actual time when data is completely on disk
may be much higher.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB51211080
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jul 2020 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgGAQWv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jul 2020 12:22:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgGAQWu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Jul 2020 12:22:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBC23ADCA;
        Wed,  1 Jul 2020 16:22:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A07411E1288; Wed,  1 Jul 2020 18:22:48 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:22:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Costa Sapuntzakis <costa@purestorage.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [BUG] invalid superblock checksum possibly due to race
Message-ID: <20200701162248.GA4355@quack2.suse.cz>
References: <CAABuPhaMHu+mmHbVKGt2L0tcE2-EMyd5VWcok7kAfJY3DQ=-vw@mail.gmail.com>
 <20200630114832.GA16372@quack2.suse.cz>
 <CAABuPhZrQXQ8-tFu9V3575by5N3RV7jd-OcOjy_pLw_na1OUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABuPhZrQXQ8-tFu9V3575by5N3RV7jd-OcOjy_pLw_na1OUkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 30-06-20 11:34:49, Costa Sapuntzakis wrote:
> > Yes, probably ext4_superblock_csum_set() should use
> >
> > lock_buffer(EXT4_SB(sb)->s_sbh)
> >
> > to synchronize updating of superblock checksum. Will you send a patch?
> 
> Yes. I will send a patch.

Thanks!

> I noticed lock_buffer can sleep. That would seem to imply to me that
> lock_buffer can be held across I/Os.
> I worry that this will occasionally significantly slow down this code
> path compared to what it used to be.  Are there any things
> about the way ext4 uses buffers that makes this less of a concern?

Yes, buffer lock is a sleeping lock but that's the lock we usually use to
protect consistency of buffer contents. So I prefer to use that lock unless
we have definitive performance data showing we need something more
clever...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

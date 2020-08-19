Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77320249921
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHSJQj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 05:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgHSJQi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 05:16:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E182CAD80;
        Wed, 19 Aug 2020 09:17:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FCBD1E1312; Wed, 19 Aug 2020 11:16:37 +0200 (CEST)
Date:   Wed, 19 Aug 2020 11:16:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 2/5] jbd2: introduce journal callbacks
 j_submit|finish_inode_data_buffers
Message-ID: <20200819091637.GH1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-3-mfo@canonical.com>
 <20200818145204.GC1902@quack2.suse.cz>
 <CAO9xwp3mvXbGSMwPag431P+nGuVud2FK7n-Bq12LYLqm8uNOug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3mvXbGSMwPag431P+nGuVud2FK7n-Bq12LYLqm8uNOug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 18-08-20 22:20:08, Mauricio Faria de Oliveira wrote:
> > > To opt-out of the default behavior (i.e., to do nothing), one has
> > > to opt-in with a no-op function.
> >
> > Your Signed-off-by is missing for this patch.
> 
> Oh, I thought it wasn't needed in RFC patches.

Yes, it's not strictly needed if you don't want patches included yet. But
usually they are present so that people have less things to worry about
when preparing final submission :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

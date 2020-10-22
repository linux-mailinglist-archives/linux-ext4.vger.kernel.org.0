Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7A295F5C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894464AbgJVNGX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 09:06:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507469AbgJVNGX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Oct 2020 09:06:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0270FAC3F;
        Thu, 22 Oct 2020 13:06:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B4A501E1342; Thu, 22 Oct 2020 15:06:16 +0200 (CEST)
Date:   Thu, 22 Oct 2020 15:06:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v10 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
Message-ID: <20201022130616.GC24163@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-2-harshadshirwadkar@gmail.com>
 <20201021160423.GB25702@quack2.suse.cz>
 <CAD+ocbyp1PBS-GeU4r75DBE-r15HT6PJSk_t0zordFv3hH2Fjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyp1PBS-GeU4r75DBE-r15HT6PJSk_t0zordFv3hH2Fjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-10-20 10:25:14, harshad shirwadkar wrote:
> > BTW, how is EXT4_FC_TAG_CREAT different from EXT4_FC_TAG_LINK? It seems
> > like they describe essentially the same operation?
> In the replay path, creat has to do certain things that link doesn't.
> For example, "creat" needs to mark the inode as used in the bitmap and
> also if it's a directory that's being created, it needs to initialize
> the "." and ".." dirents in the directory. That's why we need
> different tags.

Aha, OK, makes sence. Thanks for explanation. BTW it would be good to have
some documentation (or at least examples) how a sequence of system calls
translates to fastcommit log entries and then how these are replayed in
case of crash.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9A3558ED
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbhDFQNA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 12:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346283AbhDFQM7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Apr 2021 12:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D58F8AD7C;
        Tue,  6 Apr 2021 16:12:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89CDD1F2B77; Tue,  6 Apr 2021 18:12:50 +0200 (CEST)
Date:   Tue, 6 Apr 2021 18:12:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Hao Sun <sunhao.th@gmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KCSAN: data-race in __jbd2_journal_file_buffer /
 jbd2_journal_dirty_metadata
Message-ID: <20210406161250.GH19407@quack2.suse.cz>
References: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
 <20210406123232.GD19407@quack2.suse.cz>
 <YGx308zQXxOjmwNZ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGx308zQXxOjmwNZ@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-04-21 11:01:39, Theodore Ts'o wrote:
> On Tue, Apr 06, 2021 at 02:32:33PM +0200, Jan Kara wrote:
> > And the comment explains, why we do this unreliable check. Again, if we
> > wanted to silence KCSAN, we could use data_race() macro but AFAIU Ted isn't
> > very fond of that annotation.
> 
> I'm not fond of the data_race macro, but I like bogus KCSAN reports
> even less.  My main complaint is if we're going to have to put the
> data_race() macro in place, we're going to need to annotate each
> location with an explanation of why it's there (suppress a KCSAN false
> positive), and why's it's safe.  If it's only one or two places, it'll
> probably be fine.  If it's dozens, then I would say that KCSAN is
> becoming a net negative in terms of making the Linux kernel code
> maintainable.

OK, I'll send you patches for the two I've seen in the last month. We'll
see how many accumulate over time.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
